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
import com.sist.cd.dao.MsgDAO;
import com.sist.cd.domain.MsgVO;


@Service
public class MsgSvcImple implements MsgSvc {
    private Logger log = LoggerFactory.getLogger(MsgSvcImple.class);
	
	
	@Autowired
	private MsgDAO msgDao;
	
	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#delete(com.sist.hr.user.domain.UserVO)
	 */
	@Override
	public int delete(MsgVO msgVO) throws SQLException{
		return msgDao.delete(msgVO);
	}
	
	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#update(com.sist.hr.user.domain.UserVO)
	 */
	@Override
	public int update(MsgVO msgVO) throws SQLException{
		return msgDao.update(msgVO);
	}
	
	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#getCount(java.lang.String)
	 */
	@Override
	public int getCount(String userId) throws SQLException{
		return msgDao.getCount(userId);
	}



	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#add(com.sist.hr.user.domain.UserVO)
	 */
	@Override
	public int add(MsgVO msgVO) throws DuplicateUserIdException{
		//TODO: return 
		return msgDao.add(msgVO);
	}

	
	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#do_retrieve(com.sist.hr.common.SearchVO)
	 */
	@Override
	public List<MsgVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return msgDao.do_retrieve(searchVO);
	}
	

	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#get(com.sist.hr.user.domain.UserVO)
	 */
	@Override
	public MsgVO get(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return  msgDao.get(msgVO);
	}



	@Override
	public int do_upsert(MsgVO msgVO) throws SQLException {
		return msgDao.do_upsert(msgVO);
	}

	@Override
	public int do_deleteMulti(List<MsgVO> list) throws RuntimeException, SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
}



