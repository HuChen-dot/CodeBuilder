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
     * 批量添加：根据传入的参数添加信息
     * @param tQccCompanyFromProducts
     * @return
    */
    Integer batchInsert${table.className}(@Param("list") List<${table.className}> list);


    /**
     * 添加或者修改，此方法借助于数据库唯一索引，如果数据库某一个唯一索引存在则更新，不存在则添加
     * 该数据表中必须存在某一个字段的唯一索引
     * @param ${lowerClassName}
     * @return
    */
    Integer insertOrUpdate${table.className}(${table.className} ${lowerClassName});


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
