ifneq (,)
.error This Makefile requires GNU Make.
endif

PWD := $(abspath .)
CONTAINER_REGISTRY := goldeelox
CONTAINER_IMAGE_NAME := gitchangelog

.PHONY: build
build:
	@printf "Building container image..."
	@nerdctl build -t $(CONTAINER_REGISTRY)/$(CONTAINER_IMAGE_NAME):latest .
	@printf "done\n"

.PHONY: release
release:
	$(MAKE) changelog
	@git tag -d $(CURRENT_TAG)
	@git commit --no-edit --amend --include CHANGELOG.md
	@git tag $(CURRENT_TAG)

.PHONY: changelog
changelog:
	@printf "Generating changelog..."
	@nerdctl run --rm -v $(PWD):/data goldeelox/gitchangelog > CHANGELOG.md
	@printf "done\n"
