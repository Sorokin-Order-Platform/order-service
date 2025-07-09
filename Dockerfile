# Финальный образ (только JAR и JDK)
FROM eclipse-temurin:21-jdk-alpine

# Копируем только собранный JAR (должен быть собран в /target)
COPY /target/*.jar app.jar

# Безопаснее запускать не от root
RUN addgroup -S app && adduser -S app -G app
USER app

ENTRYPOINT ["java", "-jar", "app.jar"]
