.PHONY: run build

default: run

run:
	love .

build:
	makelove --config makelove.toml
