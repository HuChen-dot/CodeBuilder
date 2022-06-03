<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapper}.${table.className}Mapper">

    <!-- 根据id查询；返回单个对象 -->
    <select id="find${table.className}ById" resultType="${pojo}.${table.className}">
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
    <select id="find${table.className}s" resultType="${pojo}.${table.className}"
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
                    <if test="${cloumn.fieldName} != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
        order by id desc
    </select>


    <!--  添加：根据传入的参数添加信息；返回影响的行数 -->
    <insert id="insert${table.className}" parameterType="${pojo}.${table.className}"
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
                        <if test="${cloumn.fieldName} != null">
                            ${cloumn.cloumnName},
                        </if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <if test="${cloumn.fieldName} != null">
                            ${cloumn.cloumnName}
                        </if>
                    </#if>
                </#if>
            </#list>
        </trim>)
        values(
        <trim suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <if test="${cloumn.fieldName} != null">
                            ${r"#{"}${cloumn.fieldName}},
                        </if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <if test="${cloumn.fieldName} != null">
                            ${r"#{"}${cloumn.fieldName}}
                        </if>
                    </#if>
                </#if>
            </#list>
        </trim>)
    </insert>

    <!--  添加或者修改 -->
    <insert id="insertOrUpdate${table.className}" parameterType="${pojo}.${table.className}">
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
                    <if test="${cloumn.fieldName} != null">
                        ${cloumn.cloumnName},
                    </if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <if test="${cloumn.fieldName} != null">
                        ${cloumn.cloumnName}
                    </if>
                </#if>
            </#if>
        </#list>
        </trim>)
        values(
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    <if test="${cloumn.fieldName} != null">
                        ${r"#{"}${cloumn.fieldName}},
                    </if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <if test="${cloumn.fieldName} != null">
                        ${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#if>
        </#list>
        </trim>)
    ON DUPLICATE KEY UPDATE
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    <if test="${cloumn.fieldName} != null">
                        ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}},
                    </if>
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    <if test="${cloumn.fieldName} != null">
                        ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#if>
        </#list>
        </trim>
    </insert>

    <!--  根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数-->
    <update id="update${table.className}" parameterType="java.util.Map">
        update `${table.tableName}`
        <trim prefix="set" suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <if test="${cloumn.fieldName} != null">
                            ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}},
                        </if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <if test="${cloumn.fieldName} != null">
                            ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                        </if>
                    </#if>
                </#if>
            </#list>
        </trim>
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName}If != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}If}
                    </if>
                </#if>
            </#list>
        </trim>
    </update>

    <!--  删除： 根据map删除对象；返回影响的行数-->
    <delete id="delete${table.className}" parameterType="map">
        delete from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName} != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
    </delete>
</mapper>