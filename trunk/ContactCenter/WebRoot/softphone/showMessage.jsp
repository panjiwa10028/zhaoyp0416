<%
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");

String strContextPath = request.getContextPath();
String strMultiLangName = Function.GetMultiLangName(request);
%>

<html>
	<head>
		<SCRIPT LANGUAGE="JavaScript"> 
		function MM_preloadImages() { //v3.0
		  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
		    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
		    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}
		
		function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
		}
		
		function MM_findObj(n, d) { //v4.01
		  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		  if(!x && d.getElementById) x=d.getElementById(n); return x;
		}
		
		function MM_swapImage() { //v3.0
		  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
		   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
		}
		
		var strMessage = window.dialogArguments[0]; 
		var dialogType = window.dialogArguments[1];
	</SCRIPT>
		<title>show Message</title>
	</head>

	<body bgcolor="#E0DFDF" leftmargin="5" topmargin="5"
		onLoad="MM_preloadImages('<%=strContextPath%>/images/alert_image/warning01.gif','<%=strContextPath%>/images/alert_image/warning02.gif','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-sure1.gif','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-sure2.gif','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-cancel01.gif','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-cancel02.gif')">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="01">
			<tr>
				<td height="100%" align="center" valign="middle">
					<table width="80%" height="85" border="0">
						<tr>
							<td width="48" rowspan="2" valign="top">
							<SCRIPT LANGUAGE="JavaScript"> 
							<!-- 
									if(dialogType==0){
										document.write("<img src='<%=strContextPath%>/images/alert_image/warning01.gif' width='48' height='48'>");
									}else{
										document.write("<img src='<%=strContextPath%>/images/alert_image/warning02.gif' width='48' height='48'>");
									}
							// --> 
							</SCRIPT>
							</td>
							<td width="20" rowspan="2">
								&nbsp;
							</td>
							<td height="15">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td width="630" valign="top" class="font">
								<SCRIPT LANGUAGE="JavaScript"> 
									document.write(strMessage);
								</SCRIPT>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr valign="bottom">
				<td height="0">
					<div align="center">
						<table border="0" cellspacing="4">
							<tr>
								<td>
									<a style="CURSOR:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-sure2.gif',1)"><img onClick="windowClose('0')"
											src="<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-sure1.gif" name="Image2" width="59" height="23" border="0"></a>
								</td>
								<SCRIPT LANGUAGE="JavaScript"> 
									if(dialogType==0){
										document.write("<td><a style="CURSOR:hand" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('Image3','','<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-cancel02.gif',1)\"><img onClick=\"windowClose('1')\" src=\"<%=strContextPath%>/images/alert_image/<%=strMultiLangName%>/bu5-cancel01.gif\" name=\"Image3\" width=\"59\" height=\"23\" border=\"0\"></a></td>");
									}
								</SCRIPT>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>
<SCRIPT LANGUAGE="JavaScript"> 
function windowClose(StrRetrun){
	returnValue = StrRetrun;
	window.close();
}
function window.onbeforeunload(){
	if(event.clientY<0)   
	{   
		returnValue="1";  
	}
}
</SCRIPT>
