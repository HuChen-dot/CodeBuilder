package com.code.constant;

import com.code.util.PropertiesUtils;

import java.io.File;


public class Constant {
    // 模板路径
    public static String template_path = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main" + File.separator + "resources" + File.separator + "template";
    // 生成路径
    public static String path = PropertiesUtils.get("path.properties","path");
    public static String service_save_path = path+"/service";
    public static String servie_impl_save_path = path+"/service";
    public static String mapper_save_path = path+"/mapper";
    public static String model_save_path = path+"/bean";


    //指定包名
    public static String pojo = PropertiesUtils.get("path.properties","pojo_bag");
    public static String mapper = PropertiesUtils.get("path.properties","mapper_bag");
    public static String service = PropertiesUtils.get("path.properties","service_bag");
    public static String service_impl = PropertiesUtils.get("path.properties","service_impl_bag");
}
