#esta imagen de maven (SE SUPONE xdd) que buildea la app
FROM maven:3.8.4-openjdk-17 AS build
COPY . .
RUN mvn clean install -DskipTests

#esta imagen de java lo que hará es ejecutar el sitio en sí mimso
FROM openjdk:17-jdk-slim
COPY --from=build /site/target/site.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
