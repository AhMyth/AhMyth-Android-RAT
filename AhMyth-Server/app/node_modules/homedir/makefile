.PHONY: clean test

clean:
	@$(RM) -fr node_modules
	@$(RM) -fr npm-debug.log

test: node_modules
	@node test

node_modules: package.json
	@npm prune
	@npm install

publish: test
	@git push --tags
	@npm publish

