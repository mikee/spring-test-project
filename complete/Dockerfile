# Stage 1: Build the application
FROM gradle:jdk17-alpine AS build
WORKDIR /app
COPY build.gradle .
COPY src/ /app/src/
RUN gradle clean build --no-daemon

# Stage 2: Create the final image
FROM eclipse-temurin:17.0.7_7-jdk-jammy

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/*.jar /app/app.jar

# Expose the port on which the application will run
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]