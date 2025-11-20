#!/usr/bin/env bash
# Start script using Maven Wrapper to avoid dependency on global mvn
# Usage:
#   ./start.sh              # default profile with PostgreSQL
#   ./start.sh dev          # dev profile (H2)
set -euo pipefail

PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  ./mvnw spring-boot:run -Dspring-boot.run.profiles="$PROFILE" -Dspring-boot.run.jvmArguments="-Dserver.port=3001 -Dserver.address=0.0.0.0"
else
  ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=3001 -Dserver.address=0.0.0.0"
fi
