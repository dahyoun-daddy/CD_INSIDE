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
import com.sist.cd.domain.ChatVO;
import com.sist.cd.domain.MsgVO;

@Repository
public class ChatDAOImple implements ChatDAO{

	Logger  log = LoggerFactory.getLogger(MsgDAOImple.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.chat";
	
	public ChatDAOImple() {
		
	}
	
	/**
	 * 1.전송(add)
	 * 2.1건가져오기(get)
	 * 3.채팅전체갯수(getAllCount)
	 * 4.안읽은쪽지갯수(getNCount)
	 * 5.채팅내용목록, 시간순정렬(getAll) 
	*/

	public int add(ChatVO chatVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".add";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+chatVO);
		int flag  = this.sqlSession.update(statement, chatVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	public ChatVO get(ChatVO chatVO) throws ClassNotFoundException, SQLException,EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".get";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+chatVO);
		ChatVO outVO = this.sqlSession.selectOne(statement, chatVO);
		log.debug("3.outVO: "+outVO);

		return outVO;
		
	}	
	
	public int getAllCount(String userId) throws SQLException {
		int cnt = 0;
		String statement = NAME_SPACE+".getAllCount";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userId);
		int flag  = this.sqlSession.selectOne(statement, userId);
		log.debug("3.flag: "+flag);

		return flag;
		
	}

	public int getNCount(String msgReadYn) throws SQLException {
		int cnt = 0;
		String statement = NAME_SPACE+".getNCount";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgReadYn);
		int flag  = this.sqlSession.selectOne(statement, msgReadYn);
		log.debug("3.flag: "+flag);

		return flag;
				
	}


	public List<ChatVO> getAll() throws ClassNotFoundException, SQLException,EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".getAll";
		log.debug("1.statement: "+statement);
		return this.sqlSession.selectList(statement);				
	}


	
}
