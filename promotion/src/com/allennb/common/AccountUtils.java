package com.allennb.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AccountUtils {

	private static List<String> accountList;
	private static String[] accountNames = new String[]{};//网站名称
	private static Map<String, String> accountLoginUrlMap = new HashMap<String, String>();//网站登录地址
	private static Map<String, List<String>> accountLoginParamMap = new HashMap<String, List<String>>();//网站登录参数
	private static Map<String, String> accountPublishUrlMap = new HashMap<String, String>();//网站发布地址
	private static Map<String, List<String>> accountPublishParamMap = new HashMap<String, List<String>>();//网站发布参数
	
	/**
	 * 加载帐号文件
	 */
	public static void loadAccountInfo() {
		accountList = FileUtils.getFileContent("帐号.txt");
		
		if(accountList != null && !accountList.isEmpty()) {
			accountNames = new String[accountList.size()];
			for(int i=0;i<accountList.size();i++) {
				String item = accountList.get(i);
//				口碑网|https://login.koubei.com/member/login.html?city=2595|0|user-name:gzywyjs|user-password:3764570#http://www.koubei.com/fuwu/poststep2.html?categoryId=712&city=2595|o.5736:|yk-iu-editor:|0|post-input-5733:2011-10-01|cal.end:2012-10-01
				String[] accountInfo = item.split("#");
				String[] loginInfo = accountInfo[0].split("\\|");
				accountNames[i] = loginInfo[0]; //网站名称
				String loginUrl = loginInfo[1];
				accountLoginUrlMap.put(accountNames[i], loginUrl);
				List<String> loginParamList = new ArrayList<String>();
				for(int j=3;j<loginInfo.length;j++) {
					loginParamList.add(loginInfo[j]);
				}
				accountLoginParamMap.put(accountNames[i], loginParamList);
				
				String[] publishInfo = accountInfo[1].split("\\|");
				accountPublishUrlMap.put(accountNames[i], publishInfo[0]);
				List<String> publishParamList  =new ArrayList<String>();
				for(int j=1;j<publishInfo.length;j++) {
					publishParamList.add(publishInfo[j]);
				}
				accountPublishParamMap.put(accountNames[i], publishParamList);
			}
		}
	}

	public static List<String> getAccountList() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountList;
	}

	public static String[] getAccountNames() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountNames;
	}

	public static Map<String, String> getAccountLoginUrlMap() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountLoginUrlMap;
	}
	
	public static String getAccountLoginUrlMap(String key) {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountLoginUrlMap.get(key);
	}

	public static Map<String, List<String>> getAccountLoginParamMap() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountLoginParamMap;
	}
	
	public static List<String> getAccountLoginParamMap(String key) {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountLoginParamMap.get(key);
	}

	public static Map<String, String> getAccountPublishUrlMap() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountPublishUrlMap;
	}
	
	public static String getAccountPublishUrlMap(String key) {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountPublishUrlMap.get(key);
	}

	public static Map<String, List<String>> getAccountPublishParamMap() {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountPublishParamMap;
	}

	public static List<String> getAccountPublishParamMap(String key) {
		if(accountList == null) {
			loadAccountInfo();
		}
		return accountPublishParamMap.get(key);
	}
	
	
	
}
