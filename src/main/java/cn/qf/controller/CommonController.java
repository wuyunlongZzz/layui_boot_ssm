package cn.qf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
	@RequestMapping("{page}")
	public String tiaoZhuan(@PathVariable String page){
		return page;
	}
}
