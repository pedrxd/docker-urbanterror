#!/bin/sh

if [ ! -e /config/q3ut4/server.cfg ]; then
  echo "Server config not found, using the default one..."
  mkdir -p /config/q3ut4

  if [ -z "${URT_RCONPASSWORD}" ]; then
    export URT_RCONPASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
    echo " "
    echo "============Rcon Password=========="
    echo " The rcon password is ${URT_RCONPASSWORD}"
    echo "==================================="
    echo " "
  fi

  envsubst < /data/UrbanTerror43/q3ut4/docker-server.cfg > /config/q3ut4/server.cfg
fi

## run the UrT server
echo "===== running UrT server on port ${URT_PORT} ======"
exec /data/UrbanTerror43/urbanterror-server \
	+set fs_game q3ut4 \
	+set fs_homepath /config/ \
	+set dedicated 2 \
	+set net_port ${URT_PORT} \
	+exec server.cfg \
	+set com_hunkmegs 128 \
	2>&1
