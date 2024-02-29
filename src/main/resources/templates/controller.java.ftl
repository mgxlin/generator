package ${controllerPackageName};

import com.wancheli.framework.common.pojo.PageResult;

import ${pojoPackageName}.ro.${entity}CreateRO;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.ro.${entity}UpdateRO;
import ${pojoPackageName}.vo.${entity}VO;

import ${servicePackageName}.${table.serviceName};

import static com.wancheli.framework.common.pojo.CommonResult.success;
import org.springframework.web.bind.annotation.*;
import com.wancheli.framework.common.pojo.CommonResult;

import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

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
@RestController
<#else>
@Controller
</#if>
@RequestMapping("${mapping}")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>

    @Resource
    private ${table.serviceName} ${table.serviceName ? uncap_first};

    @ApiOperation("创建")
    @PostMapping("/insert")
    public CommonResult<Long> create(@RequestBody ${entity}CreateRO ro){
        return success(${table.serviceName ? uncap_first}.create(ro));
    }

    @ApiOperation("修改")
    @PostMapping("/update")
    public CommonResult<Long> update(@RequestBody ${entity}UpdateRO ro){
        return success(${table.serviceName ? uncap_first}.update(ro));
    }

    @ApiOperation("删除")
    @DeleteMapping("/delete")
    public CommonResult<Long> delete(@RequestParam("id") Long id){
        return success(${table.serviceName ? uncap_first}.delete(id));
    }

    @ApiOperation("获取详情")
    @GetMapping("/get")
    public CommonResult<${entity}VO> get(@RequestParam("id") Long id){
        return success(${table.serviceName ? uncap_first}.get(id));
    }

    @ApiOperation("列表-查询")
    @PostMapping("/list")
    public CommonResult<List<${entity}VO>> list(@RequestBody ${entity}QueryRO ro){
        return success(${table.serviceName ? uncap_first}.list(ro));
    }

    @ApiOperation("分页-查询")
    @PostMapping("/page")
    public CommonResult<PageResult<${entity}VO>> page(@RequestBody ${entity}QueryRO ro){
        return success(${table.serviceName ? uncap_first}.page(ro));
    }

 }
</#if>
