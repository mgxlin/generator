package com.mgxlin.module.generator;

import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DataSourceProperty;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceProperties;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.querys.MySqlQuery;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.keywords.MySqlKeyWordsHandler;
import org.apache.ibatis.type.JdbcType;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.util.List;
import java.util.Map;

@Configuration
@EnableConfigurationProperties(DynamicDataSourceProperties.class)
public class DataSourceConfiguration {

    @Bean
    public Generator generator(DynamicDataSourceProperties properties) {
        Map<String, DataSourceProperty> datasource = properties.getDatasource();
        DataSourceProperty property = datasource.get("master");
        String url = property.getUrl();
        String username = property.getUsername();
        String password = property.getPassword();

        DataSourceConfig.Builder builder = new DataSourceConfig
                .Builder(url, username, password)
                .dbQuery(new MySqlQuery())
                .typeConvert(new MySqlTypeConvert()).typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
                    // 兼容旧版本转换成Integer
                    if (JdbcType.TINYINT == metaInfo.getJdbcType()) {
                        return DbColumnType.INTEGER;
                    }
                    return typeRegistry.getColumnType(metaInfo);
                })
                .keyWordsHandler(new MySqlKeyWordsHandler());

        return new Generator(builder);
    }

}
