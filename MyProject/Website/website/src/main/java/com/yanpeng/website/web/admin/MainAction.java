package com.yanpeng.website.web.admin;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.ParentPackage;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.apache.struts2.config.NullResult;
import org.apache.struts2.dispatcher.ServletActionRedirectResult;
import org.apache.struts2.dispatcher.ServletDispatcherResult;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.User;
import org.springframework.security.userdetails.UserDetails;

import com.opensymphony.xwork2.ActionSupport;
import com.yanpeng.website.bean.entity.TMenus;
import com.yanpeng.website.bean.entity.TRoles;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.exception.ServiceException;
import com.yanpeng.website.service.manager.RoleManager.RoleManager;
import com.yanpeng.website.service.manager.menu.MenuManager;
import com.yanpeng.website.service.manager.user.UserManager;
import com.yanpeng.website.utils.XmlUtils;

import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.utils.CollectionUtils;
import org.springside.modules.web.struts2.CRUDActionSupport;
import org.springside.modules.web.struts2.SimpleActionSupport;

import org.springframework.security.Authentication;
import com.opensymphony.xwork2.ActionChainResult;
/**
 * 用户管理Action.
 * 
 * @see CRUDActionSupport
 * 
 * @author calvin
 */
@ParentPackage("default")
@Results( { @Result(name = "firstPage", value = "/firstPage", type = ServletActionRedirectResult.class)})
public class MainAction extends SimpleActionSupport {

	private static final long serialVersionUID = -2180690009159324387L;

	private UserManager userManager;
	private MenuManager menuManager;
	private TUsers entity;
	
	
	public TUsers getEntity() {
		return entity;
	}

	@Override
	public String execute() throws Exception {
		return SimpleActionSupport.SUCCESS;
	}

	
	public String getLeftMenu() throws Exception {
		User u = getUser();
		
		entity = userManager.getUserByLoginName(u.getUsername());
		List menuIdList = new ArrayList();
		Set rolesSet = entity.getTRoleses();
		Map rootMenu = new LinkedHashMap();
		for(Iterator rolesIter = rolesSet.iterator(); rolesIter.hasNext();) {
			TRoles role = (TRoles) rolesIter.next();
			menuIdList.addAll(role.getMenuIds());
		}
		List list = menuManager.getMenusByIds(menuIdList);
		String xml = XmlUtils.ListToLeftMenu(list);

		return renderText(xml);
	}


	@Required
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	@Required
	public void setMenuManager(MenuManager menuManager) {
		this.menuManager = menuManager;
	}
	
	private User getUser()    
    {   
        //取得登录用户   
        SecurityContext ctx = SecurityContextHolder.getContext();       
        Authentication auth = ctx.getAuthentication(); 
        User user = null;
        if(auth.getPrincipal() instanceof UserDetails)   
        {   
        	user = (User)auth.getPrincipal();                   
        }       
           
        return user;   
    }
}
