# Stage 1: Build the projects
FROM maven:3.8.6-openjdk-11-slim AS build

# Set the working directory
WORKDIR /app

# Copy the parent POM and build the root project
COPY pom.xml /app/pom.xml

# Copy all the microservice directories into the build context
COPY account-service /app/account-service
COPY customer-service /app/customer-service
COPY discovery-service /app/discovery-service
COPY gateway-service /app/gateway-service
COPY zipkin-service /app/zipkin-service

# Install the dependencies and build each microservice
RUN mvn clean install -DskipTests

# Stage 2: Prepare a runtime image (for a specific service, e.g., zipkin-service)
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built artifact from the build stage to the runtime stage
COPY --from=build /app/zipkin-service/target/zipkin-service.jar zipkin-service.jar

# Expose any ports your service needs
EXPOSE 9411

# Command to run the service
ENTRYPOINT ["java", "-jar", "zipkin-service.jar"]