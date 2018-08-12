package com.yeps.model;

public class ReviewDTO {
	
	private int rvnum;
	private int rnum;         
	private int mnum;
	private String content;
	private String reg_date;
	private int gradepoint;
	private int filenum;
	private String ip;
	private String recentreview;
	private MemberDTO memberDTO;
	private RestaurantDTO restaurantDTO;
	
	public int getRvnum() {
		return rvnum;
	}
	public void setRvnum(int rvnum) {
		this.rvnum = rvnum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getGradepoint() {
		return gradepoint;
	}
	public void setGradepoint(int gradepoint) {
		this.gradepoint = gradepoint;
	}
	public int getFilenum() {
		return filenum;
	}
	public void setFilenum(int filenum) {
		this.filenum = filenum;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getRecentreview() {
		return recentreview;
	}
	public void setRecentreview(String recentreview) {
		this.recentreview = recentreview;
	}
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}
	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	public RestaurantDTO getRestaurantDTO() {
		return restaurantDTO;
	}
	public void setRestaurantDTO(RestaurantDTO restaurantDTO) {
		this.restaurantDTO = restaurantDTO;
	}	
}
