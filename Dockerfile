# # Use an official OpenJDK image
# FROM openjdk:17-jdk-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the Spring Boot JAR file into the container
# COPY target/*.jar app.jar

# # Expose the application port (adjust if necessary)
# EXPOSE 8080

# # Run the application
# ENTRYPOINT ["java", "-jar", "app.jar"]

# Gunakan image Maven untuk build aplikasi sebelum runtime
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory dalam container
WORKDIR /app

# Salin file proyek ke dalam container
COPY . .

# Jalankan Maven build
RUN mvn clean package -DskipTests

# Gunakan image OpenJDK yang lebih ringan untuk menjalankan aplikasi
FROM openjdk:17-jdk-slim

# Set working directory untuk runtime
WORKDIR /app

# Salin JAR hasil build dari stage sebelumnya
COPY --from=build /app/target/*.jar app.jar

# Expose port Spring Boot (ubah jika perlu)
EXPOSE 8080

# Jalankan aplikasi Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
