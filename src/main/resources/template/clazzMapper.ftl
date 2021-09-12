package ${mapper};
import ${pojo}.${table.className};
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ${table.className}Mapper{
/**
* 根据id查询；返回单个对象
*/
${table.className} selectById(@Param(value = "id") Integer id);

/**
* 根据条件查询；返回多个对象
*/
List<${table.className}> selectListByMap(Map<String,Object> param);

/**
* 查询数量：根据传入的条件查询目标数量；返回查询的数量
*/
Integer selectCountByMap(Map<String,Object> param);

/**
* 添加：根据传入的参数添加信息；返回影响的行数
*/
Integer add${table.className}(${table.className} ${lowerClassName});

/**
* 修改：根据传入的参数修改对应的数据库类；返回影响的行数
*/
Integer modify${table.className}(${table.className} ${lowerClassName});

/**
*删除： 根据map删除对象；返回影响的行数
*/
Integer deleteByMap(Map<String,Object> param);

}
