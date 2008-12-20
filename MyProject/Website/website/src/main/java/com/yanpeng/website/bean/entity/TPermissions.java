package com.yanpeng.website.bean.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * TPermissions entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_permissions", catalog = "website", uniqueConstraints = {
		@UniqueConstraint(columnNames = "display_name"),
		@UniqueConstraint(columnNames = "name") })
public class TPermissions implements java.io.Serializable {

	// Fields

	private String id;
	private String name;
	private String displayName;
	private Set<TRoles> TRoleses = new HashSet<TRoles>(0);

	// Constructors

	/** default constructor */
	public TPermissions() {
	}

	/** minimal constructor */
	public TPermissions(String id, String name, String displayName) {
		this.id = id;
		this.name = name;
		this.displayName = displayName;
	}

	/** full constructor */
	public TPermissions(String id, String name, String displayName,
			Set<TRoles> TRoleses) {
		this.id = id;
		this.name = name;
		this.displayName = displayName;
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

	@Column(name = "name", unique = true, nullable = false, length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "display_name", unique = true, nullable = false, length = 100)
	public String getDisplayName() {
		return this.displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TPermissionses")
	public Set<TRoles> getTRoleses() {
		return this.TRoleses;
	}

	public void setTRoleses(Set<TRoles> TRoleses) {
		this.TRoleses = TRoleses;
	}

}