package ${service};
import ${pojo}.${table.className};
import java.util.List;
import java.util.Map;

/**
* Founder : 泽宇
*/
public interface ${table.className}Service {
	
	/**
	 * 根据id查询；返回单个对象
	 */
     ${table.className} get${table.className}ById(Integer id);

	/**
	 *根据条件查询；返回多个对象
	 */
     List<${table.className}>	get${table.className}ListByMap(Map<String,Object> param);

	/**
	 * 查询数量：根据传入的条件查询目标数量；返回查询的数量
	 */
     Integer get${table.className}CountByMap(Map<String,Object> param);

	/**
	 * 添加：根据传入的参数添加信息；返回影响的行数
	 */
     Integer add${table.className}(${table.className} ${lowerClassName});

	/**
	 * 根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数
	 */
     Integer modify${table.className}(${table.className} ${lowerClassName});

	/**
	 *删除： 根据id删除对象；返回影响的行数
	 */
     Integer delete${table.className}ById(Integer id);

	/**
	 *根据条件分页查询；返回分页查询后的多个对象
	 */
     PageInfo<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize);
}
