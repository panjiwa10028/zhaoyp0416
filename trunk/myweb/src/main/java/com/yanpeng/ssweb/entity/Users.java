package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Users entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "users", catalog = "myweb", uniqueConstraints = @UniqueConstraint(columnNames = "login_name"))
public class Users extends BaseEntity implements java.io.Serializable {

	// Fields
	private Groups groups;
	private String name;
	private String loginName;
	private String password;
	private Short disabled;
	private Short expired;
	private Short locked;
	private Timestamp updateDate;
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

	@Column(name = "disabled", nullable = false)
	public Short getDisabled() {
		return this.disabled;
	}

	public void setDisabled(Short disabled) {
		this.disabled = disabled;
	}

	@Column(name = "expired", nullable = false)
	public Short getExpired() {
		return this.expired;
	}

	public void setExpired(Short expired) {
		this.expired = expired;
	}

	@Column(name = "locked", nullable = false)
	public Short getLocked() {
		return this.locked;
	}

	public void setLocked(Short locked) {
		this.locked = locked;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date", length = 19)
	public Timestamp getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "users_roles", catalog = "myweb", joinColumns = { @JoinColumn(name = "user_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) })
	public Set<Roles> getRoleses() {
		return this.roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}

}