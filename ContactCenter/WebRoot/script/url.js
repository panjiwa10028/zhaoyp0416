//author mikey

//ת��url
function getUrl(oldUrl,strInteractionID) {
	var newUrl = '';
	var paraUrl = '';
	if (oldUrl == undefined || oldUrl == ''){
		return newUrl;
	}
	 if ((oldUrl.indexOf(top.strContextPath) == 0) || (oldUrl.indexOf("/"+top.strContextPath) == 0) || (oldUrl.indexOf("http://") == 0) || (oldUrl.indexOf("https://") == 0)) {
	 
	 } else if (top.strContextPath != undefined){
	 		oldUrl = top.strContextPath + "/" + oldUrl;
	 } else if (opener != undefined && opener.top.strContextPath != undefined){
	 		oldUrl = opener.top.strContextPath + "/" +  oldUrl;
	 } else if (opener != undefined && opener.opener.top.strContextPath != undefined){
	 		oldUrl = opener.opener.top.strContextPath + "/" +  oldUrl;
	 } else if (opener != undefined && opener.top.win != undefined && opener.top.win.top.strContextPath != undefined){
	 		oldUrl = opener.top.win.top.strContextPath + "/" +  oldUrl;
	 }
	 
	if (oldUrl.indexOf('[') == -1 || oldUrl.indexOf(']') == -1) {
		newUrl = oldUrl;
		return newUrl;
	} else {
		if (oldUrl.indexOf('?') != -1) {
			newUrl = oldUrl.substring(0,oldUrl.indexOf('?')+1);
			if ((oldUrl.indexOf('?')+1) < oldUrl.length) {
				paraUrl = oldUrl.substring(oldUrl.indexOf('?')+1,oldUrl.length);
			}
		} else if (oldUrl.indexOf('&') != -1) {
			newUrl = oldUrl.substring(0,oldUrl.indexOf('&')+1);
			if ((oldUrl.indexOf('&')+1) < oldUrl.length) {
				paraUrl = oldUrl.substring(oldUrl.indexOf('&')+1,oldUrl.length);
			}
		} else {
			newUrl = oldUrl;
			return newUrl;
		}
				
		var para = paraUrl.split('&');
		var paraName='';
		var paraValue='';
		var tempValue='';
		for (var i=0;i<para.length;i++) {
			if (para[i].indexOf('=[') == -1 || para[i].indexOf(']') == -1) {
				newUrl = newUrl + '&' + para[i];
				continue;
			}
			
			paraName = para[i].substring(0,para[i].indexOf('=')+1);
			paraValue = para[i].substring(para[i].indexOf('[')+1,para[i].indexOf(']'));
			tempValue = '';
			if (paraName =='=' || paraValue =='') {
				newUrl = newUrl + '&' + para[i];
				continue;
			}
			
			if (top.getPropertyValue != undefined) {//��ҳ��
				if (top.strInteractionId == strInteractionID) {
					tempValue = top.contactUtils.getValueByKey(top.strAttacheData,paraValue);
				} 
				if (tempValue == '') {
					tempValue = top.getPropertyValue(paraValue);
				}
				paraValue = tempValue;
			} else if (top.win != undefined && top.win.top.getPropertyValue != undefined) {//��ҳ�浯��ģ̬����
				paraValue = top.win.top.getPropertyValue(paraValue);
			} else if (opener != undefined && opener.top.getPropertyValue != undefined) {//��ҳ�浯����ͨ����
				paraValue = opener.top.getPropertyValue(paraValue);
			} else if (opener != undefined && opener.opener.top.getPropertyValue != undefined) {//��ҳ�浯����ͨ����
				paraValue = opener.opener.top.getPropertyValue(paraValue);
			} else if (opener != undefined && opener.top.win != undefined && opener.top.win.top.getPropertyValue != undefined) {//һ��ģ̬���ڵ�����ͨ����
				paraValue = opener.top.win.top.getPropertyValue(paraValue);
			} else {//����
				
			}
			
			if (window.encodeURIComponent) {
				paraValue = window.encodeURIComponent(paraValue);
			}
			
			if (newUrl.substring(newUrl.length-1,newUrl.length) != '?' && newUrl.substring(newUrl.length-1,newUrl.length) != '&') {
				newUrl = newUrl + '&';
			}
			newUrl = newUrl +paraName+paraValue;
		}
		return newUrl;
	}
}