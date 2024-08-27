
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app
COPY ../pom.xml /app/../pom.xml  
COPY ./pom.xml /app/pom.xml       
COPY ./src /app/src               
RUN mvn clean package -DskipTests
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/zipkin-service.jar zipkin-service.jar
ENTRYPOINT ["java", "-jar", "zipkin-service.jar"]
