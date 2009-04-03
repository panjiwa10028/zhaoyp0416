package com.yanpeng.ssweb.service.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.entity.Roles;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.service.user.UserManager;



/**
 * 实现SpringSecurity的UserDetailsService接口,获取用户Detail信息.
 * 
 * @author Allen
 */
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	private UserManager userManager;

	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException, DataAccessException {
		Users user = userManager.getUserByLoginName(userName);
		if (user == null){
			throw new UsernameNotFoundException(userName + " 不存在");
		}
		List<GrantedAuthority> authsList = new ArrayList<GrantedAuthority>();
		GrantedAuthority ag=null;
		for (Roles role : user.getRoleses()) {
			for(Permissions per:role.getPermissionses()){
				ag=new GrantedAuthorityImpl(per.getName());
				authsList.add(ag);
				ag=null;
			}
		}
		org.springframework.security.userdetails.User userdetail=new org.springframework.security.userdetails.User(user.getLoginName()
				,user.getPassword(),user.getIsDisabled()==1?false:true, user.getIsExpired()==1?false:true,
				true,user.getIsLocked()==1?false:true,
				authsList.toArray(new GrantedAuthority[authsList.size()]));
		return userdetail;
	}

}
