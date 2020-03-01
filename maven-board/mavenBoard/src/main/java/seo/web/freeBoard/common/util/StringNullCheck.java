package seo.web.freeBoard.common.util;

import java.util.List;
import java.util.Map;

public class StringNullCheck {
	/*
	 * 
	 * 공백 또는 null 체크
	 * 
	 */

	public static String isEmpty(Object obj) {

		if (obj == null) return "";
		
		if ((obj instanceof String) && ( ((String) obj).trim().length() == 0)) return "";
		
		if (obj instanceof Map) {
			if (((Map<?, ?>) obj).isEmpty()) return "";
		}

		if (obj instanceof List) {
			if (((List<?>) obj).isEmpty()) return "";
		}

		if (obj instanceof Object[]) {
			if ( ((Object[])obj).length == 0 ) return "";
		}

		return (String) obj;
	}

}
