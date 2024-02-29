spring:
  application:
    name: wancheli-${moduleName}
  profiles:
    active: local

server:
  port: 0

# 日志文件配置。注意，如果 logging.file.name 不放在 bootstrap.yaml 配置文件，而是放在 application.yaml 中，会导致出现 LOG_FILE_IS_UNDEFINED 文件
logging:
  file:
    name: ${"$"}{user.home}/logs/${"$"}{spring.application.name}.log # 日志文件名，全路径

--- #################### 注册中心相关配置 ####################

spring:
  cloud:
    nacos:
      server-addr: ${"$"}{NACOS_HOST:nacos.basic}:${"$"}{NACOS_PORT:8848}
      discovery:
        namespace: ${"$"}{spring.profiles.active}
        # ip: 192.168.6.175
        metadata:
          version: ${"$"}{REG_VERSION:${"$"}{wancheli.info.version}}
        group: VMS
        username: ${"$"}{NACOS_USERNAME:nacos}
        password: ${"$"}{NACOS_PASSWORD:nacos}

--- #################### 配置中心相关配置 ####################

spring:
  cloud:
    nacos:
      # Nacos Config 配置项，对应 NacosConfigProperties 配置属性类
      config:
        name: cipher-aes-${"$"}{spring.application.name}
        server-addr: ${"$"}{NACOS_HOST:nacos.basic}:${"$"}{NACOS_PORT:8848}
        group: VMS # 使用的 Nacos 配置分组，默认为 DEFAULT_GROUP
        file-extension: yaml # 使用的 Nacos 配置集的 dataId 的文件拓展名，同时也是 Nacos 配置集的配置格式，默认为 properties
        namespace: ${"$"}{spring.profiles.active}
        username: ${"$"}{NACOS_USERNAME:nacos}
        password: ${"$"}{NACOS_PASSWORD:nacos}
