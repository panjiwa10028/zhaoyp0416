//2007-03-21 evan

function ig_r(a,b){
		var c=function(){};
		c.prototype=a.prototype;
		b.prototype=new c
}

function _gel(a){
	return document.getElementById?document.getElementById(a):null
}

function _gelstn(a){
	if(a=="*"&&document.all)
	return document.all;return document.getElementsByTagName?document.getElementsByTagName(a):[]
}

function _uc(a){
	return a.toUpperCase()
}

function _trim(a){
	return a.replace(/^\s*|\s*$/g,"")
}

function _esc(a){
	return window.encodeURIComponent?encodeURIComponent(a):escape(a)
}

var ig_pb=function(a){
	return window.decodeURIComponent?decodeURIComponent(a):unescape(a)
}
,_unesc=ig_pb;
function _toggle(a){
	if(a.style.display==""||a.style.display=="block"){
		a.style.display="none"
	}
	else if(a.style.display=="none"){
		a.style.display="block"
	}
}

function _hesc(a){
	a=a.replace(/</g,"&lt;").replace(/>/g,"&gt;");
	a=a.replace(/"/g,"&quot;").replace(/'/g,"&#39;");return a
}

function _striptags(a){
	return a.replace(/<\/?[^>]+>/gi,"")
}

var ig_ob=0;

function _uid(){
	return"obj"+ig_ob++
}

function _min(a,b){
	return a<b?a:b
}

function _max(a,b){
	return a>b?a:b
}

function _editedTabName(){
	return _gel("tab"+_cet+"_title").value
}
	
function _IG_LoadScript(a,b){
	_sendx(a,function(c){window.eval(c);eval(b)},false,null)
}
var ig_hb=navigator.userAgent.indexOf("Safari")>=0;

function _sendx(a,b,c,d){
	var e=ig_qb();
	if(!d)d=null;
	if(!e||ig_hb&&!b){
		(new Image).src=a
		}
	else{
	e.open(d?"POST":"GET",a,true);
		if(b){
			e.onreadystatechange=function(){
				if(e.readyState==4){
					b(c&&e.responseXML?e.responseXML:e.responseText)
					}
				}
			}
			//e.send(d)
		}
}
			
function _uhc(a,b,c){var d="m_"+a+"_"+b,e=_gel(d);if(!e){e=document.createElement("INPUT");e.type="hidden";e.disabled=true;e.name=d;_gel("m_"+a+"_form").appendChild(e)}e.value=c;e.disabled=false}

function ig_qb(){var a=null;if(window.ActiveXObject){a=new ActiveXObject("Msxml2.XMLHTTP");if(!a){a=new ActiveXObject("Microsoft.XMLHTTP")}}else if(window.XMLHttpRequest){a=new XMLHttpRequest}return a}var _et="",_source="",_pid="",_authpath="",_prefid="",_setp_url="/ig/setp",ig_bb="/ig/game",_old_html=true,ig_k=null,ig_l=null;

function ig_d(a,b,c){var d=document.createElement("input");d.type="hidden";d.name=b;d.value=c;a.appendChild(d)}

function _args(){var a={},b=document.location.search.substring(1),c=b.split("&");for(var d=0;d<c.length;d++){var e=c[d].indexOf("=");if(e==-1)continue;var f=c[d].substring(0,e),g=c[d].substring(e+1);g=g.replace(/\+/g," ");a[f]=_unesc(g)}return a}

function ig_g(){var a={pid:1,host:1,hl:1},b=_args(),c="?";for(var d in b){if(a[d]){c+=d+"="+_esc(b[d])+"&"}}return c}

function _submit_form(a,b){a.action=_setp_url+ig_g()+b;a.method="get";ig_d(a,"url",document.location);ig_d(a,"et",_et);ig_d(a,"source",_source);ig_d(a,"pid",_pid);ig_d(a,"ap",_authpath);ig_d(a,"prefid",_prefid);a.submit()}

function _fsetp(a,b,c){a.action=_setp_url;a.method="get";ig_d(a,"url",document.location);ig_d(a,"et",_et);ig_d(a,"source",_source);ig_d(a,"pid",_pid);ig_d(a,"ap",_authpath);ig_d(a,"prefid",_prefid);ig_d(a,"m_"+b+"_t",c);var d=_args(),e=d["host"],f=d["hl"];if(typeof e!="undefined"){ig_d(a,"host",e)}if(typeof f!="undefined"){ig_d(a,"hl",f)}return true}var ig_s=[],ig_t=false;

function ig_K(){if(ig_s.length==0){ig_t=false;return}ig_t=true;var a=_setp_url+ig_g()+"et="+_et+"&pid="+_pid+"&ap="+_authpath+"&source="+_source+"&prefid="+_prefid,b=ig_s.shift(),c=a.length+b.length>=1800;if(c){_sendx(a,ig_L,false,b)}else{a+="&"+b;_sendx(a,ig_L,false,null)}}

function ig_L(){_IG_TriggerDelayedEvent("xsetpdone");ig_K()}

function _xsetp(a){ig_s.push(a);if(!ig_t){ig_K()}}

function _dlsetp(a,b){if(!b){b=_esc(document.location)}document.location=_setp_url+ig_g()+"et="+_et+"&source="+_source+"&pid="+_pid+"&ap="+_authpath+"&prefid="+_prefid+"&url="+b+"&"+a}

function _dlgame(a,b,c){if(!c){c=_esc(document.location)}document.location=ig_bb+ig_g()+"et="+_et+"&game="+a+"&url="+c+"&"+b}

function _ssbc(a,b,c){var d=_gelstn("*");for(var e=0;e<d.length;e++){if(d[e].className==a){d[e].style[b]=c}}}

function ig_ib(a){var b=_gelstn("*");for(var c=0;c<b.length;c++){for(var d=0;d<a.length;d++){if(b[c].className==a[d][0]){b[c].style[a[d][1]]=a[d][2]}}}}

function _edit(a,b){_gel("m_"+a).className="modbox_e";if(b){b()}ig_i("edit","m_"+a);return false}

function _cedit(a){_gel("m_"+a).className="modbox";var b=_gel("m_"+a+"_form");b.reset();ig_i("canceledit","m_"+a);return false}

function _del(a,b,c){_xsetp("m_"+a+"_enab=0&m_"+a+"_t="+b);var d=_gel("undel_msg");if(d){_gel("undel_title").innerHTML=_striptags(_gel("m_"+a+"_h").innerHTML)+" ";d.style.display="block";var e=_gel("undo_msg");if(e){e.style.display="none"}}var f=_gel("m_"+a);if(f){f.style.display="none"}ig_k=a;ig_l=c;var g=_gel(c);if(g){g.style.display=""}_mod=true;ig_i("delete",
"m_"+a);return false}

function _delpromobox(){_xsetp("hp=0");var a=_gel("promobox");a.parentNode.removeChild(a);return false}

function _delmessage(){_xsetp("gm=0");var a=_gel("googlemessage");a.parentNode.removeChild(a);return false}

function _delpromomod(){_xsetp("pm=0");var a=_gel("promomod");a.parentNode.removeChild(a);return false}

function _undel(){if(ig_k==null)return;var a="m_"+ig_k,b=_gel(a);if(b){b.style.display="block";_xsetp("undel")}var c=_gel("undel_msg");if(c){c.style.display="none"}if(ig_l!=
null){var d=_gel(ig_l);if(d){d.style.display="none"}}ig_k=null;ig_l=null;ig_i("undelete",a)}

function _zm(a,b){var c=_gel("m_"+a+"_b");if(c){var d=c.style.display!="none";c.style.display=d?"none":"block";var e=_gel("m_"+a+"_zippy");if(e){if(d){e.className=e.className.replace(/minbox/,"maxbox")}else{e.className=e.className.replace(/maxbox/,"minbox")}}_xsetp("mz="+a+":"+(d?"1":"0")+"&t="+b);ig_i(d?"zip":"unzip",a)}return false}var ig_ab="https://www.google.com/accounts";

function _enableGS(a,b){a.action=ig_ab+"/CheckCookie";a.method="get";ig_d(a,"service",b);ig_d(a,"continue",document.location);ig_d(a,"skipvpage",true);return true}

function _reload(a){var b=a-(new Date).getTime();if(b>1000){setTimeout("_reload("+a+")",b);return}document.cookie="IGREL=1";document.location.reload()}

function ig_i(a,b){switch(a){case "delete":case "undelete":case "edit":case "canceledit":case "zip":case "unzip":_IG_TriggerDelayedModuleEvent(b,a);_IG_TriggerDelayedEvent("module"+a,b);break}}

function ig_mb(a){_xsetp("pnlo="+(a?1:0))}var _uli,_pnlo,_mpnlo,_pl,_mod,_cbp=false,ig_H=false,ig_I=false,_table=null,_tabs=null,_insert_to_col=1;function _upc(){var a=[];if(!_cbp){a[a.length]=["medit","display",_uli?"":"none"]}a[a.length]=["panelo","display",_pnlo?"":"none"];a[a.length]=["panelc","display",_pnlo?"none":""];if(_mod){a[a.length]=["unmod","display","none"];a[a.length]=["mod","display",""]}else{a[a.length]=["mod","display","none"];a[a.length]=["unmod","display",""]}ig_ib(a);if(_pl){if(_cbp||_uli){if(!ig_H&&!_mpnlo){_IG_initDrag(_table,
_tabs);ig_H=true}else if(!ig_I&&_mpnlo){_IG_initMobileDrag(_table);ig_I=true}}}}var ig_h=0;function _tp(a){if(ig_h>0)clearInterval(ig_h);_pnlo=a;_mod=true;ig_mb(a);_upc();var b=_gel("cpnl"),c=_gel("cpnlc"),d=_gel("nhdr"),e=_gel("ehdr"),f=b.offsetWidth,g,h;if(a){g=c.offsetWidth;h="visible";e.style.display="";d.style.display="none"}else{g=1;h="hidden";e.style.display="none";d.style.display=""}b.style.overflow="hidden";var i=100,j=10,l=0;ig_h=setInterval(function(){var k=l/j,m=f+(g-f)*k;b.style.width=
m+"px";l++;if(k>=1){clearInterval(ig_h);ig_h=0;b.style.width=g+"px";b.style.overflow=h}},i/j);return false}

function _ts(a,b){var c=_gel(a+b),d;if(c.className=="mlist_open"){c.className="mlist_closed";d="pnlsc"}else{c.className="mlist_open";d="pnlso"}_xsetp(d+"="+_esc(b));return false}

function _add_m(a,b){_dlsetp(a+_esc("&col="+_insert_to_col),b)}

function _add_m_confirm(a,b,c){if(confirm(b)){_add_m(a,c)}}

function _add_f(a){_add_m("n_25="+_esc("url="+_esc(a)))}var ig_B=/^_add_m(_confirm)?\(\"[^"]+\"(, *\"[^"]+\")?\)$/;


