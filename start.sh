#!/usr/bin/env bash
# Start script using Maven Wrapper to avoid dependency on global mvn
# Requires: JDK 21 on PATH or JAVA_HOME pointing to JDK 21
# Usage:
#   ./start.sh              # default profile with PostgreSQL
#   ./start.sh dev          # dev profile (H2)
set -euo pipefail

# Ensure mvnw is executable to avoid "permission denied" on some environments
if [[ ! -x "./mvnw" ]]; then
  chmod +x ./mvnw || true
fi

PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  ./mvnw spring-boot:run -Dspring-boot.run.profiles="$PROFILE" -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
else
  ./mvnw spring-boot:run -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
fi
