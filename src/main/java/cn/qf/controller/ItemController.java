package cn.qf.controller;

import cn.qf.pojo.Items;
import cn.qf.service.ItemsService;
import cn.qf.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("item")
public class ItemController {
	@Autowired
	private ItemsService service;

	@RequestMapping("select")
	public Map select(Items i) {
		PageUtil pu = service.select(i);
		Map m=new HashMap();
		m.put("code",0);
		m.put("count",pu.getTc());
		m.put("data",pu.getList());
		return m;
	}
	@RequestMapping("add")
	public Map add(Items i){
		Map m=new HashMap();
		try {
			service.add(i);
			m.put("status",true);
		} catch (Exception e) {
			e.printStackTrace();
			m.put("status",false);
			m.put("message",e.getMessage());
		}
		return m;
	}
	@RequestMapping("del")
	public Map del(int[] ids){
		Map m=new HashMap();
		try {
			service.del(ids);
			m.put("status",true);
		} catch (Exception e) {
			e.printStackTrace();
			m.put("status",false);
			m.put("message",e.getMessage());
		}
		return m;
	}
	@RequestMapping("delById")
	public Map delById(int id){
		Map m=new HashMap();
		try {
			service.delById(id);
			m.put("status",true);
		} catch (Exception e) {
			e.printStackTrace();
			m.put("status",false);
			m.put("message",e.getMessage());
		}
		return m;
	}
	@RequestMapping("update")
	public Map update(Items i){
		Map m=new HashMap();
		try {
			service.update(i);
			m.put("status",true);
		} catch (Exception e) {
			e.printStackTrace();
			m.put("status",false);
			m.put("message",e.getMessage());
		}
		return m;
	}

	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class,
				new CustomDateEditor(dateFormat,true));
	}

}