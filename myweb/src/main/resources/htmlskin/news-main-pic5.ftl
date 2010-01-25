<style type="text/css"> 
<!--
.blk_01{border:0px solid #bdd2ed;text-align:center;margin-left:-9px;margin-top:40px}
.blk_01 #FlashFocusImg{border:0px solid #fff;padding:0px 0;}
#FlashFocusImg object{display:block;margin:0 auto;}
-->
</style> 
<script type="text/javascript" src="./scripts/picflash.js"></script>
<div class="blk_01">
		<div id="FlashFocusImg" class="c_s_01">	<a href="" target="_blank"><img height="176" width="306"  src=""/></a></div>
		<script type="text/javascript">
		<!--//--><![CDATA[//><!--

		var focus_width=237
		var focus_height=197
		var text_height=0
		var bgcolor="#ffffff";
		var swf_height = focus_height+text_height
		var curhref=document.location.href;

		var pics= '';
		var links= '';
		var texts= '';
		//var pics='./news/423195999_summ.jpg|http://i2.sinaimg.cn/cj/U1985P31T623D1F16779DT20100124113323.jpg|http://i3.sinaimg.cn/cj/U2860P31T623D1F16782DT20100125074815.jpg|http://i0.sinaimg.cn/cj/U3975P31T623D1F16788DT20100122230030.jpg'
		//var links='http://finance.sina.com.cn/roll/20100125/02087300577.shtml|http://finance.sina.com.cn/china/hgjj/20100124/07427299073.shtml|http://finance.sina.com.cn/stock/s/20100125/06167301308.shtml|http://finance.sina.com.cn/money/future/ds2010/index.shtml'
		//var texts='�Ϳ˳����ɴ���ȼӰ�|���Ƴ¹���4316��Ǯɽ����|ħ��ST��˾��ժ�����ñ�� �ݲ����Ϸ|ȫ����ָ��������������ʽ24�վ���'

	<#list newsList.result as news>
	pics += './${news.picPath}/${news.picName}|';
	links += './${news.htmlPath}/${news.htmlName}|';
	texts += '${news.title}|';
     </#list>
     pics = pics.substring(0, pics.length -1);
     links = pics.substring(0, pics.length -1);
     texts = pics.substring(0, pics.length -1);
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