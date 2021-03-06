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
	 * 6.안읽음->읽음여부 수정(updateReadCheck)
	 * 7.1건가져오기(get)
	 * 8.쪽지전체갯수(getAllCount)
	 * 9.안읽은쪽지갯수(getNCount)
	 * 10.쪽지전체목록,읽지않음 + 최신순정렬(getAll) 
	 * 11.검색(retrieve) 
	 * 12.보낸이가 (가짜)삭제(updateSDeleteCheck)
	 * 13.받는이가 (가짜)삭제(updateRDeleteCheck)
	 * 14.받는이가 (가짜)읽지않은쪽지삭제(updateNRDeleteCheck)

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
		return this.sqlSession.selectList(statement);				
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


	//가짜삭제 업데이트 - 보낸이가 삭제
	public int updateSDeleteCheck(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".updateSDeleteCheck";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}
	
	//가짜삭제 업데이트 - 받는이가 삭제
	public int updateRDeleteCheck(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".updateRDeleteCheck";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}	
	
	//가짜삭제 업데이트 - 받는이가 삭제
	public int updateNRDeleteCheck(MsgVO msgVO) throws SQLException {
		String statement = NAME_SPACE+".updateNRDeleteCheck";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		int flag  = this.sqlSession.update(statement, msgVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}		

	public List<MsgVO> do_Rretrieve(MsgVO msgVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		        
		String statement = NAME_SPACE+".do_Rretrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		List<MsgVO> list  = this.sqlSession.selectList(statement, msgVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}

	

	public List<MsgVO> do_Sretrieve(MsgVO msgVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		        
		String statement = NAME_SPACE+".do_Sretrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+msgVO);
		List<MsgVO> list  = this.sqlSession.selectList(statement, msgVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;	
	}
	
	
}





