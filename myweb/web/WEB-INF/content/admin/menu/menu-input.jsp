<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="${base}/js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<link href="${base}/scripts/validate/jquery.validate.css"
			type="text/css" rel="stylesheet" />
		<script language="javascript"
			src="${base}/scripts/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/date-picker/WdatePicker.js"
			type="text/javascript"></script>

		<script>
		$(document).ready(function(){
			// 字符验证     
			jQuery.validator.addMethod("letters_numbers_underscores", function(value, element) {  
			    //alert(!/[^\w+$]/g.test(value)); 
			  return this.optional(element) || !/[^\w+$]/g.test(value);     
			}, "只能输入包括英文字母、数字和下划线");
						
			$("#parentId").focus();
			$("#inputForm").validate({
				 rules: { 
					displayName: { 
		    			required: true, 
		    			remote: encodeURI("menu!checkDisplayName.action?orgName=${displayName}")
					},
					name: { 
	        			required: true, 
	        			letters_numbers_underscores: true,
	        			remote: encodeURI("menu!checkName.action?orgName=${name}")
	    			}
	           		
				},
				messages: {
					displayName: {
						remote: "菜单名称已存在！"
					},
					name: {
						remote: "菜单唯一标识已存在"
					}
				}
			});
		});

	function initPage() {
		top.setStatusBarInfo('');
		if($("#message").text() != '') {
			top.setStatusBarInfo($("#message").text());
		}	
	}

	function subForm() {
		top.setStatusBarInfo('');
		$("#inputForm").submit();
	}

	function cancel() {
		top.mainWorkArea.location='menu.action';
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
	<s:actionmessage theme="simple" />
		<form id="inputForm" name="inputForm" action="menu!save.action"
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
									<span id="Location">系统管理 > <a href='#' onclick="cancel()">菜单设定</a> > 菜单<s:if test="id == null">新增</s:if><s:else>修改</s:else></span>
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
												<pre style="margin: 0px">菜单设定</pre>
											</td>
											<td class=tdPanelSel_right>
												&nbsp;
											</td>
										</tr>
									</table>
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
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;菜单<s:if test="id == null">新增</s:if><s:else>修改</s:else>：
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						
							<TR>
								<TD class="tdRightW30H40">
									上级菜单:
								</TD>
								<TD class="tdLeftH40">
									<s:select id="parentId" name="parentId" list="allMenus" listKey="id" listValue="displayName"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									菜单名称:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="displayName" name="displayName" size="40" value="${displayName}"/>
								</TD>
							</TR>	
							<TR>
								<TD class="tdRightW30H40">
									菜单唯一标识:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="name" name="name" size="40" value="${name}"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									菜单路径:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="path" name="path" size="40" value="${path}" />
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									无效:
								</TD>
								<TD class="tdLeftH40">
									<input type="checkbox" id="isDisabled" name="isDisabled" value="1" <c:if test="${isDisabled == 1}">checked</c:if>/>
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
									<input type="button" name="cancelButton"
										value="取消" id="cancelButton" class="btn"
										onclick="cancel()" />
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>


			</TABLE>
				
			
		</form>

	</body>
</html>


