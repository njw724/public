package com.yeps.model;

public class EventReviewDTO {
	private int eventReview_num;			// 
	private int evnum;						// 
	private int mnum;						//
	private String eventReview_writer;
	private String eventReview_content;
	private String eventReview_writedate;
	private String ip;
	private MemberDTO memberDTO;
	private EventDTO eventDTO;
	
	public int getEventReview_num() {
		return eventReview_num;
	}
	public void setEventReview_num(int eventReview_num) {
		this.eventReview_num = eventReview_num;
	}
	public int getEvnum() {
		return evnum;
	}
	public void setEvnum(int evnum) {
		this.evnum = evnum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getEventReview_writer() {
		return eventReview_writer;
	}
	public void setEventReview_writer(String eventReview_writer) {
		this.eventReview_writer = eventReview_writer;
	}
	public String getEventReview_content() {
		return eventReview_content;
	}
	public void setEventReview_content(String eventReview_content) {
		this.eventReview_content = eventReview_content;
	}
	public String getEventReview_writedate() {
		return eventReview_writedate;
	}
	public void setEventReview_writedate(String eventReview_writedate) {
		this.eventReview_writedate = eventReview_writedate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}
	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	public EventDTO getEventDTO() {
		return eventDTO;
	}
	public void setEventDTO(EventDTO eventDTO) {
		this.eventDTO = eventDTO;
	}
}
