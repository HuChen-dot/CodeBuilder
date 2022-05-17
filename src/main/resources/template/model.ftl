package ${pojo};
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
* @author hu.chen
* @date
*/
@Data
public class ${table.className} implements Serializable {
<#list table.cloumns as cloumn>
    /**
    * ${cloumn.comment}
    */
    private ${cloumn.javaType} ${cloumn.fieldName};
</#list>

}
