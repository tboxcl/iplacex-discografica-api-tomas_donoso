# Stage 1: Compilación de la aplicación
FROM gradle:8.5-jdk21 AS build

WORKDIR /app

COPY . .

RUN gradle clean build -x test


# Stage 2: Ejecución de la aplicación
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/discografia-1.war app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.war"]