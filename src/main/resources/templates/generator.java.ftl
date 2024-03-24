package ${parentPackagePath};

import com.mgxlin.module.generator.Generator;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

@SpringBootTest(classes = AuthServerApplication.class)
@ActiveProfiles("local")
public class MyGenerator {

  @Resource
  private Generator generator;

  @Test
  public void generator() {
    // TODO 声明要 生成代码的表，指定任意表名
    List<String> tables = Arrays.asList("auto_model_basic", "system_users");
    // 生成代码
    generator.generator(tables);
  }
}
