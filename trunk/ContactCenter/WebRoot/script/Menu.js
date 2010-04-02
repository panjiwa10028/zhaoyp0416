document.write("<div id='MenuBarDIV' style='position: absolute; z-index: 210; display: none;'>");
document.write("<iframe id='MenuBarIFRAME' name='MenuBarIFRAME' width='0' height='0' scrolling='no' style='position: absolute; z-index: 200;' frameborder='0' onmouseout='HideMenuTable()'></iframe></div>");

//------------------------------------------------------------------------------------------------
//菜单
function Menu()
{
	//属性
	this.strId			="";		//菜单Id
	this.strLabel		="Menu";	//菜单标题
	this.strIcon		="";		//菜单的图标路径
	this.nState			=0;			//菜单状态，0-正常，1-禁止，2-不可见
	this.arrMenuItem	=null;		//菜单项数组
	this.nLeft			=0;			//MenuBar的显示参数
	this.nTop			=100;		//MenuBar的显示参数
	this.nWidth			=100;		//MenuBar的显示参数
	this.nHeight		=80;		//MenuBar的显示参数

	//方法
	this.DrawMenu		=menu_DrawMenu;		//显示菜单标题的函数
	this.DrawMenuBar	=menu_DrawMenuBar;	//显示菜单的函数

	//对应的界面对象
	this.tblMenu	=null;
	this.spanMenu	=null;
}

//显示菜单控件
function menu_DrawMenu()
{
	var strSPANId="MenuSPAN"+this.strId;
	var strIMGId="MenuIMG"+this.strId;
	document.writeln('<span id="'+strSPANId+'" class="MenuSPAN" style="cursor:default; wordWrap: normal;" onmousemove="menu_OnMouseMove();" onmouseout="menu_OnMouseOut();" onmouseenter="menu.DrawMenuBar();">');
	document.writeln(this.strLabel);
	if(this.strIcon!="")
	{
		document.writeln('<img id="'+strIMGId+'" class="MenuIMG" src="'+this.strIcon+'" onmouseenter="menu.DrawMenuBar();"/>');
	}
	document.writeln('</span>');
	
	this.spanMenu=document.getElementById(strSPANId);
}

function menu_OnMouseMove()
{
	var varSource=window.event.srcElement;
	if(varSource.className=="MenuIMG")
	{
		varSource=document.getElementById("MenuSPAN"+varSource.id.substr(7));
	}
	if(varSource.className=="MenuSPAN")
	{
		varSource.style.borderStyle="solid";
		varSource.style.borderColor="#123456";
		varSource.style.borderWidth="1px";
	}
}

function menu_OnMouseOut()
{
	var varSource=window.event.srcElement;
	if(varSource.className=="MenuIMG")
	{
		varSource=document.getElementById("MenuSPAN"+varSource.id.substr(7));
	}
	if(varSource.className=="MenuSPAN")
	{
		varSource.style.borderStyle="none";
		varSource.style.borderColor="#123456";
		varSource.style.borderWidth="1px";
	}
}

