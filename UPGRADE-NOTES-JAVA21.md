# Java 21 Upgrade Summary

This project has been upgraded to target Java 21 with Spring Boot 3.3.x.

Modified files:
- pom.xml
- README.md
- Procfile (ensures ./mvnw)
- Added Maven Wrapper: .mvn/wrapper/*, mvnw, mvnw.cmd, mvn shim, run/start scripts adjusted

Key changes:
- Set Java release to 21 and enforce with Maven Enforcer.
- Pin PostgreSQL driver to 42.7.4 and H2 (dev) to 2.2.224.
- Ensure Surefire/Failsafe are Java 21 compatible (3.3.0).
- Keep Spring Boot parent at 3.3.4 (Java 21 compatible).
- Codebase already uses `jakarta.*` and is compatible with Boot 3.x.
- Maven Wrapper added to remove need for global Maven.

Build validation:
- To compile and run tests: `./mvnw -DskipTests=false clean verify` (requires JDK 21).
- To run the app: `./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0`

## Dependency Chart (post Java 21 migration)

- Java: 21 (LTS)
- Spring Boot: 3.3.4 (parent)
- spring-boot-starter-web: managed by Boot 3.3.4
- spring-boot-starter-data-jpa: managed by Boot 3.3.4
- Hibernate/Jakarta: managed by Boot 3.3.4 (Jakarta namespace)
- PostgreSQL JDBC driver: 42.7.4 (runtime)
- H2 (dev/runtime for "dev" profile): 2.2.224
- Maven Compiler Plugin: 3.13.0 (release=21)
- Maven Enforcer Plugin: 3.5.0
- Maven Surefire Plugin: 3.3.0
- Maven Failsafe Plugin: 3.3.0
- Spring Boot Maven Plugin: managed by Boot parent

## Notes on Toolchains

If you use Maven Toolchains, provide a JDK 21 toolchain in ~/.m2/toolchains.xml. Otherwise, the wrapper will use the runtime JDK with `--release 21` configured via maven-compiler-plugin.
