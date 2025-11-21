# Spring Boot JPA PostgreSQL example with Maven (Wrapper-enabled)

This repository includes the Maven Wrapper so you can build and run without a global Maven installation. Always use ./mvnw (or mvnw.cmd on Windows).

For instruction, please visit:
> [Spring Boot PostgreSQL with Maven example using Spring Data JPA](https://www.bezkoder.com/spring-boot-postgresql-example/)

Front-end that works well with this Back-end
> [Angular 8](https://www.bezkoder.com/angular-crud-app/) / [Angular 10](https://www.bezkoder.com/angular-10-crud-app/) / [Angular 11](https://www.bezkoder.com/angular-11-crud-app/) / [Angular 12](https://www.bezkoder.com/angular-12-crud-app/) / [Angular 13](https://www.bezkoder.com/spring-boot-angular-13-postgresql/) / [Angular 14](https://www.bezkoder.com/spring-boot-angular-14-postgresql/) / [Angular 15](https://www.bezkoder.com/spring-boot-angular-15-postgresql/) / [Angular 16](https://www.bezkoder.com/spring-boot-angular-16-postgresql/) / [Angular 17 Client](https://www.bezkoder.com/angular-17-crud-example/)

> [Vue 2](https://www.bezkoder.com/vue-js-crud-app/) / [Vue 3](https://www.bezkoder.com/vue-3-crud/) / [Vuetify Client](https://www.bezkoder.com/vuetify-data-table-example/)

> [React](https://www.bezkoder.com/react-crud-web-api/) / [React Redux Client](https://www.bezkoder.com/react-redux-crud-example/)

More practice:
> [Spring Boot Validate Request Body](https://www.bezkoder.com/spring-boot-validate-request-body/)

> [Spring Boot File upload example with Multipart File](https://www.bezkoder.com/spring-boot-file-upload/)

> [Spring Boot Pagination & Filter example | Spring JPA, Pageable](https://www.bezkoder.com/spring-boot-pagination-filter-jpa-pageable/)

> [Spring Data JPA Sort/Order by multiple Columns | Spring Boot](https://www.bezkoder.com/spring-data-sort-multiple-columns/)

> [Spring Boot Repository Unit Test with @DataJpaTest](https://www.bezkoder.com/spring-boot-unit-test-jpa-repo-datajpatest/)

> [Spring Boot Rest Controller Unit Test with @WebMvcTest](https://www.bezkoder.com/spring-boot-webmvctest/)

> Cache the result: [Spring Boot Redis Cache example](https://www.bezkoder.com/spring-boot-redis-cache-example/)

> Documentation: [Spring Boot with Swagger 3 example](https://www.bezkoder.com/spring-boot-swagger-3/)

> Reactive Rest API: [Spring Boot WebFlux example](https://www.bezkoder.com/spring-boot-webflux-rest-api/)

> [Deploy Spring Boot App on AWS – Elastic Beanstalk](https://www.bezkoder.com/deploy-spring-boot-aws-eb/)

Associations:
> [Spring Boot One To One example with Spring JPA, Hibernate](https://www.bezkoder.com/jpa-one-to-one/)

> [Spring Boot One To Many example with Spring JPA, Hibernate](https://www.bezkoder.com/jpa-one-to-many/)

> [Spring Boot Many To Many example with Spring JPA, Hibernate](https://www.bezkoder.com/jpa-many-to-many/)

Security:
> [Spring Boot, Spring Security, PostgreSQL: JWT Authentication & Authorization example](https://www.bezkoder.com/spring-boot-security-postgresql-jwt-authentication/)

Exception Handling:
> [Spring Boot @ControllerAdvice & @ExceptionHandler example](https://www.bezkoder.com/spring-boot-controlleradvice-exceptionhandler/)

> [@RestControllerAdvice example in Spring Boot](https://www.bezkoder.com/spring-boot-restcontrolleradvice/)

Fullstack:
> [Vue.js + Spring Boot + MySQL/PostgreSQL example](https://www.bezkoder.com/spring-boot-vue-js-crud-example/)

> [Angular 10 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/angular-10-spring-boot-postgresql/)

> [Angular 11 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/angular-11-spring-boot-postgresql/)

> [Angular 12 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-12-postgresql/)

> [Angular 13 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-13-postgresql/)

> [Angular 14 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-14-postgresql/)

> [Angular 15 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-15-postgresql/)

> [Angular 16 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-16-postgresql/)

> [Angular 17 + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-angular-17-postgresql/)

> [React + Spring Boot + PostgreSQL example](https://www.bezkoder.com/spring-boot-react-postgresql/)

Run both Back-end & Front-end in one place:
> [Integrate Angular with Spring Boot Rest API](https://www.bezkoder.com/integrate-angular-spring-boot/)

> [Integrate React.js with Spring Boot Rest API](https://www.bezkoder.com/integrate-reactjs-spring-boot/)

> [Integrate Vue.js with Spring Boot Rest API](https://www.bezkoder.com/integrate-vue-spring-boot/)

## Java 21 and Dependency Compatibility

This project targets Java 21 and Spring Boot 3.3.x and uses the Jakarta namespace (e.g., `jakarta.persistence`). No `javax.*` remains.

- Java: 21 (LTS)
- Spring Boot: 3.3.4
- Spring Data JPA and Hibernate: managed by Boot 3.3.x (Jakarta, Java 21 compatible)
- PostgreSQL JDBC driver: 42.7.4
- H2 (dev profile): 2.2.224
- Maven Surefire/Failsafe: 3.3.0
- Maven Enforcer: 3.5.0
- maven-compiler-plugin: 3.13.0 (release 21)

If you use Maven Toolchains, ensure your `~/.m2/toolchains.xml` provides a JDK 21 toolchain; otherwise the build uses the runtime JDK and `--release 21`.

## Run Spring Boot application

This project includes the Maven Wrapper (`./mvnw`) and targets Java 21 with Spring Boot 3.3.x. No global Maven installation is required.

Prerequisites:
- JDK 21 (e.g., Eclipse Temurin 21)
- Maven Wrapper included (no separate Maven install required)

Verify Maven Wrapper and Java:
```
./mvnw -v
```

Build and run tests:
```
./mvnw -DskipTests=false clean verify
```

Run with PostgreSQL (default profile) on port 3001:
```
./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
```
Note: Requires a running PostgreSQL instance configured as in `src/main/resources/application.properties`.

Run with in-memory H2 (dev profile) on port 3001 (no PostgreSQL required):
```
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.arguments=--server.port=3001 --server.address=0.0.0.0
```

Optional helper scripts (always use Maven Wrapper; no global 'mvn' fallback):
```
./start.sh         # default PostgreSQL profile (uses ./mvnw)
./start.sh dev     # H2 profile (uses ./mvnw)
bash ./run.sh      # unified preview/start entry (uses ./mvnw)
bash ./run.sh dev  # run with 'dev' profile (uses ./mvnw)
```

## Notes

- The build enforces Java 21 via Maven Enforcer.
- Surefire/Failsafe plugins are pinned for Java 21 compatibility.
- Codebase already uses `jakarta.*` annotations and packages and is compatible with Boot 3.x.
- See UPGRADE-NOTES-JAVA21.md for a concise summary of changes.
