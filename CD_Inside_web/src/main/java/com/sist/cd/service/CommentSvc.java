package com.sist.cd.service;


import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.CommentVO;

public interface CommentSvc {
	
	/**
	 * 추천 코드테이블 확인해서 추천
	 * @param commentVO
	 * @throws SQLException
	 * @throws RuntimeException
	 */
	void onehit(CommentVO commentVO) throws SQLException, RuntimeException;
	
	/**
	 * 댓글 추가
	 * @param inVO1
	 * @return
	 * @throws DuplicateUserIdException
	 */
	int add(CommentVO commentVO) throws DuplicateUserIdException,SQLException;

	/**
	 * 댓글 삭제
	 * @param userVO
	 * @return
	 * @throws SQLException
	 */
	int delete(CommentVO commentVO) throws SQLException;
	
	/**
	 * 댓글 수정
	 * @param userVO
	 * @return
	 * @throws SQLException
	 */
	int update(CommentVO commentVO) throws SQLException;
	
	/**
	 * 댓글 단건조회
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	CommentVO get(CommentVO commentVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	/**
	 * 댓글 삽입
	 * @param inVO1
	 * @return
	 * @throws DuplicateUserIdException
	 */
	int addreply(CommentVO commentVO) throws DuplicateUserIdException, SQLException;
	
	/**
	 * 댓글 출력
	 * @param searchVO
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	List<CommentVO> do_retrieve(CommentVO commentVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	/**
	 * 댓글 code 테이블 검색
	 * @throws SQLException 
	 */
	int do_code_getCount(CommentVO commentVO) throws SQLException;
	
	/**
	 * 댓글 code 테이블 댓글번호,아이디 추가
	 * @param commentVO
	 * @return
	 * @throws SQLException
	 */
	int do_code_insert(CommentVO commentVO) throws SQLException;

	/**
	 * 댓글 추천 +1
	 * @param commentVO
	 * @return
	 * @throws SQLException
	 */
	int do_hit(CommentVO commentVO) throws SQLException;
	
	/** 
	 * 댓글 출력
	 * @param searchVO
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	List<CommentVO> scroll_retrieve(CommentVO commentVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

	List<CommentVO> scroll_reply_retrieve(CommentVO commentVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
}
