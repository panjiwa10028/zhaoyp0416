
String.prototype.trim = function()
{
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.gblen = function()
{
    return this.replace(/[^\x00-\xff]/g,"**").length;
}

String.prototype.suiteLen = function(min, max)
{
	var len = this.gblen();
	return len >=min && len <=max;
}

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


var wnds = new Array();
function OpenWnd(url, w, h, n, s, loc)
{
	var nWinLeft, nWinTop;
	if(loc == 1)
	{
		nWinLeft = event.screenX;
		nWinTop = event.screenY;
	}
	else
	{
		nWinLeft = (screen.width-w)/2;
		nWinTop = (screen.height-h)/2;
	}

	if(n != null && n != '' && n.charAt(0) != '_' && wnds[n] != null)
	{
		wnds[n].close();
	}

	wnds[n] = window.open(url, n,'resizable=1,scrollbars='+s+',width=' + w + ',height='+ h + ',top=' + nWinTop + ',left=' + nWinLeft);
}




var dialogFeatures = "";
var newwinFeatures = "";
function Trim(s)
{
	return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}


function IsDigit(cCheck)
{
    return (('0'<=cCheck) && (cCheck<='9'));
}


function IsAllDigit(str)
{
    if ((str == null) || (str.length == 0))
    {
        return false;
    }

    var chCurrent;
	for (i=0; i<str.length; i++)
    {
        chCurrent = str.charAt(i);
        if (!IsDigit(chCurrent))
        {
            return false;
		}
    }
	return true;
}


function IsAllChar(str)
{
	var reg = /[^a-zA-Z]/g;
	return (!reg.test(Trim(str)));
}


function IsCharAndNum(str)
{
	var reg = /[^0-9a-zA-Z]/g;
	return (!reg.test(Trim(str)));
}


function IsASCII(str)
{
	var len = str.length;
	for(var i=0; i<len; i++)
	{
		if((parseInt(str.charCodeAt(i))<0)||(parseInt(str.charCodeAt(i))>255))
		{
			return false;
		}
	}
	return true;
}


function IsValidDate( stringDate )
{
	var strDate = Trim(stringDate);
	if(strDate.length != 8) return false;
	if(!IsAllDigit(strDate)) return false;
	var nYear = strDate.substring( 0, 4 );
	var nMonth = strDate.substring( 4, 6 );
	var nDay = strDate.substring( 6, 8 );
	if ( nYear <= 1900 || nMonth > 12 || nMonth < 1 || nDay > 31 || nDay < 1 )
	{
		return false;
	}
	return true;
}


function IsValidTime( stringTime )
{
	var strTime = Trim(stringTime);
	if(strTime.length != 6) return false;
	if(!IsAllDigit(strTime)) return false;
	var nHour = strTime.substring( 0, 2 );
	var nMinute = strTime.substring( 2, 4 );
	var nSecond = strTime.substring( 4, 6 );
	if ( nHour >= 24 || nMinute > 60 ||nSecond > 60 )
	{
		return false;
	}
	return true;
}


function IsValidMoney(str)
{
    if ((str == null) || (str.length == 0))
    {
        return false;
    }

    var chCurrent;
    var dotFounded = false;
    var dotIndex=-1;
    var lenBeforeDot = str.length;
    var lenAfterDot = 0;

    for (i=0; i<str.length; i++)
    {
        chCurrent = str.charAt(i);
        if (!IsDigit(chCurrent))
        {
            if (chCurrent == '.')
            {
                if (dotFounded)
                {
                    return false;
                }
                dotFounded = true;
                dotIndex = i;
                if ((dotIndex == 0) || (dotIndex == str.length-1))
                {
                    return false;
                }

                lenBeforeDot = dotIndex;
                lenAfterDot = str.length - dotIndex -1;
             }
             else
             {
                return false;
             }
        }
    }

    if ((lenBeforeDot > 11) || (lenAfterDot >2))
    {
        return false;
    }

    return true;
}


function IsValidPassword(strPassword)
{
	if(strPassword.length != 6) return false;
	if(!IsAllDigit(strPassword)) return false;
	return true;
}


function IsValidPrice(str,intLen,decLen)
{
    if ((str == null) || (str.length == 0))
    {
        return false;
    }

    var chCurrent;
    var dotFounded = false;
    var dotIndex=-1;
    var lenBeforeDot = str.length;
    var lenAfterDot = 0;

    for (i=0; i<str.length; i++)
    {
        chCurrent = str.charAt(i);
        if (!IsDigit(chCurrent))
        {
            if (chCurrent == '.')
            {
                if (dotFounded)
                {
                    return false;
                }
                dotFounded = true;
                dotIndex = i;
                if ((dotIndex == 0) || (dotIndex == str.length-1))
                {
                    return false;
                }

                lenBeforeDot = dotIndex;
                lenAfterDot = str.length - dotIndex -1;
             }
             else
             {
                return false;
             }
        }
    }

    if ((lenBeforeDot > intLen) || (lenAfterDot >decLen))
    {
        return false;
    }

    return true;
}


function IsValidEmail(email)
{
  var re = /\w+@\w+\.\w+/;
  if (re.test(email))
    return true;
  else
    return false;
}


/*
function IsValidPhone(phone)
{
	var reg=/(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,4}[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
	return reg.test(Trim(phone));

}
*/


function IsValidPhone(val)
{
   if (val.length > 20) return false;
   val = val.split(" ").join("");
   val = val.split("-").join("");
   if(val.indexOf("+")==0) val=val.substring(1);
   // check whether you have a numberic value
   return !isNaN(val);
}


function IsValidMobile(phone)
{
	var reg=/(^0{0,1}13[0-9]{9}$)/;
	return reg.test(Trim(phone));

}


function OnCopy(frame)
{
    var oTxt = frame.document.body.createTextRange();
    oTxt.execCommand("copy");
}


function OnPrint(frame)
{
    try
    {
        frame.focus();
        frame.print();
    }
    catch(e)
    {
        alert("\u60a8\u7684\u6d4f\u89c8\u5668\u7248\u672c\u592a\u4f4e\uff0c\u8bf7\u5347\u7ea7\u60a8\u7684\u6d4f\u89c8\u5668\uff01");
    }
}


function GetToday()
{
    var today = new Date();
    var year = today.getYear().toString();
    var month = (today.getMonth()+1).toString();
    var day = today.getDate().toString();

    if(month.length == 1)
    {
        month = "0"+month;
    }
    if(day.length == 1)
    {
        day = "0"+day;
    }
    var strToday = year+month+day;
    return strToday;
}


function ChnStrLen(str,maxLen)
{
	var len = str.length;
	var chnLen = 0;
	var flag = true;
	for(var i=0; i<len; i++)
	{
		if((parseInt(str.charCodeAt(i))<0)||(parseInt(str.charCodeAt(i))>255))
		{
			chnLen += 2;
			flag = false;
		}
		else
		{
			chnLen += 1;
		}
	}
	return (maxLen >= chnLen);

}


function TruncStr(str,len)
{
	var retStr = "";
	var incrLen = 0;
	for(var i=0; i<str.length; i++)
	{
		if(IsAscii(str.charAt(i)))
		{
			retStr += str.charAt(i);
			incrLen += 1;
		}
		else
		{
			retStr += str.charAt(i);
			incrLen += 2;
		}
		if(incrLen >= 2*len)
		{
			break;
		}
	}
	return retStr;
}


function MyAlert(theText,notice)
{
	  alert(notice);
	  theText.focus();
	  theText.select();
}

function hideDiv(divId) {
	document.getElementById(divId).style.display = "none";
}

function selectAllCheckBox(obj, id) {
	if(id == undefined) {
		id = "'selectIds'";
	}
	var checkList = document.getElementsByName(id);
	if(checkList==null) {
		return "";
	}
	for(var i=0; i<checkList.length; i++) {	
		if(obj.checked == true) {
			checkList[i].checked = true;
		}else {
			checkList[i].checked = false;
		}
		
	}
}

function getSelectedCheckBoxIds(id) {
	if(id == undefined) {
		id = "'selectIds'";
	}
	var checkList = document.getElementsByName(id);
		
	if(checkList==null) {
		return "";
	}
		
	var strSelectedIds = "";			
	for(var i=0; i<checkList.length; i++) {				
		if(checkList[i].checked==true) {
			if(i > 0 && strSelectedIds != "") {
				strSelectedIds += ",";
			}
			strSelectedIds += checkList[i].value;
		}
	}
	return strSelectedIds;
}

