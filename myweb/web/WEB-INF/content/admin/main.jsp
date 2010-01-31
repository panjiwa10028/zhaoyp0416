<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="<c:url value="/css/genShell.css"/>" type="text/css" rel="stylesheet">		
		<link href="<c:url value="/css/menu.css"/>" type="text/css" rel="stylesheet">
		<link href="<c:url value="/css/leftMenu.css"/>" type="text/css" rel="stylesheet">
		<script src="<c:url value="/scripts/menu.js"/>" type="text/javascript"></script>
		<script src="<c:url value="/scripts/leftMenu.js"/>" type="text/javascript"></script>
		<script src="<c:url value="/scripts/default.js"/>" type="text/javascript"></script>

		<script language="JavaScript" type="text/JavaScript"> 

		var DefaultPageNo="";
		moveTo(0,0);
		resizeTo(screen.availWidth,screen.availHeight);
  		//resizeTo(screen.width,screen.height);

		
		var Default_FormTarget = "mainWorkArea";
		function initPage()
		{
			setDiv("visible");		
			MainWorkAreaIFrame = $(Default_FormTarget);			
			cw_switchMenu();
			setDiv("hidden");
		}

		//加载页面弹出层和隐藏层
		function setDiv(style) {
			if(ShieldDIV != null) {
				if (style == "hidden") {
					ShieldDIV.style.visibility = style;
				}else {
					ShieldDIV.style.visibility = style;
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
			}
			
		}
		
		//默认打开欢迎页
		function cw_switchMenu()
		{
		
			//initMenu();
			initLeftMenu();
			cw_openHomePage();
		}	
		
		//下拉菜单
		function initMenu()
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
		
		//初始化左侧菜单
		function initLeftMenu()
		{
			/*
			$.ajax({
				 type: "POST",
				 url: "main!getLeftMenu.action",
				 data:   "",				 
				 success: function(msg){
								setLeftMenu(msg);
				 			} 
				}); 
			*/
			setLeftMenu($('#leftMenuValue').val());
		}		

		//设置加载左侧菜单
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
			setDiv("hidden");
			if(window.event!=null)
				window.event.returnValue = false;			
		}
		
		function cw_openHomePage()
		{
			//空白页
			mainWorkArea.document.write("<style TYPE='text/css'>.mycontent {font: 9pt/14pt '宋体';}</style>");
			mainWorkArea.document.write("<body style='margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;'></body>");
			mainWorkArea.document.close();

			if (DefaultPageNo == "")
			{
				//CallFunc('CBANK_SHELL','b.html','FORM',null,'DefaultMenuType='+menuType);
				mainWorkArea.location="welcome.action";
			}

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
		{//alert(mainWorkArea.document.body.scrollHeight);
		//alert(window.screen.availHeight);
		//alert(document.body.scrollHeight);
			document.all.mainWorkArea.style.height=document.body.scrollHeight-127;
			//mainWorkArea.document.body.style.overflowX='auto';
			//mainWorkArea.document.body.style.overflowY='auto';
		}
		
		var sDisplay = "inline";
		function swingShortCutMenu()
		{
			if(sDisplay == "inline")
			{
				sDisplay = "none";
				document.all.tdShortCutMenu.style.display = "none";
				document.all.splitter.background = "${base}/images/splitter_r.gif";
			}
			else
			{
				sDisplay = "inline";
				document.all.tdShortCutMenu.style.display = "inline";
				document.all.splitter.background = "${base}/images/splitter_l.gif";
			}
		}

		function showDialog(sURL ,vArguments ,width, height) {
			
		    if((width == undefined) || (width == "")){
		    	width = "750";
			}

		    if((height == undefined) || (height == "")){
		    	height = "550";
			}
			
		    var iLeft = (top.window.screen.availWidth-10-width)/2;
		    var iTop = (top.window.screen.availHeight-30-height)/2;  

		    var sFeatures = "dialogWidth: "+ width +"px; dialogHeight: "+ height +"px; dialogTop: "+ iTop +"px; dialogLeft: "+ iLeft +"px; edge: Raised; center: Yes; help: Yes; resizable: No; status: No;";

			/*页面传参数方法
		    var array = new Array();
			array[0] = theURL;
			array[1] = winName;
			array[2] = jsonrpc;
			页面接参数方法
			var para = window.dialogArguments;
			openDialog.location = para[0];
			win = para[1];
			*/
			window.showModalDialog(sURL,window,sFeatures);
		}

		function setStatusBarInfo(info){
		 	if(info != undefined && info != ''){
		 		$("#statusBarInfo").html("提示信息：" + info);
				$("#processMessage").attr("style","display = 'block'");
		 	}else{
		 		$("#processMessage").attr("style","display = 'none'");
		 	}
			
		}

		function logout() {alert();
			document.href = "logout.action";
		}
		function langSelecter_onChanged() {
	        document.langForm.submit();
	    }
		</script>
	</head>
	<input id="leftMenuValue" name="leftMenuValue" type="hidden" value='<c:out value="${leftMenuValue}" escapeXml="true"/>'/>
	
	<body scroll="no" border="no" style="MARGIN: 0px 2px" bgColor="#ffffff" onLoad="initPage();" onUnload="doUnload();">
			<table id="mainTable" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="100%" background="${base}/images/headBg_02.gif" height="90">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td><IMG height="66" src="${base}/images/headBg_01.gif" width="323" border="0"></td>
											<td width="100%" background="${base}/images/headBg_02.gif"></td>
											<td><IMG height="66" src="${base}/images/headBg_03.gif" width="134" border="0"></td>
										</tr>
									</table>
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td><IMG height="24" src="${base}/images/headBg_11.gif" width="6" border="0"></td>
											<td width="100%" background="${base}/images/headBg_12.gif"></td>
											<td><IMG height="24" src="${base}/images/headBg_13.gif" width="211" border="0"></td>
										</tr>
									</table>
								</td>
								<td width="418" height="90">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="100%" background="${base}/images/headBg_04.gif" height="62">
												<table cellSpacing="0" cellPadding="0" width="100%" border="0">
													<tr>
														<td height="62" align="right" style="PADDING-RIGHT:20px;padding-top:6px" valign=top>
															<A href="${base}">首页</A>&nbsp;|&nbsp;<A href="${base}/admin/logout.action">重登录</A>&nbsp;|&nbsp;<A  href="${base}/admin/logout.action">退出</A>&nbsp;
																
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" background="${base}/images/headBg.jpg" height="28">
												<table cellSpacing="0" cellPadding="0" width="318" border="0">
													<tr>
														<td align="right" height="28"><img src="${base}/images/headBg.jpg" border="0"/></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td id="sysMenuTD" background="${base}/images/rootMenuBorder.gif" colSpan="3" height="29"></td>
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
											<td background="${base}/images/search_bg.jpg" height="57" align="center">
												
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
								<td width="14" onClick="swingShortCutMenu()" style="CURSOR: hand" background="${base}/images/splitter_bg.gif"
									height="100%" vAlign="top">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td height="125" colspan="3"></td>
										</tr>
										<tr>
											<td width="2"></td>
											<td id="splitter" height="79" background="${base}/images/splitter_l.gif" width="9"></td>
											<td width="3"></td>
										</tr>
										<tr>
											<td colspan="3"></td>
										</tr>
									</table>
								</td>
								<td vAlign="top"><iframe onactivate="hideAllSubMenu();" id="mainWorkArea" name="mainWorkArea" marginWidth="0"
										marginHeight="0" src="" frameBorder="2" width="100%"
										scrolling="no"  height="400" onload="adjustFrameSize()"> </iframe>
								</td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
			
		<div id="ShieldDIV" style="Z-INDEX: 10; FILTER: alpha(opacity=10); LEFT: 0px; VISIBILITY: hidden WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px">
	<iframe id='ShieldIftame' frameBorder="0" width="100%" height="100%" scrolling="no" marginheight="0"
		marginwidth="0" src="${base}/common/defaultDiv.jsp"></iframe>
</div>

<div id="processMessage" style="display: none">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td id="statusBarInfo">提示信息：&nbsp;</td>
								<td width="15" align="right">
									<img src="${base}/images/statusClose.gif" width="13" height="13" style="cursor:pointer;" title="Close" onClick="hideDiv('processMessage')">
								</td>
							</tr>
						</table>
					</div>	
	</body>
</HTML>
