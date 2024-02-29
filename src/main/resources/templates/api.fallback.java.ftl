package ${apiPackageName};

import com.wancheli.framework.common.exception.enums.GlobalErrorCodeConstants;
import com.wancheli.framework.common.pojo.CommonResult;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.dto.${entity}DTO;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * ${table.comment!} 熔断降级
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
<#else>
@Controller
</#if>
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>

@Component
public class ${entity}ApiFallback implements FallbackFactory<${entity}Api> {
</#if>

    @Override
    public ${entity}Api create(Throwable cause) {
        return new ${entity}Api() {
            @Override
            public CommonResult<List<${entity}DTO>> list(${entity}QueryRO ro) {
                return CommonResult.error(GlobalErrorCodeConstants.REQUEST_TIME_OUT);
            }

            @Override
            public CommonResult<${entity}DTO> get(Long id) {
                return CommonResult.error(GlobalErrorCodeConstants.REQUEST_TIME_OUT);
            }
        };
    }
}
</#if>
