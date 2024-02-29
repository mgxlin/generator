package ${enumsPackageName};

import com.wancheli.framework.common.enums.RpcConstants;
import io.swagger.annotations.ApiModel;

@ApiModel(value = "${table.comment!}")
public class ApiConstants {

    public static final String NAME = "wancheli-${moduleName}";

    public static final String PREFIX = RpcConstants.RPC_API_PREFIX +  "/${moduleName}";

}
