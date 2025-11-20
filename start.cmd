@echo off
REM Start script using Maven Wrapper to avoid dependency on global mvn
REM Usage:
REM   start.cmd           - default profile with PostgreSQL
REM   start.cmd dev       - dev profile (H2)
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXECUTION
IF "%1"=="" (
  call .\mvnw.cmd spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=3001 -Dserver.address=0.0.0.0"
) ELSE (
  call .\mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=%1 -Dspring-boot.run.jvmArguments="-Dserver.port=3001 -Dserver.address=0.0.0.0"
)
ENDLOCAL
