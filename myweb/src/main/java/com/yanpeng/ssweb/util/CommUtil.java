package com.yanpeng.ssweb.util;

import java.awt.Color;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.oro.text.regex.MalformedPatternException;
import org.apache.oro.text.regex.Perl5Compiler;
import org.apache.oro.text.regex.Perl5Matcher;

public class CommUtil {

	public static void ObjToMap(Object obj, Map map) {
		if (map == null) {
			map = new HashMap();
		}
		PropertyDescriptor descriptors[] = BeanUtilsBean.getInstance().getPropertyUtils().getPropertyDescriptors(obj);
		for (PropertyDescriptor descriptor : descriptors) {
			String name = descriptor.getName();
			try {
				if (descriptor.getReadMethod() != null) {
					map.put(name, BeanUtilsBean.getInstance().getPropertyUtils().getProperty(obj, name));
				}
			} catch (Exception e) {
				System.out.println(name + ":" + e);
			}
		}

	}

	public static void MapToObj(Map map, Object obj) {
		for (Iterator names = map.keySet().iterator(); names.hasNext();) {
			String name = (String) names.next();
			if (BeanUtilsBean.getInstance().getPropertyUtils().isWriteable(obj, name)) {
				Object value = map.get(name);
				try {
					BeanUtilsBean.getInstance().copyProperty(obj, name, value);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	/**
	 * 判断是否为INT
	 * @param expression
	 * @return
	 */
	public static boolean isInt(Object expression) {
		if (expression != null) {
			try {
				Integer.parseInt(expression.toString());
			} catch (Exception e) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 判读是否为DOUBLE
	 * @param expression
	 * @return
	 */
	public static boolean isDuble(Object expression) {
		if (expression != null) {
			try {
				Double.parseDouble(expression.toString());
			} catch (Exception e) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 判断给定的字符串数组中的数据是不是都为数值型
	 * @param array 字符串数组
	 * @return 是否成功
	 */
	public static boolean isIntArray(String[] array) {
		if (array == null) {
			return false;
		}
		if (array.length < 1) {
			return false;
		}
		for (String string : array) {
			if (!isInt(string)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 清除HTML标记
	 * 
	 * @param htmlText
	 *            带HTML标记的字符串
	 * @return 纯文本字符串
	 */
	public static String cleanHtmlTag(String htmlText) {
		String reg = "</?[a-z][a-z0-9]*[^<>]*>?";
		return htmlText.replaceAll(reg, "");
	}

	/**
	 * 格式化内容，只保留前n个字符，并进一步确认是否要在后面加上...
	 * 
	 * @param str
	 *            要处理的字符串
	 * @param num
	 *            保留的字数
	 * @param hasDot
	 *            是否显示...
	 * @return
	 */

	public static String format(String str, int num, boolean hasDot) {
		if (str == null) {
			return "";
		} else {
			if (str.getBytes().length < num * 2) {
				return str;
			} else {
				byte[] ss = str.getBytes();
				byte[] bs = new byte[num * 2];
				for (int i = 0; i < bs.length; i++) {
					bs[i] = ss[i];
				}
				String subStr = CommUtil.substring(str, num * 2);
				if (hasDot) {
					subStr = subStr + "...";
				}
				return subStr;
			}
		}
	}

	/**
	 * 取出指定长度字符串
	 * 
	 * @param s
	 *            字符串
	 * @param maxLength
	 *            长度
	 * @return
	 */
	public static String substring(String s, int maxLength) {
		if (s.getBytes().length <= maxLength) {
			return s;
		}
		int i = 0;
		for (int k = 0; k < maxLength && i < s.length(); i++, k++) {
			if (s.charAt(i) > '　') {
				k++;
			}
		}
		if (i < s.length()) {
			s = s.substring(0, i);
		}
		return s;
	}

	/**
	 * 转换对象为字符串
	 * 
	 * @param s
	 *            对象
	 * @return 如果为空则返回""
	 */
	public static String null2String(Object s) {
		return s == null ? "" : s.toString().trim();
	}

	/**
	 * 随机生成指定位数且不重复的字符串.去除了部分容易混淆的字符，如1和l，o和0等，
	 * 
	 * 随机范围1-9 a-z A-Z
	 * 
	 * @param length
	 *            指定字符串长度
	 * @return 返回指定位数且不重复的字符串
	 */
	public static String getRandomString(int length) {
		StringBuffer bu = new StringBuffer();
		String[] arr = { "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
				"m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G",
				"H", "I", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
		Random random = new Random();
		while (bu.length() < length) {
			String temp = arr[random.nextInt(57)];
			if (bu.indexOf(temp) == -1) {
				bu.append(temp);
			}
		}
		return bu.toString();
	}

	/**
	 * 获取某个范围内的随机整数
	 * 
	 * @param sek
	 *            随机种子
	 * @param start
	 *            最小范围
	 * @param max
	 *            最大范围
	 * @return 整数
	 */
	public static int getRandomInt(int sek, int min, int max) {

		Random random = new Random();

		int temp = 0;

		do {
			temp = random.nextInt(sek);
		} while (temp < min || temp > max);

		return temp;
	}

	/**
	 * 转换对象为INT
	 * 
	 * @param s
	 *            对象
	 * @return 如果为空则返回-1
	 */
	public static int null2Int(Object s) {
		return null2Int(s, -1);
	}

	/**
	 * 转换对象为INT
	 * @param object 对象
	 * @param def 失败默认值
	 * @return INT值
	 */
	public static int null2Int(Object object, int def) {

		if (object != null) {
			try {
				return Integer.parseInt(object.toString());
			} catch (Exception e) {
			}
		}
		return def;
	}

	/**
	 * 转换对象为Long
	 * @param object 对象
	 * @param def 失败默认值
	 * @return Long值
	 */
	public static Long null2Long(Object object, Long def) {

		if (object != null) {
			try {
				return Long.parseLong(object.toString());
			} catch (Exception e) {
			}
		}
		return def;
	}

	/**
	 * 转换对象为Float
	 * 
	 * @param s
	 *            对象
	 * @return 如果为空则返回-1
	 */
	public static float null2Float(Object s) {
		return null2Float(s, -1);
	}

	/**
	 * 转换对象为Float
	 * 
	 * @param s
	 *            对象
	 * @return 如果为空则返回-1
	 */
	public static float null2Float(Object s, float defValue) {
		if (s != null) {
			try {
				return Float.parseFloat(s.toString());
			} catch (Exception e) {
			}
		}
		return defValue;
	}

	/**
	 * 转换对象为Float
	 * 
	 * @param s
	 *            对象
	 * @return 如果为空则返回-1
	 */
	public static double null2Double(Object s, double defValue) {
		if (s != null) {
			try {
				return Double.parseDouble(s.toString());
			} catch (Exception e) {
			}
		}
		return defValue;
	}

	/**
	 * object型转换为bool型
	 * @param expression 要转换的对象
	 * @param defValue 缺省值
	 * @return 转换后的bool类型结果
	 */
	public static boolean null2Boolean(Object expression, boolean defValue) {
		try {
			return Boolean.parseBoolean(null2String(expression));
		} catch (Exception e) {
			return defValue;
		}
	}

	/**
	 * 按照指定方式格式化时间
	 * @param date 时间
	 * @param type 格式
	 * @return
	 */
	public static String dateFormat(Date date, String type) {
		SimpleDateFormat sdf = new SimpleDateFormat(type);
		return sdf.format(date);
	}

	/**
	 * 按照指定方式格式化时间
	 * @param type 格式
	 * @return
	 */
	public static String dateFormat(String type) {
		return dateFormat(getNowDate(), type);
	}

	/**
	 * 返回系统当前时间的date对象
	 * 
	 * @return
	 */
	public static Date getNowDate() {
		return new Date();
	}

	/**
	 * 判断时间格式
	 * 
	 * @param date
	 * @param format
	 * @return
	 */
	public static boolean checkDate(String date, String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		try {
			df.parse(date);
		} catch (Exception e) {
			// 如果不能转换,肯定是错误格式
			return false;
		}
		return true;
	}

	/**
	 * 检测邮件格式
	 * 
	 * @param email
	 * @return
	 */
	public static boolean checkEmail(String email) {
		Pattern pattern = Pattern.compile("\\w+(\\.\\w+)*@\\w+(\\.\\w+)+");
		Matcher matcher = pattern.matcher(email);
		if (matcher.matches()) {
			return true;
		}
		return false;
	}

	/**
	 * 转换字符串为指定编码格式
	 * 
	 * @param s
	 * @param encoding
	 * @return
	 */
	public static String stringFormat(String s, String encod, String encoding) {
		try {
			return new String(s.getBytes(encod), encoding);
		} catch (UnsupportedEncodingException e) {
			return s;
		}
	}

	public static String stringFormat(String s) {
		return stringFormat(s, "ISO8859-1", "UTF-8");
	}

	/**
	 * 
	 * 提供精确的小数位四舍五入处理。
	 * 
	 * @param v
	 *            需要四舍五入的数字
	 * @param scale
	 *            小数点后保留几位
	 * @return 四舍五入后的结果
	 */
	public static double round(double v, int scale) {

		if (scale < 0) {
			throw new IllegalArgumentException("The scale must be a positive integer or zero");
		}

		BigDecimal b = new BigDecimal(Double.toString(v));

		BigDecimal one = new BigDecimal("1");

		return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();

	}

	/**
	 * URL编码指定字符串
	 * @param s 字符串
	 * @return URL编码结果
	 */
	public static String urlEncode(String s) {
		try {
			return URLEncoder.encode(s, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return s;
		}
	}

	/**
	 * URL解码指定字符串
	 * @param s 字符串
	 * @return 解码结果
	 */
	public static String urlDecode(String s) {
		try {
			return URLDecoder.decode(s, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return s;
		}
	}

	/**
	 * 返回指定IP是否在指定的IP数组所限定的范围内<br>
	 * IP数组内的IP地址可以使用*表示该IP段任意, 例如192.168.1.*
	 * 
	 * @param ip
	 * @param ipArry
	 * @return
	 */
	public static boolean inIPArray(String ip, String[] ipArry) {
		String[] userip = ip.split("\\.");
		for (String element : ipArry) {
			String[] tempip = element.split("\\.");
			int r = 0;
			for (int i = 0; i < tempip.length; i++) {
				if (tempip[i].equals("*")) {
					return true;
				}
				if (userip.length > i) {
					if (tempip[i].equals(userip[i])) {
						r++;
					} else {
						break;
					}
				} else {
					break;
				}
			}// end for
			if (r == 4) {
				return true;
			}
		}// end for
		return false;
	}

	/**
	 * 判断指定字符串在指定字符串数组中的位置
	 * @param strSearch 字符串
	 * @param stringArray 字符串数组
	 * @param caseInsensetive 是否不区分大小写, true为不区分, false为区分
	 * @return 字符串在指定字符串数组中的位置, 如不存在则返回-1
	 */
	public static int getInArrayID(String strSearch, String[] stringArray, boolean caseInsensetive) {
		for (int i = 0; i < stringArray.length; i++) {
			if (caseInsensetive) {
				if (strSearch.toLowerCase().equals(stringArray[i].toLowerCase())) {
					return i;
				}
			} else {
				if (strSearch.equals(stringArray[i])) {
					return i;
				}
			}

		}
		return -1;
	}

	/**
	 * 判断指定字符串在指定字符串数组中的位置
	 * @param strSearch 字符串
	 * @param stringArray 字符串数组
	 * @return 字符串在指定字符串数组中的位置, 如不存在则返回-1
	 */
	public static int getInArrayID(String strSearch, String[] stringArray) {
		return getInArrayID(strSearch, stringArray, true);
	}

	/**
	 * 判断指定字符串是否属于指定字符串数组中的一个元素
	 * @param str 字符串
	 * @param stringArray 字符串数组
	 * @param caseInsensetive 是否不区分大小写, true为不区分, false为区分
	 * @return 判断结果
	 */
	public static boolean inArray(String str, String[] stringArray, boolean caseInsensetive) {
		return getInArrayID(str, stringArray, caseInsensetive) >= 0;
	}

	/**
	 * 判断指定字符串是否属于指定字符串数组中的一个元素
	 * @param str 字符串
	 * @param stringArray 字符串数组
	 * @return 判断结果
	 */
	public static boolean inArray(String str, String[] stringArray) {
		return inArray(str, stringArray, false);
	}

	/**
	 * 判断指定字符串是否属于指定字符串数组中的一个元素
	 * @param str 字符串
	 * @param stringArray 内部以指定符号分割单词的字符串
	 * @param strsplit 分割字符串
	 * @param caseInsensetive 是否不区分大小写, true为不区分, false为区分
	 * @return 判断结果
	 */
	public static boolean inArray(String str, String stringArray, String strsplit, boolean caseInsensetive) {
		return inArray(str, stringArray.split(strsplit), caseInsensetive);
	}

	/**
	 * 判断指定字符串是否属于指定字符串数组中的一个元素
	 * @param str 字符串
	 * @param stringArray 内部以指定符号分割单词的字符串
	 * @param strsplit 分割字符串
	 * @return 判断结果
	 */
	public static boolean inArray(String str, String stringArray, String strsplit) {
		return inArray(str, stringArray.split(strsplit), false);
	}

	/**
	 * 判断指定字符串是否属于指定字符串数组中的一个元素
	 * @param str 字符串
	 * @param stringArray 内部以逗号分割单词的字符串
	 * @return 判断结果
	 */
	public static boolean inArray(String str, String stringArray) {
		return inArray(str, stringArray.split(","), false);
	}

	/**
	 * 检测是否有Sql危险字符
	 * @param str 要判断字符串
	 * @return 判断结果
	 */
	public static boolean isSafeSqlString(String str) {
		Pattern pattern = Pattern.compile("[-|;|,|/|(|)|\\[|\\]|\\}|\\{|%|@|\\*|!|\\']");
		return !pattern.matcher(str).find();
	}

	/**
	 * 检测是否有危险的可能用于链接的字符串
	 * @param str 要判断字符串
	 * @return 判断结果
	 */
	public static boolean isSafeUserInfoString(String str) {
		Pattern pattern = Pattern.compile("^\\s*$|^c:\\con\\con$|[%,\\*\\\\s\\t\\<\\>\\&]|游客|^Guest");
		return !pattern.matcher(str).find();
	}

	/**
	 * 返回文件是否存在
	 * 
	 * @param filePath 文件名
	 * @return 是否存在
	 */
	public static boolean fileExists(String filePath) {
		File file = new File(filePath);
		return file.exists();
	}

	/**
	 * 生成指定数量的html空格符号
	 * @param spacesCount
	 * @return
	 */
	public static String getSpacesString(int spacesCount) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < spacesCount; i++) {
			sb.append("&nbsp;&nbsp;");
		}
		return sb.toString();
	}

	/**
	 * 将字符串转换为Color
	 * @param color
	 * @return
	 */
	public static Color toColor(String color) {
		int red, green, blue = 0;
		char[] rgb;
		color = "#" + color.trim();
		color = color.toLowerCase().replaceAll("[g-zG-Z]", "");
		switch (color.length()) {
		case 3:
			rgb = color.toCharArray();
			red = CommUtil.null2Int(rgb[0] + "" + rgb[0], 16);
			green = CommUtil.null2Int(rgb[1] + "" + rgb[1], 16);
			blue = CommUtil.null2Int(rgb[2] + "" + rgb[2], 16);
			return new Color(red, green, blue);
		case 6:
			rgb = color.toCharArray();
			red = CommUtil.null2Int(rgb[0] + "" + rgb[1], 16);
			green = CommUtil.null2Int(rgb[2] + "" + rgb[3], 16);
			blue = CommUtil.null2Int(rgb[4] + "" + rgb[5], 16);
			return new Color(red, green, blue);
		default:
			return Color.decode(color);
		}
	}

	/**
	 * 为脚本替换特殊字符串
	 * @param str
	 * @return
	 */
	public static String replaceStrToScript(String str) {
		str = str.replace("\\", "\\\\");
		str = str.replace("'", "\\'");
		str = str.replace("\"", "\\\"");
		return str;
	}

	/**
	 * 判断文件名是否为浏览器可以直接显示的图片文件名
	 * @param filename 文件名
	 * @return 是否可以直接显示
	 */
	public static boolean isImgFilename(String filename) {
		filename = filename.trim();
		if (filename.endsWith(".") || filename.indexOf(".") == -1) {
			return false;
		}
		String extname = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
		return (extname.equals("jpg") || extname.equals("jpeg") || extname.equals("png") || extname.equals("bmp") || extname
				.equals("gif"));
	}

	/**
	 * 检测是否为IP
	 * @param ip
	 * @return
	 */
	public static boolean isIPSect(String ip) {
		return Pattern
				.compile(
						"^((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){2}((2[0-4]\\d|25[0-5]|[01]?\\d\\d?|\\*)\\.)(2[0-4]\\d|25[0-5]|[01]?\\d\\d?|\\*)$")
				.matcher(ip).find();

	}

	/**
	 * 判断是否为时间
	 * @param timeval
	 * @return
	 */
	public static boolean isTime(String timeval) {
		return Pattern.compile("^((([0-1]?[0-9])|(2[0-3])):([0-5]?[0-9])(:[0-5]?[0-9])?)$").matcher(timeval).find();
	}

	public static boolean isRuleTip(Map<String, String> newHash, String ruletype, Map<Integer, String> keyMap) {
		keyMap.put(0, "");
		ruletype = ruletype.trim().toLowerCase();
		Set<Entry<String, String>> entrys = newHash.entrySet();
		for (Entry<String, String> entry : entrys) {
			String[] single = entry.getValue().split("\r\n");
			for (String str : single) {
				try {
					if (!str.equals("")) {

						if (ruletype.equals("email")) {
							if (!checkEmail(str)) {
								throw new Exception();
							}
						} else if (ruletype.equals("ip")) {
							if (!isIPSect(str)) {
								throw new Exception();
							}
						} else if (ruletype.equals("timesect")) {
							String[] splitetime = str.split("-");
							if (!isTime(splitetime[1]) || !isTime(splitetime[0])) {
								throw new Exception();
							}
						}
					}
				} catch (Exception e) {
					keyMap.put(0, entry.getKey());
					return false;
				}
			}
		}

		return true;

	}

	/**
	 * 获取置顶邮件的服务器地址
	 * @param strEmail
	 * @return
	 */
	public static String getEmailHostName(String strEmail) {
		if (strEmail.indexOf("@") < 0) {
			return "";
		}
		return strEmail.substring(strEmail.lastIndexOf("@")).toLowerCase();
	}

	/**
	 * HTML标签过滤
	 * @param value
	 * @return
	 */
	public static String dhtmlspecialchars(String value) {
		if (matches(value, "(&|\"|<|>)")) {
			value = value.replaceAll("&", "&amp;");
			value = value.replaceAll("\"", "&quot;");
			value = value.replaceAll("<", "&lt;");
			value = value.replaceAll(">", "&gt;");
		}
		return value;
	}

	/**
	 * HTML标签反
	 * @param value
	 * @return
	 */
	public static String htmlspecialchars(String value) {
		if (matches(value, "(&amp;|&quot;|&lt;|&gt;)")) {
			value = value.replaceAll("&amp;", "&");
			value = value.replaceAll("&quot;", "\"");
			value = value.replaceAll("&lt;", "<");
			value = value.replaceAll("&gt;", ">");
		}
		return value;
	}

	public static boolean matches(String content, String regex) {
		boolean flag = false;
		try {
			flag = new Perl5Matcher().contains(content, new Perl5Compiler().compile(regex));
		} catch (MalformedPatternException e) {
		}
		return flag;
	}

}
