<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	
	<script type='text/javascript' src='/StatService/dwr/interface/PhoneQueueDWR.js'></script>
	<script type='text/javascript' src='/StatService/dwr/engine.js'></script>
	<script type='text/javascript' src='/StatService/dwr/util.js'></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/Agent/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/script/jquery.marquee.js"></script>
	<link type="text/css" href="<%=request.getContextPath()%>/css/docs.css" rel="stylesheet" media="all" />
	<link type="text/css" href="<%=request.getContextPath()%>/css/jquery.marquee.css" rel="stylesheet" title="default" media="all" />
	
	<style type="text/css">
		h4, h5 {
			margin-bottom: 0;
		}
		
		.examples pre {
			margin-top: 0;
		}
		
		.marquee .author {
			display: none;
		}
		
		.marquee-author {
			float: left; 
			width: 90px; 
			text-align: right; 
			padding: 4px 5px 1px 0;
		}
	</style>

	<script type="text/javascript">
	<!--//
	var use_debug = false;

	function debug(){
		if( use_debug && window.console && window.console.log ) console.log(arguments);
	}

	// on DOM ready
	$(document).ready(function (){
		$(".marquee").marquee({
			loop: -1
			// this callback runs when the marquee is initialized
			, init: function ($marquee, options){
				debug("init", arguments);

				// shows how we can change the options at runtime
				if( $marquee.is("#marquee2") ) options.yScroll = "bottom";
			}
			// this callback runs before a marquee is shown
			, beforeshow: function ($marquee, $li){
				debug("beforeshow", arguments);

				// check to see if we have an author in the message (used in #marquee6)
				var $author = $li.find(".author");
				// move author from the item marquee-author layer and then fade it in
				if( $author.length ){
					$("#marquee-author").html("<span style='display:none;'>" + $author.html() + "</span>").find("> span").fadeIn(850);
				}
			}
			// this callback runs when a has fully scrolled into view (from either top or bottom)
			, show: function (){
				debug("show", arguments);
			}
			// this callback runs when a after message has being shown
			, aftershow: function ($marquee, $li){
				debug("aftershow", arguments);

				// find the author
				var $author = $li.find(".author");
				// hide the author
				if( $author.length ) $("#marquee-author").find("> span").fadeOut(250);
			}
		});
	});
	
	
	function addMessage(selector, msg){
		// append a new message to the marquee scrolling list
		var $ul = $(selector).append("<li>" + msg + "</li>");
		// update the marquee
		$ul.marquee("update");
	}
	
	function pause(selector){
		$(selector).marquee('pause');
	}
	
	function resume(selector){
		$(selector).marquee('resume');
	}
	
	var SkillGroup = new Array();
	var SkillGroupId = new Array();
	
	var strSkillGroupId = "";
	var strSkillGroupName = "";
	
	var oldQueueStr = "";
	
	var COLOR_5 = "#00CC00";
	var COLOR_10 = "orange";
	var COLOR_WARNING = "red";
	var oldColor = "";
	
	var test = 0;

	function callback(jsonStr) {
		
		var queueStr = "";
				
		if(jsonStr!=null && jsonStr.length>0) {
		
			//For TEST
			//jsonStr = "[[\"1\",\"08:00\"],[\"0\",\"00:00\"],[\"0\",\"00:00\"]]";
			/*
			if(test/5<1) {
				jsonStr = "[[\"0\",\"00:00\"],[\"0\",\"00:00\"],[\"0\",\"00:00\"]]";
			} else if(test/5<2) {
				jsonStr = "[[\"1\",\"03:12\"],[\"0\",\"00:00\"],[\"0\",\"00:00\"]]";
			} else if(test/5<3) {	
				jsonStr = "[[\"1\",\"05:12\"],[\"0\",\"00:00\"],[\"0\",\"00:00\"]]";
			} else if(test/5<4) {
				jsonStr = "[[\"1\",\"10:12\"],[\"0\",\"00:00\"],[\"0\",\"00:00\"]]";
			} else if(test/5<5) {			
				jsonStr = "[[\"0\",\"00:00\"],[\"2\",\"03:40\"],[\"0\",\"00:00\"]]";
			} else if(test/5<6) {
				jsonStr = "[[\"1\",\"03:12\"],[\"3\",\"05:40\"],[\"2\",\"03:07\"]]";
			} else if(test/5<7) {
				jsonStr = "[[\"1\",\"03:12\"],[\"5\",\"05:40\"],[\"2\",\"03:07\"]]";
			} else if(test/5<8) {
				jsonStr = "[[\"1\",\"03:12\"],[\"5\",\"05:40\"],[\"2\",\"13:07\"]]";	
			} else if(test/5<9) {
				jsonStr = "[[\"1\",\"03:12\"],[\"5\",\"05:40\"],[\"5\",\"13:07\"]]";		
			} else if(test/5<10) {			
				jsonStr = "[[\"1\",\"03:12\"],[\"0\",\"00:00\"],[\"2\",\"13:07\"]]";							
			} else if(test/5<11) {
				jsonStr = "[[\"1\",\"03:12\"],[\"0\",\"00:00\"],[\"2\",\"03:07\"]]";		
			} else if(test/5<12) {
				jsonStr = "[[\"0\",\"00:00\"],[\"0\",\"00:00\"],[\"2\",\"05:07\"]]";										
			} else if(test/5<13) {
				jsonStr = "[[\"0\",\"00:00\"],[\"0\",\"00:00\"],[\"1\",\"03:07\"]]";					
			}
			
			test+=1;
			*/
			
			var queueObject = eval('(' + jsonStr + ')');
												
			var WaitingNum = 0;
						
			var queueGroupIdStr = "";
			var waitTimeStr = "00:00";
			var waitMinute = 0;
			var showColor = COLOR_5;
			
			var marqueeStrArray = new Array();
			var marqueeWaitArray = new Array();
			
			for(var i=0; i<queueObject.length; i++) {
				
				queueStr += queueObject[i][0]+ ";";
				
				if(queueObject[i][0]!="" && queueObject[i][0]!="0") {
					WaitingNum += parseInt(queueObject[i][0]);
					queueGroupIdStr += SkillGroup[i].lid + ";" ;
					waitTimeStr = queueObject[i][1];
					
					var waitMinute = waitTimeStr.substring(0,2);
					if(waitMinute.substring(0,1)=="0")
						waitMinute = waitMinute.substring(1,2)
						
					var waitMinute_tmp = parseInt(waitMinute);
					if(waitMinute_tmp>waitMinute)
						waitMinute = waitMinute_tmp;	
						
					marqueeStrArray[marqueeStrArray.length] = "<font size=4>" + SkillGroup[i].name + "&nbsp;" + queueObject[i][0] + "</font>&nbsp;(<span id='span_" + SkillGroup[i].id + "'>" + queueObject[i][1] + "</span>)";				
					marqueeWaitArray[marqueeWaitArray.length] = parseInt(queueObject[i][0]);
				}
			}			
			
			if(marqueeWaitArray.length>1) {
				for(var i=marqueeWaitArray.length; i>1; i--) {
					for(var j=0; j<i; j++) {
						if(marqueeWaitArray[j]<marqueeWaitArray[j+1]) {
							var tempWait = marqueeWaitArray[j+1];
							marqueeWaitArray[j+1] = marqueeWaitArray[j];
							marqueeWaitArray[j] = tempWait;
							
							var tempStr = marqueeStrArray[j+1];
							marqueeStrArray[j+1] = marqueeStrArray[j];
							marqueeStrArray[j] = tempStr;
						}
					}
				}
			}
			
			parent.strQueue.style.display="block";
			
			if(WaitingNum>10 || waitMinute>=10) {
				showColor = COLOR_WARNING;
			} else if(WaitingNum>5 || waitMinute>=5) {
				showColor = COLOR_10;
			} else {
				showColor = COLOR_5;		
			}
			
			parent.spanQueueSize.style.color = showColor;
			waitTimeSpan.style.color = showColor;
										
			if(queueStr!=oldQueueStr || oldColor!=showColor) {
				oldColor = showColor;
				oldQueueStr = queueStr;
				
				parent.spanQueueSize.innerText = WaitingNum;
				
				if(queueGroupIdStr=="" || queueGroupIdStr==strSkillGroupId+";") {
					marquee1.style.display = "none";
					mainTable.style.display = "";																
					waitTimeSpan.innerText = waitTimeStr;				
				} else {
					mainTable.style.display = "none";
					marquee1.style.display = "";
									
					marqueeStr = "";
					for(var i=0; i<marqueeStrArray.length; i++) {
						marqueeStr += "&nbsp;&nbsp;&nbsp;&nbsp;" + marqueeStrArray[i];
					}
					
					marquee1.innerHTML = "";					
					addMessage(marquee1, "<li><font color='" + showColor + "'>" + marqueeStr + "</font></li>")
				}
				
			} else {
				
				if(queueGroupIdStr==strSkillGroupId+";") {
					marquee1.style.display = "none";
					mainTable.style.display = "";					
					
					waitTimeSpan.innerText = waitTimeStr;						
					
				} else {
					
					for(var i=0; i<queueObject.length; i++) {			
						if(queueObject[i][0]!="" && queueObject[i][0]!="0") {
							var span_ = eval("span_" + SkillGroup[i].id);
							if(span_&&span_!=undefined) {
								span_.innerText = queueObject[i][1];
							}
						}
					}
				}	
			}

			
			
		} else {
			alert("XXX");
		}
		
		oldQueueStr = queueStr;
		
		setTimeout('PhoneQueueDWR.phoneQueue(SkillGroupId, callback);', 2000);
	}
	
	function startGetPhoneQueue(SkillGroup_) {
		SkillGroup = SkillGroup_;
		
		for(var i=0; i<SkillGroup.length; i++) {
			SkillGroupId[i] = SkillGroup[i].id;
		}		
		
		strSkillGroupId = getCookie("strSkillGroupId");
		strSkillGroupName = top.strSkillGroupName;
		
		PhoneQueueDWR.phoneQueue(SkillGroupId, callback);				
	}
	
	function resize() {
		marquee1.style.width = parseInt(document.body.clientWidth);
	}
	
	function getCookie(Key){
	var search = Key + "=";
	begin = document.cookie.indexOf(search);
	if (begin != -1) {
	   begin += search.length;
	   end = document.cookie.indexOf(";",begin);
	   if (end == -1) end = document.cookie.length;
	   return document.cookie.substring(begin,end);
	}
}
	
	window.onresize = resize;
	//-->
	</script>
</head>

<body onload="resize();" bgcolor="#000000">
<iframe style="display:none; width:0px; height:0px" src="<%=request.getContextPath()%>/jsp/main/personalInfo.jsp" frameborder="0"></iframe>
<table id="mainTable" style="position:absolute; display:none; top:-1px; left:5px; width:100%; height:100%" width=100%>
	<tr>
		<td>
			<font size=4><span id="waitTimeSpan" style="color:green"></span></font>
		</td>
	</tr>
</table>
<ul id="marquee1" class="marquee" style="position:absolute; display:none; top:-1px; left:0px; width:100%; height:100%"><li></li></ul>
</body>
</html>
