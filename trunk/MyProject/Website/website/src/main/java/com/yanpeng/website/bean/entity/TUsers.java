package com.yanpeng.website.bean.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
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
 * TUsers entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_users", catalog = "website", uniqueConstraints = @UniqueConstraint(columnNames = "login_name"))
public class TUsers implements java.io.Serializable {

	// Fields

	private String id;
	private TGroups TGroups;
	private String name;
	private String loginName;
	private String password;
	private Integer disabled;
	private Integer expired;
	private Integer locked;
	private Date modifyTime;
	private Set<TRoles> TRoleses = new HashSet<TRoles>(0);

	// Constructors

	/** default constructor */
	public TUsers() {
	}

	/** minimal constructor */
	public TUsers(String id, TGroups TGroups, String name, String loginName,
			String password, Integer disabled, Integer expired, Integer locked,
			Date modifyTime) {
		this.id = id;
		this.TGroups = TGroups;
		this.name = name;
		this.loginName = loginName;
		this.password = password;
		this.disabled = disabled;
		this.expired = expired;
		this.locked = locked;
		this.modifyTime = modifyTime;
	}

	/** full constructor */
	public TUsers(String id, TGroups TGroups, String name, String loginName,
			String password, Integer disabled, Integer expired, Integer locked,
			Date modifyTime, Set<TRoles> TRoleses) {
		this.id = id;
		this.TGroups = TGroups;
		this.name = name;
		this.loginName = loginName;
		this.password = password;
		this.disabled = disabled;
		this.expired = expired;
		this.locked = locked;
		this.modifyTime = modifyTime;
		this.TRoleses = TRoleses;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 36)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id", nullable = false)
	public TGroups getTGroups() {
		return this.TGroups;
	}

	public void setTGroups(TGroups TGroups) {
		this.TGroups = TGroups;
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
	public Integer getDisabled() {
		return this.disabled;
	}

	public void setDisabled(Integer disabled) {
		this.disabled = disabled;
	}

	@Column(name = "expired", nullable = false)
	public Integer getExpired() {
		return this.expired;
	}

	public void setExpired(Integer expired) {
		this.expired = expired;
	}

	@Column(name = "locked", nullable = false)
	public Integer getLocked() {
		return this.locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modify_time", nullable = false, length = 19)
	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "t_users_roles", catalog = "website", joinColumns = { @JoinColumn(name = "user_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) })
	public Set<TRoles> getTRoleses() {
		return this.TRoleses;
	}

	public void setTRoleses(Set<TRoles> TRoleses) {
		this.TRoleses = TRoleses;
	}

}