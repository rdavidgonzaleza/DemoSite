#esta imagen de maven (SE SUPONE xdd) que buildea la app
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests
#esta imagen de java lo que hará es ejecutar el sitio en sí mimso
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/site/target/site-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=development", "-jar", "app.jar"]
