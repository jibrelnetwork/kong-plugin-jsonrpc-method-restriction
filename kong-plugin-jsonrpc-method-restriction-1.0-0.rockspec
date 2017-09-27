package = "kong-plugin-jsonrpc-method-restriction"
version = "1.0-0"
supported_platforms = {"linux", "macosx"}
source = {
  url = "git://github.com/jibrelnetwork/kong-plugin-jsonrpc-method-restriction",
  tag = "1.0.0"
}
description = {
  summary = "The Kong JSONRPC Method Restriction plugin.",
  license = "MIT",
  homepage = "https://www.github.com/jibrelnetwork/kong-plugin-jsonrpc-method-restriction",
  detailed = [[
  	Like XML-based services, APIs that support JavaScript object notation (JSON) are vulnerable to content-level attacks.
  	Simple JSON attacks attempt to use structures that overwhelm JSON parsers to crash a service and induce application-level denial-of-service attacks.
  	All settings are optional and should be tuned to optimize your service requirements against potential vulnerabilities.
  ]],
}
dependencies = {
  "lua ~> 5.1",
  "stringy ~> 0.4-1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.kong-plugin-jsonrpc-method-restriction.handler"] = "src/handler.lua",
    ["kong.plugins.kong-plugin-jsonrpc-method-restriction.schema"] = "src/schema.lua",
    ["kong.plugins.kong-plugin-jsonrpc-method-restriction.jsonrpc_validator"] = "src/jsonrpc_validator.lua"
  }
}