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
	
	
	private String id;
	
		
	
	
	@Id
	@GeneratedValue(generator="paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")  
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
}
