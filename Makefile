.PHONY: help run check

help:
	@echo "make run   - Start local PHP development server (port 8090)"
	@echo "make check - Check PHP syntax in project entry files"

run:
	php -S 127.0.0.1:8090 -t public

check:
	php -l bootstrap.php
	php -l config/config.php
	php -l public/index.php
