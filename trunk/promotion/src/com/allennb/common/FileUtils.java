package com.allennb.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtils {
	
	protected static Logger logger = LoggerFactory.getLogger(FileUtils.class);
	
	private static Properties pp = new Properties();
	
	
	/**
	 * 根据文件名读取文件内容
	 * @param FileName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<String> getFileContent(String FileName) {
		InputStream input = null ;
		List<String> contentLines = null;
		try {
			input = new FileInputStream(FileName);
			contentLines = IOUtils.readLines(input, "gbk");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return contentLines;
	}
	
	/**
	 * 根据文件读取文件内容
	 * @param file
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<String> getFileContent(File file) {
		InputStream input = null ;
		List<String> contentLines = null;
		try {
			input = new FileInputStream(file);
			contentLines = IOUtils.readLines(input, "gbk");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return contentLines;
	}
	
	/**
	 * 获取属性文件值
	 * @param key
	 * @return
	 */
	public static String getProp(String key) {
	 InputStream in = null;
		 try{
	          in = ClassLoader.getSystemResourceAsStream("config.properties");
		   }catch(Exception e)
		   {
		    System.out.println("properties文件没有找到");
		   }
		   try
		   {
		   pp.load(in);
		   }catch(IOException e)
		   {
		    System.out.println(e+"调用load方法时出现异常");
		   }
		return pp.getProperty(key);
	}
}
