package ${apiImplPackageName};

import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.convert.${entity}Convert;
import ${pojoPackageName}.vo.${entity}VO;
import ${pojoPackageName}.dto.${entity}DTO;
import ${apiPackageName}.${entity}Api;
import ${servicePackageName}.${table.serviceName};

import org.springframework.web.bind.annotation.*;
import com.mgxlin.framework.common.pojo.CommonResult;

import io.swagger.annotations.ApiOperation;

import java.util.List;

import javax.annotation.Resource;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
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

@RestController
public class ${entity}ApiImpl implements ${entity}Api {
</#if>

    @Resource
    private ${table.serviceName} ${table.serviceName ? uncap_first};

    @ApiOperation("获取详情")
    public CommonResult<${entity}DTO> get(@RequestParam("id") Long id){
        ${entity}VO ${entity ? uncap_first}VO = ${entity ? uncap_first}Service.get(id);
        ${entity}DTO ${entity ? uncap_first}DTO = ${entity}Convert.INSTANCE.convert(${entity ? uncap_first}VO);
        return CommonResult.success(${entity ? uncap_first}DTO);
    }

    @ApiOperation("列表-查询")
    public CommonResult<List<${entity}DTO>> list(@RequestBody ${entity}QueryRO ro){
        List<${entity}VO> list = ${table.serviceName ? uncap_first}.list(ro);
        List<${entity}DTO> ${entity ? uncap_first}DTOList = ${entity}Convert.INSTANCE.convertDTOList(list);
        return CommonResult.success(${entity ? uncap_first}DTOList);
    }

 }
</#if>
