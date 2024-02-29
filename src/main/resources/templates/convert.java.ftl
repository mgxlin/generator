package ${pojoPackageName}.convert;

import java.util.List;
import ${pojoPackageName}.ro.${entity}CreateRO;
import ${pojoPackageName}.ro.${entity}QueryRO;
import ${pojoPackageName}.ro.${entity}UpdateRO;
import ${pojoPackageName}.vo.${entity}VO;
import ${pojoPackageName}.dto.${entity}DTO;
import ${entityPackageName}.${entity}DO;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

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
@Mapper
public interface ${entity}Convert {

    ${entity}Convert INSTANCE = Mappers.getMapper(${entity}Convert.class);

    ${entity}DO convert(${entity}QueryRO bean);
    ${entity}DO convert(${entity}CreateRO bean);

    ${entity}DO convert(${entity}UpdateRO bean);

    ${entity}VO convert(${entity}DO bean);
    ${entity}DTO convert(${entity}VO bean);

    List<${entity}VO> convertVOList(List<${entity}DO> list);
    List<${entity}DTO> convertDTOList(List<${entity}VO> list);

}
</#if>
