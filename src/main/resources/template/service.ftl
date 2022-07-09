package ${service};
import ${pojo}.${table.className};
import java.util.List;
import java.util.Map;

/**
* @author hu.chen
* @date
*/
public interface ${table.className}Service {

	/**
	  * 根据主键查询
	  * @param primaryKey 主键
	  * @return
	*/
     ${table.className} find${table.className}ByPrimaryKey(Integer primaryKey);

	/**
 	 * 根据条件查询；返回多个对象
	 * @param param
	 * @return
	 */
     List<${table.className}>	find${table.className}List(Map<String,Object> param);


	/**
     * 添加：根据传入的参数添加信息；返回影响的行数
	 * @param ${lowerClassName}
	 * @return
	*/
     Integer insert${table.className}(${table.className} ${lowerClassName});


	/**
	 * 根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数
	 * @param ${lowerClassName}
	 * @return
	*/
     Integer update${table.className}(${table.className} ${lowerClassName});


	/**
	 * 删除： 根据id删除对象；返回影响的行数
	 * @param id 主键
	 * @return
	*/
     Integer delete${table.className}ById(Integer id);


	/**
	 * 根据条件分页查询；返回分页查询后的多个对象
	 * @param param
	 * @param pageNo 当前页码
	 * @param pageSize  每页大小
	 * @return
	*/
     PageInfo<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize);
}
