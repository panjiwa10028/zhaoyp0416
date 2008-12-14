package com.yanpeng.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * TGroups entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_groups", catalog = "web", uniqueConstraints = @UniqueConstraint(columnNames = {
		"name", "parent_id" }))
public class TGroups implements java.io.Serializable {

	// Fields

	private Long id;
	private String name;
	private Long parentId;
	private String description;
	private Timestamp modifyTime;
	private Set<TUsers> TUserses = new HashSet<TUsers>(0);

	// Constructors

	/** default constructor */
	public TGroups() {
	}

	/** minimal constructor */
	public TGroups(String name, Long parentId, String description,
			Timestamp modifyTime) {
		this.name = name;
		this.parentId = parentId;
		this.description = description;
		this.modifyTime = modifyTime;
	}

	/** full constructor */
	public TGroups(String name, Long parentId, String description,
			Timestamp modifyTime, Set<TUsers> TUserses) {
		this.name = name;
		this.parentId = parentId;
		this.description = description;
		this.modifyTime = modifyTime;
		this.TUserses = TUserses;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "name", nullable = false, length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "parent_id", nullable = false)
	public Long getParentId() {
		return this.parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	@Column(name = "description", nullable = false, length = 65535)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modify_time", nullable = false, length = 0)
	public Timestamp getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TGroups")
	public Set<TUsers> getTUserses() {
		return this.TUserses;
	}

	public void setTUserses(Set<TUsers> TUserses) {
		this.TUserses = TUserses;
	}

}