<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
System.out.println(request.getAttribute("page"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="<c:url value="/css/genShell.css"/>" type="text/css" rel="stylesheet">		
		<link href="<c:url value="/css/menu.css"/>" type="text/css" rel="stylesheet">
		<link href="<c:url value="/css/leftMenu.css"/>" type="text/css" rel="stylesheet">
		<script src="<c:url value="/js/menu.js"/>" type="text/javascript"></script>
		<script src="<c:url value="/js/leftMenu.js"/>" type="text/javascript"></script>

		<script language="JavaScript" type="text/JavaScript"> 

		//var GenShell_ClientNo="015C3BBB172525FEBE9231E3448941E1127204223268947900111786";
		//var DefaultAuthName="CBANK_PB";
		//var LoginType="D";
		//var DefaultMenuType="A";
		var DefaultPageNo="";
		//var ClientWarrantFlag="N";
		moveTo(0,0);
  		resizeTo(screen.width,screen.height);

		
		var Default_FormTarget = "mainWorkArea";
		function initPage()
		{
			if(ShieldDIV != null)
			{
				ShieldDIV.style.width = window.document.body.clientWidth;
				
				if(window.document.body.scrollHeight > window.document.body.clientHeight)
				{
					ShieldDIV.style.height = window.document.body.scrollHeight;
				}
				else
				{
					ShieldDIV.style.height = window.document.body.clientHeight;
				}
			}			
			MainWorkAreaIFrame = document.getElementById(Default_FormTarget);
			
			cw_switchMenu();
			
		}
		
		//默认打开欢迎页
		function cw_switchMenu()
		{
			var menuType = "";
			initMenu(menuType);
			initShortCutMenu(menuType);
			cw_openHomePage(menuType);
		}	
		
		//下拉菜单
		function initMenu(menuType)
		{
			hideAllSubMenu();

			var menuData = "<ul id='menu'>";
			menuData += '<li><a href="#">Home</a></li>';
			menuData += '<li><a href="#">About</a>';
			menuData += '<ul><li><a href="#">History</a></li>';
			menuData += '<li><a href="#">Team</a></li>';
			menuData += '<li><a href="#">Offices</a></li>';
			menuData += '</ul>';
			menuData += '</li>';
			menuData += '<li><a href="#">Services</a>';
			menuData += '<ul><li><a href="#">Web Design</a></li>';
			menuData += '<li><a href="#">Internet Marketing</a></li>';
			menuData += '<li><a href="#">Hosting</a></li>';
			menuData += '<li><a href="#">Domain Names</a></li>';
			menuData += '<li><a href="#">Broadband</a>';
			menuData += '<ul><li><a href="#">Web Design</a></li>';
			menuData += '<li><a href="#">United Kingdom</a></li>';
			menuData += '</ul></li></ul>';
			menuData += '</li>';
			menuData += '</ul>';
			if(menuData)
			{
				//sysMenuTD.innerHTML = menuData;
			}
			buildMenu("menu");
			if(window.event!=null)
				window.event.returnValue = false;
			return false;
		}	
		
		//初始化快捷菜单
		function initShortCutMenu(menuType)
		{
			$.ajax({
				 type: "POST",
				 url: "main!leftMenu.action",
				 data:   "role_id=1",				 
				 success: function(msg){
								setLeftMenu(msg);
							 //header1.showAll();
							//document.getElementById("vmenu").innerHTML;
							 //alert("${entity}");
							 
							//document.getElementById("vmenu").innerHTML=msg;
				 			} 
				}); 

			return false;
		}		

		function setLeftMenu(returnValue) {
			var leftMenus = returnValue.split(",");

			var menu = AccMenuManager.getMenu("vmenu");
			var needOpenUsual = false;
			if( null == menu )
			{
				menu = AccMenuManager.createNewMenu("vmenu","headerOpen","headerClose","menuItem");

				for(var i=0; i<leftMenus.length; i++) {
					var element = leftMenus[i].split("||");

					var header = menu.addHeader(element[0],"");
					if(element[1])
					{
						header.setContent(element[1]);
						if(!needOpenUsual) {
							header.showAll();
						}						
						needOpenUsual = true;
					}else{
						header.hide();
					}
				}				
			}

			if(window.event!=null)
				window.event.returnValue = false;			
		}
		
		function cw_openHomePage(menuType)
		{
			//空白页
			mainWorkArea.document.write("<style TYPE='text/css'>.mycontent {font: 9pt/14pt '宋体';}</style>");
			mainWorkArea.document.write("<body style='margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;'></body>");
			mainWorkArea.document.close();

			if (DefaultPageNo == "")
			{
				//CallFunc('CBANK_SHELL','b.html','FORM',null,'DefaultMenuType='+menuType);
				mainWorkArea.location="firstPage.action";
			}
			/*
			//银证通快速通道
			else if (DefaultPageNo == "105101" && (LoginType == "A" || LoginType == "B" || LoginType == "D") && (DefaultMenuType == "A" || DefaultMenuType == "B"))
			{			
				CallFunc('CBANK_INVEST','Invest/StockHome.aspx','FORM',null);
			}
			//银基通快速通道
			else if (DefaultPageNo == "105202" && (LoginType == "A" || LoginType == "B" || LoginType == "D") && (DefaultMenuType == "A" || DefaultMenuType == "B"))
			{
				CallFunc('CBANK_INVEST','Fund/FundHome.aspx','FORM',null);
			}
			else
			{
				CallFunc('CBANK_SHELL','Login/HomePage.aspx','FORM',null,'DefaultMenuType='+menuType);
			}
		*/
		    window.event.returnValue = false;
			return false;
		}
		
		function doUnload()
		{
			if((window.screenLeft >= 10000 && window.screenTop >= 10000) || event.altKey) 
			{
			//	var bRet = logoutGenServer();
			}
			else
			{
			//	GenLogoutTransServerOnly();
			}
		}

		function adjustFrameSize()
		{
			document.all.mainWorkArea.style.height=mainWorkArea.document.body.scrollHeight<400?400:mainWorkArea.document.body.scrollHeight;
			mainWorkArea.document.body.style.overflowX='auto';
			mainWorkArea.document.body.style.overflowY='auto';
		}
		
		var sDisplay = "inline";
		function swingShortCutMenu()
		{
			if(sDisplay == "inline")
			{
				sDisplay = "none";
				document.all.tdShortCutMenu.style.display = "none";
				document.all.splitter.background = "${ctx}/images/splitter_r.gif";
			}
			else
			{
				sDisplay = "inline";
				document.all.tdShortCutMenu.style.display = "inline";
				document.all.splitter.background = "${ctx}/images/splitter_l.gif";
			}
		}
		</script>
	</head>
	<body style="MARGIN: 0px 2px" bgColor="#ffffff" onLoad="initPage();" onUnload="doUnload();">
		<form name="TheForm" method="post" action="GenIndex.aspx" id="TheForm" onSubmit="window.event.returnValue = false;">

			<table id="mainTable" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="100%" background="${ctx}/images/headBg_02.gif" height="90">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td><IMG height="66" src="${ctx}/images/headBg_01.gif" width="323" border="0"></td>
											<td width="100%" background="${ctx}/images/headBg_02.gif"></td>
											<td><IMG height="66" src="${ctx}/images/headBg_03.gif" width="134" border="0"></td>
										</tr>
									</table>
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td><IMG height="24" src="${ctx}/images/headBg_11.gif" width="6" border="0"></td>
											<td width="100%" background="${ctx}/images/headBg_12.gif"></td>
											<td><IMG height="24" src="${ctx}/images/headBg_13.gif" width="211" border="0"></td>
										</tr>
									</table>
								</td>
								<td width="418" height="90">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="100%" background="${ctx}/images/headBg_04.gif" height="62">
												<table cellSpacing="0" cellPadding="0" width="100%" border="0">
													<tr>
														<td height="62" align="right" style="PADDING-RIGHT:20px;padding-top:6px" valign=top>
															<A onclick="CallFunc('CBANK_SHELL','Login/HomePage.aspx','FORM',null);" href="#null">
																首页</A>&nbsp;|&nbsp;<A onclick="CallFunc('CBANK_SHELL','Service/WebSiteMap.aspx','FORM',null);" href="#null">功能地图</A>&nbsp;|&nbsp;<A onclick="CallFunc('CBANK_SHELL','Login/HP_QueryLog.aspx','FORM',null);" href="#null">日志查询</A>
															|&nbsp;<A onclick="doRelogin();" href="#null">重登录</A>&nbsp;|&nbsp;<A onclick="doExit();" href="#null">退出</A>&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" background="${ctx}/images/headBg.jpg" height="28">
												<table cellSpacing="0" cellPadding="0" width="318" border="0">
													<tr>
														<td align="right" height="28"><img src="${ctx}/images/headBg.jpg" border="0"/></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td id="sysMenuTD" background="${ctx}/images/rootMenuBorder.gif" colSpan="3" height="29"></td>
							</tr>
							<tr>
								<td bgColor="#d9d9d9" colSpan="3" height="2"></td>
							</tr>
							<tr>
								<td bgColor="#ffffff" colSpan="3" height="4"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="100%">
						<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td class="leftBg" id="tdShortCutMenu" vAlign="top" width="159" height="100%">
									<table cellSpacing="0" cellPadding="0" width="159" border="0">
										<tr>
											<td width="159" background="${ctx}/images/onlineCS_bg.gif" height="102"><IMG style="CURSOR: hand" onClick="var nWinLeft = (screen.width-600)/2;var nWinTop = (screen.height-450)/2;window.open(GenOnlineCustomerServiceURL,'WindowOpen','menubar=no,toolbar=no,location=no,directories=no,status=yes,resizable=no,scrollbars=no,width=600,height=450,top='+nWinTop+',left='+nWinLeft);"
													src="${ctx}/images/95555.gif"></td>
										</tr>
										<tr>
											<td bgColor="white" height="4"></td>
										</tr>
										<tr>
											<td background="${ctx}/images/search_bg.jpg" height="57" align="center">
												<input id="txtSearch" maxlength="10" value="功能搜索" onKeyPress="if(window.event.keyCode==13){onSearch();}" onClick="if(this.style.color=='gray'){this.style.color='black';this.value='';}"
													onblur="if(this.value==''){this.value='功能搜索';this.style.color='gray';}" style="BORDER-RIGHT:gray 1px solid;BORDER-TOP:gray 1px solid;PADDING-LEFT:5px;MARGIN-BOTTOM:5px;BORDER-LEFT:gray 1px solid;COLOR:gray;PADDING-TOP:4px;BORDER-BOTTOM:gray 1px solid;HEIGHT:22px"
													size="10">&nbsp; <input type="image" src="${ctx}/images/search_btn.jpg" onClick="onSearch();return false;">
											</td>
										</tr>
										<tr>
											<td bgColor="#0783df" style="HEIGHT: 27px">
												<ul id="vmenu">
												</ul>
											</td>
										</tr>
										<tr>
											<td bgColor="#0783df" height="4"><FONT face="宋体"></FONT></td>
										</tr>
									</table>
								</td>
								<td width="14" onClick="swingShortCutMenu()" style="CURSOR: hand" background="${ctx}/images/splitter_bg.gif"
									height="100%" vAlign="top">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td height="125" colspan="3"></td>
										</tr>
										<tr>
											<td width="2"></td>
											<td id="splitter" height="79" background="${ctx}/images/splitter_l.gif" width="9"></td>
											<td width="3"></td>
										</tr>
										<tr>
											<td colspan="3"></td>
										</tr>
									</table>
								</td>
								<td vAlign="top"><iframe onactivate="hideAllSubMenu();" id="mainWorkArea" name="mainWorkArea" marginWidth="0"
										marginHeight="0" src="" frameBorder="0" width="100%"
										scrolling="yes" onload="adjustFrameSize();" height="400"> </iframe>
								</td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
			
		<div id="ShieldDIV" style="Z-INDEX: 10; FILTER: alpha(opacity=10); LEFT: 0px; VISIBILITY: visible; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px">
	<iframe id='ShieldIftame' frameBorder="0" width="100%" height="100%" scrolling="no" marginheight="0"
		marginwidth="0" src="..\Base\DefaultDiv.htm"></iframe>
</div>
</form>
	</body>
</HTML>
