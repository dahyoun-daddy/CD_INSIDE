package com.sist.cd.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.CommentVO;

@Repository
public class CommentDAOImple implements CommentDAO{

	Logger  log = LoggerFactory.getLogger(this.getClass());
    
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.comment";
	
	public CommentDAOImple() {
		
	}
	
	public int add(CommentVO commentVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".add";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		int flag  = this.sqlSession.update(statement, commentVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}
	
}
