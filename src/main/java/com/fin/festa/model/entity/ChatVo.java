package com.fin.festa.model.entity;

import java.sql.Date;

public class ChatVo {

	String chatName;
	String chatId;
	String chatContent;
	String chatGrnum;
	Date chatTime;
	public ChatVo() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
		return "ChatVo [chatName=" + chatName + ", chatId=" + chatId + ", chatContent=" + chatContent + ", chatGrnum="
				+ chatGrnum + ", chatTime=" + chatTime + "]";
	}
	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatGrnum() {
		return chatGrnum;
	}
	public void setChatGrnum(String chatGrnum) {
		this.chatGrnum = chatGrnum;
	}
	public Date getChatTime() {
		return chatTime;
	}
	public void setChatTime(Date chatTime) {
		this.chatTime = chatTime;
	}
	public ChatVo(String chatName, String chatId, String chatContent, String chatGrnum, Date chatTime) {
		super();
		this.chatName = chatName;
		this.chatId = chatId;
		this.chatContent = chatContent;
		this.chatGrnum = chatGrnum;
		this.chatTime = chatTime;
	}
	
}
