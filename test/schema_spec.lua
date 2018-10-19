local schemas = require "kong.dao.schemas_validation"
local validate_entity = schemas.validate_entity

local schema = require "kong.plugins.kong-plugin-jsonrpc-method-restriction.schema"

describe("JSONRPC Method Restriction schema", function()
    it("should work when no configuration has been set", function()
        local config = {}
        local valid, err = validate_entity(config, schema)

        assert.truthy(valid)
        assert.falsy(err)
        assert.is_true(type(config.allowed_methods) == 'table')
        assert.is_true(next(config.allowed_methods) == nil)
    end)
end)
