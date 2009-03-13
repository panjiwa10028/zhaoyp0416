<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
<style type="text/css">
#newPreview
{
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);
}
</style>
		<link href="${base}/js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/lang/zh_CN.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/kindeditor-core.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/plugin-all.js"></script>
<script language="javascript" src="${base}/scripts/previewImage.js"  type="text/javascript" ></script>

<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script type="text/javascript">
	KE.show({
		id:'news.content',
		cssPath:'${base}/scripts/kindeditor/src/index.css'
	});
</script>
		<script>
	$(document).ready(function(){
		$("#name").focus();
		
	});

	function initPage() {
		top.setStatusBarInfo('');
		if($("#message").text() != '') {
			top.setStatusBarInfo($("#message").text());
		}
		if('${news.picture}' != '') {
			$("#newPreview").html("<img width='80' height='60' src='${base}/upload/${news.picture}'/>"); 
		}
	}

	function subForm() {
		//inputForm.target = "mainWorkArea";
		//inputForm.target = "dialog_Info_hiddenSubmitIFrame";
		KE.util.setData('news.content');
		inputForm.submit();
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>
<form id="inputForm" action="news!save.action" method="post" enctype="multipart/form-data">
	<input type="hidden" name="news.id" value="${news.id}" />
	<input type="hidden" name="page.pageParam" value="${page.pageParam}" />
	<body scroll="auto" style="overflow: auto" onload="initPage()">
	
		<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
						<TR>
							<TD class="tdTitle1" colSpan="1" rowSpan="1">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
								<span id="Location">系统管理 > 菜单设定 > 菜单修改</span>
							</TD>
							<TD class="tdTitle2"></TD>
							<TD class="tdTitle3">
								版面号：101005
								<IMG alt="" src="${base}/images/title_06.gif">
							</TD>
						</TR>
					</TABLE>
					
				</TD>
			</TR>
			<TR>
				<TD class="tdSpaceH12"></TD>
			</TR>
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbPanel" id="Table4" cellSpacing="0" cellPadding="0"
						border="0">
						<TR>
							<TD class="tdPanelContent" colSpan="1" rowSpan="1">
								<!-- 修改密码标签 -->
								<table border="0" cellpadding="0" cellspacing="0" class=tbPanelContent>
									<tr>
										<td class=tdPanelHead>&nbsp;</td>
										<td class=tdPanelSel_left>&nbsp;</td>
										<td class=tdPanelSel_center><pre style="margin:0px">菜单设定</pre></td>
										<td class=tdPanelSel_right>&nbsp;</td>
									</tr>
								</table>
								<!-- END 修改密码标签 -->
							</TD>
							<TD class="tdPanelTrail"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbCommonColor" id="Table5" cellSpacing="0" border="0">
						<TR>
							<TD class="tdSpaceH12Color"></TD>
						</TR>
					</TABLE>

					<TABLE class="tbBlock" id="Table1" cellSpacing="1" border="0">
						<TR>
							<TD class="tdPrompt">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;菜单修改：
							</TD>
						</TR>
					</TABLE>
					<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						<TR>
							<TD class="tdRightW30H40">
								标题:
							</TD>
							<TD class="tdLeftH40">
								<input type="text" id="name" name="news.title" size="40" value="${news.title}" class="required"/>
							</TD>
						</TR>	
						<TR>
							<TD class="tdRightW30H40">
								图片:
							</TD>
							<TD class="tdLeftH40">								
								<span><input type="file" name="upload" class="required" onChange="javascript:FileChange(this.value,'newPreview');"/>
								
								<span id="newPreview"></span></span>
							</TD>
						</TR>	
						<tr>
				<td class="tdRightW30H40">作者:</td>
				<td class="tdLeftH40"><input type="text" name="news.auth" size="40" value="${news.auth}" class="required"/></td>
			</tr>
			<tr>
				<td class="tdRightW30H40">发布日期:</td>
				<td class="tdLeftH40"><input type="text" name="news.date" size="40" value="${news.date}" onFocus="new WdatePicker(this,'%Y-%M-%D',false)"/></td>
			</tr>
			<tr>
				<td class="tdRightW30H40">内容:</td>
				<td class="tdLeftH40"><textarea id="content" name="news.content" style="width:600px;height:250px;visibility:hidden;" class="required">${news.content}</textarea>
				</td>
			</tr>				
					</TABLE>
					<TABLE class="tbCommonColor" id="Table3" cellSpacing="1" border="0">
						<TR>
							<TD class="tdCenterW30H40"></TD>
							<TD class="tdLeftH40">
								<input type="button" name="uc_am_ModiQueryPwd1:BtnOK"
									value="确 定" id="uc_am_ModiQueryPwd1_BtnOK" class="btn" onclick="subForm()"/>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD class="tdSpaceH12"></TD>
			</TR>
	
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbExplain" id="Table6" cellSpacing="1" border="0"
						height="20">
						<TR>
							<TD class="tdExplain">
								<IFRAME class="ifExplain" id="ExplainPageFrame"
									name="ExplainPageFrame" src="${base}/common/help/menu-help.jsp" frameBorder="0"
									scrolling="no"></IFRAME>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			
		</TABLE>
			<div id="message" style="display:none;"><s:actionmessage theme="simple"/></div>
		</form>
		

<hr />

<p>不论您使用的是 IE6 还是 IE7，均可以看到以下预览。</p>


<hr />

<p>请选择一个图片进行预览：<input type="file" size="20" onchange="javascript:PreviewImg(this);" /></p>
	</body>
</html>


