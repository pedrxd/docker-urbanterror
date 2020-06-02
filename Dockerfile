FROM debian:buster as builder

## Install dependencies
RUN apt-get update \
  && apt-get -y install \
    aria2 \
    unzip \
    make \
    gcc \
    wget

## Download Urban Terror
## if links are broken, check http://www.urbanterror.info/downloads/
ARG CHECKSUM_UrbanTerror434_full_zip=9bf7f0092161391697d24f6b004a6c6b
RUN aria2c --file-allocation=none \
  --checksum=md5=$CHECKSUM_UrbanTerror434_full_zip \
  --check-integrity \
  http://cdn.urbanterror.info/urt/43/releases/zips/UrbanTerror434_full.zip \
  https://up.barbatos.fr/urt/UrbanTerror434_full.zip \
  https://www.happyurtday.com/releases/4x/UrbanTerror434_full.zip \
  --dir=/tmp \
    && mkdir /data/ \
    && unzip /tmp/UrbanTerror43*.zip -d /data/ && rm /tmp/UrbanTerror43*.zip

##Compile Quake3
RUN cd /tmp \
    && wget https://github.com/pedrxd/MaxModUrT/archive/urt.zip \
    && unzip urt.zip \
    && cd MaxModUrT-urt \
    && make -j8 \
    && cp /tmp/MaxModUrT-urt/build/release-linux-*/urbanterror-server-m9.* /data/UrbanTerror43/urbanterror-server && chmod +x /data/UrbanTerror43/urbanterror-server \
    && rm -r /tmp/*

FROM debian:buster as final

RUN apt-get update
RUN apt-get install gettext-base -y

ENV URT_PORT 27960
ENV URT_SERVERNAME "New Unnamed Server"
ENV URT_MAP "ut4_casa"

COPY --from=builder /data/ /data/
COPY server.cfg /data/UrbanTerror43/q3ut4/docker-server.cfg
COPY urt.sh /data/UrbanTerror43/run.sh

RUN chmod +x /data/UrbanTerror43/run.sh

VOLUME urtconfig

##Add script for run server
ENTRYPOINT ["/data/UrbanTerror43/run.sh"]
