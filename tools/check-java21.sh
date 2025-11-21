#!/usr/bin/env bash
# Simple helper to verify that Java 21+ is available for the build and print actionable guidance.
# Intended for preview/CI environments to fail-fast with a clear message if Java is too old.

set -euo pipefail

required_major=21

# Determine java version
if ! command -v java >/dev/null 2>&1; then
  echo "ERROR: 'java' not found on PATH. Please install JDK ${required_major}+ and set JAVA_HOME accordingly." >&2
  exit 2
fi

# Parse version string like 'openjdk version "21.0.4"' or 'java version "17.0.16"'
ver_str="$(java -version 2>&1 | head -n1)"
# Extract the major version number (21, 17, etc.)
if [[ "$ver_str" =~ \"([0-9]+)\. ]]; then
  major="${BASH_REMATCH[1]}"
else
  echo "WARNING: Unable to parse Java version from: $ver_str" >&2
  major=0
fi

if (( major < required_major )); then
  echo "ERROR: Detected Java major version ${major}. This project requires Java ${required_major}+." >&2
  echo "Please configure the preview/CI environment to use JDK ${required_major} (e.g., Temurin 21) and set JAVA_HOME." >&2
  echo "Then re-run: ./mvnw -DskipTests=false clean verify" >&2
  exit 3
fi

echo "Java version check OK: $ver_str (major ${major})"
exit 0
