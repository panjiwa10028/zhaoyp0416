		// [Cookie] Clears a cookie
		function clearCookie()
		{
			var now = new Date();
			var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
			this.setCookie('co'+this.obj, 'cookieValue', yesterday);
			this.setCookie('cs'+this.obj, 'cookieValue', yesterday);
		}
		
		// [Cookie] Sets value in a cookie
		function setCookie(cookieName, cookieValue, expires, path, domain, secure)
		{
			document.cookie =
				escape(cookieName) + '=' + escape(cookieValue)
				+ (expires ? '; expires=' + expires.toGMTString() : '')
				+ (path ? '; path=' + path : '')
				+ (domain ? '; domain=' + domain : '')
				+ (secure ? '; secure' : '');
		}
		
		// [Cookie] Gets a value from a cookie
		function getCookie(cookieName)
		{
			var cookieValue = '';
			var posName = document.cookie.indexOf(escape(cookieName) + '=');
			if (posName != -1) {
				var posValue = posName + (escape(cookieName) + '=').length;
				var endPos = document.cookie.indexOf(';', posValue);
				if (endPos != -1) cookieValue = unescape(document.cookie.substring(posValue, endPos));
				else cookieValue = unescape(document.cookie.substring(posValue));
			}
			return (cookieValue);
		}