function _find_feed(a){var b="acd";if(!a){var c=_gelstn("div");if(c){for(var d=0;d<c.length;d++){if(c[d].id&&c[d].id.indexOf("ps")==0&&c[d].className=="mlist_open"){_ts("ps",c[d].id.substring(2))}}}if(_gel("add_custom")){a=_gel("add_custom").value}}if(!a||a==""){b="advdsrch";a=_gel("add_advd").value}var e=_gel("ffresults");if(e){e.style.display="none"}var f=_gel("ffloading");if(f){f.style.display="block"}_sendx("/ig/feeds"+ig_g()+"q="+_esc(a)+"&page="+_esc(b),ig_$a,false,null);return false}

function ig_$a(a){var b=_gel("ffloading");if(b){b.style.display="none"}var c=_gel("ffresults");if(c){c.style.display="block"}if(a.length>0&&a.charAt(0)=="<"){c.innerHTML=a}else if(a.match(ig_B)!=null){eval(a)}else{eval(a)}}

function _add_remote_module(a,b){_sendx("/ig/feeds"+ig_g()+"module=1&q="+_esc(a),function(c){b();ig_2a(c)},false,null);return false}

function ig_2a(a){var b=/^alert\(\"[^"]+\"\)$/;if(a.match(ig_B)!=null||a.match(b)!=null){eval(a)}}var _cet=-1;function _editTab(a){if(_cet!=-1)return;_renameTab();_cet=a;
_gel("tab"+_cet+"_view").style.display="none";_gel("tab"+_cet+"_edit").style.display="";_gel("tab"+_cet+"_title").select();_gel("tab"+_cet+"_title").focus()}

function _renameTab(){if(_cet==-1)return;var a=_editedTabName();_xsetp("rt_"+_cet+"="+_esc(a));_gel("tab"+_cet+"_view_title").innerHTML=_hesc(a);var b=_gel("tip_tabtitle");if(b){b.innerHTML=_hesc(a)}_gel("tab"+_cet+"_edit").style.display="none";_gel("tab"+_cet+"_view").style.display="";_cet=-1;return false}

function _ListApp(a,b,c){this.items=
a;this.deleted=[];this.item_constructor=b;this.module_id=c;this.app_name="m_"+c+"_App";this.display_area=_gel("m_"+c+"_disp");this.value_input_field=_gel("m_"+c+"_val");this.name_input_field=_gel("m_"+c+"_name");if(!this.name_input_field){this.name_input_field=this.value_input_field}if(this.name_input_field){this.default_name=this.name_input_field.value;this.default_value=this.value_input_field.value}this.prev_items=[].concat(this.items)}_ListApp.prototype.reset=function(){this.items=[].concat(this.prev_items);
this.refresh()};_ListApp.prototype.sort=function(a,b){return a.I(b)};_ListApp.prototype.bb=function(){var a="";if(_old_html){a="<table cellspacing=0 cellpadding=0 border=0>"}var b="",c=this.items;for(var d=0;d<c.length;d++){if(!c[d]){this.items.splice(d,1);d--}else{if(_old_html){a+="<tr><td nowrap><font size=-1>"+c[d].R()+'</font></td><td><a  style="CURSOR:hand"  onclick="'+this.app_name+".del("+d+')"><img src="/ig/images/x.gif" width=16 height=13 border=0></a></td></tr>'}else{a+='<a  style="CURSOR:hand"  onclick="'+this.app_name+
".del("+d+')" class="delbox"style="float:left;margin:1px 3px 0px 0px;"></a>'+c[d].R()+"<br>"}if(parseInt(c[d]._uid)<0){b+=c[d].F(d)}}}var e=this.deleted,f="";for(var d=0;d<e.length;d++){if(parseInt(e[d]._uid)>=0){f+=","+e[d]._uid}}a+=this.sa(b,f);return a};_ListApp.prototype.sa=function(a,b){var c="<input type=hidden name=m_"+this.module_id+'_add value="'+a+'"><input type=hidden name=m_'+this.module_id+'_del value="'+b+'">';if(_old_html){c="</table><input type=hidden name=m_"+this.module_id+'_add value="'+
a+'"><input type=hidden name=m_'+this.module_id+'_del value="'+b+'">'}return c};_ListApp.prototype.refresh=function(){this.items.sort(this.sort);this.display_area.innerHTML="<font size=-1>"+this.bb()+"</font>"};_ListApp.prototype.add=function(a,b){if(!a){a=_trim(this.name_input_field.value)}if(!b){b=_trim(this.value_input_field.value)}var c=new this.item_constructor(a,b,-1);if(!c.V())return;this.items[this.items.length]=c;this.refresh();this.name_input_field.value=this.default_name;this.value_input_field.value=
this.default_value};_ListApp.prototype.del=function(a){this.deleted[this.deleted.length]=this.items[a];this.items.splice(a,1);this.refresh()};

function _PrefListApp(a,b,c,d,e){var f=typeof c=="string"?[]:c,g=new _ListApp(f,d,e);for(var h in g){this[h]=g[h]}if(typeof c=="string"){this.ab(c)}this.prefidx=a;this.prefname=b;this.app_name="m_"+e+"_"+a+"_App";this.display_area=_gel("m_"+e+"_"+a+"_disp");this.value_input_field=_gel("m_"+e+"_"+a+"_val");this.name_input_field=this.value_input_field;this.default_name=
"";this.default_value="";this.sa=_PrefListApp_get_tail}

function _PrefListApp_get_tail(a,b){var c="</table>";_gel("m_"+this.module_id+"_"+this.prefidx).value=this.eb();return c}_PrefListApp.prototype.ab=function(a){if(a.length==0){return}var b=_IG_Prefs._strToArray(a),c=[];for(var d=0;d<b.length;d++){var e=new this.item_constructor(b[d],b[d],-1);c[c.length]=e}this.items=c;this.prev_items=[].concat(c)};_PrefListApp.prototype.eb=function(){var a=[];for(var b=0;b<this.items.length;b++){a[a.length]=this.items[b]._v}return _IG_Prefs._arrayToStr(a)};


function _ListItem(a,b,c){this._n=a;this._v=b;this._uid=c}_ListItem.prototype.V=function(){return this._n!=""};_ListItem.prototype.I=function(a){return 0};_ListItem.prototype.R=function(){return _hesc(this._n)};_ListItem.prototype.F=function(a){return"&"+_esc(this._n)+"="+_esc(this._v)};

function _BMListItem(a,b,c){_ListItem.call(this,a,b,c)}ig_r(_ListItem,_BMListItem);_BMListItem.prototype.V=function(){return _ListItem.prototype.V.call(this)&&this._n!="http://"};_BMListItem.prototype.P=function(){if(this._v){return this._v}else{var a=
this._n;if(a.indexOf("http://")==0){a=a.substring(7)}if(a.indexOf("www.")==0){a=a.substring(4)}return a}};_BMListItem.prototype.R=function(){return'<a href="'+this._n+'" target=bmwindow>'+_hesc(this.P())+"</a>"};_BMListItem.prototype.F=function(a){return"&b"+a+"="+_esc(this._n)+"&t"+a+"="+_esc(this._v)};_BMListItem.prototype.I=function(a){var b=_uc(this.P()),c=_uc(a.P());if(b==c)return 0;return b<c?-1:1};

function _WthrListItem(a,b,c){_ListItem.call(this,a,b,c)}ig_r(_ListItem,_WthrListItem);_WthrListItem.prototype.F=function(a){var b="&"+_esc(this._n);if(this._v){b+="="+_esc(this._v)}return b};

function _FListItem(a,b,c,d){_ListItem.call(this,a,b,c);this._s=d||0}ig_r(_ListItem,_FListItem);_FListItem.prototype.F=function(a){return"&"+_esc(this._n)};_FListItem.prototype.I=function(a){var b=this;if(b._s<a._s)return-1;if(b._s>a._s)return 1;var c=_uc(b._n),d=_uc(a._n);if(c<d)return-1;if(c>d)return 1;return 0};var ig_b={N:0,za:1800,X:null,W:null,da:function(){ig_b.N=(new Date).getTime()+ig_b.za*1000},$a:function(){if((new Date).getTime()>
ig_b.N){_reload(ig_b.N)}},Z:function(a){ig_b.da();if(ig_b.X){ig_b.X(a)}},Y:function(a){ig_b.da();if(ig_b.W){ig_b.W(a)}}};

function _IG_start_refresh_cycle(a,b){ig_b.X=document.onmousedown;ig_b.W=document.onkeyup;ig_b.za=a;if(document.addEventListener){document.addEventListener("keyup",ig_b.Y,false);document.addEventListener("mousedown",ig_b.Z,false)}else if(document.attachEvent){document.attachEvent("onkeyup",ig_b.Y);document.attachEvent("onmousedown",ig_b.Z)}else{document.onkeyup=ig_b.Y;document.onmousedown=
ig_b.Z}ig_b.da();setInterval(ig_b.$a,b*1000)}

function _IG_GetImageUrl(a){var b="/ig/proxy?url="+_esc(a);return _et!=""?b+"&et="+_et:b}

function _IG_GetImage(a){var b=new Image;b.src=_IG_GetImageUrl(a);return b}

function _mailWindow(a){window.open(a,"mailwindow","width=400,height=340,left=50,top=50,scrollbars=no")}

function _findPos(a){var b=0,c=0;while(a!=null){b+=a.offsetLeft;c+=a.offsetTop;a=a.offsetParent}return[b,c]};var ig_n=0,ig_4a="span",ig_D=false,ig_J=false,ig_j={PROCESSING:0,COMPLETED:1};

function _InstallAC(a,b,c,d,e){var f=new _AutoCompleteObj(document,a,b,c,d,e);return f}

