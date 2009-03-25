package com.yanpeng.ssweb.web.admin.group;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.Groups;
import com.yanpeng.ssweb.exceptions.ServiceException;
import com.yanpeng.ssweb.service.group.GroupManager;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author calvin
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CURDBaseAction.RELOAD, location = "group.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class GroupAction extends CURDBaseAction<Groups> {

	// CRUD Action 基本属性
	
	@Autowired
	private GroupManager groupManager;

	// CRUD Action 属性访问函数


	@Override
	protected void prepareModel() throws Exception {
		if (id != null && !id.equals("")) {
			entity = groupManager.getGroupById(id);
		} else {
			entity = new Groups();
		}
	}

	

	// CRUD Action 函数

	@Override
	public String list() throws Exception {
		page = groupManager.getAllGroup(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {		
		return INPUT;
	}

	
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
		System.out.println("------------------ save()");
		if(entity != null && entity.getId().equals("")) {
			entity.setId(null);
		}
//		暂不支持多级组
		entity.setParentId("0");
		
		try{
			groupManager.saveGroup(entity);
			addActionMessage("保存用户组成功");
			return RELOAD;
		}catch(Exception e) {
			e.printStackTrace();
			addActionMessage("保存用户组失败");
			return INPUT;
		}
		
	}

	@Override
	public String delete() throws Exception {
		try {
			String []ids = id.split(",");
			List<String> list = Arrays.asList(ids);   
	
			groupManager.deleteGroups(list);
			addActionMessage("删除用户组成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(e.getMessage());
		}
		return RELOAD;
	}

	// 其他属性访问函数及Action函数

	
	/**
	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
	 */
	public String checkName() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		String orgName = request.getParameter("orgName");
		
		if (groupManager.isNameUnique(name, orgName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出而不经过Jsp,因此返回null.
		return null;
	}	

	
	

	

	
		
	
}
