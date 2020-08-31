package cn.qf.util;

import java.util.ArrayList;
import java.util.List;

//数组转集合
public class ListUtil {
	public static List toList(int[] i){
		List L = new ArrayList();
		for (int j = 0; j < i.length; j++) {
			L.add(i[j]);
		}
		return L;
	}
}
