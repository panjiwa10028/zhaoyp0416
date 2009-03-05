package com.yanpeng.ssweb.entity;

import java.util.HashSet;
import java.util.LinkedHashSet;
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
 * Permissions entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "permissions", catalog = "myweb", uniqueConstraints = {
		@UniqueConstraint(columnNames = "name"),
		@UniqueConstraint(columnNames = "display_name") })
public class Permissions extends BaseEntity implements java.io.Serializable {

	// Fields
	private String name;
	private String displayName;
	private String path;
	private Set<Roles> roleses = new LinkedHashSet<Roles>(0);

	// Constructors

	/** default constructor */
	public Permissions() {
	}

	

	// Property accessors

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
	
	@Column(name = "path")
	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "permissionses")
	public Set<Roles> getRoleses() {
		return this.roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}

}