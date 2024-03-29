package ${mapperPackageName};

import ${entityPackageName}.${entity}DO;
import ${superMapperClassPackage};

import org.apache.ibatis.annotations.Mapper;
/**
 * <p>
 * ${table.comment!} Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */

@Mapper
public interface ${table.mapperName} extends ${superMapperClass}<${entity}DO> {

}

