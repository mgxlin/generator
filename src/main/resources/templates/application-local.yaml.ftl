spring:
  # 数据源配置项
  autoconfigure:
    exclude:
      - com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure # 排除 Druid 的自动配置，使用 dynamic-datasource-spring-boot-starter 配置多数据源
  datasource:
    druid: # Druid 【监控】相关的全局配置
      web-stat-filter:
        enabled: true
      stat-view-servlet:
        enabled: true
        allow: # 设置白名单，不填则允许所有访问
        url-pattern: /druid/*
        login-username: # 控制台管理用户名和密码
        login-password:
      filter:
        stat:
          enabled: true
          log-slow-sql: true # 慢 SQL 记录
          slow-sql-millis: 100
          merge-sql: true
        wall:
          config:
            multi-statement-allow: true
    dynamic: # 多数据源配置
      druid: # Druid 【连接池】相关的全局配置
        initial-size: 5 # 初始连接数
        min-idle: 10 # 最小连接池数量
        max-active: 20 # 最大连接池数量
        max-wait: 600000 # 配置获取连接等待超时的时间，单位：毫秒
        time-between-eviction-runs-millis: 60000 # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位：毫秒
        min-evictable-idle-time-millis: 300000 # 配置一个连接在池中最小生存的时间，单位：毫秒
        max-evictable-idle-time-millis: 900000 # 配置一个连接在池中最大生存的时间，单位：毫秒
        validation-query: SELECT 1 FROM DUAL # 配置检测连接是否有效
        test-while-idle: true
        test-on-borrow: false
        test-on-return: false
      primary: master
      datasource:
        master:
          name: wancheli-product
          url: jdbc:mysql://mysql-svc.default:3306/${"$"}{spring.datasource.dynamic.datasource.master.name}?allowMultiQueries=true&useUnicode=true&useSSL=false&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&autoReconnect=true&nullCatalogMeansCurrent=true # MySQL Connector/J 8.X 连接的示例
          username: u_develop
          password: ENC(Plr8rd5uWRaNFudRYHsnbSE2yNlC2oFaMcJea1EzKmv2TrlCwbW/BhZ5edCPtaerbEKuBatwf4C5TNsa/Yicwg==)
          public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIbasmacvuOBAw9MotV0i+7WaHwWcn3qlOLlWD+lG96EUjRQNGAVqHYjbGS55/2D5bjmLjbgFpZeOIgVaba8LwMCAwEAAQ==

        slave: # 模拟从库，可根据自己需要修改
          name: wancheli-product
          url: jdbc:mysql://mysql-svc.default:3306/${"$"}{spring.datasource.dynamic.datasource.slave.name}?allowMultiQueries=true&useUnicode=true&useSSL=false&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&autoReconnect=true&nullCatalogMeansCurrent=true # MySQL Connector/J 8.X 连接的示例
          username: u_develop
          password: ENC(Plr8rd5uWRaNFudRYHsnbSE2yNlC2oFaMcJea1EzKmv2TrlCwbW/BhZ5edCPtaerbEKuBatwf4C5TNsa/Yicwg==)
          public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIbasmacvuOBAw9MotV0i+7WaHwWcn3qlOLlWD+lG96EUjRQNGAVqHYjbGS55/2D5bjmLjbgFpZeOIgVaba8LwMCAwEAAQ==
        vms:
          name: vms_models
          url: jdbc:mysql://192.168.18.156:3306/${"$"}{spring.datasource.dynamic.datasource.vms.name}?allowMultiQueries=true&useUnicode=true&useSSL=false&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&autoReconnect=true&nullCatalogMeansCurrent=true # MySQL Connector/J 8.X 连接的示例
          username: u_develop
          password: ENC(DdQbD17CHS37CtkoM0zNnKWqoWC+8RNH9kCfEr8LanmusYVwEvnZ2CReHkKw5J1C7MvaPUBjCFYfPfg636H/AQ==)
          public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAJV9l13VfagdWLr36AKru08pS3hfccQQSpKzSC0Wk/pqMC/KILLPKPeu7YXCDsd6i9tclF3TPlG4UDzl2fOYTOECAwEAAQ==


  # Redis 配置。Redisson 默认的配置足够使用，一般不需要进行调优
  redis:
    sentinel:
      master: mymaster
      nodes:
        - 192.168.6.157:27001
        - 192.168.6.158:27003
        - 192.168.6.159:27002

--- #################### MQ 消息队列相关配置 ####################
spring:
  cloud:
    stream:
      # rocketmq:
      #   # RocketMQ Binder 配置项，对应 RocketMQBinderConfigurationProperties 类
      #   binder:
      #     name-server: 192.168.6.157:9876 # RocketMQ Namesrv 地址
      #   # Spring Cloud Stream RocketMQ 配置项
      #   default: # 默认 bindings 全局配置
      #     producer: # RocketMQ Producer 配置项，对应 RocketMQProducerProperties 类
      #       group: system_producer_group # 生产者分组
      #       send-type: SYNC # 发送模式，SYNC 同步
      binders:
        defaultRabbit:
          type: rabbit
          environment:
            spring:
              rabbitmq:
                addresses: 192.168.6.159
                password: guest
                port: 5672
                username: guest
                virtual-host: /
rabbitmq:
  host: 192.168.6.159
  port: 5672
  username: guest
  password: guest
  virtual-host: /

--- #################### 定时任务相关配置 ####################

xxl:
  job:
    admin:
      addresses: http://192.168.6.157:8089/xxl-job-admin # 调度中心部署跟地址

--- #################### 服务保障相关配置 ####################

# Lock4j 配置项
lock4j:
  acquire-timeout: 3000 # 获取分布式锁超时时间，默认为 3000 毫秒
  expire: 30000 # 分布式锁的超时时间，默认为 30 毫秒

wanguo-imp:
  url: http://192.168.6.95:19201
  appId: wcl_assistant
  secret: cce0cdac8644a7c542bb37ac98153271

--- #################### 监控相关配置 ####################

# Actuator 监控端点的配置项
management:
  endpoints:
    web:
      base-path: /actuator # Actuator 提供的 API 接口的根目录。默认为 /actuator
      exposure:
        include: '*' # 需要开放的端点。默认值只打开 health 和 info 两个端点。通过设置 * ，可以开放所有端点。

# Spring Boot Admin 配置项
# spring:
#   boot:
#     admin:
#       port: 37000
#       context-path: /
#       # Spring Boot Admin Client 客户端的相关配置
#       client:
#         url: http://boot-admin.wancheli.com:${"$"}{spring.boot.admin.port} # 设置 Spring Boot Admin Server 地址
#         instance:
#           prefer-ip: true # 注册实例时，优先使用 IP
#         username: admin
#         password: admin

# 日志文件配置
#logging:
#  level:
#    # 配置自己写的 MyBatis Mapper 打印日志
#    com.mgxlin.module.model.dal.mysql: debug
#    com.mgxlin.module.model.controller.admin: debug
#  config: classpath:logback-spring.xml

--- #################### 万车利相关配置 ####################
elasticsearch:
  host: 172.21.49.117:30017
  username: elastic
  password: elastic

# 万车利配置项，设置当前项目所有自定义的配置
wancheli:
  env: # 多环境的配置项
    tag: ${"$"}{HOSTNAME}
  captcha:
    enable: false # 本地环境，暂时关闭图片验证码，方便登录等接口的测试
  security:
    mock-enable: true
  xss:
    enable: false
    exclude-urls: # 如下两个 url，仅仅是为了演示，去掉配置也没关系
      - ${"$"}{spring.boot.admin.context-path}/** # 不处理 Spring Boot Admin 的请求
      - ${"$"}{management.endpoints.web.base-path}/** # 不处理 Actuator 的请求
  access-log: # 访问日志的配置项
    enable: false
  error-code: # 错误码相关配置项
    enable: false
  demo: false # 关闭演示模式

justauth:
  enabled: true
  type:
    DINGTALK: # 钉钉
      client-id: dingvrnreaje3yqvzhxg
      client-secret: i8E6iZyDvZj51JIb0tYsYfVQYOks9Cq1lgryEjFRqC79P3iJcrxEwT6Qk2QvLrLI
      ignore-check-redirect-uri: true
    WECHAT_ENTERPRISE: # 企业微信
      client-id: wwd411c69a39ad2e54
      client-secret: 1wTb7hYxnpT2TUbIeHGXGo7T0odav1ic10mLdyyATOw
      agent-id: 1000004
      ignore-check-redirect-uri: true
  cache:
    type: REDIS
    prefix: 'social_auth_state:' # 缓存前缀，目前只对 Redis 缓存生效，默认 JUSTAUTH::STATE::
    timeout: 24h # 超时时长，目前只对 Redis 缓存生效，默认 3 分钟

license:
  publicAlias: publicCert
  storePass: Wcl2023pwd
  licenseId: 25a66673348b4280ae854a52df320b27
  customerId: WCL2023070251438
  module: auth

feign:
  client:
    config:
      default:
        connect-timeout: 2000 # 单个远程调用超过2秒，认为超时
        read-timeout: 2000 # 读超时
  httpclient:
    enabled: false # 关闭 httpclient
    max-connections: 1000 # 最大连接数。默认为 200
    max-connections-per-route: 400 # 每个路由的最大连接数。默认为 50。
  okhttp:
    enabled: true # 启用性能更高的 okhttp
  sentinel:
    enabled: true

spring:
  cloud:
    sentinel:
      eager: true
      transport:
        dashboard: 192.168.6.167:8718
        port: 8719
        client-ip: 192.168.6.175

--- #################### 配置中心相关配置 ####################

spring:
  cloud:
    nacos:
      server-addr: nacos.basic:${"$"}{NACOS_PORT:8848}
      discovery:
        namespace: dev
        ip: 192.168.6.175
        metadata:
          version: lhb2
        group: VMS
        username: ${"$"}{NACOS_USERNAME:nacos}
        password: ${"$"}{NACOS_PASSWORD:nacos}
      # Nacos Config 配置项，对应 NacosConfigProperties 配置属性类
      config:
        name: cipher-aes-${"$"}{spring.application.name}
        server-addr: nacos.basic:${"$"}{NACOS_PORT:8848} # Nacos 服务器地址
        group: VMS # 使用的 Nacos 配置分组，默认为 DEFAULT_GROUP
        file-extension: yaml # 使用的 Nacos 配置集的 dataId 的文件拓展名，同时也是 Nacos 配置集的配置格式，默认为 properties
        namespace: dev
        username: ${"$"}{NACOS_USERNAME:nacos}
        password: ${"$"}{NACOS_PASSWORD:nacos}
server:
  port: 8081
