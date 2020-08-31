package cn.qf.service;

import cn.qf.pojo.Items;
import cn.qf.util.PageUtil;

public interface ItemsService {
	PageUtil select(Items i);
	void add(Items i);
	void del(int[] ids);
	void delById(int id);
	void update(Items i);
}