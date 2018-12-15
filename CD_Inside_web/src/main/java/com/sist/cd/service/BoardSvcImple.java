package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DTO;
import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.BoardDAO;
import com.sist.cd.domain.BoardVO;

@Service
public class BoardSvcImple implements BoardSvc {
	private Logger log = LoggerFactory.getLogger(UserSvcImple.class);
	
	@Autowired
	private BoardDAO bd;
	
	@Override
	public int addSY(BoardVO boardVO) throws DuplicateUserIdException {
		
		return bd.addSY(boardVO);
	}

	@Override
	public int addLK(BoardVO boardVO) throws DuplicateUserIdException {
		return bd.addLK(boardVO);
	}
	

	@Override
	public BoardVO get(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.get(boardVO);
	}

	@Override
	public List<BoardVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.do_retrieve(searchVO);
	}
	
	@Override
	public List<BoardVO> do_cateret(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.do_cateret(searchVO);
	}

	@Override
	public int update(BoardVO boardVO) throws SQLException {
		return bd.update(boardVO);
	}

	@Override
	public int delete(BoardVO boardVO) throws SQLException {
		return bd.delete(boardVO);
	}

	@Override
	public List<BoardVO> do_hitretreive(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.do_hitretreive(boardVO);
	}

	
}
