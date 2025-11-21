# Java 21 Migration Plan - Status: In Progress

Scope
- Container: spring-boot-jpa-postgresql-174384 (backend only)
- Goal: Migrate build to Java 21 and Spring Boot 3.3.x, ensuring test/build plugins are Java 21 compatible without changing application code.

Changes applied (this step)
- Set Java version property to 21.
- Configured maven-compiler-plugin with <release>21</release> (declared in pluginManagement and plugins).
- Upgraded Spring Boot parent to 3.3.4 (Java 21 compatible).
- Pinned Maven Surefire and Failsafe plugins to 3.2.5 (3.2.x+ as required).
- Kept spring-boot-maven-plugin.
- No application source changes.

Next steps
- Validate build on JDK 21 using: ./mvnw -DskipTests=false clean verify
- Run app with dev profile to validate runtime: ./mvnw spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
- Review logs for deprecations or Jakarta namespace issues (none expected as code already uses jakarta.*).

Notes
- This repository uses the Maven Wrapper (./mvnw). Do not use system mvn.
- If Maven Toolchains are used, ensure a JDK 21 toolchain is available; otherwise the wrapper uses the runtime JDK with --release 21.
