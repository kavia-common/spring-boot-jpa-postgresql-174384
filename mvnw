#!/usr/bin/env sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# Standard Maven Wrapper launcher (Takari 0.5.6) with downloader fallback.
# This file is intentionally committed to ensure wrapper usage is consistent.

set -eu

if [ -z "${MAVEN_SKIP_RC:-}" ] ; then
  [ -f /etc/mavenrc ] && . /etc/mavenrc
  [ -f "$HOME/.mavenrc" ] && . "$HOME/.mavenrc"
fi

cygwin=false; darwin=false; mingw=false
case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  MINGW*) mingw=true ;;
  Darwin*) darwin=true
    if [ -z "${JAVA_HOME:-}" ]; then
      if [ -x "/usr/libexec/java_home" ]; then
        export JAVA_HOME="$(/usr/libexec/java_home)"
      else
        export JAVA_HOME="/Library/Java/Home"
      fi
    fi
    ;;
esac

if [ -z "${JAVA_HOME:-}" ] ; then
  if [ -r /etc/gentoo-release ] ; then
    JAVA_HOME=$(java-config --jre-home)
  fi
fi

if [ -z "${M2_HOME:-}" ] ; then
  PRG="$0"
  while [ -h "$PRG" ] ; do
    ls=$(ls -ld "$PRG")
    link=$(expr "$ls" : '.*-> \(.*\)$')
    if expr "$link" : '/.*' >/dev/null; then
      PRG="$link"
    else
      PRG="$(dirname "$PRG")/$link"
    fi
  done
  saveddir=$(pwd)
  M2_HOME=$(dirname "$PRG")/..
  M2_HOME=$(cd "$M2_HOME" && pwd)
  cd "$saveddir"
fi

$cygwin && [ -n "${M2_HOME:-}" ] && M2_HOME=$(cygpath --unix "$M2_HOME")
$cygwin && [ -n "${JAVA_HOME:-}" ] && JAVA_HOME=$(cygpath --unix "$JAVA_HOME")
$cygwin && [ -n "${CLASSPATH:-}" ] && CLASSPATH=$(cygpath --path --unix "$CLASSPATH")

$mingw && [ -n "${M2_HOME:-}" ] && M2_HOME="$(cd "$M2_HOME"; pwd)"
$mingw && [ -n "${JAVA_HOME:-}" ] && JAVA_HOME="$(cd "$JAVA_HOME"; pwd)"

if [ -z "${JAVACMD:-}" ]; then
  if [ -n "${JAVA_HOME:-}"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD="$(command -v java)"
  fi
fi

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly." >&2
  echo "  We cannot execute $JAVACMD" >&2
  exit 1
fi

[ -z "${JAVA_HOME:-}" ] && echo "Warning: JAVA_HOME environment variable is not set."

CLASSWORLDS_LAUNCHER=org.codehaus.plexus.classworlds.launcher.Launcher

find_maven_basedir() {
  [ -z "$1" ] && { echo "Path not specified to find_maven_basedir"; return 1; }
  basedir="$1"
  wdir="$1"
  while [ "$wdir" != '/' ] ; do
    if [ -d "$wdir/.mvn" ] ; then
      basedir="$wdir"
      break
    fi
    if [ -d "$wdir" ]; then
      wdir=$(cd "$wdir/.."; pwd)
    fi
  done
  echo "${basedir}"
}

concat_lines() { [ -f "$1" ] && tr -s '\n' ' ' < "$1"; }

BASE_DIR=$(find_maven_basedir "$(pwd)") || exit 1

if [ -r "$BASE_DIR/.mvn/wrapper/maven-wrapper.jar" ]; then
  [ "${MVNW_VERBOSE:-}" = true ] && echo "Found .mvn/wrapper/maven-wrapper.jar"
else
  [ "${MVNW_VERBOSE:-}" = true ] && echo "Couldn't find .mvn/wrapper/maven-wrapper.jar, downloading it ..."
  jarUrl="https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar"
  if [ -n "${MVNW_REPOURL:-}" ]; then
    jarUrl="$MVNW_REPOURL/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar"
  fi
  while IFS="=" read key value; do
    case "$key" in (wrapperUrl) jarUrl="$value"; break ;; esac
  done < "$BASE_DIR/.mvn/wrapper/maven-wrapper.properties"
  [ "${MVNW_VERBOSE:-}" = true ] && echo "Downloading from: $jarUrl"
  wrapperJarPath="$BASE_DIR/.mvn/wrapper/maven-wrapper.jar"
  $cygwin && wrapperJarPath=$(cygpath --path --windows "$wrapperJarPath")
  if command -v wget >/dev/null; then
    if [ -z "${MVNW_USERNAME:-}" ] || [ -z "${MVNW_PASSWORD:-}" ]; then
      wget "$jarUrl" -O "$wrapperJarPath"
    else
      wget --http-user="$MVNW_USERNAME" --http-password="$MVNW_PASSWORD" "$jarUrl" -O "$wrapperJarPath"
    fi
  elif command -v curl >/dev/null; then
    if [ -z "${MVNW_USERNAME:-}" ] || [ -z "${MVNW_PASSWORD:-}" ]; then
      curl -o "$wrapperJarPath" "$jarUrl" -f
    else
      curl --user "$MVNW_USERNAME:$MVNW_PASSWORD" -o "$wrapperJarPath" "$jarUrl" -f
    fi
  else
    javaClass="$BASE_DIR/.mvn/wrapper/MavenWrapperDownloader.java"
    $cygwin && javaClass=$(cygpath --path --windows "$javaClass")
    if [ -e "$javaClass" ]; then
      [ ! -e "$BASE_DIR/.mvn/wrapper/MavenWrapperDownloader.class" ] && ("$JAVA_HOME/bin/javac" "$javaClass")
      [ -e "$BASE_DIR/.mvn/wrapper/MavenWrapperDownloader.class" ] && ("$JAVA_HOME/bin/java" -cp .mvn/wrapper MavenWrapperDownloader "$MAVEN_PROJECTBASEDIR")
    fi
  fi
fi

export MAVEN_PROJECTBASEDIR="${MAVEN_BASEDIR:-"$BASE_DIR"}"
[ "${MVNW_VERBOSE:-}" = true ] && echo "$MAVEN_PROJECTBASEDIR"
MAVEN_OPTS="$(concat_lines "$MAVEN_PROJECTBASEDIR/.mvn/jvm.config") ${MAVEN_OPTS:-}"

$cygwin && [ -n "${M2_HOME:-}" ] && M2_HOME=$(cygpath --path --windows "$M2_HOME")
$cygwin && [ -n "${JAVA_HOME:-}" ] && JAVA_HOME=$(cygpath --path --windows "$JAVA_HOME")
$cygwin && [ -n "${CLASSPATH:-}" ] && CLASSPATH=$(cygpath --path --windows "$CLASSPATH")
$cygwin && [ -n "${MAVEN_PROJECTBASEDIR:-}" ] && MAVEN_PROJECTBASEDIR=$(cygpath --path --windows "$MAVEN_PROJECTBASEDIR")

MAVEN_CMD_LINE_ARGS="${MAVEN_CONFIG:-} $*"
export MAVEN_CMD_LINE_ARGS

WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

exec "$JAVACMD" \
  $MAVEN_OPTS \
  -classpath "$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar" \
  "-Dmaven.home=${M2_HOME:-}" "-Dmaven.multiModuleProjectDirectory=${MAVEN_PROJECTBASEDIR}" \
  ${WRAPPER_LAUNCHER} ${MAVEN_CONFIG:-} "$@"
