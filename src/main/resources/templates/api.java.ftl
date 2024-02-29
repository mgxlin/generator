package ${apiPackageName};

import ${parentPackagePath}.enums.ApiConstants;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.dto.${entity}DTO;

import org.springframework.web.bind.annotation.*;
import com.wancheli.framework.common.pojo.CommonResult;
import io.swagger.annotations.Api;
import org.springframework.cloud.openfeign.FeignClient;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

<#if restControllerStyle>
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * ${table.comment!} 前端控制器
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

@Api(tags = "RPC ${table.comment!}")
@FeignClient(name = ApiConstants.NAME)
public interface ${entity}Api {
</#if>

    String PREFIX = ApiConstants.PREFIX + "/${mapping}";

    @ApiOperation(PREFIX + "获取详情")
    @GetMapping(PREFIX +"/get")
    public CommonResult<${entity}DTO> get(@RequestParam("id") Long id);

    @ApiOperation("列表-查询")
    @PostMapping(PREFIX + "/list")
    public CommonResult<List<${entity}DTO>> list(@RequestBody ${entity}QueryRO ro);

 }
</#if>
