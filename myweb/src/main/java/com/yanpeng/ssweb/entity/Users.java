package com.yanpeng.ssweb.entity;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.yanpeng.core.utils.ReflectionUtils;


/**
 * Users entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "users", catalog = "myweb", uniqueConstraints = @UniqueConstraint(columnNames = "login_name"))
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Users extends BaseEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1008379722069409647L;
	// Fields
	private Groups groups;
	private String name;
	private String loginName;
	private String password;
	private Short isDisabled = 0;
	private Short isExpired = 0;
	private Short isLocked = 0;
	private Set<Roles> roleses = new LinkedHashSet<Roles>(0);

	// Constructors

	/** default constructor */
	public Users() {
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id", nullable = false)
	public Groups getGroups() {
		return this.groups;
	}

	public void setGroups(Groups groups) {
		this.groups = groups;
	}

	@Column(name = "name", nullable = false, length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "login_name", unique = true, nullable = false, length = 100)
	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	@Column(name = "password", nullable = false)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "isdisabled", nullable = false)
	public Short getIsDisabled() {
		return this.isDisabled;
	}

	public void setIsDisabled(Short isDisabled) {
		this.isDisabled = isDisabled;
	}

	@Column(name = "isExpired", nullable = false)
	public Short getIsExpired() {
		return this.isExpired;
	}

	public void setIsExpired(Short isExpired) {
		this.isExpired = isExpired;
	}
	
	@Column(name = "isLocked", nullable = false)
	public Short getIsLocked() {
		return this.isLocked;
	}

	public void setIsLocked(Short isLocked) {
		this.isLocked = isLocked;
	}

	
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "users_roles", catalog = "myweb", joinColumns = { @JoinColumn(name = "user_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) })
	public Set<Roles> getRoleses() {
		return this.roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}
	
	//非持久化属性.
	@Transient
	public String getRoleNames() throws Exception {
		return ReflectionUtils.fetchElementPropertyToString(roleses, "name", ", ");
	}

	//非持久化属性.
	@Transient
	@SuppressWarnings("unchecked")
	public List<String> getRoleIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(roleses, "id");
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}