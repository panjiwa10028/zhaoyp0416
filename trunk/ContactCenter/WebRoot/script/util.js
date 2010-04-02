//author by gamma
//Map
//An object that maps keys to values.  A map cannot contain duplicate keys;
// each key can map to at most one value.

function struct(key, value){

  this.key = key;
  this.value = value;

}
//set key to map
function putValue(key, value){
  var index = this.mapValue.length;
  for (var i = 0; i < index; i++)
  {
    if ( this.mapValue[i].key === key )
    {
      this.mapValue[i].value = value;
      return;
    }
  }
  this.mapValue[index] = new struct(key, value);
}
//if have key then return value,else return null value
function getValue(key)
{
  var arr = new Array();
  var j = 0;
  var index = this.mapValue.length;
  for (var i = 0; i < index; i++)
  {
    if ( this.mapValue[i].key === key )
    {
      arr[j++] = this.mapValue[i].value;
      	return this.mapValue[i].value;
    }
  }
//  return arr;
  return null;
}
//if have key then return value,else return key
function getValueOrKey(key)
{
  var arr = new Array();
  var j = 0;
  var index = this.mapValue.length;
  for (var i = 0; i < index; i++)
  {
    if ( this.mapValue[i].key === key )
    {
      arr[j++] = this.mapValue[i].value;
      	return this.mapValue[i].value;
    }
  }
  
//  return arr;
  return key;
}
//if have key then return value,else return value
function getValueOrKeyValue(key,value)
{
  var arr = new Array();
  var j = 0;
  var index = this.mapValue.length;
  for (var i = 0; i < index; i++)
  {
    if ( this.mapValue[i].key === key )
    {
      arr[j++] = this.mapValue[i].value;
      	return this.mapValue[i].value;
    }
  }
  
//  return arr;
  return value;
}
//remove key
function removeKey(key)
{
  var v;
  var index = this.mapValue.length;
  for (var i = 0; i < index; i++)
  {
    v = this.mapValue.pop();
    if ( v.key === key )
      continue;
      
    this.mapValue.unshift(v);
  }
}
//count all number
function getCount(){
  return this.mapValue.length;
}
// verify empty
function isEmpty(){
  var index = this.mapValue.length;
  return index <= 0;
}

function classMap() {

  this.mapValue = new Array();

  this.getValue 			= getValue;
  this.getValueOrKey 		= getValueOrKey;
  this.getValueOrKeyValue	= getValueOrKeyValue;
  this.putValue 			= putValue;
  this.removeKey 			= removeKey;
  this.getCount 			= getCount;
  this.isEmpty 				= isEmpty;
}

//????????????
function setAllButtion(buttonName, isTrue)
{	
		var aryChecked = document.all(buttonName);
		 if (aryChecked != null)
		 {

			  if (aryChecked.length != null && aryChecked.length > 0)
			  {
			  	
				   for (var i = 0; i < aryChecked.length; i ++)
				   {
				   		setModifyButtion(aryChecked[i],isTrue);
				   }
			  }
			  else
			  {
			  		setModifyButtion(aryChecked,isTrue);
			  }
		  }
}
	  
function setModifyButtion(button,isTrue)
{
	if(isTrue)
		button.disabled = '';
	else
		button.disabled = 'disabled';
}

//??????????????????
function Justify2Time(timeB,timeE){
  var timeStart = timeB;
  var timeEnd = timeE;
  if(timeStart != "" && timeEnd != ""){
  	var yearStart = parseInt(timeStart.substring(0,4),10);
  	var yearEnd = parseInt(timeEnd.substring(0,4),10);
  	if(yearStart>yearEnd){
  		return false;
  	}else if(yearStart === yearEnd){
  		var monthStart = parseInt(timeStart.substring(5,7),10);
  		var monthEnd = parseInt(timeEnd.substring(5,7),10);
  		if(monthStart > monthEnd){
  			return false;
  		}else if(monthStart === monthEnd){
  			var dateStart = parseInt(timeStart.substring(8,10),10);
  			var dateEnd = parseInt(timeEnd.substring(8,10),10);
  			if(dateStart > dateEnd){
  				return false;
  			}else if(dateStart === dateEnd){
  				var hourStart = parseInt(timeStart.substring(11,13),10);
  				var hourEnd = parseInt(timeEnd.substring(11,13),10);
  				if(hourStart > hourEnd){
  					return false;
  				}else if(hourStart === hourEnd){
  					var minuteStart = parseInt(timeStart.substring(14,16),10);
  					var minuteEnd = parseInt(timeEnd.substring(14,16),10);
  					if(minuteStart > minuteEnd){
  						return false;
  					}
  				}
  			}
  		}
  	}
  }
  return true;
}
  
  function setButtonPermission(hasPermission, name, useName,unuserName)
  {
  	try
  	{
  			var valueDIV="";
			if(hasPermission)
			{
				valueDIV = document.getElementById(useName);
			}
			else
			{
				valueDIV = document.getElementById(unuserName);
			}
			
			if(valueDIV!=null)
					setAllButton_href(name,valueDIV.innerHTML);
				else
					setAllButton_href(name,'');
			
  	}
  	catch(e){}
  }
  
  
  function setAllButton_href(buttonName, value)
  {	
					var aryChecked = document.all(buttonName);
					 if (aryChecked != null)
					 {
			
						  if (aryChecked.length != null && aryChecked.length > 0)
						  {
						  	
							   for (var i = 0; i < aryChecked.length; i ++)
							   {
							   		aryChecked[i].innerHTML =value;
							   }
						  }
						  else
						  {	
						  		aryChecked.innerHTML =value;
						  }
					  }
}

function setHrefPermission(buttonName, isTrue)
{	
		var aryChecked = document.all(buttonName);
		var aryDisabled = document.all(buttonName+'Disabled');
		 if (aryChecked != null)
		 {

			  if (aryChecked.length != null && aryChecked.length > 0)
			  {
			  	
				   for (var i = 0; i < aryChecked.length; i ++)
				   {	
				   		display(aryChecked[i], aryDisabled[i],isTrue);
				   }
			  }
			  else
			  {
			  		display(aryChecked, aryDisabled,isTrue);
			  }
		  }
}

function display(able,disable,isTrue)
{
	if(isTrue)
	{
		able.style.display = "";
		disable.style.display ="none";
	}
	else
	{
		able.style.display = "none";
		disable.style.display ="";
	}
}
