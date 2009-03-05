package com.yanpeng.ssweb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Version;

import org.hibernate.annotations.GenericGenerator;

import com.yanpeng.core.utils.DateUtils;



/**
 * 统一定义id的entity基类.
 * 
 * @author caoyang
 */
@SuppressWarnings("unused")
@MappedSuperclass
public class BaseEntity implements Serializable{

	private static final long serialVersionUID = 3980743350790156736L;
	
	@Id
	@GeneratedValue(generator="paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")  
	private String id;
	
	@Version
	private Long version;
	
	@Column(insertable=true,updatable=false)
	private Date insertDate=DateUtils.getCurrentDateTime();
	
	@Column(insertable=false,updatable=true)
	private Date updateDate=DateUtils.getCurrentDateTime();
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}



	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
}
