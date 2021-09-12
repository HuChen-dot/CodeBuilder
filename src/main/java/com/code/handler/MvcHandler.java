package com.code.handler;

import java.util.HashMap;
import java.util.Map;

import com.code.bean.Table;
import com.code.constant.Constant;
import com.code.util.FreeMarkerUtils;
import com.code.util.StringUtils;

public class MvcHandler {

    String templateFile = Constant.template_path;

    public void executeModule(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("pojo", Constant.pojo);
        input.put("mapper", Constant.mapper);
        input.put("service", Constant.service);
        input.put("serviceImpl", Constant.service_impl);
        String fileName = table.getClassName() + ".java";
        String savePath = Constant.model_save_path;
        String templateName = "model";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeService(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));

        input.put("pojo", Constant.pojo);
        input.put("mapper", Constant.mapper);
        input.put("service", Constant.service);
        input.put("serviceImpl", Constant.service_impl);
        String fileName = table.getClassName() + "Service" + ".java";
        String savePath = Constant.service_save_path + "//" + StringUtils.lowerName(table.getClassName()) + "//";
        String templateName = "service";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeServiceImpl(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        input.put("pojo", Constant.pojo);
        input.put("mapper", Constant.mapper);
        input.put("service", Constant.service);
        input.put("serviceImpl", Constant.service_impl);
        String fileName = table.getClassName() + "ServiceImpl" + ".java";
        String savePath = Constant.servie_impl_save_path + "//" + StringUtils.lowerName(table.getClassName()) + "//";
        String templateName = "serviceImpl";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeMapper(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        input.put("pojo", Constant.pojo);
        input.put("mapper", Constant.mapper);
        input.put("service", Constant.service);
        input.put("serviceImpl", Constant.service_impl);
        String fileName = table.getClassName() + "Mapper" + ".xml";
        String savePath = Constant.mapper_save_path + "//" + StringUtils.lowerName(table.getClassName()) + "//";
        String templateName = "mapper";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeClazzMapper(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        input.put("pojo", Constant.pojo);
        input.put("mapper", Constant.mapper);
        input.put("service", Constant.service);
        input.put("serviceImpl", Constant.service_impl);
        String fileName = table.getClassName() + "Mapper" + ".java";
        String savePath = Constant.mapper_save_path + "//" + StringUtils.lowerName(table.getClassName()) + "//";
        String templateName = "clazzMapper";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }
}
