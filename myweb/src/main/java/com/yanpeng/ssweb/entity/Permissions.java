package com.yanpeng.ssweb.entity;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * Permissions entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "permissions", catalog = "myweb", uniqueConstraints = { @UniqueConstraint(columnNames = "name"),
		@UniqueConstraint(columnNames = "display_name") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Permissions extends BaseEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6596873908207663947L;
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
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "display_name", unique = true, nullable = false, length = 100)
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "path")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "permissionses", fetch = FetchType.LAZY)
	public Set<Roles> getRoleses() {
		return roleses;
	}

	public void setRoleses(Set<Roles> roleses) {
		this.roleses = roleses;
	}

}