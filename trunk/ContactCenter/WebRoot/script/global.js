var businessAppletReadyFlag = false;

function afterBusinessAppletLoaded() {
	businessAppletReadyFlag = true;
	
	if (top.strProductId!='Contact')
	{
		//hide waiting page add by Norman
		top.hideWaitingPage('sys');
	}
}