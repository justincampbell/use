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
	git tag --force latest
	git tag | grep $(TAG) || git tag --message "Release $(TAG)" --sign $(TAG)
	git push origin
	git push origin --force --tags

pkg/$(ARCHIVE): pkg/
	wget --output-document pkg/$(ARCHIVE) $(ARCHIVE_URL)

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
