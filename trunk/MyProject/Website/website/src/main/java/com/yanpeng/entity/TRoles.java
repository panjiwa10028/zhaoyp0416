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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * TRoles entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_roles", catalog = "web", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class TRoles implements java.io.Serializable {

	// Fields

	private Long id;
	private String name;
	private String description;
	private Date modifyTime;
	private Set<TPermission> TPermissions = new HashSet<TPermission>(0);
	private Set<TUsers> TUserses = new HashSet<TUsers>(0);

	// Constructors

	/** default constructor */
	public TRoles() {
	}

	/** minimal constructor */
	public TRoles(Long id, String name, String description, Date modifyTime) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.modifyTime = modifyTime;
	}

	/** full constructor */
	public TRoles(Long id, String name, String description, Date modifyTime,
			Set<TPermission> TPermissions, Set<TUsers> TUserses) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.modifyTime = modifyTime;
		this.TPermissions = TPermissions;
		this.TUserses = TUserses;
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

	@Temporal(TemporalType.DATE)
	@Column(name = "modify_time", nullable = false, length = 0)
	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "t_roles_permissions", catalog = "web", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "permission_id", nullable = false, updatable = false) })
	public Set<TPermission> getTPermissions() {
		return this.TPermissions;
	}

	public void setTPermissions(Set<TPermission> TPermissions) {
		this.TPermissions = TPermissions;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TRoleses")
	public Set<TUsers> getTUserses() {
		return this.TUserses;
	}

	public void setTUserses(Set<TUsers> TUserses) {
		this.TUserses = TUserses;
	}

}