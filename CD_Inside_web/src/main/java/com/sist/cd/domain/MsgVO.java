package com.sist.cd.domain;

import com.sist.cd.common.DTO;

public class MsgVO extends DTO{

	
	private String msgSeq;
	private String userId;
	private String msgRecvId;
	private String msgCont;
	private String regDt;
	private String msgReadYn;
	private String msgSdelYn;
	private String msgYdelYn;

	public MsgVO() {
		
	}

	public String getMsgSeq() {
		return msgSeq;
	}

	public void setMsgSeq(String msgSeq) {
		this.msgSeq = msgSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMsgRecvId() {
		return msgRecvId;
	}

	public void setMsgRecvId(String msgRecvId) {
		this.msgRecvId = msgRecvId;
	}

	public String getMsgCont() {
		return msgCont;
	}

	public void setMsgCont(String msgCont) {
		this.msgCont = msgCont;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getMsgReadYn() {
		return msgReadYn;
	}

	public void setMsgReadYn(String msgReadYn) {
		this.msgReadYn = msgReadYn;
	}

	public String getMsgSdelYn() {
		return msgSdelYn;
	}

	public void setMsgSdelYn(String msgSdelYn) {
		this.msgSdelYn = msgSdelYn;
	}

	public String getMsgYdelYn() {
		return msgYdelYn;
	}

	public void setMsgYdelYn(String msgYdelYn) {
		this.msgYdelYn = msgYdelYn;
	}

	@Override
	public String toString() {
		return "MsgVO [msgSeq=" + msgSeq + ", userId=" + userId + ", msgRecvId=" + msgRecvId + ", msgCont=" + msgCont
				+ ", regDt=" + regDt + ", msgReadYn=" + msgReadYn + ", msgSdelYn=" + msgSdelYn + ", msgYdelYn="
				+ msgYdelYn + "]";
	}

	public MsgVO(String msgSeq, String userId, String msgRecvId, String msgCont, String regDt, String msgReadYn,
			String msgSdelYn, String msgYdelYn) {
		super();
		this.msgSeq = msgSeq;
		this.userId = userId;
		this.msgRecvId = msgRecvId;
		this.msgCont = msgCont;
		this.regDt = regDt;
		this.msgReadYn = msgReadYn;
		this.msgSdelYn = msgSdelYn;
		this.msgYdelYn = msgYdelYn;
	}

	
}
