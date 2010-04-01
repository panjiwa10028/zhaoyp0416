var disconFlag = 0;

function webMouseClick(name) {
	if(name=="dialImage"){
		var obj = document.getElementById(name);
		
		if(obj.className=="dialImage_over")
		{
			var phoneNumber = document.getElementById("phoneNumber").value
			if(!onMakeCall(phoneNumber)) //check whether is do not call.
			{ 
				return;
			}
		}
	}
	top.softPhone.webMouseClick(name);
}
function webMouseOver(name) {
	var obj = document.getElementById(name);
	if(name=="dialImage"){
		if(obj.className=="dialImage_enabled")
			obj.className = "dialImage_over";
	}
	if(name=="disconImage"){
		if(obj.className=="dialImage_hangup"){
			obj.className = "dialImage_over";
			disconFlag = 1;
		}
		if(obj.className=="dialImage_refuse"){
			obj.className = "dialImage_over";
			disconFlag = 2;
		}
	}
	if(name=="mailinImage"){
		if(obj.className=="mailinImage_enabled")
			obj.className = "mailinImage_over";
	}
	if(name=="newEmailImage"){
		if(obj.className=="newEmailImage_enabled")
			obj.className = "newEmailImage_over";
	}
	if(name=="chatImage"){
		if(obj.className=="chatImage_enabled")
			obj.className = "chatImage_over";
	}
	if(name=="callMeBackImage"){
		if(obj.className=="callMeBackImage_enabled")
			obj.className = "callMeBackImage_over";
	}
	if(name=="workbinEmailImage"){
		if(obj.className=="workbinEmailImage_enabled")
			obj.className = "workbinEmailImage_over";
	}
}

function webMouseOut(name) {
	var obj = document.getElementById(name);
	if(name=="dialImage"){
		if(obj.className=="dialImage_over")
			obj.className = "dialImage_enabled";
	}
	if(name=="disconImage"){
		if(obj.className=="disconImage_over" && disconFlag == 1)
			obj.className = "disconImage_hangup";
		if(obj.className=="disconImage_over" && disconFlag == 2)
			obj.className = "disconImage_refuse";
	}
	if(name=="mailinImage"){
		if(obj.className=="mailinImage_over")
			obj.className = "mailinImage_enabled";
	}
	if(name=="newEmailImage"){
		if(obj.className=="newEmailImage_over")
			obj.className = "newEmailImage_enabled";
	}
	if(name=="chatImage"){
		if(obj.className=="chatImage_over")
			obj.className = "chatImage_enabled";
	}
	if(name=="callMeBackImage"){
		if(obj.className=="callMeBackImage_over")
			obj.className = "callMeBackImage_enabled";
	}
	if(name=="workbinEmailImage"){
		if(obj.className=="workbinEmailImage_over")
			obj.className = "workbinEmailImage_enabled";
	}
}
function webMouseUp(name) {
	var obj = document.getElementById(name);
	if(name=="dialImage"){
		if(obj.className=="dialImage_down")
			obj.className = "dialImage_over";
		if(obj.className=="dialImage_flash_down")
			obj.className = "dialImage_flash";
	}
	if(name=="mailinImage"){
		if(obj.className=="mailinImage_down")
			obj.className = "mailinImage_over";
	}
	if(name=="newEmailImage"){
		if(obj.className=="newEmailImage_down")
			obj.className = "newEmailImage_over";
	}
	if(name=="chatImage"){
		if(obj.className=="chatImage_down")
			obj.className = "chatImage_over";
	}
	if(name=="callMeBackImage"){
		if(obj.className=="callMeBackImage_down")
			obj.className = "callMeBackImage_over";
	}
}
function webMouseDown(name) {
	var obj = document.getElementById(name);
	if(name=="dialImage"){
		if(obj.className=="dialImage_over")
			obj.className = "dialImage_down";		
		if(obj.className=="dialImage_flash" || obj.className=="dialImage_ringing" || obj.className=="dialImage_dialing")
			obj.className = "dialImage_flash_down";
	}
	if(name=="mailinImage"){
		if(obj.className=="mailinImage_over")
			obj.className = "mailinImage_down";
	}
	if(name=="newEmailImage"){
		if(obj.className=="newEmailImage_over")
			obj.className = "newEmailImage_down";
	}
	if(name=="chatImage"){
		if(obj.className=="chatImage_over")
			obj.className = "chatImage_down";
	}
	if(name=="callMeBackImage"){
		if(obj.className=="callMeBackImage_over")
			obj.className = "callMeBackImage_down";
	}
}