package ${mapper};
import ${pojo}.${table.className};
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.cursor.Cursor;

/**
* @author hu.chen
* @date
*/
@Mapper
public interface ${table.className}Mapper{

    /**
     * 主键查询
     * @param primaryKey 主键
     * @return
    */
    ${table.className} selectByPrimaryKey(@Param(value = "primaryKey") Long primaryKey);


    /**
     * 多条件查询
     * @param param
     * @return
    */
    List<${table.className}> select(Map<String,Object> param);


    /**
     * 流式查询，可以设置 fetchSize 属性设置一次流查询多少条数据，直至取完数据
     * 注意：使用流式查询，需要在service层将使用流式查询的方法上添加@Transactional注解，不然会报错
     * 错误原因为 @Autowired注入的mapper查询一次就会将连接关闭，不会保持链接
     * @param param
     * @return
    */
    Cursor<${table.className}> flowSelect(Map<String,Object> param);


    /**
     * 添加
     * @param ${lowerClassName}
     * @return
    */
    Integer insert(${table.className} ${lowerClassName});


    /**
     * 批量添加
     * @param list
     * @return
    */
    Integer batchInsert(@Param("list") List<${table.className}> list);


    /**
     * 添加或者修改
     * 此方法借助于数据库唯一索引，如果数据库某一个唯一索引存在则更新，不存在则添加
     * 该数据表中必须存在某一个字段的唯一索引
     * @param ${lowerClassName}
     * @return
    */
    Integer insertOrUpdate(${table.className} ${lowerClassName});


    /**
     * 修改
     * @param param
     * @return
    */
    Integer update(Map<String,Object> param);


    /**
     * 删除
     * @param param 参数
     * @return
    */
    Integer delete(Map<String,Object> param);

}
