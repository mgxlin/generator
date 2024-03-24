package ${parentPackagePath};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients(basePackages = "com.mgxlin.module")
public class ${capitalizeModuleName}ServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(${capitalizeModuleName}ServerApplication.class, args);
    }

}
