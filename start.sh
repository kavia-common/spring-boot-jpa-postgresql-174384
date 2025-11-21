#!/usr/bin/env bash
# Start script using Maven Wrapper to avoid dependency on global mvn
# Requires: JDK 21 on PATH or JAVA_HOME pointing to JDK 21
# Usage:
#   ./start.sh              # default profile with PostgreSQL
#   ./start.sh dev          # dev profile (H2)
set -euo pipefail

# Ensure this script is executable
chmod +x "$0" || true

# Ensure mvnw is executable to avoid "permission denied" on some environments
if [[ ! -x "./mvnw" ]]; then
  chmod +x ./mvnw 2>/dev/null || true
fi

# Guard against missing mvnw; never fallback to system mvn
if [[ ! -f "./mvnw" || ! -x "./mvnw" ]]; then
  echo "ERROR: Maven Wrapper './mvnw' is required but not found or not executable." >&2
  echo "This project must use the Maven Wrapper (no 'mvn' fallback). Run: chmod +x ./mvnw" >&2
  exit 127
fi

# Extra hardening: ensure local mvn shim is executable if present (redirects to mvnw)
if [[ -f "./mvn" && ! -x "./mvn" ]]; then
  chmod +x ./mvn || true
fi

PROFILE="${1:-}"
if [[ -n "$PROFILE" ]]; then
  exec ./mvnw spring-boot:run \
    -Dspring-boot.run.profiles="$PROFILE" \
    -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
else
  exec ./mvnw spring-boot:run \
    -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
fi
