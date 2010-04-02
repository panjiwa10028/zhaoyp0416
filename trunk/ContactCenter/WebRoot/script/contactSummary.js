// grand variable
// boundtype
var BOUNDTYPE_INBOUND	=	0;	//inbound
var BOUNDTYPE_OUTBOUND	=	1;	//outbound

// result
var CONTACT_RESULT_UNKNOWN		=	0;	// unknown
var CONTACT_RESULT_FAILED		=	1;	// failed
var CONTACT_RESULT_SUCCESSFUL	=	2;	// successful
var CONTACT_RESULT_TRACK		=	3;	// track
var CONTACT_RESULT_NOT_TRACK	=	4;	// not track


// channel
var CHANNEL_TELEPHONE	=	1;	// telphone
var CHANNEL_EMAIL		=	2;	// email
var CHANNEL_FAX			=	3;	// fax
var CHANNEL_SMS			=	4;	// sms
var CHANNEL_MAIL		=	5;	// mail
var CHANNEL_CHAT		=	6;	// Chat
var CHANNEL_COBROWSER	=	7;	// Cobrowser
var CHANNEL_VOIP		=	8;	// VOIP

// location variable

// relative data
var g_objArrayBusiness		=	new Array(0);	// task
var g_objArrayFaq			=	new Array(0);	// faq
var g_objArrayAttacheddata	=	new Array(0);	// attacched data

var g_isContactSummary		=	false;	// false:not contact summary, true:in process of contact summary
var g_lContactSummaryId		=	0;		// contact summary id

// private function
// constanct key value object
function keyValueObject(key, value)
{
	this.key = key;
	this.value = value;
}

// public function
function isDoingContactSummary()
{
	if(g_isContactSummary==true && g_lContactSummaryId > 0)
	{
		return true;
	}
	
	return false;
}

function setContactSummary(isContactSummary)
{
	g_isContactSummary = isContactSummary;
}

function getContactSummaryId()
{
	return g_lContactSummaryId;
}

function setContactSummaryId(lContactSummaryId)
{
	g_lContactSummaryId = lContactSummaryId;
}

function getKey()
{
	return this.key;
}

function getValue()
{
	return this.value;
}

function clearBusinessArray()
{
	g_objArrayBusiness = new Array(0);
}

function clearFaqArray()
{
	g_objArrayFaq = new Array(0);
}

function clearAttacheddataArray()
{
	g_objArrayAttacheddata = new Array(0);
}

function addBusiness(key, value)
{
	var blnIsDoingContactSummary = isDoingContactSummary();
	
	if(blnIsDoingContactSummary==true)
	{
		var blnHasKey = false;
		for(var i = 0; i < g_objArrayBusiness.length; i++)
		{
			if(g_objArrayBusiness[i].key==key)
			{
				blnHasKey = true;
				
				break;
			}
		}
		
		if(blnHasKey==false)
		{
			g_objArrayBusiness[g_objArrayBusiness.length] = new keyValueObject(key, value);
		}
	}
}

function getBusinessIds()
{
	var strBusinessIds = "";
	
	for(var i = 0; i < g_objArrayBusiness.length; i++)
	{
		strBusinessIds += g_objArrayBusiness[i].key + ",";
	}
	
	if(strBusinessIds.substring(strBusinessIds.length-1, strBusinessIds.length)==",")
	{
		return strBusinessIds.substring(0, strBusinessIds.length - 1);
	}
	else
	{
		return strBusinessIds;
	}
}

function addFaq(key, value)
{
	var blnIsDoingContactSummary = isDoingContactSummary();
	
	if(blnIsDoingContactSummary==true)
	{
		var blnHasKey = false;
		for(var i = 0; i < g_objArrayFaq.length; i++)
		{
			if(g_objArrayFaq[i].key==key)
			{
				blnHasKey = true;
				
				break;
			}
		}
		
		if(blnHasKey==false)
		{
			g_objArrayFaq[g_objArrayFaq.length] = new keyValueObject(key, value);
		}
	}
}

function getFaqIds()
{
	var strFaqIds = "";
	
	for(var i = 0; i < g_objArrayFaq.length; i++)
	{
		strFaqIds += g_objArrayFaq[i].key + ",";
	}
	
	if(strFaqIds.substring(strFaqIds.length-1, strFaqIds.length)==",")
	{
		return strFaqIds.substring(0, strFaqIds.length - 1);
	}
	else
	{
		return strFaqIds;
	}
}

function addAttacheddata(key, value)
{
	g_objArrayAttacheddata[g_objArrayAttacheddata.length] = new keyValueObject(key, value);
}

// get
function getBusinessArray()
{
	return g_objArrayBusiness;
}

function getFaqArray()
{
	return g_objArrayFaq;
}

function getAttacheddataArray()
{
	return g_objArrayAttacheddata;
}

function clearContactSummary()
{
	setContactSummary(false);
	setContactSummaryId(0);
	clearBusinessArray();
	clearFaqArray();
	clearAttacheddataArray();
}