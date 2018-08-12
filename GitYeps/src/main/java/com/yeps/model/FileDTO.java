package com.yeps.model;

public class FileDTO {
	private int filenum;
	private int mnum;
	private int rnum;
	private int rvnum;
	private int evnum;
	private String filename;
	private String origin_filename;
	private int filesize;
	private String file_content;
	private String file_upload_date;
	private String ismainphoto;
	private MemberDTO memberDTO;
	private RestaurantDTO restaurantDTO;
	
	public int getFilenum() {
		return filenum;
	}
	public void setFilenum(int filenum) {
		this.filenum = filenum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getRvnum() {
		return rvnum;
	}
	public void setRvnum(int rvnum) {
		this.rvnum = rvnum;
	}
	public int getEvnum() {
		return evnum;
	}
	public void setEvnum(int evnum) {
		this.evnum = evnum;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrigin_filename() {
		return origin_filename;
	}
	public void setOrigin_filename(String origin_filename) {
		this.origin_filename = origin_filename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public String getFile_content() {
		return file_content;
	}
	public void setFile_content(String file_content) {
		this.file_content = file_content;
	}
	public String getFile_upload_date() {
		return file_upload_date;
	}
	public void setFile_upload_date(String file_upload_date) {
		this.file_upload_date = file_upload_date;
	}
	public String getIsmainphoto() {
		return ismainphoto;
	}
	public void setIsmainphoto(String ismainphoto) {
		this.ismainphoto = ismainphoto;
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
