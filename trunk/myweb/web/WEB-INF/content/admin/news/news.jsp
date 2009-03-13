<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<HEAD>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<script src="<c:url value="/scripts/default.js"/>" type="text/javascript"></script>
		<script language="JavaScript" type="text/JavaScript">
		
		function InitPage()
		{
			top.setStatusBarInfo('');
			if($("#message").text() != '') {
				top.setStatusBarInfo($("#message").text());
			}
			
			body.style.cursor = "";
		}		
		
		function CheckValid()
		{
			body.style.cursor = "wait";			
		}

		function add() {
			
			var url = "news!input.action";
			top.mainWorkArea.location = url;
			//top.showDialog(url, null, 750, 500);
		}

		function getSelectedIds()
		{
			var checkList = document.getElementsByName("id");
				
			if(checkList==null)
			{
				return "";
			}
				
			var strSelectedIds = "";
			
			for(var i=0; i<checkList.length; i++)
			{
				
				if(checkList[i].checked==true)
				{
					if(i > 0 && strSelectedIds != "") {
						strSelectedIds += ",";
					}
					strSelectedIds += checkList[i].value;
				}
			}

			return strSelectedIds;
		}

		function query() {
			queryForm.target = "mainWorkArea";
			queryForm.submit();
		}
		</script>
	</HEAD>
	
	<body scroll="auto" style="overflow: auto" id="body" onload="InitPage()" MS_POSITIONING="GridLayout">	
