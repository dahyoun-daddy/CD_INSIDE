package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.UserVO;

public interface UserSvc {

	int do_deleteMulti(List<UserVO> list) throws RuntimeException, SQLException;
	
	
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

	/**등록
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	int save(UserVO userVO) throws DuplicateUserIdException;

	List<UserVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

	/**
	 * 단건조회
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	UserVO selectOne(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
}
