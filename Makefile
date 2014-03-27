SCRIPT=share/use/use.sh
INSTALL_LOCATION=/usr/local/$(SCRIPT)
VERSION=$(shell source $(SCRIPT) && use --version)

test:
	bats test

release: tag
	git push origin
	git push origin --tags -f

tag:
	git tag -f latest
	git tag v$(VERSION)

install:
	mkdir -p $(shell dirname $(INSTALL_LOCATION))
	cp $(SCRIPT) $(INSTALL_LOCATION)

uninstall:
	rm $(INSTALL_LOCATION)

.PHONY: test release tag install uninstall
