package com.yanpeng.core.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public abstract class FormatConstants {
	public static final DateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd",java.util.Locale.CHINA);
	public static final DateFormat TIME_FORMAT = new SimpleDateFormat("HH:mm:ss",java.util.Locale.CHINA);	
	public static final DateFormat DATE_TIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",java.util.Locale.CHINA);
	public static final String DATE_FORMAT_STRING = "yyyy-MM-dd";
	public static final String TIME_FORMAT_STRING = "HH:mm:ss";
	public static final String DATE_TIME_FORMAT_STRING = "yyyy-MM-dd HH:mm:ss";
}
