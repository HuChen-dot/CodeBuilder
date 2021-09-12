package com.code;

import java.util.List;

import com.code.bean.Table;
import com.code.constant.Constant;
import com.code.handler.MvcHandler;
import com.code.handler.TableHandler;

public class Genterator {
    public static void main(String args[]) throws Exception {
        TableHandler tableHandler = new TableHandler();
        tableHandler.addExceptTable("");
        MvcHandler mvcHandler = new MvcHandler();
        List<Table> tableList = tableHandler.getTables();
        for (Table table : tableList) {
            mvcHandler.executeModule(table);
            mvcHandler.executeService(table);
            mvcHandler.executeServiceImpl(table);
            mvcHandler.executeMapper(table);
            mvcHandler.executeClazzMapper(table);
        }
        System.err.println("生成已完成,请到" + Constant.path + "下查看");
    }
}