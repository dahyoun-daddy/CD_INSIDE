package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.dao.BoardDAO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CommentVO;




@Service
public class BoardSvcImple implements BoardSvc {
	private Logger log = LoggerFactory.getLogger(UserSvcImple.class);
	
	private SqlSessionTemplate sqlSession;
	private final String NAME_SPACE ="com.sist.cd.mappers.board";
	
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
	public List<BoardVO> do_retrieve(BoardVO boardVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.do_retrieve(boardVO);
	}
	
	@Override
	public List<BoardVO> do_cateret(BoardVO boardVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return bd.do_cateret(boardVO);
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
	
	
	@Override
	public int do_code_getCount(BoardVO boardVO) throws SQLException {
		return bd.do_code_getCount(boardVO);
	}

	@Override
	public int do_code_insert(BoardVO boardVO) throws SQLException {
		return bd.do_code_insert(boardVO);
	}

	@Override
	public int do_hit(BoardVO boardVO) throws SQLException {
		
		int flag;
		if(bd.do_code_getCount(boardVO) == 1) {
			log.info("이미 추천한 아이디가 존재합니다.");
			flag = -1;
			log.info("flag\n"+flag);
		}else {

			flag = bd.do_code_insert(boardVO);
			log.info("code테이블에 값을 주입시켰습니다.\n"+flag);
			flag = bd.do_hit(boardVO);
			log.info("추천수 + 1"+flag);
		}
		return flag;
	}
	
	@Override
	public int cnt(BoardVO boardVO) throws SQLException, RuntimeException {
		return bd.viewcnt(boardVO);

	}
	
	
	
	}
	

	

