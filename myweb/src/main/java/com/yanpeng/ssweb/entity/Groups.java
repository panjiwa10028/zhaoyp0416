package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Groups entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "groups", catalog = "myweb", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class Groups extends BaseEntity implements java.io.Serializable {

	// Fields
	private Groups groups;
	private String name;
	private String description;
	private String parentId;
	private Date updateDate;
	private Set<Users> userses = new LinkedHashSet<Users>(0);
	private Set<Groups> groupses = new LinkedHashSet<Groups>(0);

	// Constructors

	/** default constructor */
	public Groups() {
	}

	

	// Property accessors
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id", unique = true, nullable = false, insertable = false, updatable = false)
	public Groups getGroups() {
		return this.groups;
	}

	public void setGroups(Groups groups) {
		this.groups = groups;
	}

	@Column(name = "name", unique = true, nullable = false, length = 100)
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

	@Column(name = "parent_id", nullable = false, length = 32)
	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date", length = 19)
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
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