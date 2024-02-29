<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>com.wancheli</groupId>
        <artifactId>wancheli-dependencies</artifactId>
        <version>1.0.0</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>

    <modules>
        <module>wancheli-module-${moduleName}-api</module>
        <module>wancheli-module-${moduleName}-biz</module>
    </modules>

    <artifactId>wancheli-module-${moduleName}</artifactId>
    <version>${"$"}{revision}</version>
    <packaging>pom</packaging>

    <name>${"$"}{project.artifactId}</name>

    <repositories>
        <repository>
            <id>nexus</id>
            <url>http://192.168.6.95:8081/repository/maven-public/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
        </repository>
    </repositories>

    <distributionManagement>
        <repository>
            <id>nexus</id>
            <name>maven-releases</name>
            <url>http://192.168.6.95:8081/repository/maven-releases/</url>
        </repository>
        <snapshotRepository>
            <id>nexus</id>
            <name>maven-snapshot</name>
            <url>http://192.168.6.95:8081/repository/maven-snapshots/</url>
        </snapshotRepository>
    </distributionManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>${"$"}{maven-surefire-plugin.version}</version>
                <configuration>
                    <skipTests>true</skipTests>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${"$"}{maven-compiler-plugin.version}</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.springframework.boot</groupId>
                            <artifactId>spring-boot-configuration-processor</artifactId>
                            <version>${"$"}{spring.boot.version}</version>
                        </path>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>${"$"}{lombok.version}</version>
                        </path>
                        <path>
                            <groupId>org.mapstruct</groupId>
                            <artifactId>mapstruct-processor</artifactId>
                            <version>${"$"}{mapstruct.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <profiles>
        <!-- 本地环境（默认）-->
        <profile>
            <id>local</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <profiles.avtive>local</profiles.avtive>
                <api.version>${"$"}{revision}-SNAPSHOT</api.version>
            </properties>
        </profile>
        <!-- 开发环境-->
        <profile>
            <id>dev</id>
            <properties>
                <profiles.avtive>dev</profiles.avtive>
                <api.version>${"$"}{revision}-SNAPSHOT</api.version>
            </properties>

            <repositories>
                <repository>
                    <id>nexus</id>
                    <url>http://192.168.6.95:8081/repository/dev-public/</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>

            <distributionManagement>
                <repository>
                    <id>nexus</id>
                    <name>maven-releases</name>
                    <url>http://192.168.6.95:8081/repository/dev-releases/</url>
                </repository>
                <snapshotRepository>
                    <id>nexus</id>
                    <name>maven-snapshot</name>
                    <url>http://192.168.6.95:8081/repository/dev-snapshots/</url>
                </snapshotRepository>
            </distributionManagement>
        </profile>
        <!-- 测试环境-->
        <profile>
            <id>test</id>
            <properties>
                <profiles.avtive>test</profiles.avtive>
                <api.version>${"$"}{revision}-SNAPSHOT</api.version>
            </properties>

            <repositories>
                <repository>
                    <id>nexus</id>
                    <url>http://192.168.6.95:8081/repository/test-public/</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>

            <distributionManagement>
                <repository>
                    <id>nexus</id>
                    <name>maven-releases</name>
                    <url>http://192.168.6.95:8081/repository/test-releases/</url>
                </repository>
                <snapshotRepository>
                    <id>nexus</id>
                    <name>maven-snapshot</name>
                    <url>http://192.168.6.95:8081/repository/test-snapshots/</url>
                </snapshotRepository>
            </distributionManagement>

        </profile>
        <!-- 生产环境 -->
        <profile>
            <id>prod</id>
            <properties>
                <profiles.avtive>prod</profiles.avtive>
                <api.version>${"$"}{revision}</api.version>
            </properties>
        </profile>
    </profiles>
</project>
