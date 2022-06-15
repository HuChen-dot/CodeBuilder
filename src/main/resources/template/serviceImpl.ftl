package ${serviceImpl};
import ${mapper}.${table.className}Mapper;
import ${pojo}.${table.className};
import ${service}.${table.className}Service;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.*;

/**
* @author hu.chen
* @date
*/
@Service
public class ${table.className}ServiceImpl implements ${table.className}Service {


        @Autowired
        private ${table.className}Mapper ${lowerClassName}Mapper;

        /**
         * 根据id查询；返回单个对象
         * @param id 主键
         * @return
        */
        @Override
        public ${table.className} find${table.className}ById(Integer id){
                return ${lowerClassName}Mapper.selectById(id);
        }

        /**
         * 根据条件查询；返回多个对象
         * @param param
         * @return
        */
        @Override
        public List<${table.className}>  find${table.className}ListByMap(Map<String,Object> param){
                return ${lowerClassName}Mapper.selectByWideFactor(param);
        }

        /**
         * 添加：根据传入的参数添加信息；返回影响的行数
         * @param ${lowerClassName}
         * @return
        */
        @Override
        public Integer add${table.className}(${table.className} ${lowerClassName}){
                return ${lowerClassName}Mapper.insert(${lowerClassName});
        }

        /**
         * 根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数
         * @param ${lowerClassName}
         * @return
        */
        @Override
        public Integer update${table.className}(${table.className} ${lowerClassName}){
                Map<String,Object> param = new ConcurrentHashMap<>()
                // 将对象转换成 map ，并设置值
                map.put("idIf", "id");
                return ${lowerClassName}Mapper.updateByWideFactor(param);
        }

        /**
         * 删除： 根据id删除对象；返回影响的行数
         * @param id 主键
         * @return
        */
        @Override
        public Integer delete${table.className}ById(Integer id){
                Map<String, Object> map = new HashMap<>();
                map.put("id", id);
                return ${lowerClassName}Mapper.deleteByWideFactor(map);
        }


        /**
         * 根据条件分页查询；返回分页查询后的多个对象
         * @param param
         * @param pageNo 当前页码
         * @param pageSize  每页大小
         * @return
        */
        public PageInfo<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize){
                //设置分页的起始页数和页面容量
                PageHelper.startPage(pageNo, pageSize);
                //正常查询数据库，mybatis拦截器已经把原始sql拦截下来做好了分页
                List<${table.className}> ${lowerClassName}List = ${lowerClassName}Mapper.selectByWideFactor(param);
                //把查询出来分页好的数据放进插件的分页对象中
                PageInfo<${table.className}> info = new  PageInfo<${table.className}>(${lowerClassName}List);
                return info;
        }

}
