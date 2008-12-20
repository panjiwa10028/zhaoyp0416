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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * TRoles entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_roles", catalog = "website", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class TRoles implements java.io.Serializable {

	// Fields

	private String id;
	private String name;
	private String description;
	private Date modifyTime;
	private Set<TPermissions> TPermissionses = new HashSet<TPermissions>(0);
	private Set<TUsers> TUserses = new HashSet<TUsers>(0);

	// Constructors

	/** default constructor */
	public TRoles() {
	}

	/** minimal constructor */
	public TRoles(String id, String name, String description,
			Date modifyTime) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.modifyTime = modifyTime;
	}

	/** full constructor */
	public TRoles(String id, String name, String description,
			Date modifyTime, Set<TPermissions> TPermissionses,
			Set<TUsers> TUserses) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.modifyTime = modifyTime;
		this.TPermissionses = TPermissionses;
		this.TUserses = TUserses;
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

	@Column(name = "name", unique = true, nullable = false, length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", nullable = false, length = 65535)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
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
	@JoinTable(name = "t_roles_permissions", catalog = "website", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "permission_id", nullable = false, updatable = false) })
	public Set<TPermissions> getTPermissionses() {
		return this.TPermissionses;
	}

	public void setTPermissionses(Set<TPermissions> TPermissionses) {
		this.TPermissionses = TPermissionses;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TRoleses")
	public Set<TUsers> getTUserses() {
		return this.TUserses;
	}

	public void setTUserses(Set<TUsers> TUserses) {
		this.TUserses = TUserses;
	}

}