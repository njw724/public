package com.yeps.model;

public class MemberDTO {
	private int mnum;
	private String name;
	private String ssn1;
	private String ssn2;
	private String email;
	private String passwd;
	private String joindate;
	private int reviewcount;
	private int imagecount;
	private String ismaster;
	private String ismanager;
	private String controlcate;
	private String controlevent;
	private String controlmember;
	private String controlstore;
	private String controlreview;
	private String salt;
	private String nickname;
	private String address;
	private MemberPhotoDTO memberPhotoDTO;

	public int getMnum() {
		return mnum;
	}

	public void setMnum(int mnum) {
		this.mnum = mnum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSsn1() {
		return ssn1;
	}

	public void setSsn1(String ssn1) {
		this.ssn1 = ssn1;
	}

	public String getSsn2() {
		return ssn2;
	}

	public void setSsn2(String ssn2) {
		this.ssn2 = ssn2;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	public int getReviewcount() {
		return reviewcount;
	}

	public void setReviewcount(int reviewcount) {
		this.reviewcount = reviewcount;
	}

	public int getImagecount() {
		return imagecount;
	}

	public void setImagecount(int imagecount) {
		this.imagecount = imagecount;
	}

	public String getIsmaster() {
		return ismaster;
	}

	public void setIsmaster(String ismaster) {
		this.ismaster = ismaster;
	}

	public String getIsmanager() {
		return ismanager;
	}

	public void setIsmanager(String ismanager) {
		this.ismanager = ismanager;
	}

	public String getControlcate() {
		return controlcate;
	}

	public void setControlcate(String controlcate) {
		this.controlcate = controlcate;
	}

	public String getControlevent() {
		return controlevent;
	}

	public void setControlevent(String controlevent) {
		this.controlevent = controlevent;
	}

	public String getControlmember() {
		return controlmember;
	}

	public void setControlmember(String controlmember) {
		this.controlmember = controlmember;
	}

	public String getControlstore() {
		return controlstore;
	}

	public void setControlstore(String controlstore) {
		this.controlstore = controlstore;
	}

	public String getControlreview() {
		return controlreview;
	}

	public void setControlreview(String controlreview) {
		this.controlreview = controlreview;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	public MemberPhotoDTO getMemberPhotoDTO() {
		return memberPhotoDTO;
	}

	public void setMemberPhotoDTO(MemberPhotoDTO memberPhotoDTO) {
		this.memberPhotoDTO = memberPhotoDTO;
	}

	@Override
	public int hashCode() {
		return email.hashCode();
	}
	
	
	// 중복제거 위한 코드
	@Override
	public boolean equals(Object obj) {
		if(!(obj instanceof MemberDTO)) {
			return false;
		}

		MemberDTO s = (MemberDTO)obj;
		return email.equals(s.email);
	}
}
