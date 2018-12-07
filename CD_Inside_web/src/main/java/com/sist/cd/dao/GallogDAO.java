package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.GallogVO;

public interface GallogDAO {
	
	int save(GallogVO gallogVO) throws DuplicateUserIdException;
	
	int delete(GallogVO gallogVO) throws SQLException;
	
	int update(GallogVO gallogVO) throws SQLException;
	
	List<GallogVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	
}
