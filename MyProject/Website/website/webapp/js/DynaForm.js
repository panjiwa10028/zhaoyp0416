/*
* The DynaForm object.
* Example:
*	var dynaForm = new DynaForm("theForm");
*	dynaForm.setAction("http://localhost/CmbBank_GenShell/Login.aspx");
*	dynaForm.setTarget("_blank");
*	//dynaForm.setTarget("newwin");
*	//dynaForm.setFeatures("status=no,scrollbars=yes,width=800,height=550,top=0,left=0");
*	dynaForm.addHidden("h1","<h1value>");
*	dynaForm.addHidden("h2","h2value");
*	dynaForm.submit();
*
*/
function DynaForm(name)
{
	this.name = name;
	this.action = "";
	this.method = "post";
	this.target = "_self";
	
	//window features used in window.open(...) method
	this.features = "";
    
    this.debug = false;	
    //this.hiddenField = new Object();
    this.hiddenNameArray = new Array();
    this.hiddenValueArray = new Array();
    this.hiddenNumber = 0;
}
new DynaForm("");

function EnableDebug()
{
	this.debug = true;
}
DynaForm.prototype.enableDebug = EnableDebug;

function SetFeatures(features)
{
	this.features = features;
}
DynaForm.prototype.setFeatures = SetFeatures;
function GetFeatures()
{
	return this.features;
}
DynaForm.prototype.getFeatures = GetFeatures;


function SetTarget(target)
{
	this.target = target;
}
DynaForm.prototype.setTarget = SetTarget;
function GetTarget()
{
	return this.target;
}
DynaForm.prototype.getTarget = GetTarget;

function SetMethod(method)
{
	this.method = method;
}
DynaForm.prototype.setMethod = SetMethod;
function GetMethod()
{
	return this.method;
}
DynaForm.prototype.GetMethod = GetMethod;


function SetAction(action)
{
	this.action = action;
}
DynaForm.prototype.setAction = SetAction;
function GetAction()
{
	return this.action;
}
DynaForm.prototype.getAction = GetAction;

function AddHidden(name,value)
{
	var currentIndex = this.hiddenNumber;
	this.hiddenNumber ++ ;
    this.hiddenNameArray[currentIndex] = name;
    this.hiddenValueArray[currentIndex] = value;
    	
}
DynaForm.prototype.addHidden = AddHidden;

function AddHiddens(obj)
{
	var currentIndex = this.hiddenNumber;
	for(var attr in obj)
	{
		this.hiddenNumber ++ ;
		this.hiddenNameArray[currentIndex] = attr;
		this.hiddenValueArray[currentIndex++] = obj[attr];
	}
}
DynaForm.prototype.addHiddens = AddHiddens;

function GetParamNames()
{
	return this.hiddenNameArray;
}
DynaForm.prototype.getParamNames = GetParamNames;

function GetParamValues()
{
	return this.hiddenValueArray;
}
DynaForm.prototype.getParamValues = GetParamValues;

function Submit(theDocument)
{
	if(theDocument == undefined)
	{
		theDocument = window.document;
	}
		var formObj = theDocument.getElementById(this.name);
		//delete the form object if exist yet
		if(formObj != null)
		{
			theDocument.body.removeChild(formObj);
		}
		//create the form object
    	formObj = theDocument.createElement("<form style='display:none' id="+this.name+" name="+this.name+" method="+this.method+" action="+this.action+" target="+this.target+">");
    	if (this.action != undefined && this.action != "") {
        	formObj.action = this.action;
    	}
    	//create hidden fields and add to the form object
    	for(var i=0; i<this.hiddenNumber; i++)
    	{	
    		var name = this.hiddenNameArray[i];
    		var value = this.hiddenValueArray[i];
    		//var hiddenObj = theDocument.createElement("<input type=hidden  name="+name+"  value="+encodeURIComponent(value)+">");
    		var hiddenObj = theDocument.createElement("<input type=hidden  name=\""+name+"\"  value=\""+value+"\">");
        	formObj.appendChild(hiddenObj);
    	}
    	if(this.debug)
    	{
    		alert(formObj.outerHTML);
    	}
    	if(this.target.substr(0,1) != "_")
    	{
    		if(theDocument.getElementById(this.target) == null)
    		{//submit the form in a new window
    			window.open('',this.target,this.features);
    		}
    		else
    		{
    		}
    	}
    	
    	theDocument.body.appendChild(formObj);
    	formObj.submit();
}
DynaForm.prototype.submit = Submit;

