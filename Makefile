VERSION	?= $(shell git describe --tags)
PREFIX	?= ""

MANPAGES := u-boot-update.8 u-boot-menu-ng.conf.5

all: $(MANPAGES)

$(MANPAGES): %: docs/%.md
	pandoc $< -s -t man \
		-V version="$(VERSION)" \
		-M footer="u-boot-menu-ng $(VERSION)" \
		-o $@

clean:
	rm -f $(MANPAGES)
