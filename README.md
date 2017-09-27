# kong-plugin-jsonrpc-method-restriction

## Use Kong with the plugin

$ make install-dev

This command installs plugin locally to a ./lua_modules directory. The PATH to moudles installed in this folder will be something like:

/path/to/kong-plugin-jsonrpc-method-restriction/lua_modules/share/lua/5.1/?.lua 

## Configuration

Configuring the plugin is straightforward, you can add it on top of an API by executing the following request on your Kong server:

$ curl -X POST http://kong:8001/apis/{api}/plugins \
    --data "name=kong-plugin-jsonrpc-method-restriction"
    --data "config.allowed_method=eth_sendTransaction"
    
**api**: The id or name of the API that this plugin configuration will target

You can also apply it for every API using the http://kong:8001/plugins/ endpoint.

| Parameter                           | Default    | Description                                                                                                                                                                                                                                    |
|-------------------------------------|------------|---------------------------------------------------------|
| **config.allowed_methods**          |            | Comma-delimited list of the allowed JSONRPC method.     |
