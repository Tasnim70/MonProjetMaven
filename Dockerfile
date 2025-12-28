# Utiliser une image JDK pour build/production
FROM eclipse-temurin:17-jdk

# Copier le JAR généré par Maven
COPY target/TP-Projet-2025-0.0.1-SNAPSHOT.jar /app.jar

# Exposer le port sur lequel Spring Boot écoute
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "/app.jar"]
