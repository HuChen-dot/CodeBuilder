package ${serviceImpl};
import ${mapper}.${table.className}Mapper;
import ${pojo}.${table.className};
import ${service}.${table.className}Service;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.*;
@Service
public class ${table.className}ServiceImpl implements ${table.className}Service {


@Resource
private ${table.className}Mapper ${lowerClassName}Mapper;

/**
* 根据id查询；返回单个对象
*/
@Override
public ${table.className} get${table.className}ById(Integer id){
return ${lowerClassName}Mapper.selectById(id);
}

/**
*根据条件查询；返回多个对象
*/
@Override
public List<${table.className}>  get${table.className}ListByMap(Map<String,Object> param){
return ${lowerClassName}Mapper.selectListByMap(param);
}

/**
* 查询数量：根据传入的条件查询目标数量；返回查询的数量
*/
@Override
public Integer get${table.className}CountByMap(Map<String,Object> param){
return ${lowerClassName}Mapper.selectCountByMap(param);
}

/**
* 添加：根据传入的参数添加信息；返回影响的行数
*/
@Override
public Integer add${table.className}(${table.className} ${lowerClassName}){
return ${lowerClassName}Mapper.add${table.className}(${lowerClassName});
}

/**
* 根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数
*/
@Override
public Integer modify${table.className}(${table.className} ${lowerClassName}){
return ${lowerClassName}Mapper.modify${table.className}(${lowerClassName});
}

/**
*删除： 根据map删除对象；返回影响的行数
*/
@Override
public Integer delete${table.className}ById(Integer id){
Map<String, Object> map = new HashMap<String, Object>();
map.put("invid", id);
return ${lowerClassName}Mapper.deleteByMap(map);
}

/**
*根据条件分页查询；返回分页查询后的多个对象
*/
public PageInfo<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize){
        //设置分页的起始页数和页面容量
PageHelper.startPage(pageNo, pageSize);
        //正常查询数据库，mybatis拦截器已经把原始sql拦截下来做好了分页
List<${table.className}> ${lowerClassName}List = ${lowerClassName}Mapper.selectListByMap(param);
        //把查询出来分页好的数据放进插件的分页对象中
PageInfo<${table.className}> info = new  PageInfo<${table.className}>(${lowerClassName}List);
return info;
}

}
