package org.springside.modules.web.struts2;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Struts2 Action基类.
 * 
 * 实现获取Request/Response/Session的简化方法和绕过jsp/freemaker直接输出文本的方法.
 * 
 * @author calvin
 */
public class SimpleActionSupport extends ActionSupport {

	private static final long serialVersionUID = -3200676032178970212L;

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 取得HttpSession的简化方法.
	 */
	protected HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * 取得HttpRequest的简化方法.
	 */
	protected HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 取得HttpResponse的简化方法.
	 */
	protected HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * 绕过Template,直接输出内容的简便函数. 
	 */
	protected void render(final String text, final String contentType) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType(contentType);
			response.getWriter().write(text);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 直接输出文本.
	 */
	protected void renderText(final String text, final String encoding) {
		render(text, "text/plain;charset=" + encoding);
	}

	/**
	 * 直接输出文本,默认编码为UTF-8.
	 */
	protected void renderText(final String text) {
		render(text, "text/plain;charset=UTF-8");
	}

	/**
	 * 直接输出HTML.
	 */
	protected void renderHtml(final String html, final String encoding) {
		render(html, "text/html;charset=" + encoding);
	}

	/**
	 * 直接输出HTML,默认编码为UTF-8.
	 */
	protected void renderHtml(final String html) {
		render(html, "text/html;charset=UTF-8");
	}

	/**
	 * 直接输出XML.
	 */
	protected void renderXML(final String xml, final String encoding) {
		render(xml, "text/xml;charset=" + encoding);
	}

	/**
	 * 直接输出XML,默认编码为UTF-8.
	 */
	protected void renderXML(final String xml) {
		render(xml, "text/xml;charset=UTF-8");
	}
}
