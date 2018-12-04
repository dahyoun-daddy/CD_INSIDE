package com.sist.cd.domain;

import com.sist.cd.common.DTO;

public class CommentVO extends DTO{

	private String commTextNum	     ;
	private String bNum              ;
	private String commCont          ;
	private String userId            ;
	private String commHit           ;
	private String commGroupNo       ;
	private String commDepth         ;
	private String regDt             ;
	private String modId             ;
	private String modDt             ;
	
	public CommentVO() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the commTextNum
	 */
	public String getCommTextNum() {
		return commTextNum;
	}

	/**
	 * @param commTextNum the commTextNum to set
	 */
	public void setCommTextNum(String commTextNum) {
		this.commTextNum = commTextNum;
	}

	/**
	 * @return the bNum
	 */
	public String getbNum() {
		return bNum;
	}

	/**
	 * @param bNum the bNum to set
	 */
	public void setbNum(String bNum) {
		this.bNum = bNum;
	}

	/**
	 * @return the commCont
	 */
	public String getCommCont() {
		return commCont;
	}

	/**
	 * @param commCont the commCont to set
	 */
	public void setCommCont(String commCont) {
		this.commCont = commCont;
	}

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * @return the commHit
	 */
	public String getCommHit() {
		return commHit;
	}

	/**
	 * @param commHit the commHit to set
	 */
	public void setCommHit(String commHit) {
		this.commHit = commHit;
	}

	/**
	 * @return the commGroupNo
	 */
	public String getCommGroupNo() {
		return commGroupNo;
	}

	/**
	 * @param commGroupNo the commGroupNo to set
	 */
	public void setCommGroupNo(String commGroupNo) {
		this.commGroupNo = commGroupNo;
	}

	/**
	 * @return the commDepth
	 */
	public String getCommDepth() {
		return commDepth;
	}

	/**
	 * @param commDepth the commDepth to set
	 */
	public void setCommDepth(String commDepth) {
		this.commDepth = commDepth;
	}

	/**
	 * @return the regDt
	 */
	public String getRegDt() {
		return regDt;
	}

	/**
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}

	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * @return the modDt
	 */
	public String getModDt() {
		return modDt;
	}

	/**
	 * @param modDt the modDt to set
	 */
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CommVO [commTextNum=" + commTextNum + ", bNum=" + bNum + ", commCont=" + commCont + ", userId=" + userId
				+ ", commHit=" + commHit + ", commGroupNo=" + commGroupNo + ", commDepth=" + commDepth + ", regDt="
				+ regDt + ", modId=" + modId + ", modDt=" + modDt + "]";
	}

	public CommentVO(String commTextNum, String bNum, String commCont, String userId, String commHit, String commGroupNo,
			String commDepth, String regDt, String modId, String modDt) {
		super();
		this.commTextNum = commTextNum;
		this.bNum = bNum;
		this.commCont = commCont;
		this.userId = userId;
		this.commHit = commHit;
		this.commGroupNo = commGroupNo;
		this.commDepth = commDepth;
		this.regDt = regDt;
		this.modId = modId;
		this.modDt = modDt;
	}
	
}
