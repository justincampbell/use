SCRIPT=bin/use-setup
VERSION=$(shell source $(SCRIPT) && use --version)

test:
	bash test/runner.sh
	zsh test/runner.sh

release: tag
	git push origin --tags

tag:
	git tag -f latest
	git tag v$(VERSION)

.PHONY: test release tag
