package com.yanpeng.website.bean.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * TRolesMenusId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
public class TRolesMenusId implements java.io.Serializable {

	// Fields

	private String roleId;
	private String menuId;

	// Constructors

	/** default constructor */
	public TRolesMenusId() {
	}

	/** full constructor */
	public TRolesMenusId(String roleId, String menuId) {
		this.roleId = roleId;
		this.menuId = menuId;
	}

	// Property accessors

	@Column(name = "role_id", nullable = false, length = 36)
	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	@Column(name = "menu_id", nullable = false, length = 36)
	public String getMenuId() {
		return this.menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TRolesMenusId))
			return false;
		TRolesMenusId castOther = (TRolesMenusId) other;

		return ((this.getRoleId() == castOther.getRoleId()) || (this
				.getRoleId() != null
				&& castOther.getRoleId() != null && this.getRoleId().equals(
				castOther.getRoleId())))
				&& ((this.getMenuId() == castOther.getMenuId()) || (this
						.getMenuId() != null
						&& castOther.getMenuId() != null && this.getMenuId()
						.equals(castOther.getMenuId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getRoleId() == null ? 0 : this.getRoleId().hashCode());
		result = 37 * result
				+ (getMenuId() == null ? 0 : this.getMenuId().hashCode());
		return result;
	}

}