package ${servicePackageName};

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mgxlin.framework.common.pojo.PageParam;

import ${pojoPackageName}.convert.${entity}Convert;
import ${entityPackageName}.${entity}DO;
import ${mapperPackageName}.${table.mapperName};
import ${superServiceImplClassPackage};

import ${pojoPackageName}.ro.${entity}CreateRO;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.ro.${entity}UpdateRO;
import ${pojoPackageName}.vo.${entity}VO;

import ${mapperPackageName}.${table.mapperName};

import org.springframework.stereotype.Service;
import io.swagger.annotations.ApiOperation;
import com.mgxlin.framework.common.pojo.PageResult;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}DO>(), ${table.serviceName} {

}
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}DO> implements ${table.serviceName} {

    @Resource
    private ${table.mapperName} ${table.mapperName ? uncap_first};

    @Override
    public Long create(${entity}CreateRO ro) {
        ${entity}DO ${entity ? uncap_first} = ${entity}Convert.INSTANCE.convert(ro);
        this.save(${entity ? uncap_first});
        return ${entity ? uncap_first}.getId();
    }

    @Override
    public Long update(${entity}UpdateRO ro) {
        ${entity}DO ${entity ? uncap_first} = ${entity}Convert.INSTANCE.convert(ro);
        this.updateById(${entity ? uncap_first});
        return ${entity ? uncap_first}.getId();
    }

    @Override
    public Long delete(Long id) {
        this.removeById(id);
        return id;
    }

    @Override
    public ${entity}VO get(Long id) {
        ${entity}DO ${entity ? uncap_first} = this.getById(id);
        return ${entity}Convert.INSTANCE.convert(${entity ? uncap_first});
    }

    @Override
    public List<${entity}VO> list(${entity}QueryRO ro) {
        List<${entity}DO> ${entity ? uncap_first}List = this.basicList(ro);
        return ${entity}Convert.INSTANCE.convertVOList(${entity ? uncap_first}List);
    }

    @Override
    public PageResult<${entity}VO> page(${entity}QueryRO ro) {
        // 构建参数
        QueryWrapper<${entity}DO> wrapper = buildParam(ro);
        PageParam pageParam = ro.getPageParam();
        Page<${entity}DO> page = new Page<>(pageParam.getPageNo(), pageParam.getPageSize());
        // 分页查询
        Page<${entity}DO> pageResult = this.page(page, wrapper);
        List<${entity}DO> records = pageResult.getRecords();
        // 转换对象
        List<${entity}VO> ${entity ? uncap_first}List =${entity}Convert.INSTANCE.convertVOList(records);
        long total = pageResult.getTotal();
        // 返回结果集
        return new PageResult<>(${entity ? uncap_first}List, total);
    }

    /**
    * 基础查询列表
    *
    * @param ro
    */
    public List<${entity}DO> basicList(${entity}QueryRO ro) {
        QueryWrapper<${entity}DO> wrapper = buildParam(ro);
        // 获取结果集
        return this.list(wrapper);
    }

    private QueryWrapper<${entity}DO> buildParam(${entity}QueryRO ro) {

        // 条件构造
        QueryWrapper<${entity}DO> wrapper = new QueryWrapper<>();

        // 等值查询
        ${entity}DO ${entity ? uncap_first}DO = ${entity}Convert.INSTANCE.convert(ro);
        wrapper.setEntity(${entity ? uncap_first}DO);

        // 过滤字段查询
        List<String> columns = ro.getColumns();
        if (CollUtil.isNotEmpty(columns)) {
            wrapper.select(columns);
        }

        // 按id集合查询
        List<Long> idList = ro.getIdList();
        if (CollUtil.isNotEmpty(idList)) {
            wrapper.in("id", idList);
        }

        // TODO 复杂参数构建

        return wrapper;
    }
}
</#if>
