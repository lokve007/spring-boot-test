# Build stage
FROM eclipse-temurin:21-jdk as builder
WORKDIR /app
COPY . .
RUN ./gradlew clean bootJar

# Run stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
