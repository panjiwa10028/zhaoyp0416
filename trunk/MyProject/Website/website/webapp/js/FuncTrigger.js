/*
* The FuncTrigger object.
* Example:
*	var funcTrigger = new FuncTrigger("http://localhost/TheLocation/SomeFunc.aspx");
*	funcTrigger.setOpenType("MODAL_DIALOG");
*	funcTrigger.setDialogFeatures("......");
*   funcTrigger.setFormParams(obj);
*	var retValue = funcTrigger.tirgger();
*
*/
function FuncTrigger(funcUrl)
{
	this.funcUrl = funcUrl;
	this.openType = "FORM";
	this.dialogFeatures = "dialogHeight: 550px; dialogWidth: 750px; dialogTop: 200px; dialogLeft: 200px; edge: Raised; center: Yes; help: Yes; resizable: No; status: No;";
	this.newWindowFeatures = "menubar=no,location=no,toolbar=no,status=no,scrollbars=yes,width=750,height=550,top=0,left=0";
	this.formTarget = "_self";
	this.formParams = new Object();
	
	this.debug = false;
	this.helperDialog = "";
}

new FuncTrigger("");

function SetHelperDialog(helperDialog)
{
	this.helperDialog = helperDialog;
}
FuncTrigger.prototype.setHelperDialog = SetHelperDialog;

function SetOpenType(openType)
{
	this.openType = openType;
}
FuncTrigger.prototype.setOpenType = SetOpenType;

function SetDialogFeatures(features)
{
	this.dialogFeatures = features;
}
FuncTrigger.prototype.setDialogFeatures = SetDialogFeatures;

function SetNewWindowFeatures(features)
{
	this.newWindowFeatures = features;
}
FuncTrigger.prototype.setNewWindowFeatures = SetNewWindowFeatures;

function SetFormTarget(target)
{
	this.formTarget = target;
}
FuncTrigger.prototype.setFormTarget = SetFormTarget;

function AddFormParams(params)
{
	for(var attr in params) 
	{
		this.formParams[attr] = params[attr];
	}
}
FuncTrigger.prototype.addFormParams = AddFormParams;

function AddFormParam(paramName,paramValue)
{
	this.formParams[paramName] = paramValue;
}
FuncTrigger.prototype.addFormParam = AddFormParam;


function EnableDebug()
{
	this.debug = true;
}
FuncTrigger.prototype.enableDebug = EnableDebug;

function Trigger()
{
	if(window.event)
	{
		window.event.returnValue = false;
	}
	
	var dynaForm = new DynaForm("TriggerForm");
	dynaForm.setAction(this.funcUrl);
	dynaForm.addHiddens(this.formParams);
	if(this.openType == "MODAL_DIALOG")
	{
		return window.showModalDialog(this.helperDialog,null,this.dialogFeatures);
	}
	else if(this.openType == "MODELESS_DIALOG")
	{
		return window.showModelessDialog(this.helperDialog,dynaForm,this.dialogFeatures);
	}
	else
	{
		dynaForm.setFeatures(this.newWindowFeatures);
		dynaForm.setTarget(this.formTarget);
		if(this.debug) dynaForm.enableDebug();
		dynaForm.submit();

		return "";
	}
	
}
FuncTrigger.prototype.trigger = Trigger;