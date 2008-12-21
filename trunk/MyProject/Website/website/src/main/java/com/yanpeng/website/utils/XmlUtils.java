package com.yanpeng.website.utils;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springside.modules.utils.BeanUtils;

import com.yanpeng.website.bean.entity.TMenus;

public class XmlUtils {
	protected static Logger logger = LoggerFactory.getLogger(XmlUtils.class);
	
	public static String ListToLeftMenu(List menuList) {
		
		Element root = new Element("DIV");  
		Document doc = new Document(root);  
		Element elementDIV = null; 
		Element elementA = new Element("A"); 
		Element elementUL = new Element("UL"); 
		int cnt = 1;
		String returnValue = "";
		String value = "";
		for (int i = 0; i < menuList.size(); i++) {    
            
	    	   TMenus menu = (TMenus)menuList.get(i);
	    	   if("0".equals(menu.getParentId())) {
	    		// 创建节点 user; 
	    		   if(!"".equals(returnValue)) {
//	    			   elementDIV.addContent(elementA);
//	    			   elementDIV.addContent(elementUL);
//	    			   root.addContent(elementDIV); 
	    			   cnt ++;
	    			   returnValue += ",";
	    		   }
	    			   
//		           elementDIV = new Element("DIV");    
//		               
//		           // 给 user 节点添加属性 id;    
//		           elementDIV.setAttribute("id", "vmenu_" + cnt);    
//		           elementDIV.setAttribute("headerOpenClass", "headerOpen");   
//		           elementDIV.setAttribute("headerCloseClass", "headerClose");   
//		           elementDIV.setAttribute("itemClass", "menuItem");   
//		           elementDIV.setAttribute("m_maxItemId", "0");   
//		           
//		           
//		           elementA = new Element("A"); 
//		           elementA.setAttribute("class", "headerClose");  
//		           elementA.setAttribute("href", "#");  
//		           elementA.addContent(menu.getDisplayName());
//		           
//		           elementUL = new Element("UL"); 
//		           elementUL.setAttribute("id", "vmenu_"+ cnt +"_content");
//		           elementUL.setAttribute("style", "DISPLAY: block; MARGIN: 0px; HEIGHT: 0px");  
//		           elementUL.setAttribute("height", "0");
		           
		           returnValue += menu.getDisplayName() + "||";
		           
	    	   }else {
//	    		   Element elementLI = new Element("LI"); 
//	        	   elementLI.setAttribute("class", "menuItem");  
//	        	   elementLI.setAttribute("id", "vmenu_"+cnt+"_"+menu.getSort());  
//	               
//	               Element elementLI_A = new Element("A"); 
//	               elementLI_A.setAttribute("onclick", menu.getUrl() + ";return false;window.focus();");  
//	               elementLI_A.setAttribute("href", "null");  
//	               elementLI_A.addContent(menu.getDisplayName());
//	               
//	               elementLI.addContent(elementLI_A);
//	               elementUL.addContent(elementLI);
	               
	              value = XmlUtils.setChildMenu(menu, cnt);
	              returnValue += value;
	    	   }	           
	    
	       } 
//		returnValue += value;
//		if(elementDIV != null) {
//			   elementDIV.addContent(elementA);
//			   elementDIV.addContent(elementUL);
//			   root.addContent(elementDIV); 
//		   }
		
//		XMLOutputter XMLOut = new XMLOutputter();   

		return returnValue;
	}
	public static String setChildMenu(TMenus menu, int cnt) {
		
		//Element root = new Element("DIV");  
		 
		
		Element elementLI = new Element("LI"); 
		Document doc = new Document(elementLI); 
 	   	elementLI.setAttribute("class", "menuItem");  
 	   	elementLI.setAttribute("id", "vmenu_"+cnt+"_"+menu.getSort());  
        
        Element elementLI_A = new Element("A"); 
        elementLI_A.setAttribute("onclick", menu.getUrl() + ";return false;window.focus();");  
        elementLI_A.setAttribute("href", "null");  
        elementLI_A.addContent(menu.getDisplayName());
        
        elementLI.addContent(elementLI_A);
        
       XMLOutputter XMLOut = new XMLOutputter();   
		return XMLOut.outputString(doc).replaceAll("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
	}
	
	public static void main(String args[]){
		
		List list = new ArrayList();
		Map map = new LinkedHashMap();
		map.put("name", "系统管理");
		List l = new ArrayList();
		String []s = new String[2];
		 s[0] = "菜单管理";
		 s[1] = "menu.action";
		l.add(s);
		map.put("child", l);
		list.add(map);
		String xml = XmlUtils.ListToLeftMenu(list);
		System.out.println(xml);
	}
}
