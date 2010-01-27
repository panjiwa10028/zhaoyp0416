<style type="text/css"> 
<!--
.blk_01{border:0px solid #bdd2ed;text-align:center;margin-left:-7px;margin-top:44px}
.blk_01 #FlashFocusImg{border:0px solid #fff;padding:0px 0;}
#FlashFocusImg object{display:block;margin:0 auto;}
-->
</style> 
<script type="text/javascript" src="./scripts/picflash.js"></script>
<div class="blk_01">
		<div id="FlashFocusImg" class="c_s_01">	<a href="" target="_blank"><img height="176" width="306"  src=""/></a></div>
		<script type="text/javascript">
		<!--//--><![CDATA[//><!--

		var focus_width=233
		var focus_height=177
		var text_height=0
		var bgcolor="#ffffff";
		var swf_height = focus_height+text_height
		var curhref=document.location.href;

		var pics= '';
		var links= '';
		var texts= '';
	
	<#list newsList.result as news>
	pics += './${news.picPath}/${news.picName}|';
	links += './${news.htmlPath}/${news.htmlName}|';
	texts += '${news.title}|';
     </#list>
     pics = pics.substring(0, pics.length -1);
     links = links.substring(0, pics.length -1);
     texts = texts.substring(0, pics.length -1);
		var FocusFlash = new picFlash("./scripts/focus.swf", "focusflash", focus_width, swf_height, "7", bgcolor, false, "High");
		FocusFlash.addParam("allowScriptAccess", "sameDomain");
		FocusFlash.addParam("menu", "false");
		FocusFlash.addParam("wmode", "opaque");

		FocusFlash.addVariable("pics", pics);
		FocusFlash.addVariable("links", links);
		FocusFlash.addVariable("texts", texts);
		FocusFlash.addVariable("borderwidth", focus_width);
		FocusFlash.addVariable("borderheight", focus_height);
		FocusFlash.addVariable("textheight", text_height);
		FocusFlash.addVariable("curhref", curhref);
		FocusFlash.write("FlashFocusImg");

		//--><!]]>
		</script>
</div>