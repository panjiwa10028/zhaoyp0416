package com.yanpeng.ssweb.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 *
 * @author Allen
 *
 */
public class HtmlGenerator {
	protected Log logger = LogFactory.getLog(getClass());
	
	private String encode;//邮件生成的编码方式

    private String templateDir;//模板文件存放的路径(在classpath下)

    private String templateFile;//模板文件名

    private String previewHtmlFileDir;//生成的预览文件的路径

    private Configuration freemarkerCfg = null;
    
    String rootDir = "";
    
   

	public String getRootDir() {
		return rootDir;
	}

	public void setRootDir(String rootDir) {
		this.rootDir = rootDir;
	}

	public String getTemplateDir() {
        return templateDir;
    }

    public void setTemplateDir(String template) {
        this.templateDir = template;
    }
    public String getEncode() {
        return encode;
    }

    public void setEncode(String encode) {
        this.encode = encode;
    }

    public String getTemplateFile() {
        return templateFile;
    }

    public void setTemplateFile(String templateFile) {
        this.templateFile = templateFile;
    }

    public String getPreviewHtmlFileDir() {
        return previewHtmlFileDir;
    }

    public void setPreviewHtmlFileDir(String htmlFileDir) {
        this.previewHtmlFileDir = htmlFileDir;
    }
	/**
     * 获取freemarker的配置
     */
    protected Configuration getFreemarkerCfg() {
        if (null == freemarkerCfg) {
            freemarkerCfg = new Configuration();
            freemarkerCfg.setDefaultEncoding(encode);
            freemarkerCfg.setClassForTemplateLoading(this.getClass(), templateDir);
        }
        return freemarkerCfg;
    }

    /**
     * 生成预览要发送的邮件到previewHtmlFileDir指定目录
     *
     * @param propMap
     * @param htmlFileName
     * @return 预览文件的相对路径,譬如:preview/1.html
     */
    public String preview(Map propMap, String htmlFileName) {
        if (geneHtmlFile(templateFile, propMap, htmlFileName)) {
            return previewHtmlFileDir + "/" + htmlFileName;
        } else {
            return null;
        }
    }

    /**
     * 根据邮件模板和对应的参数生成静态文件.
     * 文件存放路径为当前webapp下面的1级子目录,在spring配置文件中指定
     * 如当前htmlFileName为1.html,previewHtmlFileDir为preview
     * 那么文件生成后的访问路径类似于:http://localhost:8080/springside/preview/1.html
     *
     * @param templateFileName 模板文件名
     * @param propMap          用于处理模板的属性Object映射
     * @param htmlFileName     要生成的文件名,例如 "1.htm"
     */
    private boolean geneHtmlFile(String templateFileName, Map propMap, String htmlFileName) {
//        String sRootDir = getAbsolutePath();
        try {
            Template t = getFreemarkerCfg().getTemplate(templateFileName);
            logger.info(templateFileName);
            //如果根路径存在,则递归创建子目录 
            creatDirs(rootDir, previewHtmlFileDir);
            File afile = new File(rootDir + "/" + previewHtmlFileDir + "/" + htmlFileName);
            Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(afile), encode));
            t.process(propMap, out);
        }
        catch (TemplateException e) {
            logger.error("Error while processing FreeMarker template " + templateFileName, e);
            return false;
        }
        catch (IOException e) {
            logger.error(("Error while generate Static Html File " + htmlFileName), e);
            return false;
        }
        return true;
    }

    /**
     * 获取当前webapp绝对路径
     */
    private String getAbsolutePath() {
        File f = new File("");
        return f.getAbsolutePath();
    }

    /**
     * 创建多级目录
     *
     * @param aParentDir String
     * @param aSubDir    以 / 开头
     * @return boolean 是否成功
     */
    private boolean creatDirs(String aParentDir, String aSubDir) {
        File aFile = new File(aParentDir);
        if (aFile.exists()) {
            File aSubFile = new File(aParentDir + "/" + aSubDir);
            if (!aSubFile.exists()) {
                return aSubFile.mkdirs();
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

    /**
     * 根据模板文件和传入的属性生成邮件内容.
     *
     * @param propMap 用于处理模板的属性Object映射
     * @return 生成的邮件内容
     */
    public String generateContent(Map propMap) {
        String result = null;
        try {
            Template t = getFreemarkerCfg().getTemplate(templateFile);
            result = FreeMarkerTemplateUtils.processTemplateIntoString(t, propMap);
        }
        catch (TemplateException e) {
            logger.error("Error while processing FreeMarker template ", e);
            return null;
        } catch (FileNotFoundException e) {
            logger.error("Error while open template file ", e);
            return null;
        }
        catch (IOException e) {
            logger.error("Error while generate Email Content ", e);
            return null;
        }
        return result;
    }
}
