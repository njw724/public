package com.yeps.model;

import java.util.List;

public class LargeMenuDTO {
	private List<LargeMenuDTO> largeMenuList;
	private int large_menunum;
	private int rnum;
	private String large_name;
	public List<LargeMenuDTO> getLargeMenuList() {
		return largeMenuList;
	}
	public void setLargeMenuList(List<LargeMenuDTO> largeMenuList) {
		this.largeMenuList = largeMenuList;
	}
	public int getLarge_menunum() {
		return large_menunum;
	}
	public void setLarge_menunum(int large_menunum) {
		this.large_menunum = large_menunum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getLarge_name() {
		return large_name;
	}
	public void setLarge_name(String large_name) {
		this.large_name = large_name;
	}
	
	
	
	
	
}
