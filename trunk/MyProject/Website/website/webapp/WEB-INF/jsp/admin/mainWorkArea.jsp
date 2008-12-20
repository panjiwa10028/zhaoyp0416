<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="<c:url value="/css/styleHome.css"/>" type="text/css" rel="stylesheet">


		<script language="JavaScript" type="text/JavaScript">
		var DefaultMenuType="A";
		var Param="DefaultMenuType=A";	
			dialogFeatures = "dialogHeight: 450px; dialogWidth: 750px; edge: Raised; center: Yes; help: No; resizable: No; status: No;";
			function InitPage()
			{
				body.style.cursor = "";
				FunSwitchSrc(DefaultMenuType);
			}
			
			function SetRegClient(type)
			{
				if (type == "Y")
				{
					if (window.confirm('您确定[允许]登记新的可信电脑吗？'))
						parent.CallFunc('CBANK_SHELL','Login/HomePage.aspx','FORM',null,'RegAuth=1',Param);
				}
				else if (type == "N")
				{
					var hint = '';
					if ((document.all.ClientNum.value == "0001")||(document.all.ClientNum.value == "1"))
						hint = '您仅有当前这1台可信电脑，如果您选择禁止登记，当这台可信电脑出故障时，您将无法通过大众版登记新的可信电脑！\r您还确定[禁止]登记新的可信电脑吗？'; 
					else hint='您确定[禁止]登记新的可信电脑吗？';

					if (window.confirm(hint)) 
						parent.CallFunc('CBANK_SHELL','Login/HomePage.aspx','FORM',null,'RegAuth=0',Param);
				}
				return;
			}
						
		function AdjustFrameSize(id)
		{
			var frameIdDOM = window.frames[id];
			var frameIdOBJECT = document.getElementById(id);
			frameIdOBJECT.style.height = frameIdDOM.document.body.scrollHeight;	
			if(parent.adjustFrameSize != null) parent.adjustFrameSize();
		}			

		function FunSwitchSrc(menuType)
		{/*
			if (menuType == "A")
			{
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_A.htm";	
			}
			else if (menuType == "B")
			{
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_B.htm";		
			}
			else if (menuType == "C_A")
			{
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_C_A.htm";
			}
			else if (menuType == "C_B")
			{
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_C_B.htm";
			}			
			else if (menuType == "C_C")
			{
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_C_C.htm";
			}
			else if (menuType == "D")
			{	
				document.all.peixun01.src = "../doc/Htmls/RecentUpdate_D.htm";
			}
			*/
		    window.event.returnValue = false;
			return false;
		}

		function FunUpdateWindowOpen(menuType)
		{
			var nWinLeft = 0;
			var nWinTop = 0;
			var myDialogFeatures = 'menubar=no,toolbar=no,location=no,directories=no,status=yes,resizable=no,scrollbars=yes,width=780,height=500,top='+nWinTop+',left='+nWinLeft;		
			if (menuType == "A")
			{
				window.open('../doc/Htmls/Update_A.htm','Update_A',myDialogFeatures);
			}
			else if (menuType == "B")
			{
				window.open('../doc/Htmls/Update_B.htm','Update_B',myDialogFeatures);
			}
			else if (menuType == "C_A")
			{
				window.open('../doc/Htmls/Update_C_A.htm','Update_C_A',myDialogFeatures);
			}
			else if (menuType == "C_B")
			{
				window.open('../doc/Htmls/Update_C_B.htm','Update_C_B',myDialogFeatures);
			}			
			else if (menuType == "C_C")
			{
				window.open('../doc/Htmls/Update_C_C.htm','Update_C_C',myDialogFeatures);
			}
			else if (menuType == "D")
			{	
				window.open('../doc/Htmls/Update_D.htm','Update_D',myDialogFeatures);
			}
			
		    window.event.returnValue = false;
			return false;
		}
					
		function FunSecuWindowOpen()
		{
			var nWinLeft = 0;
			var nWinTop = 0;				
			window.open('https://www.cmbchina.com/personal+business/netbank/common/safe.htm','notice20060301','menubar=no,toolbar=no,location=no,directories=no,status=no,resizable=no,scrollbars=yes,width=780,height=500,top='+nWinTop+',left='+nWinLeft);
		}	
		
		function RefreshPage()
		{
			triggerFunc("../Login/HomePage.aspx","FORM","_self",Param);
		}
		
	    function EAccountWhatNetBankUserWinOpen()
		{
			var nWinLeft = 0;
			var nWinTop = 0;			
			window.open('https://pbnj.ebank.cmbchina.com/ea/help/adv.htm','EAccountWhatNetBankUser','menubar=no,toolbar=no,location=no,directories=no,status=yes,resizable=yes,scrollbars=yes,width=780,height=500,top='+nWinTop+',left='+nWinLeft);
			//window.open('/ea/help/adv.htm','EAccountWhatNetBankUser','menubar=no,toolbar=no,location=no,directories=no,status=yes,resizable=yes,scrollbars=yes,width=780,height=500,top='+nWinTop+',left='+nWinLeft);
		}		
		
		function openwindow1(){
			var nWinLeft = (screen.width-179)/2;
			var nWinTop = (screen.height-304)/2;		
			window.open('http://info.cmbchina.com/cmb2005stock/investaspxbin/pbinfo/stockmarket.aspx','PBWindow','menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=0,resizable=0,width=179,height=304,top='+nWinTop+',left='+nWinLeft);
		}		
		function openwindow2(){
			var nWinLeft = (screen.width-179)/2;
			var nWinTop = (screen.height-503)/2;		
			window.open('http://info.cmbchina.com/cmb2005stock/investaspxbin/pbinfo/fundrank.aspx','PBWindow','menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=0,resizable=0,width=179,height=503,top='+nWinTop+',left='+nWinLeft);
		}
		
		function WangDunOpen()
		{
			var nWinLeft = (screen.width-660)/2;
			var nWinTop = (screen.height-550)/2;				
			window.open('http://app.cmbchina.com/webprotect/download.htm','WangDunOpen','menubar=no,toolbar=no,location=no,directories=no,status=no,resizable=no,scrollbars=yes,width=660,height=490,top='+nWinTop+',left='+nWinLeft);
		}
		
		function openwindowWHJH()
		{
			parent.CallFunc('CBANK_PB','DebitCard/im_InvestFS.aspx','FORM',null,'panel=InvestFS');
		}
		
		function openwindowFund()
		{
			parent.CallFunc('CBANK_INVEST','Fund/QueryDDApply.aspx','FORM',null);
		}
		function openwindowTrans()
		{
			parent.CallFunc('CBANK_PB','DebitCard/tf_BankStockTransfer.aspx','FORM',null);
		}		
		function openwindowJJFilter()
		{
			parent.CallFunc('CBANK_INVEST','Fund/JJ_Tools_Filter.aspx','FORM','JJ_Tools_Filter');
		}	
		function MobileWapOpen()
		{
			var nWinLeft = (screen.width-835)/2;
			var nWinTop = (screen.height-625)/2;				
			window.open('http://mobile.cmbchina.com/mobilewap','MobileWapOpen','menubar=no,toolbar=no,location=no,directories=no,status=no,resizable=no,scrollbars=yes,width=835,height=625,top='+nWinTop+',left='+nWinLeft);
		}
		function openwindowYQZZ()
		{
			parent.CallFunc('CBANK_PB','DebitCard/tf_FuturesTransfer.aspx','FORM',null);
		}
		function openwindowSelfPayFee()
		{
			parent.CallFunc('CBANK_CREDITCARD','CreditCard/pf_QueryPayFeeProject.aspx','FORM',null,'MainPanel=inline','SIDType=A','Panel=PayFeeTransfer');
		}
		function openwindowFinancial()
		{
			parent.CallFunc('CBANK_SHELL','Financial/Index.aspx','FORM',null);
		}
		function GoToSearch()
		{
			parent.CallFunc('CBANK_SHELL','Service/nv_FuncSearch.aspx','FORM',null);
		}
		
		
		</script>
	</HEAD>
	<body id="body" onLoad="InitPage()" MS_POSITIONING="GridLayout">
		<form name="HomePage" method="post" action="HomePage.aspx" id="HomePage" onSubmit="CheckValid()">
