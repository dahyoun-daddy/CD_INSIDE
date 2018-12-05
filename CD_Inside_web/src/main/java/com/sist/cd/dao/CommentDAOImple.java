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
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.CommentVO;

@Repository
public class CommentDAOImple implements CommentDAO{

	Logger  log = LoggerFactory.getLogger(this.getClass());
    
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.comment";
	
	public CommentDAOImple() {
		
	}
	
	/**
	 *  댓글 추가
	 */
	public int add(CommentVO commentVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".add";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		int flag  = this.sqlSession.update(statement, commentVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}
	
	/**
	 * 댓글 삭제
	 */
	public int delete(CommentVO CommentVO) throws SQLException {
		String statement = NAME_SPACE+".delete";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+CommentVO);
		int flag  = this.sqlSession.delete(statement, CommentVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

	/**
	 * 댓글 수정
	 */
	public int update(CommentVO CommentVO) throws SQLException {
		String statement = NAME_SPACE+".update";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+CommentVO);
		int flag  = this.sqlSession.update(statement, CommentVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	/**
	 * 댓글 단건 조회
	 */
	@Override
	public CommentVO get(CommentVO commentVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".get";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		CommentVO outVO = this.sqlSession.selectOne(statement, commentVO);
		log.debug("3.outVO: "+outVO);

		return outVO;
	}

	/**
	 * 댓글 답글 달기
	 */
	public int addreply(CommentVO commentVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".addreply";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		int flag  = this.sqlSession.update(statement, commentVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}
	
	/**
	 * 
	 * @param searchVO
	 * @return 댓글 출력
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	public List<CommentVO> do_retrieve(CommentVO commentVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		        
		String statement = NAME_SPACE+".do_retrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		List<CommentVO> list  = this.sqlSession.selectList(statement, commentVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}
	
	
}
