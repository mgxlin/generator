package com.wancheli.module.generator;

import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.builder.CustomFile;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.querys.MySqlQuery;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.keywords.MySqlKeyWordsHandler;
import org.apache.ibatis.type.JdbcType;

import java.io.File;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

public class MybatisPlusGenerator {

    // 父级目录 的固定前缀
    public static final String PARENT_PACKAGE_PATH = "com.wancheli.module.";
    // 项目工程 的固定前缀
    public static final String PARENT_PROJECT_PATH = "wancheli-module-";

    // controller 包的固定前缀
    public static final String CONTROLLER_PREFIX = ".controller.admin.";
    // pojo 包的固定前缀
    public static final String POJO_PREFIX = ".pojo.";
    public static final String CONVERT_PREFIX = ".convert.";
    // entity 包的固定前缀
    public static final String ENTITY_PREFIX = ".entity.";

    public static final String API_PREFIX = ".api.";
    public static final String ENUMS_PREFIX = ".enums";
    // mapper 包的固定前缀
    public static final String MAPPER_PREFIX = ".mapper.";
    public static final String SERVICE_PREFIX = ".service.";
    public static final String FRAMEWORK_PREFIX = ".framework.security.config";

    public static final String SRC_MAIN_JAVA = String.join(File.separator, "src", "main", "java");
    public static final String SRC_TEST_JAVA = String.join(File.separator, "src", "test", "java");
    public static final String SRC_MAIN_RESOURCE = String.join(File.separator, "src", "main", "resources");

    /**
     * 根据绝对路径获取项目名称
     *
     * @param path
     * @return
     */
    public static String getProjectName(String path) {
        // 使用lastIndexOf方法查找最后一个反斜杠的位置
        int lastIndex = path.lastIndexOf("\\");

        if (lastIndex != -1) {
            // 使用substring方法提取最后一个反斜杠后面的内容
            String result = path.substring(lastIndex + 1);
            System.out.println("项目名称 == : " + result);
            return result;
        } else {
            System.out.println("非法项目名称");
            return "";
        }
    }

    /**
     * 获取表前缀
     *
     * @param tableName
     * @return
     */
    public static String extractPrefix(String tableName) {
        if (tableName != null) {
            int endIndex = tableName.indexOf("_"); // 找到第一个下划线的位置
            if (endIndex != -1) {
                return tableName.substring(0, endIndex + 1); // 包括下划线
            } else {
                return tableName; // 如果没有下划线，返回整个表名
            }
        } else {
            return ""; // 如果表名为null，返回空字符串或其他适当的值
        }
    }

