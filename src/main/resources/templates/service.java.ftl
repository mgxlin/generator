package ${servicePackageName};

import ${entityPackageName}.${entity}DO;
import ${superServiceClassPackage};

import ${pojoPackageName}.ro.${entity}CreateRO;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.ro.${entity}UpdateRO;
import ${pojoPackageName}.vo.${entity}VO;

import com.mgxlin.framework.common.pojo.PageResult;

import io.swagger.annotations.ApiOperation;
import java.util.List;

/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass}<${entity}DO> {

    @ApiOperation("创建")
    Long create(${entity}CreateRO ro);

    @ApiOperation("修改")
    Long update(${entity}UpdateRO ro);

    @ApiOperation("删除")
    Long delete(Long id);

    @ApiOperation("获取详情")
    ${entity}VO get(Long id);

    @ApiOperation("列表-查询")
    List<${entity}VO> list(${entity}QueryRO ro);

    @ApiOperation("分页-查询")
    PageResult<${entity}VO> page(${entity}QueryRO ro);

}
</#if>
