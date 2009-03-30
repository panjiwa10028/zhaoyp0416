package com.yanpeng.ssweb.web.admin;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.Collection;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.struts2.ServletActionContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.yanpeng.ssweb.entity.Menus;
import com.yanpeng.ssweb.entity.Users;
import com.yanpeng.ssweb.entity.global.VerifyImageInfo;
import com.yanpeng.ssweb.service.menu.MenuManager;
import com.yanpeng.ssweb.service.user.UserManager;
import com.yanpeng.ssweb.util.CommUtil;
import com.yanpeng.ssweb.util.VerifyImage;
import com.yanpeng.ssweb.web.BaseAction;

/**
 * 登入默认Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
public class VerifyImageAction extends ActionSupport {

	@Autowired
	private VerifyImage verifyImage;


	@Override
	public String execute() throws Exception {
		String bgcolor = "00ff00";
		int textcolor = 1;
		String[] bgcolorArray = bgcolor.split(",");

		Color bg = Color.WHITE;

		if (bgcolorArray.length == 1 && !bgcolor.equals("")) {
			bg = CommUtil.toColor(bgcolor);
		} else if (bgcolorArray.length == 3) {
			bg = new Color(CommUtil.null2Int(bgcolorArray[0], 255), CommUtil.null2Int(bgcolorArray[1], 255), CommUtil.null2Int(
					bgcolorArray[2], 255));
		}
		VerifyImageInfo verifyimg = verifyImage.generateImage(CommUtil.getRandomString(5), 120, 60, bg, textcolor);

		// 输出验证码到页面
		BufferedImage image = verifyimg.getImage();
		OutputStream out = ServletActionContext.getResponse().getOutputStream();
		try {
			ImageIO.write(image, "JPEG", out);
			out.flush();
			out.close();
		} catch (Exception e) {
		}
		return null;
	}

	

	
}
