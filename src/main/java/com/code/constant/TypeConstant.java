package com.code.constant;

import java.util.HashMap;
import java.util.Map;


public class TypeConstant {
    /***
     * 类型转化的Map
     */
    private static Map<String, String> typeMap = new HashMap<String, String>();

    static {
        typeMap.put("BOOLEAN", "boolean");
        typeMap.put("BYTE", "byte[]");
        typeMap.put("BIGINT", "Integer");
        typeMap.put("INT", "Integer");
        typeMap.put("FLOAT", "float");
        typeMap.put("VARCHAR", "String");
        typeMap.put("CHAR", "String");
        typeMap.put("TEXT", "String");
        typeMap.put("DATETIME", "Date");
        typeMap.put("TIME", "Date");
        typeMap.put("TIMESTAMP", "Date");
        typeMap.put("DATE", "Date");
        typeMap.put("YEAR", "Date");
        typeMap.put("DOUBLE", "Double");
        typeMap.put("NUMBER", "Integer");
        typeMap.put("VARCHAR2", "String");
        typeMap.put("CLOB", "String");
        typeMap.put("BINARY_DOUBLE", "Double");
        typeMap.put("BLOB", "byte[]");
        typeMap.put("RAW", "byte[]");
        typeMap.put("BIT", "Boolean");
        typeMap.put("DECIMAL", "BigDecimal");
        typeMap.put("TINYINT", "Integer");

        typeMap.put("LONGBLOB", "byte[]");
        typeMap.put("MEDIUMTEXT", "String");
        typeMap.put("BIGINT UNSIGNED", "Long");
        typeMap.put("INT UNSIGNED", "Integer");
        typeMap.put("tinyint", "byte");
        typeMap.put("TINYINT UNSIGNED", "Integer");
        typeMap.put("MEDIUMBLOB", "String");
        typeMap.put("json", "String");
        typeMap.put("JSON", "String");
        typeMap.put("SMALLINT UNSIGNED", "Integer");
        typeMap.put("VARBINARY", "String");
        typeMap.put("BINARY", "byte[]");
        typeMap.put("LONGTEXT", "String");
        typeMap.put("SMALLINT", "Integer");
        typeMap.put("ENUM", "String");
    }


    public static String getJavaType(String columnType) {
        String type = typeMap.get(columnType.toLowerCase());
        if (type == null) {
            type = typeMap.get(columnType.toUpperCase());
        }
        return type;
    }

}
