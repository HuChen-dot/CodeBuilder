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
    <select id="selectListByMap" resultType="${pojo}.${table.className}"
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


    <!--  查询数量：根据传入的条件查询目标数量；返回查询的数量 -->
    <select id="selectCountByMap" resultType="int" parameterType="map">
        select count(*) from `${table.tableName}`
        <trim prefix="where" prefixOverrides="and | or">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <if test="${cloumn.fieldName} != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                <#else>
                    <if test="${cloumn.fieldName} != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
    </select>

    <!--  添加：根据传入的参数添加信息；返回影响的行数 -->
    <insert id="add${table.className}" parameterType="${pojo}.${table.className}"
            <#if table.far == "mysql">
        useGeneratedKeys="true" keyProperty="id"
            </#if>>
        <#if table.far == "oracle">
            <selectKey keyProperty="id" order="BEFORE" resultType="int">
                select seq_${table.tableName}.nextval as sysId from DUAL
            </selectKey>
        </#if>

        insert into `${table.tableName}`(
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    ${cloumn.cloumnName},
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    ${cloumn.cloumnName})
                </#if>
            </#if>
        </#list>
        values(
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                <#if  cloumn.cloumnName!='id'>
                    ${r"#{"}${cloumn.fieldName}},
                </#if>
            <#else>
                <#if  cloumn.cloumnName!='id'>
                    ${r"#{"}${cloumn.fieldName}})
                </#if>
            </#if>
        </#list>
    </insert>


    <!--  根据id修改：根据传入的参数修改对应的数据库类；返回影响的行数-->
    <update id="modify${table.className}" parameterType="${pojo}.${table.className}">
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
        where id = ${r"#{"}id}
    </update>

    <!--  删除： 根据map删除对象；返回影响的行数-->
    <delete id="deleteByMap" parameterType="map">
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