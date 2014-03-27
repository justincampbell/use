HOMEPAGE=https://github.com/justincampbell/use
PREFIX=/usr/local

VERSION=$(shell source $(SCRIPT) && use --version)
TAG=v$(VERSION)

ARCHIVE=use-$(TAG).tar.gz
ARCHIVE_URL=$(HOMEPAGE)/archive/$(TAG).tar.gz
INSTALL_LOCATION=$(PREFIX)/$(SCRIPT)
SCRIPT=share/use/use.sh

test:
	bats test

release: tag sha

tag:
	git tag -f latest
	git tag | grep $(TAG) || git tag $(TAG)
	git push origin
	git push origin --tags -f

pkg/$(ARCHIVE): pkg/
	wget -O pkg/$(ARCHIVE) $(ARCHIVE_URL)

pkg/:
	mkdir pkg

sha: pkg/$(ARCHIVE)
	shasum pkg/$(ARCHIVE)

install:
	mkdir -p $(shell dirname $(INSTALL_LOCATION))
	cp $(SCRIPT) $(INSTALL_LOCATION)

uninstall:
	rm $(INSTALL_LOCATION)

.PHONY: test release tag sha install uninstall
