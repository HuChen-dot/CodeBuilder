<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapper}.${table.className}Mapper">

    <!-- 主键查询 -->
    <select id="selectByPrimaryKey" resultType="${pojo}.${table.className}">
        select
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                ${cloumn.cloumnName} as ${cloumn.fieldName},
            <#else>
                ${cloumn.cloumnName} as ${cloumn.fieldName}
            </#if>
        </#list>
        from `${table.tableName}`
            <#list table.cloumns as cloumn>
                <#if cloumn_index==0>
        where ${cloumn.cloumnName}=${r"#{"}primaryKey}
                    <#break>
                </#if>
            </#list>
    </select>

    <!-- 多条件查询-->
    <select id="select" resultType="${pojo}.${table.className}"
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
<#--            <if test="startTime != null">-->
<#--                <!--创建时间大于开始时间，创建时间小于结束时间 &ndash;&gt;-->
<#--                and create_time &gt;= #{startTime} and create_time &lt;= #{endTime}-->
<#--            </if>-->
        </trim>
    </select>


    <!-- 流式查询：根据条件查询；可以设置 fetchSize 属性设置一次流查询多少条数据，直至取完数据-->
    <select id="flowSelect" resultType="${pojo}.${table.className}"
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
                    <if test="${cloumn.fieldName} != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                </#if>
            </#list>
        </trim>
    </select>


    <!--  添加 -->
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
                            ${cloumn.cloumnName},
                        </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            ${cloumn.cloumnName}
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                            ${cloumn.cloumnName}
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
                            ${r"#{"}${cloumn.fieldName}},
                         </#if>
                    </#if>
                <#else>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                            now()
                        </#if>
                        <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                            ${r"#{"}${cloumn.fieldName}}
                          </#if>
                    </#if>
                </#if>
            </#list>
        </trim>)
    </insert>

    <!--  批量添加 -->
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
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        ${cloumn.cloumnName},
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        ${cloumn.cloumnName},
                    </#if>
            <#else>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        ${cloumn.cloumnName}
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        ${cloumn.cloumnName}
                    </#if>
            </#if>
        </#list>
        </trim>)
        values(
        <trim suffixOverrides=",">
        <#list table.cloumns as cloumn>
            <#if cloumn_has_next>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        now(),
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        ${r"#{"}${cloumn.fieldName}},
                    </#if>
            <#else>
                    <#if  cloumn.cloumnName=='update_time' || cloumn.cloumnName=='create_time'>
                        now()
                    </#if>
                    <#if  cloumn.cloumnName!='update_time' && cloumn.cloumnName!='create_time'>
                        ${r"#{"}${cloumn.fieldName}}
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
                    <if test="${cloumn.fieldName} != null">
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
                    <if test="${cloumn.fieldName} != null">
                        ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}}
                    </if>
                    </#if>
                </#if>
            </#if>
        </#list>
        </trim>
    </insert>

    <!--  修改 -->
    <update id="update" parameterType="java.util.Map">
        update `${table.tableName}`
        <trim prefix="set" suffixOverrides=",">
            <#list table.cloumns as cloumn>
                <#if cloumn_has_next>
                    <#if  cloumn.cloumnName!='id'>
                        <#if  cloumn.cloumnName=='update_time'>
                                ${cloumn.cloumnName}=now(),
                        </#if>
                        <#if  cloumn.cloumnName!='update_time'>
                        <if test="${cloumn.fieldName} != null">
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
                        <if test="${cloumn.fieldName} != null">
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
                    <if test="${cloumn.fieldName}If != null">
                        and ${cloumn.cloumnName}=${r"#{"}${cloumn.fieldName}If}
                    </if>
                </#if>
            </#list>
        </trim>
    </update>

    <!--  删除 -->
    <delete id="delete" parameterType="map">
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