<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<html>
<head>
	<%@ include file="/jsp/common/header/include_link.jsp" %>
	<%@ include file="/jsp/common/header/include_script.jsp" %>
<title><%=Function.getMultiLangItemContent("AUX.reason.selecttion", request)%></title>
</head>

<body background="<%=strContextPath%>/softphone/images/pipe/bg_main.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('<%=strContextPath%>/softphone/images/pipe/top_right02.gif','<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-sure2.gif','<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-cancel02.gif')">
<table align="center" width="330" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="12%" align="left" valign="bottom" background="<%=strContextPath%>/softphone/images/pipe/top_bg.gif"><img src="<%=strContextPath%>/softphone/images/light_red.gif" width="40" height="33"></td>
          <td width="75%" align="left" valign="bottom" background="<%=strContextPath%>/softphone/images/pipe/top_bg.gif"><table height="16" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top"><%=Function.getMultiLangItemContent("AUX.reason.selecttion", request)%></td>
            </tr>
          </table></td>
          <td width="13%" align="right" valign="bottom" background="<%=strContextPath%>/softphone/images/pipe/top_bg.gif"><img src="<%=strContextPath%>/softphone/images/pipe/top_right.gif" width="31" height="33"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="13" background="<%=strContextPath%>/softphone/images/pipe/bg_left.gif">&nbsp;</td>
    <td width="303" height="70" align="left" valign="top" bgcolor="F1F1F1"> <table width="100%" border="0" cellpadding="1" cellspacing="8">
        <tr> 
          <td width="22%" align="center"><img src="<%=strContextPath%>/softphone/images/titleico_AUX.gif" width="28" height="28"></td>
          <td valign="bottom"><select name="select" size="1" class="box01" onClick="returnValue=vReturnValue();">
            <SCRIPT LANGUAGE="JavaScript"> 
				<!-- 
					a = dialogArguments[0]; 
					b = dialogArguments[1]; 
					for(i=0;i<a.length;i++)
					{
						if(a[i]!="")
						document.write("<option value='"+a[i]+"'>"+b[i]+"</option>");
					}
				// --> 
			</SCRIPT> 
                                        </select></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><table border="0" cellpadding="2" cellspacing="3">
            <tr>
              <td><a style="CURSOR:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-sure2.gif',1)"><img onclick="window.close();" src="<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-sure1.gif" name="Image5" width="59" height="23" border="0"></a></td>
              <td><a style="CURSOR:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-cancel02.gif',1)"><img onclick="returnValue='';window.close();" src="<%=strContextPath%>/softphone/images/<%=strMultiLangName%>/bu5-cancel01.gif" name="Image6" width="59" height="23" border="0"></a></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    <td width="14" background="<%=strContextPath%>/softphone/images/pipe/bg_right.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=strContextPath%>/softphone/images/pipe/bottom_bg.gif">
        <tr> 
          <td align="left" valign="top"><img src="<%=strContextPath%>/softphone/images/pipe/bottom_left.gif"  width="40" height="18"></td>
          <td align="right" valign="top"><img src="<%=strContextPath%>/softphone/images/pipe/bottom_right.gif" width="31" height="18"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript"> 
	<!-- 
		function vReturnValue(){
		return select.value;
		}
		function window.onbeforeunload()
		{
		      if(event.clientY<0)   
		      {   
		         returnValue="";  
		      }
		}  
		returnValue=vReturnValue();
	// --> 
</SCRIPT> 