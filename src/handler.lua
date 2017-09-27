local stringy = require "stringy"
local responses = require "kong.tools.responses"
local jsonrpc_validator = require "kong.plugins.kong-plugin-jsonrpc-method-restriction.jsonrpc_validator"
local BasePlugin = require "kong.plugins.base_plugin"

local JsonrpcMethodRestrictionHandler = BasePlugin:extend()

JsonrpcMethodRestrictionHandler.PRIORITY = 500

---------------
-- Constants --
---------------

local APPLICATION_JSON = "application/json"
local CONTENT_TYPE = "content-type"

----------------------
-- Utility function --
----------------------

local function get_content_type()
    local header_value = ngx.req.get_headers()[CONTENT_TYPE]
    if header_value then
        return stringy.strip(header_value):lower()
    end
    return nil
end

---------------------------
-- Plugin implementation --
---------------------------

function JsonrpcMethodRestrictionHandler:new()
    JsonrpcMethodRestrictionHandler.super.new(self, "JSONRPC Method Restriction")
end

function JsonrpcMethodRestrictionHandler:access(config)
    JsonrpcMethodRestrictionHandler.super.access(self)

    local is_json = stringy.startswith(get_content_type(), APPLICATION_JSON)
    if is_json then
        ngx.req.read_body()
        local body = ngx.req.get_body_data()

        if not body then
            return responses.send_OK()
        end

        local result, message = jsonrpc_validator.execute(body, config.allowed_methods)
        if not result then
            return responses.send_HTTP_BAD_REQUEST(message)
        end
    end
end

return JsonrpcMethodRestrictionHandler

