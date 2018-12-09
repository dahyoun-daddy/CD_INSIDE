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
	
	
	/**
	 * 1.전송(submit)
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
	@Override
	public int add(MsgVO msgVO) throws DuplicateUserIdException{
		return msgDao.add(msgVO);
	}	

	@Override
	public int delete(MsgVO msgVO) throws SQLException{
		return msgDao.delete(msgVO);
	}	

//	@Override
//	public void deleteSAll() throws SQLException{
//		return msgDao.deleteSAll();
//	}
//	
//	@Override
//	public void deleteRAll() throws SQLException{
//		return msgDao.deleteRAll();
//	}
//	
//	@Override
//	public void deleteN() throws SQLException{
//		return msgDao.deleteN();
//	}
	
	@Override
	public int getAllCount(String userId) throws SQLException{
		return msgDao.getAllCount(userId);
	}

	@Override
	public int getNCount(String msgReadYn) throws SQLException{
		return msgDao.getAllCount(msgReadYn);
	}
	

	@Override
	public int update(MsgVO msgVO) throws SQLException{
		return msgDao.update(msgVO);
	}
	
	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#getCount(java.lang.String)
	 */

	/* (non-Javadoc)
	 * @see com.sist.hr.user.service.UserSvc#add(com.sist.hr.user.domain.UserVO)
	 */


	
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

	@Override
	public void deleteSAll() throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteRAll() throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteN() throws SQLException {
		// TODO Auto-generated method stub
		
	}
}



