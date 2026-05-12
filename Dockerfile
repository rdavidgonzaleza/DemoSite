#esta imagen de maven (SE SUPONE xdd) que buildea la app
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests
RUN find . -name "*.jar" ! -name "*.original" -type f -exec du -b {} + | sort -n | tail -1 | cut -f2 | xargs -I{} cp {} /app/app.jar
#esta imagen de java lo que hará es ejecutar el sitio en sí mimso
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Xmx1024M", "-Dspring.profiles.active=development", "-jar", "app.jar"]
