package com.yanpeng.ssweb.web.admin;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

import com.yanpeng.core.web.struts2.SimpleSupportAction;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.service.user.UserManager;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
public class MainAction extends SimpleSupportAction {

	// 基本属性
	private Users users;

	private String leftMenuValue;

	@Autowired
	public UserManager userManager;

	@Autowired
	public MenuManager menuManager;

	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	public MenuManager getMenuManager() {
		return menuManager;
	}

	public String getLeftMenuValue() {
		return leftMenuValue;
	}

	public Users getUsers() {
		return users;
	}

	@Override
	public String execute() throws Exception {
		users = getLoginUser();
		if (users == null) {
			users = new Users();
		}

		Collection<Serializable> roleIds = users.getRoleIds();
		List<Menus> menusList = menuManager.findMenusByRoleIds(roleIds);
		leftMenuValue = listToLeftMenu(menusList);
		return SUCCESS;
	}

	public Users getLoginUser() throws Exception {
		try {
			Users user = (Users) getSession().getAttribute("LoginUser");
			if (user == null) {
				SecurityContext ctx = SecurityContextHolder.getContext();
				Authentication auth = ctx.getAuthentication();
				if (auth.getPrincipal() instanceof UserDetails) {
					org.springframework.security.userdetails.User userd = (org.springframework.security.userdetails.User) auth
							.getPrincipal();
					if (userd != null && userd.getUsername() != null) {
						user = userManager.getUserByLoginName(userd
								.getUsername());
						getSession().setAttribute("LoginUser", user);
					}
				}
			}
			return user;
		} catch (Exception e) {
			return null;
		}
	}

	private String listToLeftMenu(List menuList) {

		Element root = new Element("DIV");
		Document doc = new Document(root);
		Element elementDIV = null;
		Element elementA = new Element("A");
		Element elementUL = new Element("UL");
		int cnt = 1;
		String returnValue = "";
		String value = "";
		for (int i = 0; i < menuList.size(); i++) {

			Menus menu = (Menus) menuList.get(i);
			if ("0".equals(menu.getMenus().getId())) {
				// 创建节点 user;
				if (!"".equals(returnValue)) {
					cnt++;
					returnValue += ",";
				}

				returnValue += menu.getDisplayName() + "||";

			} else {

				if (menu.getDisabled() == 1) {
					continue;
				}
				value = setChildMenu(menu, cnt);
				returnValue += value;
			}

		}

		return returnValue;
	}

	public String setChildMenu(Menus menu, int cnt) {

		Element elementLI = new Element("LI");
		Document doc = new Document(elementLI);
		elementLI.setAttribute("class", "menuItem");
		elementLI.setAttribute("id", "vmenu_" + cnt + "_" + menu.getSort());

		Element elementLI_A = new Element("A");
		elementLI_A.setAttribute("onclick", menu.getUrl()
				+ ";return false;window.focus();");
		elementLI_A.setAttribute("href", "null");
		elementLI_A.addContent(menu.getDisplayName());

		elementLI.addContent(elementLI_A);

		XMLOutputter XMLOut = new XMLOutputter();
		return XMLOut.outputString(doc).replaceAll(
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
	}

}
