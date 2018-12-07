package com.sist.cd.domain;

import com.sist.cd.common.DTO;

public class GallogVO extends DTO{
	
	private String gSeq; //시퀀스
	private String userId; // 유저 아이디
	private String gId;    // 방명록 아이디
	private String gPw;	// 방명록 비밀번호
	private String gTitle; // 제목
	private String gCont;  // 내용
	private String gCate;  // 메모장(0), 방명록(1) 구분자 
	private String regDt;  // 등록일
	private String modId;  // 수정자 아이디
	private String modDt;  // 수정일
	
	public GallogVO() {}
	
	public GallogVO(String gSeq, String userId, String gId, String gPw, String gTitle, String gCont, String gCate,
			String regDt, String modId, String modDt) {
		super();
		this.gSeq = gSeq;
		this.userId = userId;
		this.gId = gId;
		this.gPw = gPw;
		this.gTitle = gTitle;
		this.gCont = gCont;
		this.gCate = gCate;
		this.regDt = regDt;
		this.modId = modId;
		this.modDt = modDt;
	}


	public String getgSeq() {
		return gSeq;
	}


	public void setgSeq(String gSeq) {
		this.gSeq = gSeq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getgId() {
		return gId;
	}


	public void setgId(String gId) {
		this.gId = gId;
	}


	public String getgPw() {
		return gPw;
	}


	public void setgPw(String gPw) {
		this.gPw = gPw;
	}


	public String getgTitle() {
		return gTitle;
	}


	public void setgTitle(String gTitle) {
		this.gTitle = gTitle;
	}


	public String getgCont() {
		return gCont;
	}


	public void setgCont(String gCont) {
		this.gCont = gCont;
	}


	public String getgCate() {
		return gCate;
	}


	public void setgCate(String gCate) {
		this.gCate = gCate;
	}


	public String getRegDt() {
		return regDt;
	}


	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}


	public String getModId() {
		return modId;
	}


	public void setModId(String modId) {
		this.modId = modId;
	}


	public String getModDt() {
		return modDt;
	}


	public void setModDt(String modDt) {
		this.modDt = modDt;
	}


	@Override
	public String toString() {
		return "GallogVO [gSeq=" + gSeq + ", userId=" + userId + ", gId=" + gId + ", gPw=" + gPw + ", gTitle=" + gTitle
				+ ", gCont=" + gCont + ", gCate=" + gCate + ", regDt=" + regDt + ", modId=" + modId + ", modDt=" + modDt
				+ "]";
	}
	

	

	
	
	
}

