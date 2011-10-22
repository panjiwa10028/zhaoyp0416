package com.allennb;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.allennb.form.MaterialForm;

public class Application {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			
			MaterialForm window = new MaterialForm();
			window.open();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
