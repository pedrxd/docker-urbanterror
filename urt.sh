#!/bin/sh

URT_PORT=${URT_PORT:-27960}

#Check if server.cfg exist
if [ -e /config/q3ut4/server.cfg ]; then
  echo "Server config found"
else
  echo "Server config not found, copying the default one..."
  mkdir -p /config/q3ut4
  cp /data/UrbanTerror43/q3ut4/server_example.cfg /config/q3ut4/server.cfg
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
