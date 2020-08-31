package cn.qf.util;

import java.util.List;

public class PageUtil {
	private Integer pi=1;
	private Integer ps=4;
	private Integer tc;
	private Integer tp;
	private Integer sp;
	private List list;

	public PageUtil() {}	
	public PageUtil(Integer pi,Integer tc,List list) {
		this.pi = pi;
		this.tc = tc;
		this.list = list;
	}

	public Integer getPi() {
		return pi;
	}
	public void setPi(Integer pi) {
		this.pi = pi;
	}
	public Integer getPs() {
		return ps;
	}
	public void setPs(Integer ps) {
		this.ps = ps;
	}
	public Integer getTc() {
		return tc;
	}
	public void setTc(Integer tc) {
		this.tc = tc;
	}
	public Integer getTp() {
		return (tc%ps==0?tc/ps:tc/ps+1)==0?1:(tc%ps==0?tc/ps:tc/ps+1);
	}
	public void setTp(Integer tp) {
		this.tp = tp;
	}
	public Integer getSp() {
		return (pi-1)*ps;
	}
	public void setSp(Integer sp) {
		this.sp = sp;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
}
