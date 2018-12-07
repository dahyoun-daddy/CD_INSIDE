package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DTO;
import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CommentVO;


public interface BoardDAO {

	/**
	 * 게시글 단건조회
	 * @param userVO
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	BoardVO get(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	
	/**
	 * 게시판 전체 조회
	 * @param searchVO
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	List<BoardVO> do_retrieve(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	
	/**
	 * 게시글 삭제
	 * @param userVO
	 * @return
	 * @throws SQLException
	 */
	int delete(BoardVO boardVO) throws SQLException;
	
}