function _AutoCompleteObj(a,b,c,d,e,f){this.srcdocument=a;this.submitMode="";this.previousFormValue="";this.skipNextRequest=false;this.userInput="";this.lastUserInput="";this.lastUserKey="";this.selectedItemIndex=-1;this.selectedItemDiv=null;this.completionItemsSize=-1;this.completionItems=null;this.numCompletionsFound=5;this.documentTitle=
"";this.rowTagName="div";this.completeDiv=null;this.completeIFrame=null;this.urlFrameName=null;this.fillInField=null;this.skipNextBlur=false;this.addEventHandler=null;this.removeEventHandler=null;this.completionCache={};this.completeLeftBorder=1;this.completeTopBorder=1;this.alwaysChooseFirst=false;this.requireExactEntry=false;this.windowLastKeyCode=-1;this.requestStartTime=(new Date).getTime();this.xmlHttpRequestSupported=false;this.xmlHttpRequest=null;this.requestURI=null;this.requestPath=null;
this.lastFieldValue=null;this.nonWesternLang=false;this.displayWidth=60;this.hideDisplay=null;this.lastCjkFixSelectionVal=null;this.lastCjkFixSelectionLoc1=null;this.lastCjkFixSelectionLoc2=null;this.fixedBrokenCJKInput=false;this.documentFieldFocused=false;this.wholeSuggestionList=null;this.maxSuggLength=30;this.documentForm=b;this.documentField=c;this.submitButton=d;this.iframeLoaded=false;this.requestPath=e;this.divFiltered=false;this.lastKeyDown="";var g="zh|zh-CN|zh-TW|ja|ko|";if(!f||f.length<
1){f="en"}this.requestLanguage=ig_7a(f);if(g.indexOf(this.requestLanguage+"|")==-1){this.fillInField=true;this.requireExactEntry=false;this.alwaysChooseFirst=false;this.nonWesternLang=false}else{this.fillInField=false;this.requireExactEntry=true;if(this.requestLanguage.indexOf("zh")==0){this.alwaysChooseFirst=false}this.nonWesternLang=true}this.hideDisplay=false;this.submitMode="query";this.urlFrameName=null;setTimeout("_idfn('"+this.documentField.id+"')",10);this.Wa()}_AutoCompleteObj.prototype.qa=
function(){this.skipNextBlur=true;this.documentField.blur();setTimeout("_sfi('"+this.documentField.id+"');",10)};_AutoCompleteObj.prototype.ra=function(){if(navigator&&navigator.userAgent.toLowerCase().indexOf("msie")==-1){return this.documentField.offsetWidth-this.completeLeftBorder*2}else{return this.documentField.offsetWidth}};_AutoCompleteObj.prototype.Wa=function(){this.requestURI=this.requestPath;this.documentField.autocomplete="off";this.documentField.onfocus=function(){var a=this.acObject;
if(a){a.documentFieldFocused=true}};this.documentField.onblur=function(){var a=this.acObject;if(a){a.documentFieldFocused=false;if(!a.skipNextBlur){a.z();if(a.windowLastKeyCode==9){a.windowLastKeyCode=-1}}a.skipNextBlur=false}};if(!this.documentForm.acObject){this.documentForm.acObject=[];this.documentForm.prevOnSubmit=this.documentForm.onsubmit;this.documentForm.onsubmit=function(a){var b=false;for(var c=0;c<this.acObject.length;c++){if(this.acObject[c].lastKeyDown==13&&this.acObject[c].completeDiv.style.visibility==
"visible"){b=true}this.acObject[c].z()}if(b){return false}if(this.prevOnSubmit){return this.prevOnSubmit(a)}else{return true}}}this.documentForm.acObject[this.documentForm.acObject.length]=this;if(this.documentField.createTextRange){this.documentField.onkeydown=new Function("return _okdh(event); ");this.documentField.onkeyup=new Function("return _okuh(event); ")}else{this.documentField.onkeydown=_okdh;this.documentField.onkeyup=_okuh}this.documentField.acObject=this;if(typeof window.acObjects=="undefined"){window.acObjects=
[]}window.acObjects[window.acObjects.length]=this;if(!window.suggestionCache){window.suggestionCache={}}this.userInput=this.documentField.value;this.previousFormValue=this.userInput;this.completeDiv=this.srcdocument.createElement("DIV");this.completeDiv.id="completeDiv_"+this.documentField.id;this.completeLeftBorder=1;this.completeTopBorder=1;this.completeDiv.style.borderRight="black "+this.completeLeftBorder+"px solid";this.completeDiv.style.borderLeft="black "+this.completeLeftBorder+"px solid";
this.completeDiv.style.borderTop="black "+this.completeTopBorder+"px solid";this.completeDiv.style.borderBottom="black "+this.completeTopBorder+"px solid";this.completeDiv.style.zIndex="2";this.completeDiv.style.paddingRight="0";this.completeDiv.style.paddingLeft="0";this.completeDiv.style.paddingTop="0";this.completeDiv.style.paddingBottom="0";this.completeDiv.style.visibility="hidden";this.completeDiv.style.position="absolute";this.completeDiv.style.backgroundColor="white";this.completeIFrame=this.srcdocument.createElement("IFRAME");
this.completeIFrame.id="completeIFrame_"+this.documentField.id;this.completeIFrame.style.zIndex="1";this.completeIFrame.style.position="absolute";this.completeIFrame.style.display="block";this.completeIFrame.style.visibility="hidden";this.completeIFrame.style.borderRightWidth="0";this.completeIFrame.style.borderLeftWidth="0";this.completeIFrame.style.borderTopWidth="0";this.completeIFrame.style.borderBottomWidth="0";this.completeIFrame.src=this.requestURI;this.completeIFrame.scrolling="no";this.ca();
this.Va(this.completeDiv);if(!ig_J){_IG_AddEventHandler("resize",function(){if(!window.acObjects){return}for(var a=0;a<window.acObjects.length;a++){var b=window.acObjects[a];b.ca()}});ig_J=true}if(this.nonWesternLang){setTimeout("idkc('"+this.documentField.id+"')",10)}};_AutoCompleteObj.prototype._fetchSuggestionList=function(){if(this.wholeSuggestionList){return}var a=false;if(!window.suggestionCache[this.requestURI]){window.suggestionCache[this.requestURI]={};window.suggestionCache[this.requestURI].state=
ig_j.PROCESSING;window.suggestionCache[this.requestURI].pending=[];window.suggestionCache[this.requestURI].pending[this.documentField.id]=true;a=true}else if(window.suggestionCache[this.requestURI].state==ig_j.COMPLETED){var b=window.suggestionCache[this.requestURI].content,c=this.documentField.id;setTimeout(function(){_initSuggList(b,c,true)},10);a=false}else if(window.suggestionCache[this.requestURI].state==ig_j.PROCESSING){if(window.suggestionCache[this.requestURI].pending[this.documentField.id]){a=
true}else{window.suggestionCache[this.requestURI].pending[this.documentField.id]=true;a=false}}if(a){_IG_FetchContent(this.requestURI,_IG_Callback(_initSuggList,this.requestURI,false),null)}};var _initSuggList=function(a,b,c){if(a.charAt(0)=="<"){ig_n--}else{if(c){_gel(b).acObject._initSuggestionList(a)}else{window.suggestionCache[b].content=a;window.suggestionCache[b].state=ig_j.COMPLETED;for(var d in window.suggestionCache[b].pending){if(window.suggestionCache[b].pending[d]){_gel(d).acObject._initSuggestionList(a);
window.suggestionCache[b].pending[d]=false}}}}};_AutoCompleteObj.prototype.ca=function(){if(this.completeDiv){this.completeDiv.style.left=_getElementOffsetLeft(this.documentField)+"px";this.completeDiv.style.top=_getElementOffsetTop(this.documentField)+this.documentField.offsetHeight-1+"px";this.completeDiv.style.width=this.ra()+"px";if(this.completeIFrame){this.completeIFrame.style.left=this.completeDiv.style.left;this.completeIFrame.style.top=this.completeDiv.style.top;this.completeIFrame.style.width=
this.completeDiv.style.width;this.completeIFrame.style.height=this.completeDiv.style.height}}};

function ig_E(a){var b=null;if(a){try{b=a.target.acObject}catch(c){b=a.srcElement.acObject}}return b}

function _okdh(a){var b=ig_E(a);b.lastKeyDown=a.keyCode}var _okuh=function(a){var b=ig_E(a);if(!b.fixedBrokenCJKInput){b.fixedBrokenCJKInput=true}b.lastUserKey=a.keyCode;b.lastFieldValue=b.documentField.value;b.onkeyevent()},_sfi=function(a){_gel(a).focus()};function ig_nb(a){for(var b=0,c="",d="\n\r";b<
a.length;b++){if(d.indexOf(a.charAt(b))==-1){c+=a.charAt(b)}else{c+=" "}}return c}

function ig_F(a,b){var c=a.getElementsByTagName(ig_4a);if(c){for(var d=0;d<c.length;++d){if(c[d].className==b){var e=c[d].innerHTML;if(e=="&nbsp;"){return""}else{var f=ig_nb(e);return f}}}}else{return""}}

function ig_m(a){if(!a){return null}return ig_F(a,"cAutoComplete")}

function ig_q(a){if(!a){return null}return ig_F(a,"dAutoComplete")}_AutoCompleteObj.prototype.z=function(){this.completeDiv.style.visibility="hidden";
this.completeIFrame.style.visibility="hidden"};_AutoCompleteObj.prototype.ya=function(){if(!this.divFiltered){return}this.completeDiv.style.visibility="visible";this.completeIFrame.style.visibility="visible";this.ca()};_AutoCompleteObj.prototype.Ca=function(a,b,c,d){this.completionCache[a]=new Array(b,c,d)};_AutoCompleteObj.prototype.B=function(a,b,c,d,e){if(!this.iframeLoaded){this.srcdocument.body.appendChild(this.completeDiv);this.srcdocument.body.appendChild(this.completeIFrame);this.iframeLoaded=
true}if(ig_n>0){ig_n--}if(!a){a=this.completeDiv}this.Ca(b,c,d,e);this.completeDiv.completeStrings=c;this.completeDiv.displayStrings=d;this.completeDiv.prefixStrings=e;this.Ja(this.completeDiv,this.completeDiv.completeStrings,this.completeDiv.displayStrings);this.ta(this.completeDiv,ig_m);if(this.numCompletionsFound>0){this.completeDiv.height=16*this.numCompletionsFound+4;this.completeIFrame.height=this.completeDiv.height-4}else{this.z()}};_AutoCompleteObj.prototype.onkeyevent=function(){if(this.lastUserKey==
40||this.lastUserKey==38){this.qa()}if(this.lastUserKey==16){return}var a=_GetSelectionLength(this.documentField),b=_GetBegSelection(this.documentField),c=this.documentField.value;if(this.fillInField&&this.lastUserKey!=0){if(a>0&&b!=-1){this.userInputTemp=c.substring(0,b)}if(this.lastUserKey==13||this.lastUserKey==3){var d=this.documentField;if(d.createTextRange){var e=d.createTextRange();e.moveStart("character",d.value.length);e.select()}else if(d.setSelectionRange){d.setSelectionRange(d.value.length,
d.value.length)}}else{if(this.documentField.value!=c){this.w(c)}}}this.userInput=c;if(this.Ia(this.lastUserKey)&&this.lastUserKey!=0){this.ta(this.completeDiv,ig_m)}};