<div id="message" style="display:none;"><s:actionmessage theme="simple"/></div>
<form id="queryForm" action="menu.action" method="post">
		<input name="pageSize" type="hidden"
			value="<c:out value='${NPAGESIZE}'/><c:if test="${NPAGESIZE==null || NPAGESIZE <= 0}">20</c:if>" />
		<input name="pageIndex" type="hidden"
			value="<c:out value='${NPAGEINDEX}'/>" />
		<input name="recordIndex" type="hidden"
			value="<c:out value='${NPAGESIZE*(NPAGEINDEX-1)}'/>" />
		<input name="pageCount" type="hidden"
			value="<c:out value='${NPAGECOUNT}'/>" />
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">新闻管理 > 新闻设定</span>&nbsp;&nbsp;&nbsp;
									<img src="${base}/images/ask.gif" id="BtnAsk"
										style="CURSOR: hand" alt="账户管理提供账户余额查询、交易查询、修改密码、挂失等账户基本功能。"
										height="23" width="24" align="absMiddle" />
								</TD>
								<TD class="tdTitle2">
									<FONT face="宋体"></FONT>
								</TD>
								<TD class="tdTitle3">
								
								<IMG alt="" src="${base}/images/title_06.gif">
							</TD>
							</TR>
						</TABLE>

					</TD>
				</TR>
				<TR>
					<TD class="tdSpaceH12">
						<FONT face="宋体"></FONT><FONT face="宋体"></FONT>
					</TD>
				</TR>
				<TR>
					<TD id="tdPanel" class="tdCommonTop">
						<TABLE class="tbPanel" id="Table4" cellSpacing="0" cellPadding="0"
							border="0">
							<TR>
								<TD class="tdPanelContent">
									<!-- 账户管理首页标签 -->
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
												<pre style="margin: 0px"><a href="#" class=lkPanelSel onclick="top.mainWorkArea.location='news.action'">新闻设定</a></pre>
											</td>
											<td class=tdPanelSel_right>
												&nbsp;
											</td>
										</tr>
									</table>
									<!-- END 账户管理首页标签 -->
								</TD>
								<TD class="tdPanelTrail">
									<table border="0" cellpadding="0" cellspacing="0"
										class=tbPanelContent>
										<tr>
											<td class=tdOperButton onclick="add()"><img src="${base}/images/${locale}/new.jpg" /></td>
											<td class=tdPanelSpace10>&nbsp;</td>
											<td class=tdOperButton onclick="update()"><img src="${base}/images/${locale}/update.jpg"/></td>
											<td class=tdPanelSpace10>&nbsp;</td>
											<td class=tdOperButton onclick="del()"><img src="${base}/images/${locale}/del.jpg"/></td>		
										
											<td class=tdPanelSpaceW20>
												&nbsp;
											</td>

										</tr>
									</table>
								</TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD id="tdQueryResult1" class="tdCommonTop">
						<TABLE class="tbCommonColor" id="Table5" cellSpacing="0"
							border="0">
							<TR>
								<TD id="tdSpace" class=""></TD>

							</TR>
						</TABLE>
						<TABLE class="tbCommonColor" id="Table6" cellSpacing="1"
							border="0">
							<TR>
								<TD class="tdLeftH30">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;菜单级别：
									<select name="parentId" id="parentId"
										style="width: 100px;">
										<option selected="selected" value="-">
											[ 全部 ]
										</option>
										<c:forEach var="element" items="${conditionMap.typeMenu}">
											<option value="${element.id}" <c:if test="${conditionMap.parentId == element.id}">selected</c:if>>
												${element.displayName}
											</option>
										</c:forEach>
									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名称：
									<input type="text" id="name" name="displayName" value="${conditionMap.displayName}"/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是否可用：
									<select name="disabled" id="disabled"
										style="width: 100px;">
										<option value="">
											[ 全部 ]
										</option>
										<option value="0" <c:if test="${conditionMap.disabled == 0}">selected</c:if>>
											可用
										</option>
										<option value="1" <c:if test="${conditionMap.disabled == 1}">selected</c:if>>
											不可用
										</option>

									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="button" name="BtnOK" value="查 询" id="BtnOK"
										class="btn" onclick="query()"/>
								</TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				<TR>
					<TD id="tdQueryResult2" class="tdCommonTop">
						<TABLE class="tbBlock" id="Table8" cellSpacing="1" border="0">
							<TR>
								<TD class="tdPrompt">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</TD>
							</TR>
						</TABLE>
						<table class="dgMain" cellspacing="0" cellpadding="3"
							align="Center" rules="all" bordercolor="#9FD6FF" border="1"
							id="dgSubAccRecSet"
							style="border-color: #9FD6FF; border-width: 1px; border-style: solid; border-collapse: collapse;">
							<tr class="dgHeader" align="Center">
								<td class="dgHeader">
									<input type="checkbox" class="checkbox" name="lId" />
								</td>
								<td class="dgHeader">
									<a href="${base}/demo/news.action?page.orderBy=name&page.order=
			<s:if test="page.orderBy=='title'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>标题</b></a>
								</td>
								<td class="dgHeader">
									<a href="news.action?page.orderBy=auth&page.order=
			<s:if test="page.orderBy=='auth'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>作者</b></a>
								</td>
								<td class="dgHeader">
									<a href="${base}/demo/news.action?page.orderBy=mobile&page.order=
			<s:if test="page.orderBy=='date'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>发布日期</b></a>
								</td>
								<td class="dgHeader">
									<b>照片</b>
								</td>
								<td class="dgHeader">
									<b>操作</b>
								</td>
							</tr>
							<s:iterator value="page.result">
								<tr class="dgAlternatingItem">
									<td align="center">
										<input type="checkbox" class="checkbox" name="id"
											value="<c:out value='${id}'/>" />
									</td>
									<td align="Left">
										${title}
									</td>
									<td align="Left">
										${auth}
									</td>
									<td align="Left">
										${date}
									</td>
									<td align="Left">
										<img src="${base}/upload/${picture}" alt="${base}/upload/${picture}" width="64" height="56"/>
									</td>
									<td align="Left">
									<a href="news!input.action?news.id=${id}&page.pageParam=${page.pageParam}">修改</a>
										<a href="news!delete.action?news.id=${id}&page.pageParam=${page.pageParam}">删除</a>
									</td>
								</tr>
							</s:iterator>
						</table>
						<div id="footer" style="margin-top:10px;width: 600px;">
		第${page.pageNo}页, 共${page.totalPages}页 
		<s:set var="actionName" value="news.action"></s:set>
		<a href="${actionName}?page.pageNo=1&page.orderBy=${page.orderBy}&page.order=${page.order}">首页</a>
		<s:if test="page.pageNo-3>0">
			...&nbsp;
		</s:if>
		<s:if test="page.pageNo-2>0">
			<a href="${actionName}?page.pageNo=${page.pageNo-2}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo-2}</a>&nbsp;
		</s:if>
		<s:if test="page.pageNo-1>0">
			<a href="${actionName}?page.pageNo=${page.pageNo-1}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo-1}</a>&nbsp;
		</s:if>
		<s:if test="page.pageNo>0">
			${page.pageNo}&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+1">
			<a href="${actionName}?page.pageNo=${page.pageNo+1}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+1}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+2">
			<a href="${actionName}?page.pageNo=${page.pageNo+2}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+2}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+3">
			<a href="${actionName}?page.pageNo=${page.pageNo+3}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+3}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+4">
			<a href="${actionName}?page.pageNo=${page.pageNo+4}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+4}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+5">
			...&nbsp;
		</s:if>
		<a href="${actionName}?page.pageNo=${page.totalPages}&page.orderBy=${page.orderBy}&page.order=${page.order}">末页</a>
		
	</div>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbExplain" id="Table10" height="20" cellSpacing="1"
							border="0">
							<TR>
								<TD class="tdExplain">
									<IFRAME class="ifExplain" id="ExplainPageFrame"
										name="ExplainPageFrame" src="101002.htm" frameBorder="0"
										scrolling="no"></IFRAME>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
				
	</body>
	</form>
</HTML>
