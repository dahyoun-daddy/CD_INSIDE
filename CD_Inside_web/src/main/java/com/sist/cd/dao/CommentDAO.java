package com.sist.cd.dao;

import java.sql.SQLException;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.CommentVO;

public interface CommentDAO {

	/**
	 * 댓글 추가
	 * @param inVO1
	 * @return
	 * @throws DuplicateUserIdException
	 */
	int add(CommentVO commentVO) throws DuplicateUserIdException;

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
	int addreply(CommentVO commentVO) throws DuplicateUserIdException;
	
}
