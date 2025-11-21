SHELL := /bin/bash

.PHONY: start start-dev verify-mvnw

verify-mvnw:
	@if [ ! -f "./mvnw" ]; then echo "ERROR: ./mvnw missing. No 'mvn' fallback allowed."; exit 127; fi
	@if [ ! -x "./mvnw" ]; then chmod +x ./mvnw || true; fi

start: verify-mvnw
	./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0

start-dev: verify-mvnw
	./mvnw spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