function ig_7a(a){if(encodeURIComponent){return encodeURIComponent(a)}if(escape){return escape(a)}}

function ig_eb(a){var b=100;for(var c=1;c<=(a-2)/2;c++){b=b*2}b=b+50;return b}var _idfn=function(a){var b=_gel(a).acObject;b.srcdocument=document;if(b.previousFormValue!=b.userInput&&b.userInput.length>0){if(!b.skipNextRequest){var c=b.completionCache[b.userInput];
if(c){b.requestStartTime=-1;b.B(b.completeDiv,b.userInput,c[0],c[1],b.completeDiv.prefixStrings)}else{b.Oa(b.completeDiv,b.userInput,b.wholeSuggestionList)}b.documentField.focus()}b.skipNextRequest=false}b.previousFormValue=b.userInput;setTimeout("_idfn('"+a+"')",ig_eb(ig_n));return true};_AutoCompleteObj.prototype.Oa=function(a,b,c){var d=false,e=0,f=c[0].length,g;while(!d&&f>e){g=e+Math.floor((f-e)/2);var h=c[0][g].substr(0,b.length).toLowerCase(),i=g==0?null:c[0][g-1].substr(0,b.length).toLowerCase();
if(h==b.toLowerCase()&&(g==0||i<b.toLowerCase())){d=true}else{if(h<b.toLowerCase()){if(e==g){break}e=g}else{f=g}}}if(d){this.divFiltered=true;var j;for(j=g;j<c[0].length&&c[0][j].substr(0,b.length).toLowerCase()==b.toLowerCase()&&j-g<=this.maxSuggLength;j++){}if(j-g>this.maxSuggLength){this.B(a,"",[],[],[])}else{this.B(a,b,c[0].slice(g,j),c[1].slice(g,j),new Array(""))}}else{this.B(a,"",[],[],[])}};var ig_jb=function(){this.acObj.w(ig_m(this));this.acObj.documentTitle=ig_q(this);this.acObj.skipNextRequest=
true},ig_lb=function(){if(this.acObj.selectedItemDiv){this.acObj.d(this.acObj.selectedItemDiv,"aAutoComplete")}this.acObj.d(this,"bAutoComplete")},ig_kb=function(a){this.acObj.d(this,"aAutoComplete")};_AutoCompleteObj.prototype._initSuggestionList=function(a){var b=a.split(/[\r\n]+/g),c=[],d=[];for(var e=0;e<b.length;e++){var f=b[e].split(/\t/g);b[e]=f[0];c[c.length]="";d[d.length]=f.length>1?f[1]:""}this.wholeSuggestionList=new Array(b,c,d)};_AutoCompleteObj.prototype.ba=function(a){this.userInput=
this.lastUserInput;this.w(this.lastUserInput);this.documentTitle=this.lastUserInput;if(!this.completionItems||this.completionItemsSize<=0){return}this.ya();if(a>=this.completionItemsSize){a=this.completionItemsSize-1}if(this.selectedItemIndex!=-1&&a!=this.selectedItemIndex){this.d(this.selectedItemDiv,"aAutoComplete");this.selectedItemIndex=-1}if(a<0){this.selectedItemIndex=-1;this.documentField.focus();return}this.selectedItemIndex=a;this.selectedItemDiv=this.completionItems.item(a);this.d(this.selectedItemDiv,
"bAutoComplete");this.userInput=this.lastUserInput;this.documentTitle=ig_q(this.selectedItemDiv);this.w(ig_m(this.selectedItemDiv))};_AutoCompleteObj.prototype.Ia=function(a){if(a==40){this.ba(this.selectedItemIndex+1);return false}else if(a==38){this.ba(this.selectedItemIndex-1);return false}else if(a==13||a==3){return false}return true};_AutoCompleteObj.prototype.ta=function(a,b){var c=this.documentField,d=false;this.selectedItemIndex=-1;var e=a.getElementsByTagName(this.rowTagName),f=e.length;
this.completionItemsSize=f;this.completionItems=e;this.numCompletionsFound=f;this.lastUserInput=this.userInput;if(this.userInput==""||f==0||this.lastKeyDown==13){this.lastKeyDown=0;this.z()}else{this.ya()}var g="";if(this.userInput.length>0){var h,i;for(var h=0;h<f;h++){for(i=0;i<a.prefixStrings.length;i++){var j=a.prefixStrings[i]+this.userInput;if(this.alwaysChooseFirst||!this.requireExactEntry&&b(e.item(h)).toUpperCase().indexOf(j.toUpperCase())==0||this.requireExactEntry&&h==0&&b(e.item(h)).toUpperCase()==
j.toUpperCase()){g=a.prefixStrings[i];d=true;break}}if(d){break}}}if(d){this.selectedItemIndex=h}for(var h=0;h<f;h++)this.d(e.item(h),"aAutoComplete");if(d){this.selectedItemDiv=e.item(this.selectedItemIndex);this.documentTitle=ig_q(this.selectedItemDiv)}else{this.documentTitle=this.userInput;this.selectedItemIndex=-1;this.selectedItemDiv=null}var l=false;switch(this.lastUserKey){case 8:case 33:case 34:case 35:case 35:case 36:case 37:case 39:case 45:case 46:l=true;break;default:break}if(!l&&this.selectedItemDiv){var k=
this.userInput;this.d(this.selectedItemDiv,"bAutoComplete");var m;if(d){m=b(this.selectedItemDiv).substr(a.prefixStrings[i].length)}else{m=k}if(m!=c.value){if(c.value!=this.userInput){return}if(this.fillInField){if(c.createTextRange||c.setSelectionRange){this.w(m)}if(c.createTextRange){var n=c.createTextRange();n.moveStart("character",k.length);n.select()}else if(c.setSelectionRange){c.setSelectionRange(k.length,c.value.length)}}}}else{this.selectedItemIndex=-1;this.documentTitle=this.userInput}};


function _getElementOffsetLeft(a){return _getElementValueRecursive(a,"offsetLeft")}

function _getElementOffsetTop(a){return _getElementValueRecursive(a,"offsetTop")}

function _getElementValueRecursive(a,b){var c=0;while(a){c+=a[b];a=a.offsetParent}return c}_AutoCompleteObj.prototype.ib=function(){var a=this.srcdocument.body.scrollWidth-220;a=0.73*a;this.documentField.size=Math.floor(a/6.18)};function _GetSelectionLength(a){var b=-1;if(a.setSelectionRange){b=a.selectionEnd-a.selectionStart}return b}
function _GetBegSelection(a){var b=0;if(a.setSelectionRange){b=a.selectionStart}else{b=-1}return b}_AutoCompleteObj.prototype.d=function(a,b){this.ma();a.className=b;if(ig_D){return}switch(b.charAt(0)){case "m":a.style.fontSize="13px";a.style.fontFamily="arial,sans-serif";a.style.wordWrap="break-word";break;case "l":a.style.display="block";a.style.paddingLeft="3";a.style.paddingRight="3";a.style.height="16px";a.style.overflow="hidden";break;case "a":a.style.backgroundColor="white";a.style.color="black";
if(a.displaySpan){a.displaySpan.style.color="green"}break;case "b":a.style.backgroundColor="#3366cc";a.style.color="white";if(a.displaySpan){a.displaySpan.style.color="white"}break;case "c":a.style.width=this.displayWidth+"%";a.style.cssFloat="left";break;case "d":a.style.cssFloat="right";a.style.width=100-this.displayWidth+"%";if(this.submitMode=="query"){a.style.fontSize="10px";a.style.textAlign="right";a.style.color="green";a.style.paddingTop="3px"}else{a.style.color="#696969"}break}};_AutoCompleteObj.prototype.ma=


function(){this.displayWidth=65;if(this.submitMode=="query"){var a=110,b=this.ra(),c=(b-a)/b*100;this.displayWidth=c;this.displayWidth=100}else{this.displayWidth=65}if(this.hideDisplay){this.displayWidth=99.99}};_AutoCompleteObj.prototype.Va=function(a){this.ma();var b="font-size: 13px; font-family: arial,sans-serif; word-wrap:break-word;",c="display: block; padding-left: 3; padding-right: 3; height: 16px; overflow: hidden;",d="background-color: white;",e="background-color: #3366cc; color: white ! important;",
f="display: block; margin-left: 0%; width: "+this.displayWidth+"%; float: left;",g="display: block; margin-left: "+this.displayWidth+"%;";if(this.submitMode=="query"){g+="font-size: 10px; text-align: right; color: green; padding-top: 3px;"}else{g+="color: #696969;"}ig_e(".mAutoComplete",b);ig_e(".lAutoComplete",c);ig_e(".aAutoComplete *",d);ig_e(".bAutoComplete *",e);ig_e(".cAutoComplete",f);ig_e(".dAutoComplete",g);this.d(a,"mAutoComplete")};_AutoCompleteObj.prototype.Ja=function(a,b,c){while(a.childNodes.length>
0)a.removeChild(a.childNodes[0]);for(var d=0;d<b.length;++d){var e=this.srcdocument.createElement("DIV");e.acObj=this;e.onmousedown=ig_jb;e.onmouseover=ig_lb;e.onmouseout=ig_kb;this.d(e,"aAutoComplete");var f=this.srcdocument.createElement("SPAN");this.d(f,"lAutoComplete");var g=this.srcdocument.createElement("SPAN");g.innerHTML=b[d];var h=this.srcdocument.createElement("SPAN");this.d(h,"dAutoComplete");this.d(g,"cAutoComplete");e.displaySpan=h;if(!this.hideDisplay){h.innerHTML=c[d]}f.appendChild(g);
f.appendChild(h);e.appendChild(f);a.appendChild(e)}};

