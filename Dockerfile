# 该镜像需要依赖的基础镜像

FROM eclipse-temurin:11-jre

LABEL maintainer=jacky

COPY  blog-springboot-2.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