    /**
     * 首字母大写
     * @param input
     * @return
     */
    public static String capitalizeFirstLetter(String input) {
        if (input == null || input.isEmpty()) {
            return input; // 如果输入为null或空字符串，则返回原字符串
        }
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

    /**
     * 根据表名 转为 实体类名
     * @param tableName
     * @return
     */
    public static String convertToCamelCase(String tableName) {
        if (tableName != null && !tableName.isEmpty()) {
            StringBuilder camelCaseName = new StringBuilder();
            String[] words = tableName.split("_");

            for (String word : words) {
                if (!word.isEmpty()) {
                    camelCaseName.append(word.substring(0, 1).toUpperCase())
                            .append(word.substring(1).toLowerCase());
                }
            }
            return camelCaseName.toString();
        } else {
            return ""; // 如果表名为null或空，返回空字符串或其他适当的值
        }
    }

    public static void main(String[] args) {

        // 非必填 默认取当前路径 - ps: 此时项目将生成在 D盘
        String projectPath = "d:\\project1\\";

        /**
         * eg：若模块名称指定为 "converter" ，则会生成 wancheli-module-converter
         *
         * 非必填 的情况 ：在 "当前项目" 中生成代码时，可以不指定，默认取当前模块名称
         * 必填 的情况 ：当需要逆向生成 "整个 maven项目" 时,则必须指定模块名称
         *
         */
        String moduleName = "auth";

        // TODO 必填  要生成的表，支持多表生成
        List<String> tableNameList = Arrays.asList("auto_model_brand","auto_model_factory");

        // 非必填  默认取每个表的第一个单词
        String prefix = "auth_";

        // 生成代码
        generator(moduleName,tableNameList);
//        generator(projectPath,moduleName,tableNameList, prefix);
        // 不指定项目路径，则在当前项目中生成
//        generator(moduleName,tableNameList, prefix);
        // 不指定模块名称，则在采用当前模块名称
//        generator(tableNameList, prefix);
        // 不指定表前缀，则默认使用 表名第一个单词
//        generator(tableNameList);
    }

    public static void autoGenerator(DataSourceConfig.Builder dataSource, String tableName, String prefix, String projectPath, String parentPackagePath, String apiPath, String bizPath,String moduleName) {
        // 去掉表前缀的表名 eg: model_brand
        String removePrefixTableName = tableName.replace(prefix, "");
        // 转为基础包路径 eg: model.brand
        String basePackagePath = removePrefixTableName.replace("_", ".");
        // 请求路径
        String mapping = moduleName+"/"+removePrefixTableName.replace("_", "-");

        String entityName = convertToCamelCase(removePrefixTableName);

        // 模块名 首字母大写
        System.out.println("moduleName====" + moduleName);
        String capitalizeModuleName = capitalizeFirstLetter(moduleName);
        System.out.println("capitalizeModuleName====" + capitalizeModuleName);

        // 自定义路径
        Map<OutputFile, String> customPathInfo = new EnumMap<>(OutputFile.class);

        // 控制层 包名 = 父包路径 + 固定前缀 + 表对象名  eg:com.wancheli.module.model.controller.admin.model.brand
        String controllerPackageName = parentPackagePath + CONTROLLER_PREFIX + basePackagePath;
        // 控制层 包路径
        String controllerPackagePath = controllerPackageName.replace(".", File.separator);

        // 自定义 controller 路径
        // eg: G:\project\wancheli-module-model\wancheli-module-model-biz\src\main\java\com\wancheli\module\model\controller\admin\model\brand
        customPathInfo.put(OutputFile.controller, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, controllerPackagePath));

        // 数据层 包路径 = 父包路径 + 固定前缀 + 表对象名  eg:com.wancheli.module.model.pojo.model.brand
        String pojoPackageName = parentPackagePath + POJO_PREFIX + basePackagePath;
        // 数据层 包路径
        String pojoPackagePath = pojoPackageName.replace(".", File.separator);
//            customPathInfo.put(OutputFile.other, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, pojoPackagePath));

        // 实体层 包路径 = 父包路径 + 固定前缀 + 表对象名  eg:com.wancheli.module.model.entity.model.brand
        String entityPackageName = parentPackagePath + ENTITY_PREFIX + basePackagePath;
        String apiPackageName = parentPackagePath + API_PREFIX + basePackagePath;
        String apiImplPackageName = parentPackagePath + API_PREFIX+ basePackagePath;
        String enumsPackageName = parentPackagePath + ENUMS_PREFIX;
        String frameworkPackageName = parentPackagePath + FRAMEWORK_PREFIX;
        // 实体层 包路径
//            String entityPackagePath = entityPackageName.replace(".", File.separator);
        // 这里entity生成策略采用自定义 加 DO后缀
        customPathInfo.put(OutputFile.entity, "");
//            customPathInfo.put(OutputFile.entity, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, entityPackagePath));

        // 数据访问层 包路径 = 父包路径 + 固定前缀 + 表对象名  eg:com.wancheli.module.model.entity.model.brand
        String mapperPackageName = parentPackagePath + MAPPER_PREFIX + basePackagePath;
        // 数据访问层 包路径
        String mapperPackagePath = mapperPackageName.replace(".", File.separator);
        customPathInfo.put(OutputFile.mapper, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, mapperPackagePath));
        customPathInfo.put(OutputFile.xml, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, mapperPackagePath));

        // service 包路径 = 父包路径 + 固定前缀 + 表对象名  eg:com.wancheli.module.model.service.model.brand
        String servicePackageName = parentPackagePath + SERVICE_PREFIX + basePackagePath;
        // 服务层 包路径
        String servicePackagePath = servicePackageName.replace(".", File.separator);
        customPathInfo.put(OutputFile.service, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, servicePackagePath));
        customPathInfo.put(OutputFile.serviceImpl, String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA, servicePackagePath));

        // 开始生成代码
        FastAutoGenerator.create(dataSource)
                .globalConfig(builder -> {
                    builder.author("mgxlin") //设置作者
                            .commentDate("YYYY-MM-DD HH:mm:ss")//注释日期
                            .enableSwagger()
                            .fileOverride()
                            .disableOpenDir()
                            .outputDir(String.join(File.separator, projectPath, bizPath)); //指定输出目录
                })
                .packageConfig(builder -> {
                    builder.pathInfo(customPathInfo);
                })
                .strategyConfig(builder -> {
                    builder.addInclude(tableName) // 设置需要生成的表名 请输入表名，多个英文逗号分隔？所有输入 all:
                            .addTablePrefix(prefix)// 设置过滤表前缀

                            // Entity 策略配置
                            .entityBuilder()
                            .enableLombok() // 开启lombok
                            .enableChainModel() // 链式
                            .enableRemoveIsPrefix() // 开启boolean类型字段移除is前缀
                            .enableTableFieldAnnotation() //开启生成实体时生成的字段注解
                            .versionColumnName("请输入数据库中的乐观锁字段") // 乐观锁数据库字段
                            .versionPropertyName("请输入字段中的乐观锁名称") // 乐观锁实体类名称
                            .logicDeleteColumnName("deleted") // 逻辑删除数据库中字段名
                            .logicDeletePropertyName("deleted") // 逻辑删除实体类中的字段名
                            .naming(NamingStrategy.underline_to_camel) // 表名 下划线 -》 驼峰命名
                            .columnNaming(NamingStrategy.underline_to_camel) // 字段名 下划线 -》 驼峰命名
//                                .idType(IdType.ASSIGN_UUID) // 主键生成策略 雪花算法生成id
                            .formatFileName("%s") // Entity 文件名称
//                                .addTableFills(new Column("create_time", FieldFill.INSERT), new Column("update_time", FieldFill.INSERT_UPDATE))//生成时间自动填充属性
                            .controllerBuilder().enableRestStyle()//开启@RestController风格
                            .serviceBuilder().formatServiceFileName("%sService"); //去掉默认的I前缀
                })

                //使用Freemarker引擎模板，默认的是Velocity引擎模板
                .templateEngine(new FreemarkerTemplateEngine())
                //设置自定义模板路径
                .templateConfig(builder -> {
                    builder
                            .service("/templates/service.java")
                            .serviceImpl("/templates/serviceImpl.java")
                            .controller("/templates/controller.java");
                })

                //注入配置————自定义模板
                .injectionConfig(consumer -> {

                    consumer.beforeOutputFile((tableInfo, objectMap) -> {
                        tableInfo.setEntityName("");
                        System.out.println("tableInfo: " + tableInfo.getEntityName() + " objectMap: " + objectMap.size());
                    });

                    consumer.customFile(new CustomFile.Builder().fileName(entityName+"DO.java").enableFileOverride()
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/entity.java.ftl")
                                    .packageName(entityPackageName).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"DTO.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/dto.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "dto")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"VO.java")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/vo.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "vo")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"RO.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/ro.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "ro")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"QueryRO.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/query.ro.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "ro")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"Constant.java").enableFileOverride()
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/constant.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "constant")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"CreateRO.java").enableFileOverride()
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/create.ro.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "ro")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"UpdateRO.java").enableFileOverride()
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/update.ro.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "ro")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"Convert.java").enableFileOverride()
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/convert.java.ftl")
                                    .packageName(String.join(File.separator, pojoPackagePath, "convert")).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"Api.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/api.java.ftl")
                                    .packageName(apiPackageName).build())

                            .customFile(new CustomFile.Builder().fileName(entityName+"ApiFallback.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/api.fallback.java.ftl")
                                    .packageName(apiPackageName).build())

                            .customFile(new CustomFile.Builder().fileName("ApiConstants.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/api.constant.java.ftl")
                                    .packageName(enumsPackageName).build())
                            .customFile(new CustomFile.Builder().fileName("ErrorCodeConstants.java")
                                    .filePath(String.join(File.separator, projectPath, apiPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/error.constant.java.ftl")
                                    .packageName(enumsPackageName).build())

                            .customFile(new CustomFile.Builder().fileName("pom.xml")
                                    .filePath(String.join(File.separator, projectPath, apiPath))
                                    .templatePath("templates/api.pom.xml.ftl")
                                    .packageName("").build())
                            .customFile(new CustomFile.Builder().fileName("pom.xml")
                                    .filePath(String.join(File.separator, projectPath, bizPath))
                                    .templatePath("templates/biz.pom.xml.ftl")
                                    .packageName("").build())
                            .customFile(new CustomFile.Builder().fileName("pom.xml")
                                    .filePath(String.join(File.separator, projectPath))
                                    .templatePath("templates/pom.xml.ftl")
                                    .packageName("").build())

                            .customFile(new CustomFile.Builder().fileName(".gitignore")
                                    .filePath(String.join(File.separator, projectPath))
                                    .templatePath("templates/gitignore.ftl")
                                    .packageName("").build())

                            .customFile(new CustomFile.Builder().fileName(entityName +"ApiImpl.java")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/api.impl.java.ftl")
                                    .packageName(apiPackageName).build())

                            .customFile(new CustomFile.Builder().fileName("bootstrap.yaml")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_RESOURCE))
                                    .templatePath("templates/bootstrap.yaml.ftl")
                                    .packageName("").build())
                            .customFile(new CustomFile.Builder().fileName("application.yaml")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_RESOURCE))
                                    .templatePath("templates/application.yaml.ftl")
                                    .packageName("").build())
                            .customFile(new CustomFile.Builder().fileName("application-local.yaml")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_RESOURCE))
                                    .templatePath("templates/application-local.yaml.ftl")
                                    .packageName("").build())
                            .customFile(new CustomFile.Builder().fileName("logback-spring.xml")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_RESOURCE))
                                    .templatePath("templates/logback.ftl")
                                    .packageName("").build())

                            .customFile(new CustomFile.Builder().fileName("SecurityConfiguration.java")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/security.java.ftl")
                                    .packageName(frameworkPackageName).build())

                            .customFile(new CustomFile.Builder().fileName(capitalizeModuleName+"ServerApplication.java")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_MAIN_JAVA))
                                    .templatePath("templates/application.java.ftl")
                                    .packageName(parentPackagePath).build())

                            .customFile(new CustomFile.Builder().fileName("MyGenerator.java")
                                    .filePath(String.join(File.separator, projectPath, bizPath, SRC_TEST_JAVA))
                                    .templatePath("templates/generator.java.ftl")
                                    .packageName(parentPackagePath).build());

                    // 定义模板数据
                    Map<String, Object> customMap = new HashMap<>();
                    customMap.put("basePackagePath", basePackagePath);
                    customMap.put("controllerPackageName", controllerPackageName);
                    customMap.put("servicePackageName", servicePackageName);
                    customMap.put("pojoPackageName", pojoPackageName);
                    customMap.put("entityPackageName", entityPackageName);
                    customMap.put("mapperPackageName", mapperPackageName);
                    customMap.put("apiPackageName", apiPackageName);
                    customMap.put("apiImplPackageName", apiImplPackageName);
                    customMap.put("enumsPackageName", enumsPackageName);
                    customMap.put("frameworkPackageName", frameworkPackageName);
                    customMap.put("mapping", mapping);
                    customMap.put("parentPackagePath", parentPackagePath);
                    customMap.put("capitalizeModuleName", capitalizeModuleName);
                    if (!"".equals(moduleName)) {
                        customMap.put("moduleName", moduleName);
                    }
                    consumer.customMap(customMap);
                })
                .execute();
    }

    /**
     * 逆向生成整个项目
     * @param moduleName
     * @param tableNameList
     */
    public static void generator(String moduleName, List<String> tableNameList) {
        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");

        // 项目名称 eg：wancheli-module-model
        String projectName = PARENT_PROJECT_PATH + moduleName;
        // 生成的 项目路径 为 eg:  G:\project\wancheli-module-generator\wancheli-module-model
        projectPath = String.join(File.separator, projectPath, projectName);
        System.out.println("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
//        String projectName = getProjectName(projectPath);

        System.out.println("=========projectName===========" + moduleName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
//        String moduleName = projectName.replace("wancheli-module-", "");
        System.out.println("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 默认配置为 开发环境 的数据源
        DataSourceConfig.Builder dataSource = new DataSourceConfig
                .Builder(
                "jdbc:mysql://192.168.6.175:3306/genrator?serverTimezone=Asia/Shanghai",
                "u_develop",
                "u_develop")
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        // 批量生成代码
        for (String tableName : tableNameList) {
            // 获取表前缀
            String prefix = extractPrefix(tableName);
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }

    /**
     * 逆向生成整个项目
     * @param moduleName
     * @param tableNameList
     * @param prefix
     */
    public static void generator(String moduleName, List<String> tableNameList, String prefix) {
        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");

        // 项目名称 eg：wancheli-module-model
        String projectName = PARENT_PROJECT_PATH + moduleName;
        // 生成的 项目路径 为 eg:  G:\project\wancheli-module-generator\wancheli-module-model
        projectPath = String.join(File.separator, projectPath, projectName);
        System.out.println("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
//        String projectName = getProjectName(projectPath);

        System.out.println("=========projectName===========" + moduleName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
//        String moduleName = projectName.replace("wancheli-module-", "");
        System.out.println("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 默认配置为 开发环境 的数据源
        DataSourceConfig.Builder dataSource = new DataSourceConfig
                .Builder(
                "jdbc:mysql://192.168.6.175:3306/genrator?serverTimezone=Asia/Shanghai",
                "u_develop",
                "u_develop")
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        // 批量生成代码
        for (String tableName : tableNameList) {
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }

    /**
     * 指定项目地址、模块名称、表名 逆向生成 MAVEN项目
     * @param projectPath    项目生成的目标文件夹  eg：D:\myProject  非必填 默认当前路径
     * @param moduleName     模块名称  eg：model
     * @param tableNameList  表名集合  eg： auto_model_brand, auto_model_factory
     * @param prefix         表前缀  eg： auto_   非必填  默认取一个单词
     */
    public static void generator(String projectPath, String moduleName, List<String> tableNameList, String prefix) {
        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model

        // 项目名称 eg：wancheli-module-model
        String projectName = PARENT_PROJECT_PATH + moduleName;
        // 生成的 项目路径 为 eg:  G:\project\wancheli-module-generator\wancheli-module-model
        projectPath = String.join(File.separator, projectPath, projectName);
        System.out.println("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
//        String projectName = getProjectName(projectPath);

        System.out.println("=========projectName===========" + moduleName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
//        String moduleName = projectName.replace("wancheli-module-", "");
        System.out.println("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 默认配置为 开发环境 的数据源
        DataSourceConfig.Builder dataSource = new DataSourceConfig
                .Builder(
                "jdbc:mysql://192.168.6.175:3306/wancheli-auth?serverTimezone=Asia/Shanghai",
                "root",
                "root")
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        // 批量生成代码
        for (String tableName : tableNameList) {
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }
    public static void generator(List<String> tableNameList, String prefix) {
        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");
        System.out.println("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
        String projectName = getProjectName(projectPath);
        System.out.println("=========projectName===========" + projectName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
        String moduleName = projectName.replace("wancheli-module-", "");
        System.out.println("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 默认配置为 开发环境 的数据源
        DataSourceConfig.Builder dataSource = new DataSourceConfig
                .Builder(
                "jdbc:mysql://192.168.6.175:3306/genrator?serverTimezone=Asia/Shanghai",
                "u_develop",
                "u_develop")
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        // 批量生成代码
        for (String tableName : tableNameList) {
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }

    public static void generator(List<String> tableNameList) {

        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");
        File currentDirFile = new File(projectPath);
        projectPath = currentDirFile.getParent();
        System.out.println("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
        String projectName = getProjectName(projectPath);
        System.out.println("=========projectName===========" + projectName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
        String moduleName = projectName.replace("wancheli-module-", "");
        System.out.println("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 数据源配置
        DataSourceConfig.Builder dataSource = new DataSourceConfig
                .Builder(
                "jdbc:mysql://192.168.6.175:3306/genrator?serverTimezone=Asia/Shanghai",
                "u_develop",
                "u_develop")
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        for (String tableName : tableNameList) {
            // 获取表前缀
            String prefix = extractPrefix(tableName);
            // 批量生成代码
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }

}
