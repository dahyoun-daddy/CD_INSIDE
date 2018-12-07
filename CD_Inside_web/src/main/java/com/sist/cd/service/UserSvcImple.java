package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.UserDAO;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.UserSvc;
import com.sist.cd.service.UserSvcImple;

@Service
public class UserSvcImple implements UserSvc{
	 private Logger log = LoggerFactory.getLogger(UserSvcImple.class);
		
	@Autowired
	private UserDAO userDao;

	

	@Override
	public String nameCheck(String userName) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.nameCheck(userName);
	}

	@Override 
	public String idCheck(String userId) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.idCheck(userId);
	}
	
	@Override
	public UserVO selectOne(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.selectOne(userVO);
	}

	@Override
	public int delete(UserVO userVO) throws SQLException {
		return userDao.delete(userVO);
	}

	@Override
	public int update(UserVO userVO) throws SQLException {
		return userDao.update(userVO);
	}

	@Override
	public int save(UserVO userVO) throws DuplicateUserIdException {
		return userDao.save(userVO);
	}

	@Override
	public int do_deleteMulti(List<UserVO> list) throws RuntimeException, SQLException {
		// TODO 다건삭제 
		return 0;
	}

	@Override
	public List<UserVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		// TODO 전체조회
		return null;
	}
}