function ig_e(a,b){if(ig_D){var c=document.styleSheets[0];if(c.addRule){c.addRule(a,b)}else if(c.insertRule){c.insertRule(a+" { "+b+" }",c.cssRules.length)}}}_AutoCompleteObj.prototype.w=function(a){this.documentField.value=a;this.lastFieldValue=a};_AutoCompleteObj.prototype.kb=function(){var a=this.documentField.value,b=_GetBegSelection(this.documentField),c=_GetSelectionLength(this.documentField);return b==this.lastCjkFixSelectionLoc1&&c==this.lastCjkFixSelectionLoc2&&
a==this.lastCjkFixSelectionVal};_AutoCompleteObj.prototype.lb=function(){this.lastCjkFixSelectionVal=this.documentField.value;this.lastCjkFixSelectionLoc1=_GetBegSelection(this.documentField);this.lastCjkFixSelectionLoc2=_GetSelectionLength(this.documentField)};_AutoCompleteObj.prototype.jb=function(){this.qa();this.ba(this.selectedItemIndex+1)};_AutoCompleteObj.prototype._getDataOfValue=function(a){var b=false,c=this.wholeSuggestionList,d;if(c[0]){var e=0,f=c[0].length;while(!b&&f>e){d=e+Math.floor((f-
e)/2);var g=c[0][d].toLowerCase();if(g==a.toLowerCase()){b=true}else{if(g<a.toLowerCase()){if(e==d){break}e=d}else{f=d}}}}if(b){return c[2][d]}else{return null}};function _IG_Callback(a,b,c,d,e,f){var g=arguments;return function(){var h=[];for(var i=0;i<arguments.length;i++){h[h.length]=arguments[i]}for(var i=1;i<g.length;i++){h[h.length]=g[i]}a.apply(null,h)}};var ig_wa={domload:1,xsetpdone:1,moduledragstart:1,moduledragend:1,moduletitleclick:1,moduleedit:1,modulecanceledit:1,moduledelete:1,moduleundelete:1,modulezip:1,moduleunzip:1,load:1,unload:1,resize:1},ig_xa={dragstart:1,dragend:1,titleclick:1,edit:1,canceledit:1,"delete":1,undelete:1,zip:1,unzip:1};function ig_pa(a){var b="ig_event_hashcode_";if(a.hasOwnProperty&&a.hasOwnProperty(b)){return a[b]}if(!a[b]){a[b]=++ig_a.Ua}return a[b]}function ig_ma(a){return"builtin_"+a}function ig_na(a,b){if(a.indexOf&&
a.indexOf("m_")==0){a=a.substring(2)}return"builtin_m"+a+"_"+b}

function ig_la(a,b){return"builtin_"+ig_a.Qa(a)+"_"+b}

function ig_ka(a){return"custom_"+a}

function ig_oa(){for(var a in ig_a.b){for(var b=0;b<ig_a.b[a].length;b++){ig_a.b[a][b]=null}if(a in ig_a.y){var c=ig_a.y[a],d=c[0],e=c[1],f=c[2];if(d.removeEventListener){d.removeEventListener(e,f,false)}else if(d.detachEvent){d.detachEvent("on"+e,f)}ig_a.y[a]=null}}}

function ig_qa(a,b,c){for(var d=c;d<b.length;d++){a[a.length]=b[d]}return a}function ig_ua(a,b){if(a in ig_a.b){for(var c=0;c<ig_a.b[a].length;c++){if(ig_a.b[a][c]===b){ig_a.b[a][c]=null;return true}}}return false}

function ig_Da(a,b){if(a in ig_a.b){for(var c=0;c<ig_a.b[a].length;c++){if(ig_a.b[a][c]){var d=[];for(var e=1;e<arguments.length;e++){d[d.length]=arguments[e]}ig_a.b[a][c].apply(this,d)}}}}

function ig_ia(a,b){if(!(a in ig_a.fb)){throw Error("Unsupported event type: "+a);}var c=ig_a.K(a);if(!(c in ig_a.b)){ig_a.b[c]=[]}ig_a.b[c][ig_a.b[c].length]=b}

function ig_ja(a,b,c){if(!(b in ig_a.gb)){throw Error("Unsupported module event type: "+b);}var d=ig_a.L(a,b);if(!(d in ig_a.b)){ig_a.b[d]=[]}ig_a.b[d][ig_a.b[d].length]=c}

function ig_ha(a,b,c){var d=ig_a.oa(a,b);if(!(d in ig_a.b)){ig_a.b[d]=[];var e=function(g){if(!g)g=window.event;ig_a.D.apply(a,[d,g])};if(a.addEventListener){a.addEventListener(b,e,false)}else if(a.attachEvent){a.attachEvent("on"+b,e)}else{throw Error("Object {"+a+"} does not support DOM events.");}ig_a.y[d]=[a,b,e]}var f=ig_a.b[d].length;if(a===window&&b=="unload"&&
f>0){ig_a.b[d][f]=ig_a.b[d][f-1];ig_a.b[d][f-1]=c}else{ig_a.b[d][f]=c}}

function ig_ga(a,b){var c=ig_a.J(a);if(!(c in ig_a.b)){ig_a.b[c]=[]}ig_a.b[c][ig_a.b[c].length]=b}

function ig_ta(a,b){var c=ig_a.K(a);return ig_a.A(c,b)

}function ig_va(a,b,c){var d=ig_a.L(a,b);return ig_a.A(d,c)}

function ig_sa(a,b,c){var d=ig_a.oa(a,b);return ig_a.A(d,c)}

function ig_ra(a,b){var c=ig_a.J(a);return ig_a.A(c,b)}

function ig_Ca(a,b){var c=ig_a.t([ig_a.K(a)],arguments,1);ig_a.D.apply(window,c)}

function ig_Aa(a,b){var c=ig_a.t([],arguments,0);setTimeout(function(){ig_a.triggerEvent.apply(window,c)},0)}

function ig_Ea(a,b,c){var d=ig_a.t([ig_a.L(a,b)],arguments,2);ig_a.D.apply(window,d)}

function ig_Ba(a,b,c){var d=ig_a.t([],arguments,0);setTimeout(function(){ig_a.triggerModuleEvent.apply(window,d)},0)}

function ig_ya(a,b){var c=ig_a.t([ig_a.J(a)],arguments,1);ig_a.D.apply(window,c)}

function ig_za(a,b){var c=ig_a.t([],arguments,0);setTimeout(function(){ig_a.triggerCustomEvent.apply(window,c)},0)}var ig_a={Ua:0,b:{},
y:{},fb:ig_wa,gb:ig_xa,Qa:ig_pa,K:ig_ma,L:ig_na,oa:ig_la,J:ig_ka,La:ig_oa,t:ig_qa,A:ig_ua,D:ig_Da,addEventHandler:ig_ia,addModuleEventHandler:ig_ja,addDOMEventHandler:ig_ha,addCustomEventHandler:ig_ga,removeEventHandler:ig_ta,removeModuleEventHandler:ig_va,removeDOMEventHandler:ig_sa,removeCustomEventHandler:ig_ra,triggerEvent:ig_Ca,triggerModuleEvent:ig_Ea,triggerCustomEvent:ig_ya,triggerDelayedEvent:ig_Aa,triggerDelayedModuleEvent:ig_Ba,triggerDelayedCustomEvent:ig_za},_IG_AddEventHandler=ig_a.addEventHandler,
_IG_AddModuleEventHandler=ig_a.addModuleEventHandler,_IG_AddDOMEventHandler=ig_a.addDOMEventHandler,_IG_AddCustomEventHandler=ig_a.addCustomEventHandler,_IG_RemoveEventHandler=ig_a.removeEventHandler,_IG_RemoveModuleEventHandler=ig_a.removeModuleEventHandler,_IG_RemoveDOMEventHandler=ig_a.removeDOMEventHandler,_IG_RemoveCustomEventHandler=ig_a.removeCustomEventHandler,_IG_TriggerEvent=ig_a.triggerEvent,_IG_TriggerModuleEvent=ig_a.triggerModuleEvent,_IG_TriggerCustomEvent=ig_a.triggerCustomEvent,_IG_TriggerDelayedEvent=
ig_a.triggerDelayedEvent,_IG_TriggerDelayedModuleEvent=ig_a.triggerDelayedModuleEvent,_IG_TriggerDelayedCustomEvent=ig_a.triggerDelayedCustomEvent;_IG_AddDOMEventHandler(window,"unload",ig_a.La);_IG_AddDOMEventHandler(window,"load",function(){_IG_TriggerEvent("load")});_IG_AddDOMEventHandler(window,"unload",function(){_IG_TriggerEvent("unload")});_IG_AddDOMEventHandler(window,"resize",function(){_IG_TriggerEvent("resize")});

function _IG_RegisterOnloadHandler(a){_IG_AddEventHandler("domload",a)}

function _IG_LoadLibraryDeferred(a,b){_IG_RegisterOnloadHandler(function(){_IG_LoadScript(a,b)})};var _IG_time={times:{epoch:(new Date).getTime()},set_epoch:function(a){_IG_time.times["epoch"]=a},epoch:function(){return _IG_time.times["epoch"]},start:function(a){_IG_time.times[a]=(new Date).getTime()},stop:function(a){var b=_IG_time.times[a]?_IG_time.times[a]:_IG_time.epoch();_IG_time.times[a]=(new Date).getTime()-b},get:function(a){return _IG_time.times[a]},print:function(a){document.write("<div style='color:#999999;font-size:75%'>"+a+" : "+_IG_time.get(a)+"ms</div>")},stop_and_print:function(a){_IG_time.stop(a);
_IG_time.print(a)}};if(window._IG_time_epoch){_IG_time.set_epoch(window._IG_time_epoch)};

function ig_Ta(a){var b="",c=this.Q(a,b);return c!=null?c+"":b}

function ig_Ma(a){var b=0,c=parseInt(this.Q(a,b));return isNaN(c)?b:c}

function ig_Ka(a){return this.getInt(a)?true:false}

function ig_Ja(a){return _IG_Prefs._strToArray(this.Q(a,""))}

function ig_Ya(a,b){this.set(a,_IG_Prefs._arrayToStr(b))}

function ig_Oa(){return parseInt(this.s(_IG_Prefs.Aa,"0"))}

function ig_Pa(){return parseInt(this.s(_IG_Prefs.Ba,"0"))}

function ig_Na(){return this.getString(".lang")}

function ig_La(){return this.getString(".country")}


function ig_Ua(a,b){return this.s(_IG_Prefs.H+a,b)}

function ig_Qa(a){return this.s(_IG_Prefs.G+a,"")}var ig_Wa=/(.*)(\<ph.*?\>\s*(\<ex\>(.*?)\<\/ex\>)?\s*%1\s*\<\/ph\>)(.*)/;

function ig_Ra(a,b){var c=this.s(_IG_Prefs.G+a,""),d=c.match(this.Za);if(!d||!d[0]){return c}if(!b){var e=d[4]||"";return d[1]+e+d[5]}return d[1]+b+d[5]}

function ig_Xa(){var a=Math.floor(arguments.length/2),b=[];for(var c=0;c<a;c++){var d=arguments[c*2],e=arguments[c*2+1];if(_IG_Prefs.S){b.push("m_"+this.Ya+"_up_"+d+"="+_esc(e))}else{b.push(d,
e)}this.h[_IG_Prefs.H+d]=e}if(_IG_Prefs.S){_xsetp(b.join("&"))}else{if(_args()["synd"]=="open"){return}_IFPC_SetPref(b)}}

