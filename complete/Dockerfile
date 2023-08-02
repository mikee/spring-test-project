# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Spring application (JAR file) into the container
COPY target/rest-service-complete-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that your Spring application is running on
EXPOSE 8080

# Command to run the Spring application when the container starts
CMD ["java", "-jar", "app.jar"]
