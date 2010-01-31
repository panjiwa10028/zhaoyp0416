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
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.yanpeng.core.utils.ReflectionUtils;

/**
 * Roles entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "roles", catalog = "myweb", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Roles extends BaseEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7468830189078557034L;
	// Fields

	private String name;
	private String description;
	private Set<Permissions> permissionses = new LinkedHashSet<Permissions>(0);
	private Set<Users> userses = new LinkedHashSet<Users>(0);
	private Set<Menus> menuses = new LinkedHashSet<Menus>(0);

	// Constructors

	/** default constructor */
	public Roles() {
	}

	// Property accessors

	@Column(name = "name", unique = true, nullable = false, length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", nullable = false, length = 65535)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.LAZY)
	@JoinTable(name = "roles_permissions", catalog = "myweb", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "permission_id", nullable = false, updatable = false) })
	public Set<Permissions> getPermissionses() {
		return permissionses;
	}

	public void setPermissionses(Set<Permissions> permissionses) {
		this.permissionses = permissionses;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "roleses", fetch = FetchType.LAZY)
	public Set<Users> getUserses() {
		return userses;
	}

	public void setUserses(Set<Users> userses) {
		this.userses = userses;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.LAZY)
	@JoinTable(name = "roles_menus", catalog = "myweb", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "menu_id", nullable = false, updatable = false) })
	public Set<Menus> getMenuses() {
		return menuses;
	}

	public void setMenuses(Set<Menus> menuses) {
		this.menuses = menuses;
	}

	@Transient
	@SuppressWarnings("unchecked")
	public List<Long> getPermissionIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(permissionses, "id");
	}

	@Transient
	@SuppressWarnings("unchecked")
	public List<Long> getMenuIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(menuses, "id");
	}

}