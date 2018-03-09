DEV_ROCKS = busted luacheck lua-llthreads2
BUSTED_ARGS ?= -o gtest -v --exclude-tags=ci
TEST_CMD ?= busted $(BUSTED_ARGS)
KONG_PATH ?=/kong
PLUGIN_NAME := kong-plugin-jsonrpc-method-restriction

.PHONY: install uninstall dev lint test test-integration test-plugins test-all clean

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
DEV_PACKAGE_PATH := $(current_dir)lua_modules/share/lua/5.1/?

define set_env
	@eval $$(luarocks path); \
	LUA_PATH="$(DEV_PACKAGE_PATH).lua;$$LUA_PATH" LUA_CPATH="$(DEV_PACKAGE_PATH).so;$$LUA_CPATH";
endef

lint:
	@luacheck -q . \
						--exclude-files 'kong/vendor/**/*.lua' \
						--exclude-files 'spec/fixtures/invalid-module.lua' \
						--std 'ngx_lua+busted' \
						--globals '_KONG' \
						--globals 'ngx' \
						--globals 'assert' \
						--no-redefined \
						--no-unused-args

install:
	luarocks make $(PLUGIN_NAME)-*.rockspec

uninstall:
	luarocks remove $(PLUGIN_NAME)-*.rockspec

install-dev:
	luarocks make --tree lua_modules $(PLUGIN_NAME)-*.rockspec

test: install-dev
	$(call set_env) \
	$(TEST_CMD) $(current_dir)test

clean:
	@echo "removing $(PLUGIN_NAME)"
	-@luarocks remove --tree lua_modules $(PLUGIN_NAME)-*.rockspec >/dev/null 2>&1 ||:
