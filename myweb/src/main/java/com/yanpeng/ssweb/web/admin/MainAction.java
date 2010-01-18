package com.yanpeng.ssweb.web.admin;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.web.BaseAction;

/**
 * 登入默认Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
public class MainAction extends BaseAction {

	// 基本属性
	private Users user;

	private String leftMenuValue;

	@Autowired
	private MenuManager menuManager;

	public String getLeftMenuValue() {
		return leftMenuValue;
	}

	public Users getUser() {
		return user;
	}

	@Override
	public String execute() throws Exception {
		user = getLoginUser();
		if (user == null) {
			user = new Users();
		}

		Collection<Long> roleIds = user.getRoleIds();
		if (roleIds != null && roleIds.size() > 0) {
			List<Menus> menusList = menuManager.findMenusByRoleIds(roleIds);
			leftMenuValue = listToLeftMenu(menusList);
		}

		return SUCCESS;
	}

	private String listToLeftMenu(List<Menus> menuList) {

		Element root = new Element("DIV");
		Document doc = new Document(root);
		Element elementDIV = null;
		Element elementA = new Element("A");
		Element elementUL = new Element("UL");
		int cnt = 1;
		String returnValue = "";
		String value = "";
		Map<Long, String> tempMap = new LinkedHashMap<Long, String>();
		Map<Long, Integer> placeMap = new HashMap<Long, Integer>();
		for (int i = 0; i < menuList.size(); i++) {

			Menus menu = menuList.get(i);
			if (-1 ==(menu.getParentId())) {
				tempMap.put(menu.getId(), menu.getDisplayName() + "||");
				placeMap.put(menu.getId(), cnt++);
				// 创建节点 user;
//				if (!"".equals(returnValue)) {
//					cnt++;
//					returnValue += ",";
//				}

//				returnValue += menu.getDisplayName() + "||";

			} else {

				if (menu.getIsDisabled() == 1) {
					continue;
				}
				value = setChildMenu(menu, placeMap);
//				returnValue += value;
				if(tempMap.containsKey(menu.getParentId())) {
					String temp = (String) tempMap.get(menu.getParentId());
					temp += value;
					tempMap.put(menu.getParentId(), temp);
				}
			}

		}
//		returnValue = "";
		for(Iterator<String> iter=tempMap.values().iterator();iter.hasNext();) {
			String temp = (String) iter.next();
			if (!"".equals(returnValue)) {
				returnValue += ",";
			}
			returnValue += temp ;
		}
		return returnValue;
	}

	public String setChildMenu(Menus menu, Map<Long, Integer> placeMap) {

		Element elementLI = new Element("LI");
		Document doc = new Document(elementLI);
		elementLI.setAttribute("class", "menuItem");
		elementLI.setAttribute("id", "vmenu-" + placeMap.get(menu.getParentId()) + "-" + menu.getSort());

		Element elementLI_A = new Element("A");
		elementLI_A.setAttribute("onclick", menu.getPath() + ";return false;window.focus();");
		elementLI_A.setAttribute("href", "null");
		elementLI_A.addContent(menu.getDisplayName());

		elementLI.addContent(elementLI_A);

		XMLOutputter XMLOut = new XMLOutputter();
		return XMLOut.outputString(doc).replaceAll("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
	}

}
