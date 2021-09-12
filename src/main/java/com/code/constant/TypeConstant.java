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
        typeMap.put("BIGINT", "Long");
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

    }


    public static String getJavaType(String columnType) {

        return typeMap.get(columnType);
    }
}
