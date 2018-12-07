package com.sist.cd.domain;

import com.sist.cd.common.DTO;

public class BoardVO extends DTO{

	private String bNum;
	private String userId;
	private String bTitle;
	private String bCont;
	private String bCate;
	private String bHit;
	private String regDt;
	private String modId;
	private String modDt;
	private String bCnt;
	
	
	public String getbNum() {
		return bNum;
	}
	public void setbNum(String bNum) {
		this.bNum = bNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbCont() {
		return bCont;
	}
	public void setbCont(String bCont) {
		this.bCont = bCont;
	}
	public String getbCate() {
		return bCate;
	}
	public void setbCate(String bCate) {
		this.bCate = bCate;
	}
	public String getbHit() {
		return bHit;
	}
	public void setbHit(String bHit) {
		this.bHit = bHit;
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
	public String getbCnt() {
		return bCnt;
	}
	public void setbCnt(String bCnt) {
		this.bCnt = bCnt;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bNum=" + bNum + ", userId=" + userId + ", bTitle=" + bTitle + ", bCont=" + bCont + ", bCate="
				+ bCate + ", bHit=" + bHit + ", regDt=" + regDt + ", modId=" + modId + ", modDt=" + modDt + ", bCnt="
				+ bCnt + "]";
	}
	
	public BoardVO(String bNum, String userId, String bTitle, String bCont, String bCate, String bHit, String regDt,
			String modId, String modDt, String bCnt) {
		super();
		this.bNum = bNum;
		this.userId = userId;
		this.bTitle = bTitle;
		this.bCont = bCont;
		this.bCate = bCate;
		this.bHit = bHit;
		this.regDt = regDt;
		this.modId = modId;
		this.modDt = modDt;
		this.bCnt = bCnt;
	}
	
	public BoardVO() {}
	
	
	
	
	
	
}
