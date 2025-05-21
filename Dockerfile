# # Build stage
# FROM eclipse-temurin:21-jdk as builder
# WORKDIR /app
# COPY . .
# RUN ./gradlew clean bootJar

# # Run stage
# FROM eclipse-temurin:21-jre
# WORKDIR /app
# COPY --from=builder /app/build/libs/*.jar app.jar
# ENTRYPOINT ["java", "-jar", "app.jar"]


# Build stage
FROM gradle:8.7-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle clean build

# Run stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
