SCRIPT=bin/use-setup
INSTALL_LOCATION=/usr/local/$(SCRIPT)
VERSION=$(shell source $(SCRIPT) && use --version)

test:
	bash test/runner.sh
	zsh test/runner.sh

release: tag
	git push origin --tags

tag:
	git tag -f latest
	git tag v$(VERSION)

install:
	cp $(SCRIPT) $(INSTALL_LOCATION)

uninstall:
	rm $(INSTALL_LOCATION)

.PHONY: test release tag install uninstall
