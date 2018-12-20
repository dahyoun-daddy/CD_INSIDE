package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.BoardVO;


@Repository
public class BoardDAOImple implements BoardDAO{

	
	Logger  log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.board";
	
	/**
	 * 인기글조회
	 */
	@Override
	public List<BoardVO> do_hitretreive(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".do_hitretreive";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		List<BoardVO> list  = this.sqlSession.selectList(statement, boardVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}
	
	/**
	 * 쌍용게시글 작성
	 */
	@Override
	public int addSY(BoardVO boardVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".addSY";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		int flag  = this.sqlSession.insert(statement, boardVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	/**
	 * 링크게시글 작성
	 */
	@Override
	public int addLK(BoardVO boardVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".addLK";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		int flag  = this.sqlSession.insert(statement, boardVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	
	
	/**
	 * 댓글 단건 조회
	 */
	@Override
	public BoardVO get(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".get";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		BoardVO outVO = this.sqlSession.selectOne(statement, boardVO);
		log.debug("3.outVO: "+outVO);
		return outVO;
	}


	/**
	 * 전체조회
	 */
	@Override
	public List<BoardVO> do_retrieve(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".do_retrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		List<BoardVO> list  = this.sqlSession.selectList(statement, boardVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}

	
	/**
	 * 카테고리 별 조회
	 */
	@Override
	public List<BoardVO> do_cateret(BoardVO boardVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".do_cateret";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+boardVO);
		List<BoardVO> list  = this.sqlSession.selectList(statement, boardVO);
		log.info("*****************************");
		log.info("3.list: "+list);
		log.info("*****************************");
		return list;	
	}


	/**
	 * 게시글 수정
	 */
	@Override
	public int update(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".update";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		int flag  = this.sqlSession.insert(statement, boardVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

//========================================================= 추천 수 ======================================================//
	@Override
	public int do_code_getCount(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".do_code_getCount";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+boardVO);
		int flag  = this.sqlSession.selectOne(statement, boardVO);
		log.info("3.flag: "+flag);

		return flag;
	}

	@Override
	public int do_code_insert(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".do_code_insert";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+boardVO);
		int flag  = this.sqlSession.update(statement, boardVO);
		log.info("3.flag: "+flag);
		
		return flag;
	}

	@Override
	public int do_hit(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".do_hit";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+boardVO);
		int flag  = this.sqlSession.update(statement, boardVO);
		log.info("3.flag: "+flag);
		
		return flag;
	}
	
	
	@Override
	public int cnt(BoardVO boardVO) throws SQLException, RuntimeException {
		String statement = NAME_SPACE + ".viewcnt";
		log.debug("1.statement: " + statement);
		log.debug("2.param: " + boardVO);
		int flag = this.sqlSession.insert(statement, boardVO);
		log.debug("3.flag: " + flag);
		return flag;

	}
	
	
//========================================================= 추천 수 ======================================================//
	
	/**
	 * 게시글 삭제
	 */
	@Override
	public int delete(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".delete";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		int flag  = this.sqlSession.delete(statement, boardVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	
	@Override
	public int viewcnt(BoardVO boardVO) throws SQLException {
		String statement = NAME_SPACE+".viewcnt";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		int flag  = this.sqlSession.insert(statement, boardVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

	
	
}