//显示菜单Bar
function menu_DrawMenuBar()
{
	var strClass="";
	if(this.nState==0)
	{//正常菜单
		strClass="NormalMenuTable";
	}
	else if(this.nState==1)
	{//禁止菜单
		strClass="DisabledMenuTable";
	}
	else
	{//不可见菜单
		strClass="InvisibleMenuTable";
	}

	if(this.arrMenuItem==null)
	{
		return;
	}
	with(window.frames("MenuBarIFRAME"))
	{
		document.clear();

		document.writeln("<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");

		document.writeln("<style>");
		document.writeln("	*{font-size: 12px;}");
		document.writeln("	.NormalMenuItemTR{color: #000000; cursor:hand; vertical-align:middle;}");
		document.writeln("	.HotMenuItemTR{color: #FFFFFF; cursor:hand;background-color:#1975BF; vertical-align:middle;}");
		document.writeln("	.DisabledMenuItemTR{color: #808080; cursor:default; vertical-align:middle;}");
		document.writeln("	.InvisibleMenuItemTR{color: #808080; cursor:default; display: none; vertical-align:middle;}");
		document.writeln("</style>");

		document.writeln("</head>");
		document.writeln("<body onkeydown='return false' onselectstart='return false' style='margin: 0px' oncontextmenu='return false'>");

		document.writeln('<table border="1" bordercolor="#000000" bgcolor="#F1F2F2" width="100%" height="100%" cellpadding="2" style="border-collapse: collapse">');
		document.writeln('<row>');
		document.writeln('<td width="100%" height="%100">');
		document.writeln('<table id="MenuTable" border="0" width="100%" cellpadding="0" style="border-collapse: collapse">');
		for(var i=0;i<this.arrMenuItem.length;i++)
		{//显示菜单项
			var strClass	="";
			var strOnClick	=this.strOnClick;
			var strIcon		="";
			if(this.arrMenuItem[i].nState==0)
			{//正常菜单项
				strClass="NormalMenuItemTR";
				strIcon	=this.arrMenuItem[i].strNormalIcon;
			}
			else if(this.arrMenuItem[i].nState==1)
			{//禁止菜单项
				strClass="DisabledMenuItemTR";
				strOnClick="";
				strIcon	=this.arrMenuItem[i].strDisabledIcon;
			}
			else
			{//不可见菜单项
				strClass="InvisibleMenuItemTR";
			}

			document.writeln('<tr id="'+this.arrMenuItem[i].strId+'" class="'+strClass+'" height="20">');
			document.writeln('	<td><img src="'+strIcon+'"/>'+'</td>');
			document.writeln('	<td>'+this.arrMenuItem[i].strLabel+'</td>');
			document.writeln('</tr>');

			this.arrMenuItem[i].trMenuItem	=document.getElementById(this.arrMenuItem[i].strId);

			this.arrMenuItem[i].trMenuItem.onmouseover	=MenuItem_OnMouseOver;
			this.arrMenuItem[i].trMenuItem.onmouseout	=MenuItem_OnMouseOut;
			this.arrMenuItem[i].trMenuItem.onclick		=MenuItem_OnClick;
		}
		document.writeln("</table>");
		document.writeln('</td>');
		document.writeln('</row>');
		document.writeln('</table>');
		document.writeln("</body></html>");

		document.close();

		this.tblMenu	=document.getElementById("MenuTable");
	}

	var divMenuBar=document.getElementById("MenuBarDIV");
	//divMenuBar.style.left=this.nLeft;
	divMenuBar.style.top=this.nTop;
	divMenuBar.style.left = (document.body.scrollWidth - 80)/2;
	
	var ifrmMenuBar=document.getElementById("MenuBarIFRAME");
	ifrmMenuBar.width=this.nWidth;
	ifrmMenuBar.height=this.nHeight;

	divMenuBar.style.display="";
}

//------------------------------------------------------------------------------------------------
//菜单项
function MenuItem()
{
	//属性
	this.strId			="";		//菜单项Id
	this.strLabel		="MenuItem";//菜单项标题
	this.strNormanIcon	="";		//菜单项的正常图标路径
	this.strDisabledIcon="";		//菜单项的禁止图标路径
	this.nState			=0;			//菜单项状态，0-正常，1-禁止，2-不可见

	//对应的界面对象

	this.trMenuItem		=null;
}

function MenuItem_OnMouseOver()
{
	var varSource = this;

	if(varSource.className!="DisabledMenuItemTR")
	{
		varSource.className="HotMenuItemTR";
	}
}

function MenuItem_OnMouseOut()
{
	var varSource = this;

	if(varSource.className=="DisabledMenuItemTR")
	{
		return;
	}
	else if(varSource.className=="HotMenuItemTR")
	{
		varSource.className="NormalMenuItemTR";
	}
}

function MenuItem_OnClick()
{
	var varSource = this;
	if(varSource.className=="DisabledMenuItemTR")
	{
		return;
	}

	var divMenuBar=document.getElementById("MenuBarDIV");
	divMenuBar.style.display="none";

	//触发事件
	OnMenuItem(this.id);
}

function document.onclick()
{
    if(window.event.srcElement.className!="MenuSPAN" && window.event.srcElement.className!="MenuIMG")
    {
		var divMenuBar=document.getElementById("MenuBarDIV");
		divMenuBar.style.display="none";
    }
}

function HideMenuTable()
{
	var divMenuBar=document.getElementById("MenuBarDIV");
	divMenuBar.style.display="none";
}
