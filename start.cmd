@echo off
REM Start script using Maven Wrapper to avoid dependency on global mvn
REM Requires: JDK 21 installed and JAVA_HOME set to JDK 21
REM Usage:
REM   start.cmd           - default profile with PostgreSQL
REM   start.cmd dev       - dev profile (H2)
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXECUTION
IF "%1"=="" (
  call .\mvnw.cmd spring-boot:run -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
) ELSE (
  call .\mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=%1 -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
)
ENDLOCAL
