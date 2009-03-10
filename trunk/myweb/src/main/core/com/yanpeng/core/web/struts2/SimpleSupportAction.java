package com.yanpeng.core.web.struts2;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.opensymphony.xwork2.ActionSupport;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * Struts2 Action基类.
 * 
 * 实现获取Request/Response/Session的简化函数和绕过jsp/freemaker直接输出文本的函数.
 * 
 * @author calvin
 */
public class SimpleSupportAction extends ActionSupport {

	private static final long serialVersionUID = -3200676032178970212L;

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	// 取得Request/Response/Session的简化函数

	@Autowired
	public UserManager userManager;

	
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	public Users getLoginUser() throws Exception{
		try{
			Users user=(Users)getSession().getAttribute("LoginUser");
			if(user==null){
				SecurityContext ctx = SecurityContextHolder.getContext();
		        Authentication auth = ctx.getAuthentication();       
		        if(auth.getPrincipal() instanceof UserDetails){   
		        	org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User)auth.getPrincipal();     
		        	if(userd!=null&&userd.getUsername()!=null){
		        		user=userManager.getUserByLoginName(userd.getUsername());
		        		getSession().setAttribute("LoginUser", user);
		        	}
		        }     
			}
	        return user;   
		}catch (Exception e) {
			return null;
		}
	}
	/**
	 * 取得HttpSession的简化方法.
	 */
	protected HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * 取得HttpRequest的简化方法.
	 */
	protected HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 取得HttpResponse的简化方法.
	 */
	protected HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * 绕过Template,直接输出内容的简便函数. 
	 */
	protected void render(final String text, final String contentType) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType(contentType);
			response.getWriter().write(text);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	// 绕过jsp/freemaker直接输出文本的函数

	/**
	 * 直接输出文本,默认编码为UTF-8.
	 */
	protected void renderText(final String text) {
		render(text, "UTF-8");
	}

	/**
	 * 直接输出文本.
	 */
	protected void renderText(final String text, final String encoding) {
		render(text, "text/plain;charset=" + encoding);
	}

	/**
	 * 直接输出HTML,默认编码为UTF-8.
	 */
	protected void renderHtml(final String html) {
		render(html, "UTF-8");
	}

	/**
	 * 直接输出HTML.
	 */
	protected void renderHtml(final String html, final String encoding) {
		render(html, "text/html;charset=" + encoding);
	}

	/**
	 * 直接输出XML,默认编码为UTF-8.
	 */
	protected void renderXML(final String xml) {
		render(xml, "UTF-8");
	}

	/**
	 * 直接输出XML.
	 */
	protected void renderXML(final String xml, final String encoding) {
		render(xml, "text/xml;charset=" + encoding);
	}
}
