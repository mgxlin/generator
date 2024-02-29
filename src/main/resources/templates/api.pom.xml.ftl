<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>com.wancheli</groupId>
        <artifactId>wancheli-module-${moduleName}</artifactId>
        <version>${"$"}{revision}</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>wancheli-module-${moduleName}-api</artifactId>
    <packaging>jar</packaging>

    <version>${"$"}{api.version}</version>
    <name>${"$"}{project.artifactId}</name>

    <dependencies>
        <dependency>
            <groupId>com.wancheli</groupId>
            <artifactId>wancheli-common</artifactId>
        </dependency>

        <!-- Web 相关 -->
        <dependency>
            <groupId>io.swagger</groupId>
            <artifactId>swagger-annotations</artifactId>
            <optional>true</optional>
        </dependency>

        <!-- 参数校验 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
            <optional>true</optional>
        </dependency>

        <!-- RPC 远程调用相关 -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
            <optional>true</optional>
        </dependency>

    </dependencies>

</project>
