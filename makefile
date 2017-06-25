MAKEFLAGS+=--ignore-errors
MAKEFLAGS+=--no-print-directory
SHELL:=/bin/bash

.PHONY: build
.PHONY: push
.PHONY: run

build:
	docker build --tag mahendrakalkura/php-5-fpm:latest .

push:
	docker push mahendrakalkura/php-5-fpm:latest

run:
	docker run mahendrakalkura/php-5-fpm:latest
