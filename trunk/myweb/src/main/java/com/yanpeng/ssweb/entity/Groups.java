package com.yanpeng.ssweb.entity;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * Groups entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "groups", catalog = "myweb", uniqueConstraints = @UniqueConstraint(columnNames = {
		"name", "parent_id" }))
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Groups extends BaseEntity implements java.io.Serializable {

	// Fields

	private Groups groups;
	private String name;
	private String parentId;
	private String description;
	private Set<Users> userses = new LinkedHashSet<Users>(0);
	private Set<Groups> groupses = new LinkedHashSet<Groups>(0);

	// Constructors

	/** default constructor */
	public Groups() {
	}

	


	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id", unique = true, nullable = false, insertable = false, updatable = false)
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

	@Column(name = "parent_id", nullable = false, length = 36)
	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Column(name = "description", nullable = false, length = 65535)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "groups")
	public Set<Users> getUserses() {
		return this.userses;
	}

	public void setUserses(Set<Users> userses) {
		this.userses = userses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "groups")
	public Set<Groups> getGroupses() {
		return this.groupses;
	}

	public void setGroupses(Set<Groups> groupses) {
		this.groupses = groupses;
	}

}