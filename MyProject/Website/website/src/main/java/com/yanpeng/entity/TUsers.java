package com.yanpeng.entity;

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
 * TUsers entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_users", catalog = "web", uniqueConstraints = @UniqueConstraint(columnNames = "login_name"))
public class TUsers implements java.io.Serializable {

	// Fields

	private Long id;
	private TGroups TGroups;
	private String name;
	private String loginName;
	private String password;
	private Short enabled;
	private Short expired;
	private Short locked;
	private Date modifyTime;
	private Set<TRoles> TRoleses = new HashSet<TRoles>(0);

	// Constructors

	/** default constructor */
	public TUsers() {
	}

	/** minimal constructor */
	public TUsers(Long id, TGroups TGroups, String name, String loginName,
			String password, Short enabled, Short expired, Short locked,
			Date modifyTime) {
		this.id = id;
		this.TGroups = TGroups;
		this.name = name;
		this.loginName = loginName;
		this.password = password;
		this.enabled = enabled;
		this.expired = expired;
		this.locked = locked;
		this.modifyTime = modifyTime;
	}

	/** full constructor */
	public TUsers(Long id, TGroups TGroups, String name, String loginName,
			String password, Short enabled, Short expired, Short locked,
			Date modifyTime, Set<TRoles> TRoleses) {
		this.id = id;
		this.TGroups = TGroups;
		this.name = name;
		this.loginName = loginName;
		this.password = password;
		this.enabled = enabled;
		this.expired = expired;
		this.locked = locked;
		this.modifyTime = modifyTime;
		this.TRoleses = TRoleses;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
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

	@Column(name = "enabled", nullable = false)
	public Short getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Short enabled) {
		this.enabled = enabled;
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

	@Temporal(TemporalType.DATE)
	@Column(name = "modify_time", nullable = false, length = 0)
	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "t_users_roles", catalog = "web", joinColumns = { @JoinColumn(name = "user_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) })
	public Set<TRoles> getTRoleses() {
		return this.TRoleses;
	}

	public void setTRoleses(Set<TRoles> TRoleses) {
		this.TRoleses = TRoleses;
	}

}