<input type="hidden" name="__VIEWSTATE" value="dDw1ODM0MDY3NzA7dDw7bDxpPDE+Oz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs+O2w8XDxmb250IGNvbG9yPU1hcm9vblw+6LW15bu26bmPIOaCqOWlve+8jOasoui/juWFieS4tO+8gVw8L2ZvbnRcPuOAgOaCqOeahOS4iuasoeeZu+W9leaXtumXtOaYr++8mjIwMDgtMTItMTYgMjA6Mzg6MDI7Pj47Pjs7Pjs+Pjs+Pjs+EXP7/4fkpz/LQbQ7JMCNeGIhRag=" />

			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="604">
						<table cellSpacing="1" cellPadding="0" width="98%" align="center" bgColor="#a5d8ff" border="0">
							<tr>
								<td background="${ctx}/images/welcome_03.jpg" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;
									<span id="LblTop" class="Text"><font color=Maroon>赵延鹏 您好，欢迎光临！</font>　您的上次登录时间是：2008-12-16 20:38:02</span></td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="98%" align="center" bgColor="#a5d8ff" border="0">
							<tr>
								<td bgColor="white" height="8"></td>
							</tr>
							<tr>
								<td class="font1" bgColor="white"><A href="javascript:MobileWapOpen()"><IMG height="72" src="${ctx}/images/WD_adv_download.jpg" width="592" border="0"></A></td>
							</tr>
							<tr>
								<td id="TD1" bgcolor="white" height="8"></td>

							</tr>
						</table>
						<!--
					<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
						<tr>
							<td height="8"></td>
						<tr>
							<td background="${ctx}/images/006.gif" height="130"><IMG height="130" src="${ctx}/images/006.gif" width="593"></td>
						</tr>
						<tr>
							<td height="8"></td>
						</tr>
					</table>
					
					<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
						<tr>
							<td height="5"></td>
						</tr>
					</table>-->
						<table cellSpacing="1" cellPadding="0" width="98%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="${ctx}/images/welcome_33.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>最近更新</strong></span></td>
											<td width="8%"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="font" bgColor="#ffffff"><iframe id="peixun01" src="RecentUpdate.htm" frameBorder="0" width="100%" scrolling="no"
										height="309"></iframe>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td height="8"></td>
							</tr>
						</table>
						<!--  隐藏“最近消息”
						<table cellSpacing="1" cellPadding="0" width="98%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="${ctx}/images/welcome_34.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>最近消息</strong></span></td>
											<td width="8%"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="font" bgColor="#ffffff"><iframe id="peixun02" src="../doc/htmls/RecentMessage.htm" frameBorder="0" width="100%"
										scrolling="no" height="80"></iframe>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td height="8"></td>
							</tr>
						</table>
						-->
						<table cellSpacing="1" cellPadding="0" width="98%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="${ctx}/images/welcome_32.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>安全提示</strong></span></td>
											<td width="8%"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="font" bgColor="#ffffff"><iframe id="peixun03" src="SecurityTip.htm" frameBorder="0" width="100%" scrolling="no"
										height="100"></iframe>
								</td>
							</tr>
						</table>
					</td>
					<td vAlign="top" width="220">
						<table style="BORDER-RIGHT: #a2d7ff 1px solid; BORDER-TOP: #a2d7ff 1px solid; BORDER-LEFT: #a2d7ff 1px solid; BORDER-BOTTOM: #a2d7ff 1px solid"
							cellSpacing="0" cellPadding="0" width="100%" bgColor="#a2d7ff">
							<TBODY>
								<tr>
									<td background="${ctx}/images/welcome_35.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="unnamed1"><strong>新品推荐</strong></span></td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:GoToSearch()"><font color="#fe5901">功能搜索</font></A></span>&nbsp;<IMG src="${ctx}/images/newtip1.gif"></td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:MobileWapOpen()">手机银行WAP版</A></span>&nbsp;</td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:openwindowFinancial()">财务分析</A></span>&nbsp;</td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								<!--
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:openwindowSelfPayFee()"><font color="#fe5901">信用卡自助缴费</font></A></span>&nbsp;<IMG src="${ctx}/images/newtip1.gif"></td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								-->
								<!--
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:openwindowYQZZ()"><font color="#fe5901">银期转账</font></A></span>&nbsp;<IMG src="${ctx}/images/newtip1.gif"></td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
								-->
								<tr>
									<td background="${ctx}/images/welcome_36.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="font"><A class="font" href="javascript:openwindowJJFilter()">基金工具</A></span></td>
									</td>
								</tr>
								<tr>
									<td background="${ctx}/images/welcome_37.gif" bgColor="#fafcfe" height="8"></td>
								</tr>
						</table>
			<table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
				<tr>
					<td height="8"></td>
				</tr>
			</table>
			<table style="BORDER-RIGHT: #a2d7ff 1px solid; BORDER-TOP: #a2d7ff 1px solid; BORDER-LEFT: #a2d7ff 1px solid; BORDER-BOTTOM: #a2d7ff 1px solid"
				cellSpacing="0" cellPadding="0" width="100%" bgColor="#a2d7ff">
				<tr>
					<td background="${ctx}/images/welcome_39.gif" bgColor="#fafcfe" height="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="unnamed1"><strong>工具箱</strong></span></td>
				</tr>
				<!--<tr>
							<td background="${ctx}/images/welcome_08.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="font"><A class="font" href="javascript:parent.CallFunc('CBANK_SHELL','Login/HP_QueryLog.aspx','MODAL_DIALOG',null);">
													大众版日志</A></span></td>
						</tr>-->
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://forum.cmbchina.com/cmu/viewforum.aspx?forumid=50" target="_blank">
								社区留言</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="javascript:openwindow1()">证券指数</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="javascript:openwindow2()">基金收益率</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/cmb2005web/cmbaspxbin/rate/realtimefxrate.aspx"
								target="_blank">实时汇率</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/cmb2005web/cmbaspxbin/rate/interestrate.aspx"
								target="_blank">存款利率</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/cmb2005web/cmbaspxbin/rate/cdrate.aspx"
								target="_blank">贷款利率</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/personal+business/customer+service/datapublish/calculator.htm"
								target="_blank">理财计算器</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/personal+business/customer+service/datapublish/zhbz.htm"
								target="_blank">资费标准</A></span></td>
				</tr>
				<tr>
					<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="font"><A class="font" href="http://www.cmbchina.com/personal+business/customer+service/datapublish/jydm.htm"
								target="_blank">交易代码对照表</A></span></td>
				</tr>
				<!--<tr>
							<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="font"><A class="font" href="http://www.cmbchina.com/corporate+business/custody/tgcpjz" target=_blank>
													托管信托产品净值</A></span></td>
						</tr>
						<tr>
							<td background="${ctx}/images/welcome_11.jpg" bgColor="#fafcfe" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="font"><A class="font" href="http://www.cmbchina.com/corporate+business/custody/fund_4.htm" target=_blank>
													托管基金信息</A></span></td>
						</tr>--></table>
			</TD>
			<td></td>
			</TR>
			<tr>
				<td bgColor="#fafcfe" colSpan="3"><input name="ClientNo" id="ClientNo" type="hidden" value="BABD419B0FD0EF3DAE51C3F4C4081818771153675037443600088762" />
					<input name="hDefaultMenuType" id="hDefaultMenuType" type="hidden" value="A" />
					<input name="ClientNum" id="ClientNum" type="hidden" />
					
