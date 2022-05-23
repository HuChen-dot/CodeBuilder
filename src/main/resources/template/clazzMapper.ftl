package ${mapper};
import ${pojo}.${table.className};
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
* @author hu.chen
* @date
*/
@Mapper
@Repository
public interface ${table.className}Mapper{

    /**
     * 根据id查询；返回单个对象
     * @param id 主键
     * @return
    */
    ${table.className} find${table.className}ById(@Param(value = "id") Integer id);


    /**
     * 根据条件查询；返回多个对象
     * @param param
     * @return
    */
    List<${table.className}> find${table.className}s(Map<String,Object> param);


    /**
     * 添加：根据传入的参数添加信息；返回影响的行数
     * @param ${lowerClassName}
     * @return
    */
    Integer insert${table.className}(${table.className} ${lowerClassName});


    /**
     * 修改：根据传入的参数修改对应的数据库类；返回影响的行数
     * @param param
     * @return
    */
    Integer update${table.className}(Map<String,Object> param);


    /**
     * 删除： 根据id删除对象；返回影响的行数
     * @param id 主键
     * @return
    */
    Integer delete${table.className}(Map<String,Object> param);

}
