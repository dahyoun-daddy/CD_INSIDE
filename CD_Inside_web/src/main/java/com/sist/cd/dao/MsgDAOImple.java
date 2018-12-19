package com.sist.cd.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.MsgVO;

@Repository
public class MsgDAOImple implements MsgDAO{

	Logger  log = LoggerFactory.getLogger(MsgDAOImple.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.msg";
	
	public MsgDAOImple() {
		
	}
	
	/**
	 * 1.전송(add)
	 * 2.1건삭제(delete)
	 * 3.보낸쪽지전체삭제(deleteSAll)
	 * 4.받은쪽지전체삭제(deleteRAll)
	 * 5.안읽은쪽지삭제(deleteN)
	 * 6.안읽음->읽음여부 수정(updateReadCheck)
	 * 7.1건가져오기(get)
	 * 8.쪽지전체갯수(getAllCount)
	 * 9.안읽은쪽지갯수(getNCount)
	 * 10.쪽지전체목록,읽지않음 + 최신순정렬(getAll) 
	 * 11.검색(retrieve) 
	*/

	public int add(MsgVO msgVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".add";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	public int delete(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".delete";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.delete(statement, msgVO);
		log.debug("3.flag: "+flag);
		return flag;
	}	

	@Override
	public int deleteSAll(String userId) throws SQLException {
		String statement = NAME_SPACE+".deleteSAll";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userId);
		int flag  = this.sqlSession.update(statement, userId);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	public int deleteRAll(String userId) throws SQLException {
		String statement = NAME_SPACE+".deleteRAll";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userId);
		int flag  = this.sqlSession.update(statement, userId);
		log.debug("3.flag: "+flag);
		return flag;
	}		

	public int deleteN(String userId) throws SQLException {
		String statement = NAME_SPACE+".deleteN";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userId);
		int flag  = this.sqlSession.update(statement, userId);
		log.debug("3.flag: "+flag);
		return flag;
	}	
	
	public int updateReadCheck(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".updateReadCheck";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	public MsgVO get(MsgVO msgVO) throws ClassNotFoundException, SQLException,EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".get";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		MsgVO outVO = this.sqlSession.selectOne(statement, msgVO);
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

	public int getNCount(String userId) throws SQLException {
		int cnt = 0;
		String statement = NAME_SPACE+".getNCount";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userId);
		int flag  = this.sqlSession.selectOne(statement, userId);
		log.debug("3.flag: "+flag);

		return flag;
				
	}


	public List<MsgVO> getAll() throws ClassNotFoundException, SQLException,EmptyResultDataAccessException {
		
		String statement = NAME_SPACE+".getAll";
		log.debug("1.statement: "+statement);
		
		
		StringBuilder sb=new StringBuilder();		
		sb.append(" SELECT hr.*          \n"); 
		sb.append("   FROM msg hr   \n");
		sb.append("  ORDER by user_id       \n");

		return this.sqlSession.selectList(statement);				
	}

	public List<MsgVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		        
		String statement = NAME_SPACE+".do_retrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+searchVO);
		List<MsgVO> list  = this.sqlSession.selectList(statement, searchVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}

	@Override
	public int do_upsert(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".do_upsert";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}



}





