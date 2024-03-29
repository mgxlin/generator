spring:
  main:
    allow-circular-references: true # 允许循环依赖，因为项目是三层架构，无法避免这个情况。
    allow-bean-definition-overriding: true # 允许 Bean 覆盖，例如说 Dubbo 或者 Feign 等会存在重复定义的服务

  # Servlet 配置
  servlet:
    # 文件上传相关配置项
    multipart:
      max-file-size: 16MB # 单个文件大小
      max-request-size: 32MB # 设置总上传的文件大小
  mvc:
    pathmatch:
      matching-strategy: ANT_PATH_MATCHER # 解决 SpringFox 与 SpringBoot 2.6.x 不兼容的问题，参见 SpringFoxHandlerProviderBeanPostProcessor 类

  # Jackson 配置项
  jackson:
    serialization:
      write-dates-as-timestamps: true # 设置 LocalDateTime 的格式，使用时间戳
      write-date-timestamps-as-nanoseconds: false # 设置不使用 nanoseconds 的格式。例如说 1611460870.401，而是直接 1611460870401
      write-durations-as-timestamps: true # 设置 Duration 的格式，使用时间戳
      fail-on-empty-beans: false # 允许序列化无属性的 Bean

  # Cache 配置项
  cache:
    type: REDIS
    redis:
      time-to-live: 1h # 设置过期时间为 1 小时

# MyBatis Plus 的配置项
mybatis-plus:
  configuration:
    map-underscore-to-camel-case: true # 虽然默认为 true ，但是还是显示去指定下。
  global-config:
    db-config:
      id-type: NONE # “智能”模式，基于 IdTypeEnvironmentPostProcessor + 数据源的类型，自动适配成 AUTO、INPUT 模式。
      logic-delete-value: 1 # 逻辑已删除值(默认为 1)
      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)
  type-aliases-package: ${"$"}{wancheli.info.base-package}.dal.dataobject


--- #################### MQ 消息队列相关配置 ####################

#spring:
#  cloud:
#    # Spring Cloud Stream 配置项，对应 BindingServiceProperties 类
#    stream:
#      function:
#        definition: smsSendConsumer;mailSendConsumer;
#      # Binding 配置项，对应 BindingProperties Map
#      bindings:
#        smsSend-out-0:
#          destination: system_sms_send
#        smsSendConsumer-in-0:
#          destination: system_sms_send
#          group: system_sms_send_consumer_group
#        mailSend-out-0:
#          destination: system_mail_send
#        mailSendConsumer-in-0:
#          destination: system_mail_send
#          group: system_mail_send_consumer_group
#      # Spring Cloud Stream RocketMQ 配置项
#        default: # 默认 bindings 全局配置
#          producer: # RocketMQ Producer 配置项，对应 RocketMQProducerProperties 类
#            group: system_producer_group # 生产者分组
#            send-type: SYNC # 发送模式，SYNC 同步
#
#    # Spring Cloud Bus 配置项，对应 BusProperties 类
#    bus:
#      enabled: true # 是否开启，默认为 true
#      id: ${"$"}{spring.application.name}:${"$"}{server.port} # 编号，Spring Cloud Alibaba 建议使用“应用:端口”的格式
#      destination: springCloudBus # 目标消息队列，默认为 springCloudBus

--- #################### 定时任务相关配置 ####################

xxl:
  job:
    executor:
      appname: ${"$"}{spring.application.name} # 执行器 AppName
      logpath: ${"$"}{user.home}/logs/xxl-job/${"$"}{spring.application.name} # 执行器运行日志文件存储磁盘路径
    accessToken: default_token # 执行器通讯TOKEN

--- #################### 万车利相关配置 ####################

wancheli:
  info:
    version: 1.0.0
    base-package: com.mgxlin.module.${moduleName}
  web:
    admin-ui:
      url: http://dashboard.wancheli.iocoder.cn # Admin 管理后台 UI 的地址
  swagger:
    title: 管理后台
    description: 提供管理员管理的所有功能
    version: ${"$"}{wancheli.info.version}
    base-package: ${"$"}{wancheli.info.base-package}
  captcha:
    enable: true # 验证码的开关，默认为 true；
  error-code: # 错误码相关配置项
    constants-class-list:
      - com.mgxlin.module.demo.enums.ErrorCodeConstants
  tenant: # 多租户相关配置项
    enable: true
    ignore-urls:
      - /admin-api/test/xx

debug: false

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
