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

/**
 * TMenus entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_menus", catalog = "website")
public class TMenus implements java.io.Serializable {

	// Fields

	private String id;
	private String name;
	private String parentId;
	private String displayName;
	private String url;
	private Integer disabled;
	private Set<TRoles> TRoleses = new HashSet<TRoles>(0);

	// Constructors

	/** default constructor */
	public TMenus() {
	}

	/** minimal constructor */
	public TMenus(String id, String name, String parentId, String displayName,
			String url, Integer disabled) {
		this.id = id;
		this.name = name;
		this.parentId = parentId;
		this.displayName = displayName;
		this.url = url;
		this.disabled = disabled;
	}

	/** full constructor */
	public TMenus(String id, String name, String parentId, String displayName,
			String url, Integer disabled, Set<TRoles> TRoleses) {
		this.id = id;
		this.name = name;
		this.parentId = parentId;
		this.displayName = displayName;
		this.url = url;
		this.disabled = disabled;
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

	@Column(name = "name", nullable = false, length = 50)
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

	@Column(name = "display_name", nullable = false, length = 100)
	public String getDisplayName() {
		return this.displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "url", nullable = false, length = 500)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "disabled", nullable = false)
	public Integer getDisabled() {
		return this.disabled;
	}

	public void setDisabled(Integer disabled) {
		this.disabled = disabled;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TMenuses")
	public Set<TRoles> getTRoleses() {
		return this.TRoleses;
	}

	public void setTRoleses(Set<TRoles> TRoleses) {
		this.TRoleses = TRoleses;
	}

}