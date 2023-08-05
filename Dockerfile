FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /workspace/app

COPY . /workspace/app/

WORKDIR /workspace/app/complete

RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build && \
    mv build/libs/rest-service-*-SNAPSHOT.jar build/libs/app.jar
 

# make a slim down jre
RUN apk add --no-cache binutils && \
    $JAVA_HOME/bin/jlink \
         --verbose \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /slimjre

FROM alpine:latest

ENV JAVA_HOME=/jre
ENV PATH="${JAVA_HOME}/bin:${PATH}"
COPY --from=build /slimjre $JAVA_HOME

RUN addgroup -S appuser && adduser -S appuser -G appuser

VOLUME /tmp
ARG DEPENDENCY=/workspace/app/complete/build
COPY --from=build ${DEPENDENCY}/libs /app/libs
COPY --from=build ${DEPENDENCY}/resolvedMainClassName /app/resolvedMainClassName
EXPOSE 8080

#remove packages that are not needed for this deployment
RUN apk del busybox busybox-binsh zlib && \
    apk update && apk upgrade && \
    chown -R appuser:appuser /app

WORKDIR /app
USER appuser
ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar libs/app.jar"]