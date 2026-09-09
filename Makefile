.DEFAULT_GOAL := help
.PHONY: help setup tools editor run format lint check
help:
	@echo 'make setup  - install Godot and development tools'
	@echo 'make tools  - sync Python development tools from uv.lock'
	@echo 'make editor / run / format / lint / check'
setup: tools
	./scripts/setup.sh
tools:
	UV_CACHE_DIR="$(CURDIR)/.tools/uv-cache" uv sync --locked
editor:
	./scripts/godot.sh --editor --path game
run:
	./scripts/godot.sh --path game
format:
	./scripts/style.sh format
lint:
	./scripts/style.sh lint
check:
	./scripts/check.sh
