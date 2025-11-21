# Java 21 Upgrade Summary

This project has been upgraded to target Java 21 with Spring Boot 3.3.x.

Modified files:
- pom.xml
- README.md

Key changes:
- Set Java release to 21 and enforce with Maven Enforcer.
- Pin PostgreSQL driver to 42.7.4 and H2 (dev) to 2.2.224.
- Ensure Surefire/Failsafe are Java 21 compatible (3.3.0).
- Keep Spring Boot parent at 3.3.4 (Java 21 compatible).
- Codebase already uses `jakarta.*` and is compatible with Boot 3.x.

Build validation:
- To compile and run tests: `./mvnw -DskipTests=false clean verify` (requires JDK 21).
- To run the app: `./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0`
