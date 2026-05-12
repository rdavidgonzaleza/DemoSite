#esta imagen de maven (SE SUPONE xdd) que buildea la app
FROM maven:3.9-eclipse-temurin-17 AS build
COPY . .
RUN mvn clean install -DskipTests

#esta imagen de java lo que hará es ejecutar el sitio en sí mimso
FROM eclipse-temurin:17-jre-jammy
COPY --from=build /site/target/site.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