function ig_Va(a,b){if(typeof b=="undefined"){b=null}var c=this.h[a];return typeof c!="undefined"?c:b}

function ig_Ia(){document.write("<pre>");for(var a in this.h){document.writeln(a+" = "+this.s(a,null))}document.write("</pre>")}

function ig_Sa(){var a=[];for(var b in this.h){a.push(encodeURIComponent(b)+"="+encodeURIComponent(this.h[b]))}return a.join("&")}

function _IG_Prefs(a){this.getString=
ig_Ta;this.getInt=ig_Ma;this.getBool=ig_Ka;this.getArray=ig_Ja;this.setArray=ig_Ya;this.getCountry=ig_La;this.getLang=ig_Na;this.getMsg=ig_Qa;this.getMsgFormatted=ig_Ra;this.set=ig_Xa;this.getPreloadedString=ig_Sa;this.dump=ig_Ia;if(typeof a=="undefined"){var b=_args()["mid"];if(b){a=b}else{a=0}_IG_Prefs._parseURL(a)}this.getModuleHeight=ig_Oa;this.getModuleWidth=ig_Pa;this.h=_IG_Prefs.h[_IG_Prefs.ia+a]||{};this.s=ig_Va;this.Q=ig_Ua;this.Ya=a;this.Za=ig_Wa}_IG_Prefs.Aa="h";_IG_Prefs.Ba="w";_IG_Prefs.ia=
"m_";_IG_Prefs.H="up_";_IG_Prefs.G="msg_";_IG_Prefs._parseURL=function(a){_IG_Prefs.S=false;var b=window.location.search.substring(1).split("&");for(var c=0;c<b.length;c++){var d=b[c].indexOf("=");if(d==-1)continue;var e=b[c].substring(0,d);e=e.replace(/\+/g," ");var f=b[c].substring(d+1);f=f.replace(/\+/g," ");f=_unesc(f);if(e.indexOf(_IG_Prefs.H)==0||e.indexOf(_IG_Prefs.G)==0){_IG_Prefs._add(a,e,f)}}};_IG_Prefs._add=function(a,b,c){var d=_IG_Prefs.ia+a;if(typeof _IG_Prefs.h[d]!="object"){_IG_Prefs.h[d]=
{}}_IG_Prefs.h[d][b]=c};_IG_Prefs._arrayToStr=function(a){var b=a.length&&a.join;if(b){var c=[];for(var d=0;d<a.length;d++){c.push(a[d].replace(/\|/g,"%7C"))}return c.join("|")}else{return new String(a)}};_IG_Prefs._strToArray=function(a){var b=a.length>0?a.split("|"):[];for(var c=0;c<b.length;c++){b[c]=b[c].replace(/%7C/g,"|")}return b};_IG_Prefs.h={};_IG_Prefs.S=true;function _IG_FR_toggle(a,b){var c=_gel("ft_"+a+"_"+b),d=_gel("fb_"+a+"_"+b),e=_gel("ftl_"+a+"_"+b);if(d.style.display=="block"){ig_z(c,d,e)}else{var f=eval("FEED"+a);if(!f.has_entries&&!f.is_fetching){f.is_fetching=true;_IG_FetchFeedAsJSON(f.url,_IG_Callback(ig_Ha,a,b),f.num_items+15,true)}else{for(var g=0;g<eval("FEED"+a).num_items;g++){var h=_gel("ftl_"+a+"_"+g);if(h){ig_z(_gel("ft_"+a+"_"+g),_gel("fb_"+a+"_"+g),h)}}if(d.style.height!=300&&ig_Fa(e.offsetWidth,d)>300){d.style.height=300}ig_Ga(c,
d,e)}}}

function ig_Ha(a,b,c){var d=eval("FEED"+b);d.is_fetching=false;if(a&&a.Entry){for(var e=0;e<a.Entry.length;e++){if(a.Entry[e].ID!="no_id"){var f=_gel("fb_"+b+"_"+a.Entry[e].ID);if(f){f.innerHTML=a.Entry[e].Summary}}}eval("FEED"+b).has_entries=true;_IG_FR_toggle(b,c)}}function ig_z(a,b,c){a.className="fmaxbox";if(_old_html){a.className="fbox fmaxbox"}b.style.display="none";c.className="uftl"}

function ig_Ga(a,b,c){a.className="fminbox";if(_old_html){a.className="fbox fminbox"}b.style.display="block";c.className="sftl"}

function ig_Fa(a,b){var c=document.createElement("div");c.style.left=-screen.width;c.style.top=-screen.height;c.style.width=a;c.innerHTML=b.innerHTML;document.body.appendChild(c);var d=c.clientHeight;document.body.removeChild(c);return d};var ig_o;function _IG_DD_init(){document.write("<div id=IG_DD_div></div>")}function _IG_DD_create(a,b){var c=document.createElement("div");c.setAttribute("id","DD_"+a);c.onblur=_IG_DD_hide;c.className="dd dd_border";c.style.display="none";var d="";for(var e=0;e<b.length;e++){d+=ig_fa(b[e][0],b[e][1],b[e][2])}c.innerHTML=d;_gel("IG_DD_div").appendChild(c)}

function ig_fa(a,b,c){if(b==""){b="javascript:void(0)"}var d="<div class=dd_item onclick='_IG_DD_hide();"+c+";'><a href='"+b+"'>"+a+"</a></div>";return d}

function _IG_DD_open(a,b){var c=_gel("DD_"+b),d=_gel("DD_tg_"+b),e=_gel("IG_DD_div");if(c.style.display=="none"){var f=_findPos(d);c.style.display="block";var g=c.offsetWidth;c.style.left=f[0]+d.offsetWidth/2-g/2+"px";c.style.top=f[1]+d.offsetHeight+"px";ig_o=b;e.className="dd_layer";e.onclick=_IG_DD_hide;e.style.height=document.body.clientHeight+document.body.scrollTop+"px";e.style.width=document.body.clientWidth+document.body.scrollLeft+"px"}}

function _IG_DD_hide(){if(ig_o){var a=_gel("DD_"+
ig_o);a.style.display="none"}var b=_gel("IG_DD_div");b.className="";b.style.height="";b.style.width="";b.onclick=""};

function ig_w(a){if(!a.post_data&&!a.headers&&window._pl_data&&_pl_data[a.url]){if(a.asXml){var b;if(window.ActiveXObject){b=new ActiveXObject("Microsoft.XMLDOM");b.async=false;b.loadXML(_pl_data[a.url])}else{var c=new DOMParser;b=c.parseFromString(_pl_data[a.url],"text/xml")}a.callback(b)}else{a.callback(_pl_data[a.url])}}var d="/ig/proxy?url="+escape(a.url);if(_et!=""){d+="&et="+_et}if(a.encoding){d+="&enc="+escape(a.encoding)}if(a.headers){var e=[];for(var f=0;f<a.headers.length;f++){e.push(_esc(a.headers[f][0]+
": "+a.headers[f][1]))}d+="&hdrs="+_esc(e.join(","))}_sendx(d,a.callback,a.asXml,a.post_data)}

function ig_A(a){var b={};for(var c in a){b[c]=a[c]}return b}

function _IG_FetchContent(a,b,c){var d;d=c!=null&&typeof c=="object"?ig_A(c):{};d.url=a;d.callback=b;d.asXml=false;ig_w(d)}

function _IG_FetchXmlContent(a,b,c){var d;d=c!=null&&typeof c=="object"?ig_A(c):{};d.url=a;d.callback=b;d.asXml=true;ig_w(d)}

function ig_x(a,b){var c="/ig/feedjson";_sendx(c,function(d){var e={};try{e=eval("("+d+")")}catch(f){e=
{}}for(var g in b){var h=e[g]?e[g]:null;b[g](h)}e=null;b=null},false,a)}var ig_C=false,ig_9a=0,ig_f="",ig_p={};

function _IG_FetchFeedAsJSON(a,b,c,d){var e="fr_"+ig_9a++,f="url="+_esc(a);if(c){f+="&val="+_esc(c)}if(d){f+="&sum=1"}var g=e+"="+_esc(f);if(ig_C){var h={};h[e]=b;ig_x(g,h)}else{if(ig_f!="")ig_f+="&";ig_f+=g;ig_p[e]=b}}

function ig_0a(){ig_C=true;if(ig_f!=""){ig_x(ig_f,ig_p)}ig_f="";ig_p=null}_IG_AddEventHandler("domload",ig_0a);var ig_c={obj:null,init:function(a,b){a.onmousedown=ig_c.start;a.obj=b;if(isNaN(parseInt(b.style.left)))b.style.left="0px";if(isNaN(parseInt(b.style.top)))b.style.top="0px";b.onDragStart=new Function;b.onDragEnd=new Function;b.onDrag=new Function},uninit:function(a,b){window.clearInterval(b.xa);a.onmousedown=null;a.obj=null;b.onDragStart=null;b.onDragEnd=null;b.onDrag=null},start:function(a){var b=ig_c.obj=this.obj;a=ig_c.fixE(a);if(a.which!=1){return true}b.onDragStart(a);b.lastMouseX=a.clientX;
b.lastMouseY=a.clientY;if(ig_.va){b.lastMouseY-=document.body.scrollTop}b.xa=window.setInterval(ig_5a(b,ig_fb()),10);document.onmouseup=ig_c.end;document.onmousemove=ig_c.drag;return false},drag:function(a){a=ig_c.fixE(a);if(a.which==0){return ig_c.end()}var b=ig_c.obj,c=a.clientY;if(ig_.va){c-=document.body.scrollTop}var d=a.clientX;if(b.lastMouseX==d&&b.lastMouseY==c){return false}var e=parseInt(b.style.top),f=parseInt(b.style.left),g,h;g=f+d-b.lastMouseX;h=e+c-b.lastMouseY;b.style.left=g+"px";
b.style.top=h+"px";b.lastMouseX=d;b.lastMouseY=c;b.onDrag(g,h);return false},end:function(a){a=ig_c.fixE(a);document.onmousemove=null;document.onmouseup=null;window.clearInterval(ig_c.obj.xa);var b=ig_c.obj.onDragEnd();ig_c.obj=null;return b},fixE:function(a){if(typeof a=="undefined")a=window.event;if(typeof a.layerX=="undefined")a.layerX=a.offsetX;if(typeof a.layerY=="undefined")a.layerY=a.offsetY;if(typeof a.which=="undefined")a.which=a.button;return a}};

