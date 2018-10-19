describe("Jsonrpc Method Restriction Test Suite", function()

    local jtp
    local status
    local message

    setup(function()
        jtp = require "kong.plugins.kong-plugin-jsonrpc-method-restriction.jsonrpc_validator"
        status = nil
        message = nil
    end)

    teardown(function()
        jtp = nil
        status = nil
        message = nil
    end)

    it("Test with valid json", function()
        local json = "{ \"method\": \"eth_sendTransaction\" }"
        status, message = jtp.execute(json, {})

        assert.equal(status, true)
        assert.equal(message, "")
    end)

    it("Test with invalid json", function()
        local json = "{ \"meth \"eth_sendTransaction\" }"
        status, message = jtp.execute(json, {'eth_sendTransaction'})

        assert.equal(status, true)
        assert.equal(message, "")
    end)

    it("Test with valid json, jsonrpc method is not allowed", function()
        local json = "{\"method\": \"net_version\"}"
        status, message = jtp.execute(json, {'eth_sendTransaction'})

        assert.equal(status, false)
        assert.equal(message, "JSONRPCMethodRestrict[MethodIsNotAllowed]")
    end)
end)
