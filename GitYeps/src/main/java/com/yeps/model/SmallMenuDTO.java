package com.yeps.model;

import java.util.List;

public class SmallMenuDTO {
	
	private List<SmallMenuDTO> smallMenuList;
	private int small_menunum;
	private int large_menunum;
	private String small_name;
	private String small_content;
	private int small_price;
	private LargeMenuDTO largeMenuDTO;
	
	
	
	public LargeMenuDTO getLargeMenuDTO() {
		return largeMenuDTO;
	}
	public void setLargeMenuDTO(LargeMenuDTO largeMenuDTO) {
		this.largeMenuDTO = largeMenuDTO;
	}
	public List<SmallMenuDTO> getSmallMenuList() {
		return smallMenuList;
	}
	public void setSmallMenuList(List<SmallMenuDTO> smallMenuList) {
		this.smallMenuList = smallMenuList;
	}
	public int getSmall_menunum() {
		return small_menunum;
	}
	public void setSmall_menunum(int small_menunum) {
		this.small_menunum = small_menunum;
	}
	public int getLarge_menunum() {
		return large_menunum;
	}
	public void setLarge_menunum(int large_menunum) {
		this.large_menunum = large_menunum;
	}
	public String getSmall_name() {
		return small_name;
	}
	public void setSmall_name(String small_name) {
		this.small_name = small_name;
	}
	public String getSmall_content() {
		return small_content;
	}
	public void setSmall_content(String small_content) {
		this.small_content = small_content;
	}
	public int getSmall_price() {
		return small_price;
	}
	public void setSmall_price(int small_price) {
		this.small_price = small_price;
	}
	
	
	
}
