# Start with a base image containing Java runtime
FROM openjdk:8u212-jdk-slim
# Add Maintainer Info
LABEL maintainer="s.ali.abbas.raza@gmail.com"
# Add a volume pointing to /tmp
VOLUME /tmp
# Make port 8080 available to the world outside this container
EXPOSE 8080
# The application's jar file (when packaged)
ARG JAR_FILE=target/spring-user-api-0.0.1-SNAPSHOT.jar
# Add the application's jar to the container
ADD ${JAR_FILE} spring-user-api.jar
# Run the jar file
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/spring-user-api.jar"]