package com.yanpeng.ssweb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

import com.yanpeng.core.utils.DateUtils;

/**
 * entity基类.
 * 
 * @author Allen
 */
@SuppressWarnings("unused")
@MappedSuperclass
public class BaseEntity implements Serializable {

	private static final long serialVersionUID = 3980743350790156736L;

	private Long id;

	@Column(name = "update_time", length = 19, insertable = true, updatable = true)
	private Date updateTime = DateUtils.getCurrentDateTime();

	private Long userId;

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "identity")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_time", length = 19, insertable = true, updatable = true)
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "user_id")
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

}
