# 第一阶段：使用 Maven 构建项目
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app

# 复制 pom.xml 文件，以便下载依赖项
COPY pom.xml .
# 下载 Maven 依赖项
RUN mvn clean install -DskipTests

# 复制整个项目源代码并构建
COPY src ./src
RUN mvn package -DskipTests

# 第二阶段：使用 OpenJDK 11 JRE 作为基础镜像
FROM openjdk:11-jre
WORKDIR /app

# 从第一阶段中复制构建好的 JAR 文件到当前镜像中
COPY --from=build /app/target/blog-springboot-2.0.jar app.jar

# 暴露应用程序运行的端口
EXPOSE 8080

# 启动 Java 应用程序
CMD ["java", "-jar", "app.jar"]
