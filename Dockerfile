#esta imagen de maven (SE SUPONE xdd) que buildea la app
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests
#esta imagen de java lo que hará es ejecutar el sitio en sí mimso
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/site/target/*.jar ./
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -Xmx512M -Dspring.profiles.active=development -jar $(ls *.jar | grep site | grep -v \"original\" | head -n 1)"]
