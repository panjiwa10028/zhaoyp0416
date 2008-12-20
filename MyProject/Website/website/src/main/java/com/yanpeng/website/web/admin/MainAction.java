package com.yanpeng.website.web.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.ParentPackage;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.apache.struts2.dispatcher.ServletActionRedirectResult;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.User;
import org.springframework.security.userdetails.UserDetails;

import com.opensymphony.xwork2.ActionSupport;
import com.yanpeng.website.bean.entity.TRoles;
import com.yanpeng.website.bean.entity.TUsers;
import com.yanpeng.website.service.exception.ServiceException;
import com.yanpeng.website.service.manager.user.UserManager;

import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.utils.CollectionUtils;
import org.springside.modules.web.struts2.CRUDActionSupport;
import org.springside.modules.web.struts2.SimpleActionSupport;

import org.springframework.security.Authentication;

/**
 * 用户管理Action.
 * 
 * @see CRUDActionSupport
 * 
 * @author calvin
 */
@ParentPackage("default")
@Results( { @Result(name = CRUDActionSupport.RELOAD, value = "/login", type = ServletActionRedirectResult.class)
,@Result(name = CRUDActionSupport.SUCCESS, value = "/index", type = ServletActionRedirectResult.class)
,@Result(name = "index", value = "/index", type = ServletActionRedirectResult.class)
,@Result(name = "mainWorkArea", value = "/mainWorkArea", type = ServletActionRedirectResult.class)})
public class MainAction extends SimpleActionSupport {

	private static final long serialVersionUID = -2180690009159324387L;

	private UserManager manager;
	private TUsers entity;

	@Override
	public String execute() throws Exception {
		return list();
	}

	public String list() throws Exception {
		return SUCCESS;
	}
	
	public String leftMenu() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String loginName = request.getParameter("role_id");
		String value="<LI class=\"menuItem\" id=\"vmenu_1_0\"><A href=\"null\" onclick='mainWorkArea.location=\"main!repsonseWorkArea.action\";return ";
		value += "false;window.focus();'>main</A></LI></UL>";
		
		value +="<LI class=\"menuItem\" id=\"vmenu_1_1\"><A href=null onclick='mainWorkArea.location=\"./bank/guanli.html\";return ";
		value +="false;window.focus();'>帐户管理</A></LI></UL>";
		User u = getUser();
//		if (manager.isLoginNameUnique(loginName, orgLoginName))
//			return renderText("true");
//		else
//			return renderText("false");
		return renderText(value);
	}


	public String repsonseWorkArea() throws Exception {
		return new String("mainWorkArea");
	}
	
	@Required
	public void setUserManager(UserManager userManager) {
		manager = userManager;
	}
	
	public User getUser()    
    {   
        //取得登录用户   
        SecurityContext ctx = SecurityContextHolder.getContext();       
        Authentication auth = ctx.getAuthentication(); 
        User user = null;
        if(auth.getPrincipal() instanceof UserDetails)   
        {   
        	user = (User)auth.getPrincipal();     
            //log.debug("\nauth.getPrincipal()==============\n"+user.getUserid());               
        }       
           
        return user;   
    }
}
