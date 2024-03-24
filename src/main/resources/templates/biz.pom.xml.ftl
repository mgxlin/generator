<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>com.mgxlin</groupId>
        <artifactId>wancheli-module-${moduleName}</artifactId>
        <version>${"$"}{revision}</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>wancheli-module-${moduleName}-biz</artifactId>
    <packaging>jar</packaging>

    <name>${"$"}{project.artifactId}</name>

    <dependencies>

        <!-- Registry 注册中心相关 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>com.alibaba.nacos</groupId>
                    <artifactId>nacos-client</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- Config 配置中心相关 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>com.alibaba.nacos</groupId>
                    <artifactId>nacos-client</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>com.alibaba.nacos</groupId>
            <artifactId>nacos-client</artifactId>
            <version>2.1.0</version>
        </dependency>

        <!-- Spring Cloud 基础 -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-bootstrap</artifactId>
        </dependency>

        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-env</artifactId>
        </dependency>

        <!-- 依赖服务 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-module-${moduleName}-api</artifactId>
            <version>${"$"}{api.version}</version>
        </dependency>

        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-module-generator</artifactId>
            <version>${"$"}{api.version}</version>
        </dependency>

        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-module-infra-api</artifactId>
            <version>1.0.0</version>
        </dependency>

        <!-- 业务组件 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-banner</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-operatelog</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-sms</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-dict</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-data-permission</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-social</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-tenant</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-error-code</artifactId>
        </dependency>
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-biz-ip</artifactId>
        </dependency>

        <!-- Web 相关 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-security</artifactId>
        </dependency>

        <!-- DB 相关 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-mybatis</artifactId>
        </dependency>

        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-redis</artifactId>
        </dependency>

        <!-- RPC 远程调用相关 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-rpc</artifactId>
        </dependency>

        <!-- Registry 注册中心相关 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>

        <!-- Config 配置中心相关 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
        </dependency>

        <dependency>
            <groupId>io.github.resilience4j</groupId>
            <artifactId>resilience4j-core</artifactId>
            <version>1.7.0</version>
        </dependency>
        <dependency>
            <groupId>io.github.resilience4j</groupId>
            <artifactId>resilience4j-spring-boot2</artifactId>
            <version>1.7.0</version>
        </dependency>

        <!-- 服务保障相关 TODO ：暂时去掉 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-protection</artifactId>
        </dependency>

        <!-- Test 测试相关 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- 监控相关 -->
        <dependency>
            <groupId>com.mgxlin</groupId>
            <artifactId>wancheli-spring-boot-starter-monitor</artifactId>
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>2.7.8</version> <!-- 如果 spring.boot.version 版本修改，则这里也要跟着修改 -->
                <configuration>
                    <fork>true</fork>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal> <!-- 将引入的 jar 打入其中 -->
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
