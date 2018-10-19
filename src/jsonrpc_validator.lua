local cjson = require "cjson"
local cjson_safe = require "cjson.safe"

local JsonrpcValidator = {}

local function is_empty(t)
    return next(t) == nil
end

local function inTable(t, item)
    for key, value in pairs(t) do
        if value == item then
            return true
        end
    end
    return false
end

local function validateJson(json, allowed_methods)
    if type(allowed_methods) == "table" and not is_empty(allowed_methods) then
        if json["method"] ~= nil then
            if not inTable(allowed_methods, json["method"]) then
                return false, "JSONRPCMethodRestrict[MethodIsNotAllowed]"
            end
        end
    end

    return true, ""
end

------------------------------
-- Validator implementation --
------------------------------

function JsonrpcValidator.execute(body, allowed_methods)

    ----------------------------
    -- Validate if valid JSON --
    ----------------------------
    local valid = cjson_safe.decode(body)
    if not valid then
        return true, ""
    end

    local json = cjson.decode(body)

    return validateJson(json, allowed_methods)
end

return JsonrpcValidator
