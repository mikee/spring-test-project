# Stage 1: Build stage
FROM gradle:jdk17-alpine AS build
WORKDIR /app
COPY build.gradle .
COPY src/ /app/src/
RUN gradle clean build --no-daemon

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /app/build/libs/*SNAPSHOT.jar /app/app.jar

# Create a non-root user without sudo permissions
RUN addgroup -S appgroup && adduser -S appuser -G appgroup -u 1000 -s /sbin/nologin
RUN chown -R appuser:appgroup /app
USER appuser

ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0"

CMD ["java", "-jar", "/app/app.jar"]
