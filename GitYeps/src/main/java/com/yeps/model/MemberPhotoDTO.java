package com.yeps.model;

public class MemberPhotoDTO {
	private int filenum;
	private int mnum;
	private String member_filename;
	private String origin_filename;
	private int filesize;
	private String file_caption;
	private String file_upload_date;
	private String ismainphoto;

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

	public String getMember_filename() {
		return member_filename;
	}

	public void setMember_filename(String member_filename) {
		this.member_filename = member_filename;
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

	public String getFile_caption() {
		return file_caption;
	}

	public void setFile_caption(String file_caption) {
		this.file_caption = file_caption;
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
}