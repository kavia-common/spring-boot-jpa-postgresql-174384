#!/usr/bin/env bash
# Unified start script to ensure preview uses Maven Wrapper (./mvnw) instead of global mvn
# Shebang above is required for non-interactive runners.
# Requires: JDK 21 (JAVA_HOME or java on PATH)
# Usage:
#   bash ./run.sh             # default profile with PostgreSQL
#   bash ./run.sh dev         # dev profile (H2)

set -euo pipefail

# Ensure this script is executable (helps in some environments copying without perms)
chmod +x "$0" || true

# Ensure mvnw is executable to avoid permission issues in preview environments
if [[ ! -x "./mvnw" ]]; then
  # Try to set executable bit; if still missing or not present, exit with clear message.
  chmod +x ./mvnw 2>/dev/null || true
fi

# Guard: never fallback to 'mvn'. If ./mvnw is missing or not executable, exit clearly.
if [[ ! -f "./mvnw" || ! -x "./mvnw" ]]; then
  echo "ERROR: Maven Wrapper './mvnw' is required but not found or not executable." >&2
  echo "This environment is configured to use the Maven Wrapper only (no 'mvn' fallback)." >&2
  echo "Please ensure './mvnw' exists in project root and is executable (chmod +x ./mvnw)." >&2
  exit 127
fi

# Extra hardening: if a parent process invokes 'mvn' directly and PATH resolves to this repo,
# ensure the local 'mvn' shim exists and is executable to redirect to ./mvnw
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
