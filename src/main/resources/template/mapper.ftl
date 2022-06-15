<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapper}.${table.className}Mapper">

    <!-- 根据id查询；返回单个对象 -->
    <select id="selectById" resultType="${pojo}.${table.className}">
        select
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                ${cloumn.cloumnName} as ${cloumn.fieldName},
            <#else>
                ${cloumn.cloumnName} as ${cloumn.fieldName}
            </#if>
        </#list>
        from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <if test="id != null">
                and id=${r"#{id}"}
            </if>
        </trim>
    </select>

    <!-- 根据条件查询；返回多个对象-->
    <select id="selectByWideFactor" resultType="${pojo}.${table.className}"
            parameterType="java.util.Map">
        select
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                ${cloumn.cloumnName} as ${cloumn.fieldName},
            <#else>
                ${cloumn.cloumnName} as ${cloumn.fieldName}
            </#if>
        </#list>
        from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
        order by id desc
    </select>


    <!-- 流式查询：根据条件查询；可以设置 fetchSize 属性设置一次流查询多少条数据，直至取完数据-->
    <select id="flowSelectByWideFactor" resultType="${pojo}.${table.className}"
            parameterType="java.util.Map" fetchSize="200">
        select
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                ${cloumn.cloumnName} as ${cloumn.fieldName},
            <#else>
                ${cloumn.cloumnName} as ${cloumn.fieldName}
            </#if>
        </#list>
        from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
        order by id desc
    </select>


    <!--  添加：根据传入的参数添加信息；返回影响的行数 -->
    <insert id="insert" parameterType="${pojo}.${table.className}"
            <#if table.far == "mysql">
        useGeneratedKeys="true" keyProperty="id"
            </#if>>
        <#if table.far == "oracle">
            <selectKey keyProperty="id" order="BEFORE" resultType="int">
                select seq_${table.tableName}.nextval as sysId from DUAL
            </selectKey>
        </#if>
        insert into `${table.tableName}`(
        <trim suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            ${cloumn.cloumnName},
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${cloumn.cloumnName},
                        </if>
                        </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            ${cloumn.cloumnName}
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${cloumn.cloumnName}
                        </if>
                        </#if>
                    </#if>
                </#if>
            </#list>
        </trim>)
        values(
        <trim suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            now(),
                        </#if>
                         <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${r"#{"}${cloumn.fieldName}},
                        </if>
                         </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            now()
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${r"#{"}${cloumn.fieldName}}
                        </if>
                          </#if>
                    </#if>
                </#if>
            </#list>
        </trim>)
    </insert>

    <!--  批量添加：根据传入的参数添加信息 -->
    <insert id="batchInsert" parameterType="list" keyColumn="id" keyProperty="id" useGeneratedKeys="true">
        insert into `${table.tableName}`(
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                            ${cloumn.cloumnName},
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                            ${cloumn.cloumnName}
                    </#if>
                </#if>
            </#list>)
        values
        <foreach collection="list" item="item" separator=",">
            (
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            now(),
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                            ${r"#{item."}${cloumn.fieldName}},
                        </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            now()
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                            ${r"#{item."}${cloumn.fieldName}}
                        </#if>
                    </#if>
                </#if>
            </#list>
            )
        </foreach>
    </insert>

    <!--  添加或者修改 -->
    <insert id="insertOrUpdate" parameterType="${pojo}.${table.className}">
        <#if table.far == "oracle">
            <selectKey keyProperty="id" order="BEFORE" resultType="int">
                select seq_${table.tableName}.nextval as sysId from DUAL
            </selectKey>
        </#if>
        insert into `${table.tableName}`(
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        ${cloumn.cloumnName},
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${cloumn.cloumnName},
                    </if>
                    </#if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        ${cloumn.cloumnName}
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${cloumn.cloumnName}
                    </if>
                    </#if>
                </#if>
            </#if>
        </#list>
        </trim>)
        values(
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        now(),
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${r"#{"}${cloumn.fieldName}},
                    </if>
                    </#if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        now()
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${r"#{"}${cloumn.fieldName}}
                    </if>
                    </#if>
                </#if>
            </#if>
        </#list>
        </trim>)
    ON DUPLICATE KEY UPDATE
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time'>
                            ${cloumn.cloumnName}=now(),
                    </#if>
                    <#if  cloumn.cloumnName!='update_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}},
                    </if>
                    </#if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <#if  cloumn.cloumnName=='update_time'>
                        ${cloumn.cloumnName}=now()
                    </#if>
                    <#if  cloumn.cloumnName!='update_time'>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                    </#if>
                </#if>
            </#if>
        </#list>
        </trim>
    </insert>

    <!--  根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数-->
    <update id="updateByWideFactor" parameterType="java.util.Map">
        update `${table.tableName}`
        <trim prefix="set" suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time'>
                                ${cloumn.cloumnName}=now(),
                        </#if>
                        <#if  cloumn.cloumnName!='update_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}},
                        </if>
                        </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time'>
                            ${cloumn.cloumnName}=now()
                        </#if>
                        <#if  cloumn.cloumnName!='update_time'>
                        <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                            ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                        </if>
                        </#if>
                    </#if>
                </#if>
            </#list>
        </trim>
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName}If != null and ${cloumn.fieldName} != ''">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}If}
                    </if>
                </#if>
            </#list>
        </trim>
    </update>

    <!--  删除： 根据map删除对象；返回影响的行数-->
    <delete id="deleteByWideFactor" parameterType="map">
        delete from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName} != null and ${cloumn.fieldName} != ''">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
    </delete>
</mapper>