function ig_db(a,b,c){var d=b=="*"&&a.all?
a.all:a.getElementsByTagName(b),e=[];c=c.replace(/\-/g,"\\-");var f=new RegExp("(^|\\s)"+c+"(\\s|$)"),g;for(var h=0;h<d.length;h++){g=d[h];if(f.test(g.className)){e.push(g)}}return e}var _IG_initDrag=function(a,b){ig_.u=a;ig_.v=b;ig_.q=ig_db(ig_.u,"div","yui-u");if(_old_html){ig_.wa=ig_.u.tBodies[0].rows[0];ig_.q=ig_.wa.cells}ig_.l=[];var c=0;for(var d=0;d<ig_.q.length;d++){var e=ig_.q[d];if(e.className.indexOf("ig_dnd_fixed_col")!=-1)continue;for(var f=0;f<e.childNodes.length;f++){var g=e.childNodes[f];
if(g.tagName=="DIV"){ig_.l[c]=g.className!="dm"?new ig_Q(g):new ig_Y(g);c++}}}_IG_AddEventHandler("unload",ig_Za)};

function ig_Za(){for(var a=0;a<ig_.l.length;a++){ig_.l[a].x();ig_.l[a]=null}ig_.l=null;ig_.q=null;if(_old_html){ig_.wa=null}ig_.u=null}var ig_={};ig_.ea=navigator.userAgent;ig_.T=ig_.ea.indexOf("Gecko")!=-1;ig_.U=ig_.ea.indexOf("Opera")!=-1;ig_.va=ig_.ea.indexOf("Safari")!=-1;ig_.ja="IG_pageDivMaskId";ig_.ha="IG_moduleDivMaskId";ig_.Ma=function(){ig_.u.style.display="none"};ig_.Na=function(){ig_.u.style.display=
""};ig_.o=null;ig_.r=function(){if(!ig_.o){ig_.o=document.createElement("DIV");ig_.o.className="modbox";ig_.o.backgroundColor="";ig_.o.style.border="2px dashed #aaa";ig_.o.innerHTML="&nbsp;"}return ig_.o};ig_.j=function(a,b){return function(){return a[b].apply(a,arguments)}};ig_.Fa=function(){if(ig_.v){var a=ig_.v.getElementsByTagName("LI");if(_old_html){a=ig_.v.tBodies[0].rows[0].cells}for(var b=0;b<a.length;b++){var c=a[b];if(c.className.indexOf("unselectedtab")<0)continue;if(c.style.display=="none")continue;
c.isDraggableTo=true;c.pagePosLeft=ig_.g(c,true);c.pagePosRight=c.pagePosLeft+c.offsetWidth;c.pagePosTop=ig_.g(c,false);c.pagePosBottom=c.pagePosTop+c.offsetHeight}}};ig_.Ea=function(a){for(var b=0;b<ig_.l.length;b++){var c=ig_.l[b];c.a.pagePosLeft=ig_.g(c.a,true);c.a.pagePosTop=ig_.g(c.a,false)}var d=a.a.nextSibling;while(d){d.pagePosTop-=a.a.offsetHeight;d=d.nextSibling}};ig_.g=function(a,b){var c=0,d=0;if(a&&a.offsetParent&&a.offsetParent.id){if(b){a=a.offsetParent}else{var e=a.offsetParent.getElementsByTagName(a.tagName);
if(e&&e[0]){d=e[0].offsetTop}}}while(a){c+=a["offset"+(b?"Left":"Top")];a=a.offsetParent}return c-d};ig_.ka=function(a){ig_.$();var b=document.createElement("DIV");b.id=ig_.ja;b.innerHTML="&nbsp;";b.style.position="absolute";b.style.width="100%";b.style.height=document.body.offsetHeight+"px";b.style.left="0px";b.style.top="0px";b.style.backgroundImage="url(http://www.google.com/ig/images/cleardot.gif)";b.style.zIndex="9999";document.body.appendChild(b);if(a.Ta){b=b.cloneNode(true);b.id=ig_.ha;b.style.height=
a.a.offsetHeight-a.e.offsetHeight+"px";b.style.top=a.e.offsetHeight+"px";a.a.appendChild(b)}};ig_.$=function(){var a=[ig_.ha,ig_.ja];for(var b=0;b<a.length;b++){var c=_gel(a[b]);if(c){c.parentNode.removeChild(c);c=null}}};

ig_.db=function()
{
	var a="";
	for(var b=0;b<ig_.q.length;b++)
	{
	var c=ig_.q[b];
	for(var d=0;d<c.childNodes.length-1;d++)
		{
			var e=c.childNodes[d];
			if(e.tagName=="DIV")
				{a+=a!=""?":":"";a+=e.id.substring(2)+"_"+c.id.substring(2);
			
				}
		}
	}
	
	_xsetp("mp="+_esc(a))
	saveDrag(a);
};


function ig_Y(a){this.x=ig_Z;this.a=a;
this.a.innerHTML="<br />"}function ig_Z(){this.a=null}

function ig_Q(a){this._urlMouseUp=ig_X;this._urlMouseDown=ig_W;this._urlClick=ig_V;this._dragStart=ig_T;this._drag=ig_R;this._dragEnd=ig_S;this.O=ig_v;this.E=ig_U;this.x=ig_u;this.i=false;this.a=a;this.e=_gel(a.id+"_h");this.c=_gel(a.id+"_url");this.Ta=this.a.getElementsByTagName("IFRAME").length>0;this.a.DND_Module=this;if(this.e){this.e.style.cursor="move";ig_c.init(this.e,this.a);this.a.onDragStart=ig_.j(this,"_dragStart");this.a.onDrag=ig_.j(this,"_drag");this.a.onDragEnd=ig_.j(this,"_dragEnd");if(this.c){this.c.style.cursor="pointer";if(ig_.T){this.c.onmousedown=ig_.j(this,"_urlMouseDown");this.c.onclick=ig_.j(this,"_urlClick")}else{this.c.onmouseup=ig_.j(this,"_urlMouseUp")}}}}

function ig_u(){if(this.e){if(this.c){this.c.onclick=null;this.c.onmouseup=null;this.c=null}ig_c.uninit(this.e,this.a);this.a.onDragStart=null;this.a.onDrag=null;this.a.onDragEnd=null;this.e=null}this.a=null}

function ig_X(a){a=ig_c.fixE(a);if(this.i||!this.c||!this.c.href||a.which!=1){return true}this.E("titleclick");if(this.c.target||a.shiftKey){window.open(this.c.href,this.c.target)}else{document.location=this.c.href}return false}

function ig_W(a){a=ig_c.fixE(a);a.stopPropagation();return true}function ig_V(a){if(!this.i&&this.c&&this.c.href){this.E("titleclick");return true}return false}function ig_T(a){ig_.Ea(this);ig_.Fa();this.origNextSibling=this.a.nextSibling;var b=ig_.r(),c=this.a.offsetHeight;c-=parseInt(b.style.borderTopWidth)*2;var d=this.a.offsetWidth,e=
ig_.g(this.a,true),f=ig_.g(this.a,false);this.a.style.width=d+"px";b.style.height=c+"px";this.a.parentNode.insertBefore(b,this.a.nextSibling);this.a.style.position="absolute";this.a.style.zIndex=10000;this.a.style.left=e+"px";this.a.style.top=f+"px";ig_.ka(this);this.i=false;return false}function ig_G(){var a=0,b=0;if(typeof window.pageYOffset=="number"){a=window.pageXOffset;b=window.pageYOffset}else if(document.body&&(document.body.scrollLeft||document.body.scrollTop)){a=document.body.scrollLeft;
b=document.body.scrollTop}else if(document.documentElement&&(document.documentElement.scrollLeft||document.documentElement.scrollTop)){a=document.documentElement.scrollLeft;b=document.documentElement.scrollTop}return[a,b]}

function ig_R(a,b){if(!this.i){this.a.style.filter="alpha(opacity=50)";this.a.style.opacity=0.5;this.i=true;this.E("dragstart")}var c=null,d=100000000;for(var e=0;e<ig_.l.length;e++){var f=ig_.l[e],g=Math.sqrt(Math.pow(a-f.a.pagePosLeft,2)+Math.pow(b-f.a.pagePosTop,2));if(f==this)continue;
if(isNaN(g))continue;if(g<d){d=g;c=f}}this.m=null;if(ig_.v){var h=ig_.v.getElementsByTagName("LI");if(_old_html){h=ig_.v.tBodies[0].rows[0].cells}for(var e=0;e<h.length;e++){var f=h[e];if(!f.isDraggableTo)continue;var i=ig_G();if(this.a.lastMouseX>=f.pagePosLeft&&this.a.lastMouseX<=f.pagePosRight&&this.a.lastMouseY+i[1]>=f.pagePosTop&&this.a.lastMouseY+i[1]<=f.pagePosBottom){this.m=f;var j=ig_.r();if(j.parentNode!=null){j.parentNode.removeChild(j)}break}}for(var e=0;e<h.length;e++){var f=h[e];if(f.id.indexOf("view")>=0){if(f==this.m){if(f.className.indexOf(" tab_hover")<0){f.className+=" tab_hover"}}else{f.className=f.className.replace(/ tab_hover/g,"")}}}}var j=ig_.r();if(this.m==null&&c!=null&&j.nextSibling!=c.a){c.a.parentNode.insertBefore(j,c.a);if(ig_.U){document.body.style.display="none";document.body.style.display=""}}}

function ig_S(){

ig_.$();
if(this.O()){ig_.db()}
if(this.m){var a=this.m.id.match(/tab(\d+)_/)[1],b=this.a.id.match(/m_(\d+)/)[1];_xsetp("mt="+b+":"+a);this.a.style.display="none";this.m.className=this.m.className.replace(/ tab_hover/g,"")}
if(!_uli){var c=_gel("new_user_tip");if(c){c.style.display="none"}var d=_gel("new_user_save");
if(d){d.style.display="block"}}
if(this.i){this.E("dragend")}
return true
}

function ig_v(){var a=false;this.a.style.position="";this.a.style.width="";this.a.style.zIndex="";this.a.style.filter="";this.a.style.opacity="";window.scrollBy(0,0);var b=ig_.r();if(b.parentNode!=null){if(b.nextSibling!=this.origNextSibling){b.parentNode.insertBefore(this.a,b.nextSibling);a=true}b.parentNode.removeChild(b)}if(ig_.U){document.body.style.display="none";document.body.style.display=""}return a}

