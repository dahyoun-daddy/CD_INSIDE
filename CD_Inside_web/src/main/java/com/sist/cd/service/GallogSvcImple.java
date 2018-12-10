package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.GallogDAO;
import com.sist.cd.domain.GallogVO;

@Service
public class GallogSvcImple implements GallogSvc {
	
	@Autowired
	private GallogDAO gallogDao;

	@Override
	public int save(GallogVO gallogVO) throws DuplicateUserIdException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(GallogVO gallogVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(GallogVO gallogVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<GallogVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		
		return gallogDao.do_retrieve(searchVO);
	}
	
	public GallogVO get(GallogVO gallogVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return gallogDao.get(gallogVO);
	}


}