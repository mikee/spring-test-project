FROM openjdk:11
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY complete/target/rest-service-complete-0.0.1-SNAPSHOT.jar springtestproject.jar
EXPOSE 8080
ENTRYPOINT exec java $JAVA_OPTS -jar springtestproject.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar springtestproject.jar
