package com.mgxlin.module.generator;

import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.util.List;

import static com.mgxlin.module.generator.MybatisPlusGenerator.*;

@Slf4j
public class Generator {
    public Generator(DataSourceConfig.Builder dataSource) {
        this.dataSource = dataSource;
    }

    private final DataSourceConfig.Builder dataSource;

    public String generator(List<String> tables, String moduleName) {

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");

        // 项目名称 eg：wancheli-module-model
        String projectName = PARENT_PROJECT_PATH + moduleName;
        // 生成的 项目路径 为 eg:  G:\project\wancheli-module-generator\wancheli-module-model
        projectPath = String.join(File.separator, projectPath, projectName);
        log.info("=========projectPath===========" + projectPath);

        log.info("=========projectName===========" + moduleName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
        log.info("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        // 批量生成代码
        for (String tableName : tables) {
            // 获取表前缀
            String prefix = extractPrefix(tableName);
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }

        return projectPath;
    }


    public void generator(List<String> tableNameList) {

        // TODO 表名 --- 需要根据实际情况修改 --- 可批量生成多个表的代码 ---
        // List<String> tableNameList = Arrays.asList("auto_model_one", "auto_model_two");

        // TODO 表前缀 --- 需要根据实际情况修改 ---
        // String prefix = "auto_";

        // 获取项目绝对路径 eg: G:\project\wancheli-module-model
        String projectPath = System.getProperty("user.dir");
        File currentDirFile = new File(projectPath);
        projectPath = currentDirFile.getParent();
        log.info("=========projectPath===========" + projectPath);

        // 获取项目名称 eg:wancheli-module-model
        String projectName = getProjectName(projectPath);
        log.info("=========projectName===========" + projectName);

        if ("".equals(projectName)) {
            throw new RuntimeException("非法路径");
        }

        // api 层模块名称
        String apiPath = projectName + "-api";
        // biz 层模块名称
        String bizPath = projectName + "-biz";
        // 模块名称
        String moduleName = projectName.replace("wancheli-module-", "");
        log.info("=========moduleName===========" + moduleName);

        // 父包路径 eg：com.wancheli.module.model
        String parentPackagePath = PARENT_PACKAGE_PATH + moduleName;

        for (String tableName : tableNameList) {
            // 获取表前缀
            String prefix = extractPrefix(tableName);
            // 批量生成代码
            autoGenerator(dataSource, tableName, prefix, projectPath, parentPackagePath, apiPath, bizPath,moduleName);
        }
    }
}