function ig_U(a){switch(a){case "titleclick":_IG_TriggerModuleEvent(this.a.id,a,this.c.href);_IG_TriggerEvent("module"+a,this.a.id,this.c.href);break;case "dragstart":case "dragend":_IG_TriggerDelayedModuleEvent(this.a.id,a);_IG_TriggerDelayedEvent("module"+a,this.a.id);break}}

function ig_5a(a,b){return function(){var c=ig_cb(),d=ig_G(),e=d[1],f=4,g=0.05*c,h=e,i=a.offsetTop;if(a.lastMouseY<=g){i=a.offsetTop-f;h=e-f}else if(a.lastMouseY>=c-g){i=Math.min(b-a.offsetHeight,a.offsetTop+f);h=Math.min(b-c,e+f)}var j=h-e;if(j!=0){window.scrollBy(0,j);a.style.top=i+"px"}}}

function ig_cb(){var a;if(window.innerHeight){a=window.innerHeight}else if(document.documentElement&&document.documentElement.clientHeight){a=document.documentElement.clientHeight}else{a=document.body.offsetHeight}if(a<document.body.clientHeight){return a}return document.body.clientHeight}

function ig_fb(){if(document.body.scrollHeight>document.documentElement.clientHeight){return document.body.scrollHeight}else{return document.documentElement.clientHeight}};

function ig_1a(a){var b=_gel("mobile_screen");b.insertBefore(a,b.firstChild);a.style.display="block";var c=ig_8a(a.id),d=_gel("m_"+c);_gel("added_m_"+c).style.display="";_gel("add_m_"+c).style.display="none";d.style.filter="alpha(opacity=30)";d.style.opacity=0.3;if(!ig_.T){d.style.width="100%"}}

function _addToMobileDisplayAndLog(a){ig_1a(a);ig_.aa("add")}

function _delFromMobileAndLog(a,b,c){ig_6a(a,b,c);ig_.aa("del")}

function ig_6a(a,b,c){var d=_gel("mobile_m_"+a),e=_gel("m_"+a);d.style.display="none";if(e){e.style.filter="alpha(opacity=100)";e.style.opacity=1;var f=_gel("add_"+e.id),g=_gel("added_"+e.id);g.style.display="none";f.style.display=""}}

function ig_8a(a){if(a.indexOf("mobile")==0){return a.substring("mobile_m_".length)}return a.substring("m_".length)}

function ig__a(){for(var a=0;a<ig_.k.length;a++){ig_.k[a].x();ig_.k[a]=null}ig_.k=null}ig_.Da=function(a){for(var b=0;b<ig_.k.length;b++){var c=ig_.k[b];c.a.pagePosLeft=ig_.g(c.a,true);c.a.pagePosTop=ig_.g(c.a,false)}var d=a.a.nextSibling;while(d){d.pagePosTop-=a.a.offsetHeight;d=d.nextSibling}};ig_.aa=function(a){var b="",c=_gel("mobile_screen");for(var d=0;d<c.childNodes.length;d++){var e=c.childNodes[d];if(e.style.display!="none"){b+=b!=""?":":"";b+=e.id.substring(9)}}_xsetp("mobile_mp="+_esc(b)+"&action="+_esc(a))};

function ig_M(a){this._dragStart=ig_P;this._drag=ig_N;this._dragEnd=ig_O;this.x=ig_u;this.O=ig_v;this.i=false;this.a=a;this.a.style.cursor="move";this.e=_gel(a.id+"_h");this.la=_gel(a.id+"_b");if(this.e){ig_c.init(this.e,this.a)}if(this.la){ig_c.init(this.la,this.a)}this.a.onDragStart=ig_.j(this,"_dragStart");this.a.onDrag=ig_.j(this,"_drag");this.a.onDragEnd=ig_.j(this,"_dragEnd")}

function ig_P(){ig_.Da(this);this.origNextSibling=this.a.nextSibling;var a=ig_.r(),b=this.a.offsetHeight;if(ig_.T){b-=parseInt(a.style.borderTopWidth)*2}a.className="";var c=this.a.offsetWidth,d=ig_.g(this.a,true),e=ig_.g(this.a,false);ig_.Ma();this.a.style.width=c+"px";a.style.height=b+"px";this.a.parentNode.insertBefore(a,this.a.nextSibling);this.a.style.position="absolute";this.a.style.zIndex=100;this.a.style.left=d+"px";this.a.style.top=e+"px";ig_.Na();ig_.ka(this);this.i=false;return false}

function ig_N(a,b){if(!this.i){this.a.style.filter="alpha(opacity=70)";this.a.style.opacity=0.7;this.i=true}var c=null,d=100000000;for(var e=0;e<ig_.k.length;e++){var f=ig_.k[e],g=Math.sqrt(Math.pow(a-f.a.pagePosLeft,2)+Math.pow(b-f.a.pagePosTop,2));if(f==this)continue;if(isNaN(g))continue;if(g<d){d=g;c=f}}var h=ig_.r();h.className="";if(c!=null&&h.nextSibling!=c.a){c.a.parentNode.insertBefore(h,c.a);if(ig_.U){document.body.style.display="none";document.body.style.display=""}}}

function ig_O(){ig_.$();if(this.O()){ig_.aa("move")}return true}var _IG_initMobileDrag=function(a){ig_.u=a;ig_.k=[];var b=0,c=_gel("mobile_screen").childNodes;for(var d=0;d<c.length;d++){var e=c[d];if(e.tagName=="DIV"){if(ig_gb(e)){ig_3a(e)}ig_.k[b]=new ig_M(e);b++}}_IG_AddEventHandler("unload",ig__a)};

function ig_gb(a){var b=_gel(a.id+"_h");if(b){var c=_gel(a.id+"_h").innerHTML;if(c.indexOf("Google Reader")>=0){return true}}}

function ig_3a(a){var b=_gel(a.id+"_b");for(var c=0;c<b.childNodes.length;c++){var d=b.childNodes[c];if(d.tagName=="TABLE"){d.className="mmc"}}};

function ig_da(a){var b=document.createElement("DIV");b.innerHTML="<iframe onload='this.pool_locked=false'></iframe>";var c=b.getElementsByTagName("IFRAME")[0];c.style.visibility="hidden";c.style.width=(c.style.height="0px");c.style.border="0px";c.style.position="absolute";c.pool_locked=a;this.f[this.f.length]=c;b.removeChild(c);b=null;return c}

function ig_ea(a){var b=this;window.setTimeout(function(){var c=null;for(var d=b.f.length-1;d>=0;d--){var e=b.f[d];if(e&&!e.pool_locked){e.parentNode.removeChild(e);if(window.ActiveXObject){e=null;b.f[d]=null;b.f.splice(d,1)}else{e.pool_locked=true;c=e;break}}}c=c?c:b.Ka(true);c.src=a;document.body.appendChild(c)},0)}

function ig_ca(){for(var a=0;a<this.f.length;a++){this.f[a].onload=null;this.f[a]=null}this.f.length=0;this.f=[]}

function ig_ba(){this.f=[];this.Ka=ig_da;this.iframe=ig_ea;this.clear=ig_ca}

function ig_$(a,b){_IFPC.C[a]=b}

function ig__(a,b,c,d,e,f){c.unshift(_IFPC.cb(e));c.unshift(f);c.unshift(b);c.unshift(a);var g=4095-d.length;g=parseInt(g/3,10);var h=_IFPC.pa(c),i=parseInt(h.length/g,10);if(h.length%g>0){i+=1}for(var j=0;j<i;j++){var l=h.substr(j*g,g),k=[a,_IFPC.na,i,j,l];_IFPC.ua.iframe(d+"#"+_IFPC.pa(k))}_IFPC.na++}

function ig_1(){_IFPC.C={};_IFPC.p={};_IFPC.ua.clear()}

function ig_y(a){if(window.parent===window.top){var b=_IFPC.M(a),c=b.shift(),d=window.parent.frames[c];d.setTimeout(function(){try{d._IFPC.handleRequest(a)}catch(e){throw new Error("Unable to relay request to iframe: "+c);}},0)}else{var d=window.top;d.setTimeout(function(){d._IFPC.handleRequest(a)},0)}}

function ig_7(a){var a=_IFPC.M(a),b=a.shift(),c=a.shift(),d=a.shift(),e=a.shift(),f=a.shift(),g=b+"_"+c;if(!_IFPC.n[g])_IFPC.n[g]=[];_IFPC.n[g].push([e,f]);if(_IFPC.n[g].length==d){_IFPC.n[g].sort(function(o,p){return parseInt(o[0],10)-parseInt(p[0],10)});f="";for(var h=0;h<d;h++){f+=_IFPC.n[g][h][1]}_IFPC.n[g]=null;var i=_IFPC.M(f),b=i.shift(),j=i.shift(),l=i.shift(),k=i.shift(),m=_IFPC.Sa(j);if(m){var n=m.apply(null,i);if(_IFPC.Xa(k)){n.unshift(k);_IFPC.call(b,_IFPC.ga,n,l,null,"")}}else{throw new Error("Service "+j+" not registered.");}}}

function ig_6(a){if(_IFPC.C.hasOwnProperty(a)){return _IFPC.C[a]}else{return null}}

function ig_9(a){var b="";if(a&&typeof a=="function"){b=_IFPC.Ra();_IFPC.p[b]=a}return b}

function ig_aa(a){if(_IFPC.p.hasOwnProperty(a)){_IFPC.p[a]=null}}

function ig_4(a){if(a&&_IFPC.p.hasOwnProperty(a)){return _IFPC.p[a]}return null}

function ig_5(){return _IFPC.fa+_IFPC.Ga++}

function ig_8(a){return(a+"").indexOf(_IFPC.fa)==0}

function ig_2(a){var b=a.split("&");for(var c=0;c<b.length;c++){b[c]=decodeURIComponent(b[c])}return b}

function ig_3(a){var b=[];for(var c=0;c<a.length;c++){b.push(encodeURIComponent(a[c]))}return b.join("&")}

function ig_0(a){var b=_IFPC.Pa(a);if(b){var c=[];for(var d=1;d<arguments.length;d++){c[c.length]=arguments[d]}b.apply(null,c);_IFPC.hb(a)}else{throw new Error("Invalid callbackId");}}var _IFPC={registerService:ig_$,call:ig__,clear:ig_1,relayRequest:ig_y,processRequest:ig_y,handleRequest:ig_7,fa:"cbid",ga:"ifpc_callback",ua:new ig_ba,n:{},C:{},p:{},Ga:0,na:0,Sa:ig_6,cb:ig_9,hb:ig_aa,Pa:ig_4,Ra:ig_5,Xa:ig_8,M:ig_2,pa:ig_3,Ha:ig_0};_IFPC.registerService(_IFPC.ga,_IFPC.Ha);
