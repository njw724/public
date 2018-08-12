package com.yeps.model;

public class MessageDTO {

	private int msgNum;
	private int mnum;//맴버 로그인시 회원정보 가져올 외래키
	private int evnum;
	private int rvnum;
	private String title;
	private String receiver;//받은 사람(로그인 회원과 연동되게)
	private String sender;//보낸사람(로그인 회원과 연동되게)
	private String content;
	private String reg_date;//받은 시각 표시
	private String readDate;//읽은 시각 표시
	private int readNum;//읽음, 안읽음 표시 위한 옵션
	private int isLocker;//보관함쪽지 확인 옵션
	private int isIssue;
	
	
	public int getIsIssue() {
		return isIssue;
	}
	public void setIsIssue(int isIssue) {
		this.isIssue = isIssue;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getIsLocker() {
		return isLocker;
	}
	public void setIsLocker(int isLocker) {
		this.isLocker = isLocker;
	}
	
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public int getMsgNum() {
		return msgNum;
	}
	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
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
	public String getReadDate() {
		return readDate;
	}
	public void setReadDate(String readDate) {
		this.readDate = readDate;
	}
	public int getEvnum() {
		return evnum;
	}
	public void setEvnum(int evnum) {
		this.evnum = evnum;
	}
	public int getRvnum() {
		return rvnum;
	}
	public void setRvnum(int rvnum) {
		this.rvnum = rvnum;
	}
	
}
