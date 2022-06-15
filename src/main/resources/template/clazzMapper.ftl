package ${mapper};
import ${pojo}.${table.className};
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.cursor.Cursor;

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
    ${table.className} selectById(@Param(value = "id") Integer id);


    /**
     * 根据条件查询；返回多个对象
     * @param param
     * @return
    */
    List<${table.className}> selectByWideFactor(Map<String,Object> param);

    /**
     * 流式查询，可以设置 fetchSize 属性设置一次流查询多少条数据，直至取完数据
     * 注意：使用流式查询，需要在service层将使用流式查询的方法上添加@Transactional注解，不然会报错
     * 错误原因为 @Autowired注入的mapper查询一次就会将连接关闭，不会保持链接
     * @return
    */
    Cursor<${table.className}> flowSelectByWideFactor(Map<String,Object> param);


    /**
     * 添加：根据传入的参数添加信息；返回影响的行数
     * @param ${lowerClassName}
     * @return
    */
    Integer insert(${table.className} ${lowerClassName});


    /**
     * 批量添加：根据传入的参数添加信息
     * @param list
     * @return
    */
    Integer batchInsert(@Param("list") List<${table.className}> list);


    /**
     * 添加或者修改，此方法借助于数据库唯一索引，如果数据库某一个唯一索引存在则更新，不存在则添加
     * 该数据表中必须存在某一个字段的唯一索引
     * @param ${lowerClassName}
     * @return
    */
    Integer insertOrUpdate(${table.className} ${lowerClassName});


    /**
     * 修改：根据传入的参数修改对应的数据库类；返回影响的行数
     * @param param
     * @return
    */
    Integer updateByWideFactor(Map<String,Object> param);


    /**
     * 删除： 根据id删除对象；返回影响的行数
     * @param param 参数
     * @return
    */
    Integer deleteByWideFactor(Map<String,Object> param);

}
