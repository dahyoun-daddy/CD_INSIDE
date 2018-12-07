package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.MsgVO;


public interface MsgDAO { 

	/**
	 * 단건 등록
	 */
	int do_upsert(MsgVO msgVO) throws SQLException;	
	
	/**
	 * 단건삭제
	 */
	int delete(MsgVO msgVO) throws SQLException;
	
	/**
	 * 수정
	 */
	int update(MsgVO msgVO) throws SQLException;
	
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

	int add(MsgVO msgVO) throws DuplicateUserIdException;

	List<MsgVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	List<MsgVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	

	/**
	 * 단건조회
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	MsgVO get(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

}