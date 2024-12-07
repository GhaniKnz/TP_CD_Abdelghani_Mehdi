# Utiliser une image Docker avec Maven et Java 21
FROM maven:3.9.4-eclipse-temurin-21 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers Maven et le projet dans l'image
COPY pom.xml .
COPY src ./src

# Compiler et empaqueter l'application
RUN mvn clean package -DskipTests

# Créer une image d'exécution légère
FROM eclipse-temurin:21-jdk-jammy

# Définir le répertoire de travail dans l'image finale
WORKDIR /app

# Copier le fichier JAR construit depuis l'étape précédente
COPY --from=build /app/target/*.jar app.jar

# Exposer le port de l'application
EXPOSE 8080

# Commande pour exécuter l'application
CMD ["java", "-jar", "app.jar"]
