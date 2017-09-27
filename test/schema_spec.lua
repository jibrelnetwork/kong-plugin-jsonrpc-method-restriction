local schemas = require "kong.dao.schemas_validation"
local validate_entity = schemas.validate_entity

local schema = require "kong.plugins.jsonrpc-method-restriction.schema"

describe("JSONRPC Method Restriction schema", function()
    it("should work when no configuration has been set", function()
        local config = {}
        local valid, err = validate_entity(config, schema)
        assert.truthy(valid)
        assert.falsy(err)
        assert.is_true(config.allowed_methods == {})
    end)
end)
