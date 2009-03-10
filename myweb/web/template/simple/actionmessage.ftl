
<br>
<#if (actionMessages?exists && actionMessages?size > 0)>
	<ul>
		<#list actionMessages as message>
			<li><font style='color:green !important'><span<#rt/>
<#if parameters.cssClass?exists>
 class="${parameters.cssClass?html}"<#rt/>
<#else>
 class="actionMessage"<#rt/>
</#if>
<#if parameters.cssStyle?exists>
 style="${parameters.cssStyle?html}"<#rt/>
</#if>
>${message}</span></font></li>
		</#list>
	</ul>
</#if>

<#if (actionErrors?exists && actionErrors?size > 0)>
	<ul>
	<#list actionErrors as error>
		<li><font style='color:red !important'><span<#rt/>
<#if parameters.cssClass?exists>
 class="${parameters.cssClass?html}"<#rt/>
<#else>
 class="errorMessage"<#rt/>
</#if>
<#if parameters.cssStyle?exists>
 style="${parameters.cssStyle?html}"<#rt/>
</#if>
>${error}</span></font></li>
	</#list>
	</ul>
</#if>