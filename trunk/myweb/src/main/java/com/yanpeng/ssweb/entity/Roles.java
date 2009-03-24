package com.yanpeng.ssweb.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
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

	// Fields

	private String name;
	private String description;
	private Date updateDate;
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
	@Column(name = "update_date", length = 19)
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "roles_permissions", catalog = "myweb", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "permission_id", nullable = false, updatable = false) })
	public Set<Permissions> getPermissionses() {
		return this.permissionses;
	}

	public void setPermissionses(Set<Permissions> permissionses) {
		this.permissionses = permissionses;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "roleses")
	public Set<Users> getUserses() {
		return this.userses;
	}

	public void setUserses(Set<Users> userses) {
		this.userses = userses;
	}
	
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "roles_menus", catalog = "myweb", joinColumns = { @JoinColumn(name = "role_id", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "menu_id", nullable = false, updatable = false) })
	public Set<Menus> getMenuses() {
		return this.menuses;
	}

	public void setMenuses(Set<Menus> menuses) {
		this.menuses = menuses;
	}
	
	@Transient
	@SuppressWarnings("unchecked")
	public List<String> getPermissionIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(permissionses, "id");
	}
	
	@Transient
	@SuppressWarnings("unchecked")
	public List<String> getMenuIds() throws Exception {
		return ReflectionUtils.fetchElementPropertyToList(menuses, "id");
	}

}