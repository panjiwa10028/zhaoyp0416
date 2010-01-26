package com.yanpeng.ssweb.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Company entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "company", catalog = "myweb")
public class Company extends BaseEntity implements java.io.Serializable {

	// Fields    

	private String info;
	private String service;
	private String training;
	private String contact;
	private String job;

	// Constructors

	/** default constructor */
	public Company() {
	}




	// Property accessors


	@Column(name = "info", length = 65535)
	public String getInfo() {
		return this.info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	@Column(name = "service", length = 65535)
	public String getService() {
		return this.service;
	}

	public void setService(String service) {
		this.service = service;
	}

	@Column(name = "training", length = 65535)
	public String getTraining() {
		return this.training;
	}

	public void setTraining(String training) {
		this.training = training;
	}

	@Column(name = "contact", length = 65535)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "job", length = 65535)
	public String getJob() {
		return job;
	}
	
	public void setJob(String job) {
		this.job = job;
	}


}