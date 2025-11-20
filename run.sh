#!/usr/bin/env bash
# Unified start script to ensure preview uses Maven Wrapper (./mvnw) instead of global mvn
# Requires: JDK 21 (JAVA_HOME or java on PATH)
# Usage:
#   bash ./run.sh             # default profile with PostgreSQL
#   bash ./run.sh dev         # dev profile (H2)

set -euo pipefail

# Ensure mvnw is executable to avoid permission issues in preview environments
chmod +x ./mvnw || true

PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  exec ./mvnw spring-boot:run \
    -Dspring-boot.run.profiles="$PROFILE" \
    -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
else
  exec ./mvnw spring-boot:run \
    -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
fi
