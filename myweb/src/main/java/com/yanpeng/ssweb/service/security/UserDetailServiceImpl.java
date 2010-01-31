package com.yanpeng.ssweb.service.security;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
		if (user == null) {
			throw new UsernameNotFoundException(userName + " 不存在");
		}
		GrantedAuthority[] grantedAuths = obtainGrantedAuthorities(user);

		List<GrantedAuthority> authsList = new ArrayList<GrantedAuthority>();
		List<Permissions> tempList = new ArrayList<Permissions>();
		GrantedAuthority ag = null;
		for (Roles role : user.getRoleses()) {
			for (Permissions per : role.getPermissionses()) {
				if(tempList.contains(per)) {
					continue;
				} else {
					tempList.add(per);
				}
				ag = new GrantedAuthorityImpl(per.getName());
				authsList.add(ag);
				ag = null;
			}
		}
		boolean enabled = user.getIsDisabled() == 1 ? false : true;
		boolean accountNonExpired = user.getIsExpired() == 1 ? false : true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = user.getIsLocked() == 1 ? false : true;

		org.springframework.security.userdetails.User userdetail = new org.springframework.security.userdetails.User(
				user.getLoginName(), user.getPassword(), enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, grantedAuths);
		return userdetail;
	}

	/**
	 * 获得用户所有角色的权限.
	 */
	private GrantedAuthority[] obtainGrantedAuthorities(Users user) {
		Set<GrantedAuthority> perSet = new HashSet<GrantedAuthority>();
		for (Roles role : user.getRoleses()) {
			for (Permissions per : role.getPermissionses()) {
				perSet.add(new GrantedAuthorityImpl(per.getName()));
			}
		}
		return perSet.toArray(new GrantedAuthority[perSet.size()]);
	}

}
