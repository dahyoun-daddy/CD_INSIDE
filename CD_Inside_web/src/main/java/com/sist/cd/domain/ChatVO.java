package com.sist.cd.domain;

public class ChatVO {
	
	private String chatName;
	private String userId;
	private String chatCont;
	private String regDt;

	public ChatVO() {
		
	}
	
	public ChatVO(String chatName, String userId, String chatCont, String regDt) {
		super();
		this.chatName = chatName;
		this.userId = userId;
		this.chatCont = chatCont;
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "ChatVO [chatName=" + chatName + ", userId=" + userId + ", chatCont=" + chatCont + ", regDt=" + regDt
				+ "]";
	}

	public String getChatName() {
		return chatName;
	}

	public void setChatName(String chatName) {
		this.chatName = chatName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getChatCont() {
		return chatCont;
	}

	public void setChatCont(String chatCont) {
		this.chatCont = chatCont;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}


	
	

}
