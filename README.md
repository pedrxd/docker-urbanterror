# UrbanTerror as Docker

**The original binary is not used!**. A modified one is used for multi-arch support. Infinite stamina + other mods are activated by default. Check cvar and code on this [link](https://github.com/pedrxd/MaxModUrT#modification-related).


# Usage
If you want to use your customized config take care of this structure. If not, the container will create one for you with the default configuration.
```
/config/
└── q3ut4
    ├── games.log
    ├── q3config_server.cfg
    └── server.cfg
    └── yourmap.pk3
    └── othermap.pk3
```
The server files are saved on **/data/UrbanTerror43/**. You can use your custom binary replacing **/data/UrbanTerror43/urbanterror-server** file.

## docker run
You can run with default configuration using the following command

`docker run -d -p 27960:27960/udp pedrxd/urbanterror`

For a customized server, you need to add your config folder:

`docker run -d -p 27960:27960/udp -v /your/config/path:/config pedrxd/urbanterror`

If there is not any config file on that path, the container will create one for  you.

## Environment
`URT_SERVERNAME`

`URT_RCONPASSWORD`: Set a custom password, if none specified a random one will be generated and echo on console

`URT_MAP`: Set the first map for start with

`URT_PORT`: Set port, default 27960
