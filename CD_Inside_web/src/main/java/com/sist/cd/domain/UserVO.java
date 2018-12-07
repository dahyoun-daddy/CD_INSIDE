package com.sist.cd.domain;

public class UserVO {

	private String userId   ; /**아이디  */
	private String userName ; /**이름    */
	private String userPw   ; /**비밀번호*/
	private String userEmail; /**이메일  */
	private String userQues ; /**질의응답*/
	private String userAnsw ; /**답변    */
	private String userYn   ; /**관리자유*/
	private String regDt    ; /**등록일  */
	private String modId    ; /**수정자  */
	private String modDt    ; /**수정일  */

	
	public UserVO(){}
	
	/* (non-Javadoc)

	 * @see java.lang.Object#toString()

	 */

	@Override

	public String toString() {

		return "UserVO [userId=" + userId + ", userName=" + userName + ", userPw=" + userPw + ", userEmail=" + userEmail

				+ ", userQues=" + userQues + ", userAnsw=" + userAnsw + ", userYn=" + userYn + ", regDt=" + regDt

				+ ", modId=" + modId + ", modDt=" + modDt + "]";

	}

	public UserVO(String userId, String userName, String userPw, String userEmail, String userQues, String userAnsw,
			String userYn, String regDt, String modId, String modDt) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPw = userPw;
		this.userEmail = userEmail;
		this.userQues = userQues;
		this.userAnsw = userAnsw;
		this.userYn = userYn;
		this.regDt = regDt;
		this.modId = modId;
		this.modDt = modDt;
	}

	public UserVO(String userId, String userName, String userPw, String userEmail, String userQues, String userAnsw,
			String modId) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPw = userPw;
		this.userEmail = userEmail;
		this.userQues = userQues;
		this.userAnsw = userAnsw;
		this.modId = modId;
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

	 * @return the userName

	 */

	public String getUserName() {

		return userName;

	}

	/**

	 * @param userName the userName to set

	 */

	public void setUserName(String userName) {

		this.userName = userName;

	}

	/**

	 * @return the userPw

	 */

	public String getUserPw() {

		return userPw;

	}

	/**

	 * @param userPw the userPw to set

	 */

	public void setUserPw(String userPw) {

		this.userPw = userPw;

	}

	/**

	 * @return the userEmail

	 */

	public String getUserEmail() {

		return userEmail;

	}

	/**

	 * @param userEmail the userEmail to set

	 */

	public void setUserEmail(String userEmail) {

		this.userEmail = userEmail;

	}

	/**

	 * @return the userQues

	 */

	public String getUserQues() {

		return userQues;

	}

	/**

	 * @param userQues the userQues to set

	 */

	public void setUserQues(String userQues) {

		this.userQues = userQues;

	}

	/**

	 * @return the userAnsw

	 */

	public String getUserAnsw() {

		return userAnsw;

	}

	/**

	 * @param userAnsw the userAnsw to set

	 */

	public void setUserAnsw(String userAnsw) {

		this.userAnsw = userAnsw;

	}

	/**

	 * @return the userYn

	 */

	public String getUserYn() {

		return userYn;

	}

	/**

	 * @param userYn the userYn to set

	 */

	public void setUserYn(String userYn) {

		this.userYn = userYn;

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

	

}
