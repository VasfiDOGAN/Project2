FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/zipkin-service.jar zipkin-service.jar
ENTRYPOINT ["java", "-jar", "zipkin-service.jar"]
