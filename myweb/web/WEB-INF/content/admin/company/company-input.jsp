<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="${base}/scripts/validate/jquery.validate.css"
			type="text/css" rel="stylesheet" />
		<script language="javascript"
			src="${base}/scripts/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
		<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
    KE.show({
        id : 'info',
        cssPath : '${base}/scripts/kindeditor/index.css'
    });
    KE.show({
        id : 'service',
        cssPath : '${base}/scripts/kindeditor/index.css'
    });
    KE.show({
        id : 'training',
        cssPath : '${base}/scripts/kindeditor/index.css'
    });
    KE.show({
        id : 'job',
        cssPath : '${base}/scripts/kindeditor/index.css'
    });
    KE.show({
        id : 'contact',
        cssPath : '${base}/scripts/kindeditor/index.css'
    });
  </script>
		<script>
		$().ready(function(){
			$("#info").focus();
			
		});

	function initPage() {
		top.setStatusBarInfo('');
		if($("#message").text() != '') {
			top.setStatusBarInfo($("#message").text());
		}	
	}

	function subForm() {
		top.setStatusBarInfo('');
		KE.util.setData('info');
		KE.util.setData('service');
		KE.util.setData('training');
		KE.util.setData('job');
		KE.util.setData('contact');
		$("#inputForm").submit();
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
		<form id="inputForm" name="inputForm" action="company!save.action"
			method="post" >
			<s:token/>
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="page.pageRequest"
				value="${page.pageRequest}" />
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">公司管理 > <a href='#' onclick="cancel()">公司信息设定</a></span>
								</TD>
								<TD class="tdTitle2"></TD>
								<TD class="tdTitle3">									
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
									<table border="0" cellpadding="0" cellspacing="0"
										class=tbPanelContent>
										<tr>
											<td class=tdPanelHead>
												&nbsp;
											</td>
											<td class=tdPanelSel_left>
												&nbsp;
											</td>
											<td class=tdPanelSel_center>
												<pre style="margin: 0px">公司信息设定</pre>
											</td>
											<td class=tdPanelSel_right>
												&nbsp;
											</td>
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
						<TABLE class="tbCommonColor" id="Table5" cellSpacing="0"
							border="0">
							<TR>
								<TD class="tdSpaceH12Color"></TD>
							</TR>
						</TABLE>

						<TABLE class="tbBlock" id="Table1" cellSpacing="1" border="0">
							<TR>
								<TD class="tdPrompt">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司信息设定：
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						
							
							<TR>
								<TD class="tdRightW30H40">
									公司信息:
								</TD>
								<TD class="tdLeftH40">
									<textarea id="info" name="info" style="width:600px;height:250px;visibility:hidden;" class="required">${info}</textarea>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									维修与服务:
								</TD>
								<TD class="tdLeftH40">
									<textarea id="service" name="service" style="width:600px;height:250px;visibility:hidden;" class="required">${service}</textarea>
								</TD>
							</TR>	
							<TR>
								<TD class="tdRightW30H40">
									培训:
								</TD>
								<TD class="tdLeftH40">
									<textarea id="training" name="training" style="width:600px;height:250px;visibility:hidden;" class="required">${training}</textarea>
								</TD>
							</TR>	
							<TR>
								<TD class="tdRightW30H40">
									招聘:
								</TD>
								<TD class="tdLeftH40">
									<textarea id="job" name="job" style="width:600px;height:250px;visibility:hidden;" class="required">${job}</textarea>
								</TD>
							</TR>		
							<TR>
								<TD class="tdRightW30H40">
									联系我们:
								</TD>
								<TD class="tdLeftH40">
									<textarea id="contact" name="contact" style="width:600px;height:250px;visibility:hidden;" class="required">${contact}</textarea>
								</TD>
							</TR>												
						</TABLE>
						<TABLE class="tbCommonColor" id="Table3" cellSpacing="1"
							border="0">
							<TR>
								<TD class="tdCenterW30H40"></TD>
								<TD class="tdLeftH40">
									<input type="button" name="uc_am_ModiQueryPwd1:BtnOK"
										value="确 定" id="uc_am_ModiQueryPwd1_BtnOK" class="btn"
										onclick="subForm()" />									
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
					</TABLE>
			<div id="message" style="display: none;">
				<s:actionmessage theme="simple" />
			</div>
		</form>

	</body>
</html>


