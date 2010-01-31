<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<script src="<c:url value="/scripts/default.js"/>"
			type="text/javascript"></script>
		<script language="JavaScript" type="text/JavaScript">
		
		function InitPage()
		{
			top.setStatusBarInfo('');
			if($("#message").text() != '') {
				top.setStatusBarInfo($("#message").text());
			}
			
		}		
	

		function add() {
			
			var url = "product!input.action";
			top.mainWorkArea.location = url;
			//top.showDialog(url, null, 750, 500);
		}

		function update() {		
			var ids = getSelectedCheckBoxIds('selectIds');
			if(ids == "") {
				alert("请选择一条记录");
				return;
			}
			if(ids.indexOf(",") != -1) {
				alert("只能选择一条记录");
				return;
			}
			var url = "product!input.action?id="+ids+"&page.pageRequest=${page.pageRequest}";
			top.mainWorkArea.location = url;
		}
		
		function del() {		
			var ids = getSelectedCheckBoxIds('selectIds');
			if(ids == "") {
				alert("请选择一条或多条记录");
				return;
			}
			var url = "product!delete.action?selectedIds="+ids+"&page.pageRequest=${page.pageRequest}";
			if(confirm("确定删除")) {
				top.mainWorkArea.location = url;
			}
		}
		function generator() {		
			var ids = getSelectedCheckBoxIds('selectIds');
			if(ids == "") {
				alert("请选择一条或多条记录");
				return;
			}
			$.ajax({
				 type: "POST",
				 url: "product!generator.action?selectedIds=" + ids,
				 data:   "",				 
				 success: function(msg){
				unCheckBox('selectIds');
				 top.setStatusBarInfo(msg);
				 	} 
				}); 
		}

		function query() {
			$('#pageNo').val("1");
			submitForm();
		}

		function submitForm() {
			queryForm.submit();
		}
		</script>
	</HEAD>
	
	<body scroll="auto" style="overflow: auto" id="body" onload="InitPage()" MS_POSITIONING="GridLayout">	
<div id="message" style="display:none;"><s:actionmessage theme="simple"/></div>
<form id="queryForm" name="queryForm" action="product.action" method="post">
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">产品管理 > 产品设定</span>&nbsp;&nbsp;&nbsp;
									<img src="${base}/images/ask.gif" id="BtnAsk"
										style="CURSOR: hand" alt="..."
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
												<pre style="margin: 0px">产品设定</pre>
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
										<td class=tdPanelSpace10>&nbsp;</td>		
											<td class=tdOperButton onclick="generator()"><img src="${base}/images/${locale}/generator.jpg"/></td>	
											
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
				<!-- 搜索 -->
				<tr>
                <td class="tdCommonBtm">
                    <table class="tbBlock" cellspacing="1" cellpadding="0" border="0">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="tbCommonColor" id="Table3" cellspacing="1" border="0">
                                        <tbody>
                                            <tr>
                                                
                                                <td class="tdCenterH40">
                                                    产品类别：<select name="filter_EQ_categoryId" id="filter_EQ_categoryId" style="height:19px;width:110px;">
	<option value="">[ 全部 ]</option>
	<c:forEach var="element" items="${allProductCategory}">
	<option <c:if test="${param['filter_EQ_categoryId'] == element.id}">selected="selected"</c:if> value="${element.id}">${element.name}</option>
	</c:forEach>
</select>
                                                </td>
                                                <td class="tdCenterH40">
                                                   产品名称：<input type="text" name="filter_LIKE_name" value="${param['filter_LIKE_name']}" size="20"/>
                                                </td>
                                                <td class="tdLeftH40">
                                                    <input class="btn" id="BtnSubmit" onclick="query()" type="button" value="查 询"
                                                        name="BtnClose">
                                                </td> 
                                                <td bordercolor="white" width="1" ></td>
                                                <td >
                                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </td>                                              
                                             </tr>
                                            <tr>
                                                
                                            </tr>
                                        </tbody>
                                </td>
                            </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    </TD></TR>	
    		<!-- 搜索 -->	
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
									<input type="checkbox" class="checkbox" name="ids" onclick="selectAllCheckBox(this,'selectIds')"/>
								</td>
								<td class="dgHeader">
									<a href="product.action?page.orderBy=name&page.order=
			<s:if test="page.orderBy=='name'">${page.inverseOrder}</s:if><s:else>desc</s:else>"><b>产品名称</b></a>
								</td>
								<td class="dgHeader">
									<a href="product.action?page.orderBy=htmlName&page.order=
			<s:if test="page.orderBy=='htmlName'">${page.inverseOrder}</s:if><s:else>desc</s:else>"><b>发布页面名</b></a>
								</td>
								<td class="dgHeader">
									<a href="product.action?page.orderBy=updateTime&page.order=
			<s:if test="page.orderBy=='updateTime'">${page.inverseOrder}</s:if><s:else>desc</s:else>"><b>发布日期</b></a>
								</td>
								<td class="dgHeader">
									<b>图片</b>
								</td>
							</tr>
							<s:iterator value="page.result">
								<tr class="dgAlternatingItem">
									<td align="center">
										<input type="checkbox" class="checkbox" name="selectIds"
											value="<c:out value='${id}'/>" />
									</td>
									<td align="Left">
										${name}
									</td>
									<td align="Left">
										<a href="${base}${htmlPath}/${htmlName}" target="_blank">${htmlName}</a>
									</td>
									<td align="Left">
										<fmt:formatDate value="${updateTime}" pattern="yyyy-MM-dd" />
									</td>
									<td align="Left">
										<c:if test="${not empty picName }"><img src="${base}/${picPath}/${picName}" alt="..." width="30" height="28"/></c:if>
									</td>
								</tr>
							</s:iterator>							
						</table>
						<s:if test="page.result != null">
							<%@ include file="/common/paginateTool.jsp"%>
						</s:if>		
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				
			</TABLE>
				
	</body>
	</form>
</HTML>
