package org.springside.examples.miniweb.entity.user;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springside.examples.miniweb.entity.IdEntity;
import org.springside.modules.utils.ReflectionUtils;

/**
 * 用户.
 * 
 * 使用JPA annotation定义ORM关系.
 * 使用Hibernate annotation定义缓存.
 * 
 * @author calvin
 */
@Entity
@Table(name = "USERS") //表名默认等于类名,不相同时需重新定义.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)  //默认的缓存策略
public class User extends IdEntity {

	private String loginName;

	private String password; //为简化演示,使用明文保存密码.

	private String name;

	private String email;

	private Set<Role> roles = new LinkedHashSet<Role>(); //有序的关联对象集合

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE}) //避免定义CascadeType.REMOVE, 否则删除角色时会连带删除拥有它的用户
	@JoinTable(name = "USERS_ROLES", joinColumns = { @JoinColumn(name = "USER_ID") }, inverseJoinColumns = { @JoinColumn(name = "ROLE_ID") })
	@OrderBy("id") //集合按id排序
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE) //集合中对象的id的缓存
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Transient //非持久化属性
	public String getRoleNames() throws Exception {
		return ReflectionUtils.fetchElementPropertyToString(roles, "name", ", ");
	}

	@Transient //非持久化属性
	@SuppressWarnings("unchecked")
	public List<Long> getRoleIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(roles, "id");
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}