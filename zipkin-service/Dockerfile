# Use Maven to build the application
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app

# Copy the root POM from the parent directory
COPY ../../pom.xml /app/pom.xml

# Copy the service-specific POM and source files
COPY ./pom.xml /app/pom.xml
COPY ./src /app/src

# Build the project
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/target/zipkin-service.jar zipkin-service.jar

# Set the command to run the application
ENTRYPOINT ["java", "-jar", "zipkin-service.jar"]