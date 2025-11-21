# Java 21 Migration Plan - Status: Wrapper Validated, Awaiting Java 21 Runtime in Preview/CI

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
- Enforced Java 21 with Maven Enforcer.
- Ensured all preview/start configs call ./mvnw (Makefile, Procfile, start.json, kavia.start, run.sh/start.sh, and mvn shim).

Validation results
- ./mvnw -v: SUCCESS. Maven Wrapper is functional (Apache Maven 3.9.6).
- ./mvnw -DskipTests=false clean verify: FAIL due to Enforcer rule RequireJavaVersion [21,) on this runner (Java 17.0.16 detected). This confirms the wrapper is working; the environment JDK must be 21+.

Required environment action
- Preview/CI must run with JDK 21. No code change is needed. The Maven Enforcer rule intentionally blocks older JDKs.
- If using toolchains, ensure ~/.m2/toolchains.xml defines a JDK 21 toolchain. Otherwise set JAVA_HOME to a JDK 21 installation.

Next steps
- Configure the preview/CI environment to provide Java 21 and rerun:
  ./mvnw -DskipTests=false clean verify
- Run app with dev profile to validate runtime:
  ./mvnw spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
- Review logs for deprecations or Jakarta namespace issues (none expected as code already uses jakarta.*).

Notes
- This repository uses the Maven Wrapper (./mvnw). Do not use system mvn.
- If Maven Toolchains are used, ensure a JDK 21 toolchain is available; otherwise the wrapper uses the runtime JDK with --release 21.
- A helper script (tools/check-java21.sh) is included to print a clear message if Java is not 21+.
