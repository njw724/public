package com.yeps.model;

public class QnADTO {
   private int qnum;
   private int mnum;
   private String title;
   private String writer;
   private String content;
   private String secret;
   private String regdate;
   private int readcount;
   private String ip;
   private String reply;
   
   public int getQnum() {
      return qnum;
   }
   public void setQnum(int qnum) {
      this.qnum = qnum;
   }
   public int getMnum() {
      return mnum;
   }
   public void setMnum(int mnum) {
      this.mnum = mnum;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title = title;
   }
   public String getWriter() {
      return writer;
   }
   public void setWriter(String writer) {
      this.writer = writer;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getSecret() {
      return secret;
   }
   public void setSecret(String secret) {
      this.secret = secret;
   }
   public String getRegdate() {
      return regdate;
   }
   public void setRegdate(String regdate) {
      this.regdate = regdate;
   }
   public int getReadcount() {
      return readcount;
   }
   public void setReadcount(int readcount) {
      this.readcount = readcount;
   }
   public String getIp() {
      return ip;
   }
   public void setIp(String ip) {
      this.ip = ip;
   }
   public String getReply() {
      return reply;
   } 
   public void setReply(String reply) {
      this.reply = reply;
   }
   
   
}