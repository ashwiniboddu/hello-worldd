FROM openjdk:17
WORKDIR /app
COPY target/Hello-World-0.0.1-SNAPSHOT.jar /app/
EXPOSE 8084
ENTRYPOINT ["java", "-jar", "Hello-World-0.0.1-SNAPSHOT.jar"]