<script language="JavaScript" type="text/JavaScript">
		var DIV_MSG_Show = false;
		var DIV_MSG_AdjustDIVSize = null;
		var DIV_MSG_SelectedObj = null;
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//层的显示、隐藏以及大小调整
////////////////////////////////////////////////////////////////////////////////////////////////////////////
		function AdjustFrameWidth(id)
		{
			var frameIdOBJECT = window.document.getElementById(id);
			/*
			if(frameIdOBJECT.offsetWidth < 500)
			{
				frameIdOBJECT.style.width = 500;
			}
			else if(frameIdOBJECT.offsetWidth > window.document.body.clientWidth)
			{
				frameIdOBJECT.style.width = window.document.body.clientWidth;
			}
			*/
			frameIdOBJECT.style.width = 539;
		}

		function AdjustFrameHeight(id)
		{
			var frameIdDOM = window.frames[id];
			var frameIdOBJECT = window.document.getElementById(id);
			frameIdOBJECT.style.height = frameIdDOM.document.body.scrollHeight;
			
			var imgLefter = window.document.getElementById("imgLefter");
			var imgRighter = window.document.getElementById("imgRighter");
			imgLefter.height = frameIdOBJECT.offsetHeight;
			imgRighter.height = frameIdOBJECT.offsetHeight;
		}
		
		function AdjustDIVSize(msgID,shieldID)
		{
			var MsgDIV = window.document.getElementById(msgID);
			var ShieldDIV = window.document.getElementById(shieldID);
			if(MsgDIV != null)
			{
				MsgDIV.style.width = 565;//MsgDIV.scrollWidth;
				MsgDIV.style.height = MsgDIV.scrollHeight;
				
				MsgDIV.style.left = (window.document.body.clientWidth - MsgDIV.offsetWidth)/2;
				MsgDIV.style.top = (window.document.body.clientHeight - MsgDIV.offsetHeight)/2;
			}
			
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
		}
		
		function AdjustMsgDIVSize()
		{
			AdjustDIVSize('MsgDIV','');
		}
		
		function MsgShow()
		{
			if(DIV_MSG_Show)
			{
				var ShieldDIV = window.document.getElementById("ShieldDIV");
			
				if(ShieldDIV.style.visibility == "hidden")
				{
					AdjustDIVSize('','ShieldDIV');
					ShieldDIV.style.visibility = "visible";
					AdjustFrameWidth('MsgIframe');
					var param1 = "MsgXml='" + DIV_MSG_MsgXml + "'";
					triggerFuncEq('../Base/MessagePage3.aspx','FORM','MsgIframe',param1);
				}
				else
				{
	 				var MsgTable = window.document.getElementById("MsgTable");
					MsgTable.style.display = "inline";
				
					AdjustFrameHeight("MsgIframe");
					AdjustDIVSize('MsgDIV','');
					var MsgDIV = window.document.getElementById("MsgDIV");
					MsgDIV.style.visibility = "visible";
	 				MsgDIV.onmousedown = grabObj;
					
					ShieldDIV.onresize = AdjustMsgDIVSize;
					
					DIV_MSG_AdjustDIVSize = window.setInterval("AdjustDIVSize('','ShieldDIV')",100);
					DIV_MSG_Show = false;
				}
			}
		}
		
		function MsgHide()
		{
			var MsgDIV = window.document.getElementById("MsgDIV");
			var MsgIframe = window.document.getElementById("MsgIframe");
			var ShieldDIV = window.document.getElementById("ShieldDIV");
			
			if(MsgDIV.style.visibility == "visible")
			{
				MsgDIV.style.visibility = "hidden";
				MsgDIV.style.width = 0;
				MsgDIV.style.height = 0;
				MsgDIV.onmousedown = null;
				MsgIframe.style.width = "100%";
				MsgIframe.style.height = "100%";
				
	 			var MsgTable = window.document.getElementById("MsgTable");
				MsgTable.style.display = "none";				
			}			
			if(ShieldDIV.style.visibility == "visible")
			{
				ShieldDIV.style.visibility = "hidden";
				ShieldDIV.style.width = 0;
				ShieldDIV.style.height = 0;
				ShieldDIV.onresize = null;
			}
			
			if(DIV_MSG_AdjustDIVSize != null)
			{
				window.clearInterval(DIV_MSG_AdjustDIVSize);
			}
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////		
//层的移动
////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		function grabObj()
		{
			var imgObjID = window.event.srcElement.id;
			if(imgObjID == "imgHeader")
			{
				DIV_MSG_SelectedObj = window.document.getElementById("MsgDIV");
			}

			offsetX = window.event.offsetX;
			offsetY = window.event.offsetY;

			var MsgDIV = window.document.getElementById("MsgDIV");
			MsgDIV.onmousemove = dragObj;
			MsgDIV.onmouseup = releaseObj;	
			// prevent further processing of mouseDown event so 
  			// that the Macintosh doesn't display the contextual 
			// menu and lets dragging work normally.
			return false;
		}
			
		function dragObj()
		{
			if (DIV_MSG_SelectedObj)
			{
				x = window.event.clientX - offsetX;
				y = window.event.clientY - offsetY;

				if(x<0) x = 0;
				if((x+DIV_MSG_SelectedObj.offsetWidth)>window.document.body.clientWidth) x=window.document.body.clientWidth-DIV_MSG_SelectedObj.offsetWidth;

				DIV_MSG_SelectedObj.style.pixelLeft = x;

				if(y<0) y=0;
				if((y+DIV_MSG_SelectedObj.offsetHeight)>window.document.body.clientHeight) y=window.document.body.clientHeight-DIV_MSG_SelectedObj.offsetHeight;

				DIV_MSG_SelectedObj.style.pixelTop = y;

				//prevent further system response to dragging
				window.event.returnValue = false;
				return false
			}
		}

		function releaseObj()
		{
			if (DIV_MSG_SelectedObj)
			{
				DIV_MSG_SelectedObj = null;
				var MsgDIV = window.document.getElementById("MsgDIV");
				MsgDIV.onmousemove = null;
				MsgDIV.onmouseup = null;				
			}
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////		
//其他事件处理
////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		function ChangeSrc(flag)
		{
			var imgClose = window.document.getElementById("imgClose");
			if(flag == 2)
			{
				imgClose.src = '..\\doc\\Images\\MessageNew9.gif';
			}
			else
			{
				imgClose.src = '..\\doc\\Images\\MessageNew12.gif';
			}
		}
		
</script>
<div id="MsgDIV" style="Z-INDEX: 15; LEFT: 0px; VISIBILITY: hidden; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px">
	<table border="0" align="center" cellpadding="0" cellspacing="0" id="MsgTable" style="display:none">
		<tr>
			<td colspan="3">
				<img src="..\doc\Images\MessageNew7.jpg" id="imgHeader"><div style="LEFT: 535px; POSITION: absolute; TOP: 10px"><img src="..\doc\Images\MessageNew9.gif" id="imgClose" onMouseOver="ChangeSrc(1);" onMouseOut="ChangeSrc(2);"
						style="CURSOR: hand" onClick="MsgHide();"></div>
			</td>
		</tr>
		<tr>
			<td><img src="..\doc\Images\MessageNew10.gif" id="imgLefter" height="10" width="13"></td>
			<td>
				<iframe id='MsgIframe' name='MsgIframe' frameBorder="0" width="537" height="10" scrolling="no"
					marginheight="0" marginwidth="0" src="..\Base\Blank.htm" onload="MsgShow()"></iframe>
			</td>
			<td><img src="..\doc\Images\MessageNew11.gif" id="imgRighter" height="10" width="13"></td>
		</tr>
		<tr>
			<td colspan="3">
				<img src="..\doc\Images\MessageNew8.jpg">
			</td>
		</tr>
	</table>
</div>
<div id="ShieldDIV" style="Z-INDEX: 10; FILTER: alpha(opacity=10); LEFT: 0px; VISIBILITY: hidden; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px">
	<iframe id='ShieldIftame' frameBorder="0" width="100%" height="100%" scrolling="no" marginheight="0"
		marginwidth="0" src="..\Base\DefaultDiv.htm"></iframe>
</div>
</td>
			</tr>
			</TBODY></TABLE></form>
	</body>
</HTML>
