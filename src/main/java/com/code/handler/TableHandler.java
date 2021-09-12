package com.code.handler;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import com.code.bean.Cloumn;
import com.code.bean.Table;
import com.code.util.PropertiesUtils;
import com.code.util.StringUtils;

public class TableHandler {

    private List<String> tableExceptList = new ArrayList<String>();

    private static String DBDRIVER = PropertiesUtils.get("database.properties", "driver");

    private static String DBURL = PropertiesUtils.get("database.properties", "url");

    private static String DBUSER = PropertiesUtils.get("database.properties", "user");

    private static String DBPASS = PropertiesUtils.get("database.properties", "password");


    public void addExceptTable(String tableName) {
        tableExceptList.add(tableName);
    }

    private List<Table> queryDataTables() {
        DatabaseMetaData dmd = null;
        Connection conn = null;
        List<Table> tables = new ArrayList<Table>();
        Properties props = new Properties();
        props.put("remarksReporting", "true");
        props.put("user", DBUSER);
        props.put("password", DBPASS);
        try {
            Class.forName(DBDRIVER);
            conn = DriverManager.getConnection(DBURL, props);
            conn.setAutoCommit(true);
            DatabaseMetaData dbmd = conn.getMetaData();
            ResultSet resultSet = null;
            String fac = "";
            if (StringUtils.isorace(DBDRIVER, "oracle")) {
                resultSet = dbmd.getTables(null, DBUSER, null, new String[]{"TABLE"});
                fac = "oracle";
            } else {
                resultSet = dbmd.getTables(null, null, null, new String[]{"TABLE"});
                fac = "mysql";
            }
            while (resultSet.next()) {

                Table table = new Table();
                table.setCloumns(new ArrayList<Cloumn>());
                String tableName = resultSet.getString("TABLE_NAME");
                //把表名全部转成小写
                table.setTableName(tableName.toLowerCase());
                //把查询出来的数据表的表注释设置到模板表里
                table.setComment("");
                table.setFar(fac);
                //ResultSet rs = dbmd.getColumns(null, "%", tableName, "%");
                ResultSet rs = dbmd.getColumns(null, getSchema(conn), tableName, "%");
                while (rs.next()) {
                    Cloumn cloumn = new Cloumn();
                    // 设置列属性
                    cloumn.setCloumnName(rs.getString("COLUMN_NAME").toLowerCase());
                    //获取注释；如果这里注释为空，模板页面获取不到就会报错，所以给个初始值" "；
                    String far = "";
                    if (rs.getString("REMARKS") != null) {
                        far = rs.getString("REMARKS");
                    }
                    cloumn.setComment(far);
                    cloumn.setCloumnType(rs.getString("TYPE_NAME"));
                    table.getCloumns().add(cloumn);
                }
                tables.add(table);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return tables;
    }

    public List<Table> getTables() {
        List<Table> dataTableList = queryDataTables();
        if (null != dataTableList && dataTableList.size() != 0) {
            if (null != tableExceptList && tableExceptList.size() == 0) {
                for (String tableName : tableExceptList) {
                    Iterator<Table> it = dataTableList.iterator();
                    while (it.hasNext()) {
                        Table x = it.next();
                        if (x.getTableName().equals(tableName)) {
                            it.remove();
                        }
                    }
                }
            }
        }
        return dataTableList;
    }

    //其他数据库不需要这个方法 oracle和db2需要
    private static String getSchema(Connection conn) throws Exception {
        String schema;
        schema = conn.getMetaData().getUserName();
        if ((schema == null) || (schema.length() == 0)) {
            throw new Exception("ORACLE数据库模式不允许为空");
        }
        return schema.toUpperCase();

    }

}
