package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.UserVO;

public interface UserDAO {


	/**
	 * 일반유저 정보수정 
	 */
	int uUpdate (UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;
	
	/**
	 * 비밀번호 찾기>비밀번호 변경
	 */
	int pwFindUpdate (UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;
	
	/**
	 * 비밀번호 찾기
	 */
	String pwFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;

	/**
	 * 아이디 찾기
	 */
	String idFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;
	
	/**
	 * 이름(닉네임)중복확인
	 */
	String nameCheck(String userName) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;
	
	/**
	 * id중복확인
	 */
	String idCheck(String userId) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException ;
	
	/**
	 * 단건삭제
	 */
	int delete(UserVO userVO) throws SQLException;
	
	/**
	 * 수정
	 */
	int update(UserVO userVO) throws SQLException;
	
	/**
	 * 조회 COUNT
	 * @throws SQLException 
	 */
	int getCount(String userId) throws SQLException;
   

	/**
	 * 추가:115
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */

	int save(UserVO userVO) throws DuplicateUserIdException;

	List<UserVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	List<UserVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	

	/**
	 * 단건조회
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	UserVO selectOne(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

}