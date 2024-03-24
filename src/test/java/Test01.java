import com.mgxlin.module.GeneratorApplication;
import com.mgxlin.module.generator.Generator;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.Arrays;

/**
 * @author lhb
 * @date 2024/3/24 16:54
 */
@SpringBootTest(classes = GeneratorApplication.class)
public class Test01 {

    @Resource
    private Generator generator;

    @Test
    public void test(){
        generator.generator(Arrays.asList("ums_role"));
    }
}
