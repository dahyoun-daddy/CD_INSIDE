package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.GallogVO;

public interface BoardSvc {

	/**
	 * 쌍용게시글 작성
	 * @param inVO1
	 * @return
	 * @throws DuplicateUserIdException
	 */
	int addSY(BoardVO boardVO) throws DuplicateUserIdException;
	
	/**
	 * 링크게시글 작성
	 * @param inVO1
	 * @return
	 * @throws DuplicateUserIdException
	 */
	int addLK(BoardVO boardVO) throws DuplicateUserIdException;
	
	
	
	/**
	 * 게시글 단건조회
	 * @param userVO판
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	BoardVO get(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	/**
	 * 게시판 전체 조회
	 * @param boardVO
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	List<BoardVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	/**
	 * 카테고리 별 조회
	 * @param boardVO
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	List<BoardVO> do_cateret(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	
	
	/**
	 * 게시글 수정
	 * @param userVO
	 * @return
	 * @throws SQLException
	 */
	int update(BoardVO boardVO) throws SQLException;
	
	
	/**
	 * 게시글 삭제
	 * @param userVO
	 * @return
	 * @throws SQLException
	 */
	int delete(BoardVO boardVO) throws SQLException;
	
}
