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
import com.sist.cd.domain.GallogVO;


@Repository
public class GallogDAOImple implements GallogDAO {
	
	Logger  log = LoggerFactory.getLogger(GallogDAOImple.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.gallog";
	
	public GallogDAOImple() {
		
	}

	@Override
	public int save(GallogVO gallogVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".save";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+gallogVO);
		int flag  = this.sqlSession.update(statement, gallogVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	@Override
	public int delete(GallogVO gallogVO) throws SQLException {
		String statement = NAME_SPACE+".delete";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+gallogVO);
		int flag  = this.sqlSession.delete(statement, gallogVO);
		log.debug("3.flag: "+flag);
		
		return flag;
	}

	@Override
	public int update(GallogVO gallogVO) throws SQLException {
		String statement = NAME_SPACE+".update";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+gallogVO);
		int flag  = this.sqlSession.update(statement, gallogVO);
		log.debug("3.flag: "+flag);
		
		
		return flag;
	}
	
	public List<GallogVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		        
		String statement = NAME_SPACE+".do_retrieve";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+searchVO);
		List<GallogVO> list  = this.sqlSession.selectList(statement, searchVO);
		log.info("*****************************");
		log.info("3.list: "+list);
		log.info("*****************************");
		
		return list;	
	}
	
	public GallogVO get(GallogVO gallogVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".get";
		log.info("========1.statement: "+statement);		
		log.info("============2.param: "+gallogVO);
		GallogVO outVO = this.sqlSession.selectOne(statement, gallogVO);
		log.info("=============3.outVO: "+outVO);

		return outVO;
	}

}