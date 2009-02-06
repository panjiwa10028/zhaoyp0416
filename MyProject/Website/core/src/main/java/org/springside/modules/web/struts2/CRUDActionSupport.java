package org.springside.modules.web.struts2;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

/**
 * Struts2中CRUD典型Action规范类.
 * 规定使用Preparable,ModelDriven接口,规范了一些函数的命名.
 *
 * @param <T> CRUD所管理的对象类型.
 * 
 * @author calvin
 */
public abstract class CRUDActionSupport<T> extends SimpleActionSupport implements ModelDriven<T>, Preparable {

	private static final long serialVersionUID = -8059566655850173821L;
	/**
	 * 进行CUD操作后,以redirect方式重新打开action默认页的result名.
	 */
	public static final String RELOAD = "reload";

	/**
	 * Action函数,默认action函数，默认指向list函数.
	 */
	@Override
	public String execute() throws Exception {
		return list();
	}

	/**
	 * Action函数,显示Entity列表.
	 * 建议return SUCCESS.
	 */
	public abstract String list() throws Exception;

	/**
	 * Action函数,新增或修改Entity. 
	 * 建议return RELOAD.
	 */
	public abstract String save() throws Exception;

	/**
	 * Action函数,删除Entity.
	 * 建议return RELOAD.
	 */
	public abstract String delete() throws Exception;

	/**
	 * 等同于prepare()的内部函数,供prepardMethodName()函数调用. 
	 */
	protected abstract void prepareModel() throws Exception;

	/**
	 * 实现空的prepare()函数,屏蔽所有Action函数公共的二次绑定.
	 */
	public void prepare() throws Exception {
	}

	/**
	 * 在save()前执行二次绑定.
	 */
	public void prepareSave() throws Exception {
		prepareModel();
	}

	/**
	 * 在input()前执行二次绑定.
	 */
	public void prepareInput() throws Exception {
		prepareModel();
	}
}
