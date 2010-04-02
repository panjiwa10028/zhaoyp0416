//author mikey

//number input validation
function verifyNum(obj) {
	var value = obj.value;
	if (value == "0"){
		obj.value ="";
	}
	if (event.keyCode < 48 || event.keyCode > 57) {
		if (event.keyCode != 8 && event.keyCode != 9) {
			event.keyCode = 0;
	    }
	}
}

function verifyMaxLength(obj,maxLength) {
	var value = obj.value;
	if (value.length >=maxLength){
		event.keyCode = 0;
	}
}

function isInt(n) {
	var i = parseInt(n*1);
	if (i == NaN) {
		return false;
	}
	if (i != n){
		return false;
	}
	return true;
}

//filter chinese character when keyup event occured
function filterAllExceptNum(obj)
{
	var newValue= "";
	for(var i=0;i<obj.value.length;i++)
	{
		var tmp = obj.value.substring(i,i+1);
		if((tmp==0)||(tmp==1)||(tmp==2)||(tmp==3)||(tmp==4)||(tmp==5)||(tmp==6)||(tmp==7)||(tmp==8)||(tmp==9))
		{
			newValue= newValue+tmp;
		}

	}
	if(obj.value!=newValue)
		obj.value=newValue;
}
//validate the email
function isValidEMail(EmailStr){
 if(EmailStr == "") return true;
 var myReg = /[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/;
 if(myReg.test(EmailStr)) return true; 
 return false; 
}

/**compare the two dates, if 2004-12-01 > 2004-11-08 then return true
 * @param max the bigger one
 * @param min the smaller one
 * @return true/false max > min/max < min
 */
function compareDate(max,min){
    var newMax = strToDate(max);
    var newMin = strToDate(min);
    if (newMax >= newMin){
        return true;
    }else{
        return false;
    }
}

/**change a string to a date format
*  @param strDate the string needed to be changed '20020303' or '2002-3-3' or '2002.3.3'
*  @return 8 bit date
*/
function strToDate(strDate) {
    var tempDate = strDate;
    var index1 = tempDate.indexOf(".");
    if(-1 == index1)
        index1 = tempDate.indexOf("-");
        
    var index2 = tempDate.lastIndexOf(".");
    if(-1 == index2)
        index2 = tempDate.lastIndexOf("-");

    //format like 2002-2-2,2002.2.3 parsing
    if ((-1 != index1) || (-1 != index2)) {
        var year = tempDate.substring(0, index1);
        
        var m = parseInt(tempDate.substring(index1 + 1, index2),10);
        var month = "" + m;
        if(m < 10)
            month = "0" + m;
            
        var d = parseInt(tempDate.substring(index2 + 1, tempDate.length),10);             
        var day = "" + d;
        if(d < 10)
            day = "0" + d;
            
        tempDate = year + month + day;
    } 
    return tempDate;
}

//select all
function selectall(checkListName)
{
 var obj = document.all(checkListName);
 if(null ==obj) return false;
 var num=obj.length;
  if(document.all("checkall").checked){
    if(num==null){obj.checked=true;}
    else{
       for (var i=0;i<num;i++){
         if(!obj[i].disabled){
            obj[i].checked=true;
         }
       }
    }
    }
  else
  {
   if(num==null){obj.checked=false;}
   else{
     for (var i=0;i<num;i++)
       if(!obj[i].disabled){
          obj[i].checked=false;
       }
   }
  }
}

//justify are all selected, if all checkboxs of belows checked, then the state of checkall changed
function checkItem(checkListName, controlCheck)
{
 var aryChecked = document.all(checkListName);
 if (aryChecked != null)
 {
  if (aryChecked.length != null && aryChecked.length > 0)
  {
   var nCount = 0;
   for (var i = 0; i < aryChecked.length; i ++)
   {
    if (aryChecked[i].checked)
        nCount ++;
   }
   if (nCount == aryChecked.length) {
       controlCheck.checked = true;
    }  else{
       controlCheck.checked = false;
    }
  }
  else
  {
   controlCheck.checked = aryChecked.checked;
  }
 }
}

function trim(str){
	//return str.replace(/(^\s*|\s*$)/g,"");
	return str.replace(/(^[\s　]*)|([\s　]*$)/g, "");
}

//what is this ?  can not convert the js file coding from GBK to UTF-8
//Erik
    	function DateDiff(oDateTime1, oDateTime2)
	 	{ 	
			if(oDateTime1 == null)
			{
				return false;
			}else if(oDateTime2 == null)
			{
				return false;
			}else if(oDateTime1 == "" && oDateTime2 == "")
			{
				return true;
			}
		
			if(oDateTime1.indexOf("-") >0)
			{
				oDateTime1=oDateTime1.substring(0,oDateTime1.indexOf("-"))+"/"+oDateTime1.substring(oDateTime1.indexOf("-")+1,oDateTime1.lastIndexOf("-"))+"/"+oDateTime1.substring(oDateTime1.lastIndexOf("-")+1,oDateTime1.length);	    	    
			}
		
			if(oDateTime2.indexOf("-") >0)
			{
				oDateTime2=oDateTime2.substring(0,oDateTime2.indexOf("-"))+"/"+oDateTime2.substring(oDateTime2.indexOf("-")+1,oDateTime2.lastIndexOf("-"))+"/"+oDateTime2.substring(oDateTime2.lastIndexOf("-")+1,oDateTime2.length);	    	    
			}
		
			if(Date.parse(oDateTime2) - Date.parse(oDateTime1) > 0)
			{				
				return true;
			}
			else
			{				
				return false;
			}
	 	}