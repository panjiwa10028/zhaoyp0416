package com.yanpeng.website.web.admin.menu;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.ParentPackage;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import org.apache.struts2.dispatcher.ServletActionRedirectResult;
import org.apache.struts2.dispatcher.ServletDispatcherResult;
import org.springframework.beans.factory.annotation.Required;
import org.springside.modules.orm.hibernate.Page;
import org.springside.modules.utils.CollectionUtils;
import org.springside.modules.web.struts2.CRUDActionSupport;

import com.yanpeng.website.bean.entity.TMenus;
import com.yanpeng.website.service.manager.menu.MenuManager;

/**
 * 用户管理Action.
 * 
 * @see CRUDActionSupport
 * 
 * @author calvin
 */
@ParentPackage("default")
@Results( 
		{ @Result(name = CRUDActionSupport.RELOAD, value = "/menu", type = ServletActionRedirectResult.class)
			,@Result(name = "save", value = "/WEB-INF/jsp/admin/menu/hidden.jsp", type = ServletDispatcherResult.class)
	})
public class MenuAction extends CRUDActionSupport<TMenus> {

	private static final long serialVersionUID = -2180690009159324387L;

	private MenuManager manager;

	private Page<TMenus> page = new Page<TMenus>(5, true);//每页5项，自动查询计算总页数.

	private TMenus entity;

	private String id;



	public TMenus getModel() {
		return entity;
	}

	public Page<TMenus> getPage() {
		return page;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = manager.getMenu(id);
		} else {
			entity = new TMenus();
		}
	}

	@Override
	public String list() throws Exception {
		page = manager.getAllMenus(page);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
//		allRoles = manager.getAllRoles();
//		checkedRoleIds = entity.getRoleIds();
		return INPUT;
	}
///
	@Override
	public String save() throws Exception {
		//根据页面上的checkbox 整合entity的roles Set
//		CollectionUtils.mergeByCheckedIds(entity.getRoles(), checkedRoleIds, Role.class);
		System.out.println(entity.getDisabled());
		HttpServletRequest request = ServletActionContext.getRequest();
		System.out.println(request.getParameter("disabled"));
		if(request.getParameter("disabled") == null) {
			entity.setDisabled(0);
		}
		manager.saveMenu(entity);
		addActionMessage("保存用户成功");
		
		return "save";
	}
	
	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
	 */
	public String checkDisplayName() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String displayName = request.getParameter("displayName");
		String oldDisplayName = request.getParameter("oldDisplayName");

		if (manager.isDisplayNameUnique(displayName, oldDisplayName))
			return renderText("true");
		else
			return renderText("false");
	}
//
//	@Override
//	public String delete() throws Exception {
//		try {
//			manager.deleteUser(id);
//			addActionMessage("删除用户成功");
//		} catch (ServiceException e) {
//			logger.error(e.getMessage(), e);
//			addActionMessage(e.getMessage());
//		}
//		return RELOAD;
//	}
//
//	/**
//	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
//	 */
//	public String checkLoginName() throws Exception {
//		HttpServletRequest request = ServletActionContext.getRequest();
//		String loginName = request.getParameter("loginName");
//		String orgLoginName = request.getParameter("orgLoginName");
//
//		if (manager.isLoginNameUnique(loginName, orgLoginName))
//			return renderText("true");
//		else
//			return renderText("false");
//	}

	@Required
	public void setMenuManager(MenuManager menuManager) {
		manager = menuManager;
	}
	/**
	 * 规范了CRUD函数的名称，规定使用ModelDriven和Preparedable接口，并规范了prepare二次绑定接口只在input和save函数中的使用
     	流程如下：

		1.用户打开用户列表页，访问/user.action
		a.执行默认的execute() 函数，实际执行list() 函数。
		b.list() 函数查询列表放入某list变量，返回SUCCESS，默认跳转到user.jsp
		c.user.jsp取出action中的list变量进行渲染。 
		2.用户新增对象时，访问/user!input.action
		a.首先将id放入id变量，执行prepareSave()函数创建一个新的user变量
		b.input() 函数，返回INPUT，默认跳转到user-input.jsp
		c.user-input.jsp 执行getModel()获得user变量渲染input框 
		3.用户提交Form，访问/user!save.action
		a.执行preparedSave()函数创建新的user变量，将input框的内容绑定到getModel()获得的user变量
		b.执行save()函数保存user，返回RELOAD，跳转到@Result中定义RELOAD页面，以redirect方式重新打开/user.action 
		4.用户修改对象，访问/user!input.action?id=1
		a.绑定id=1到id变量，执行prepareInput()从数据库查询出user。
		b.下同2. 
		5.用户提交Form,访问/user!save.action
		a.绑定id=1到id变量，执行prepareSave()从数据库查询出user。
		b.下同3. 

	 */

	
}
