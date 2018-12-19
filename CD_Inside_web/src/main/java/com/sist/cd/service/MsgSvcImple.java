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
	 * 12.다중삭제(do_deleteMulti)
	*/
	@Override
	public int add(MsgVO msgVO) throws DuplicateUserIdException{
		return msgDao.add(msgVO);
	}	

	@Override
	public int delete(MsgVO msgVO) throws SQLException{
		return msgDao.delete(msgVO);
	}
	
	@Override
	public int deleteSAll(String userId) throws SQLException {
		return msgDao.deleteSAll(userId);
		
	}

	@Override
	public int deleteRAll(String userId) throws SQLException {
		return msgDao.deleteSAll(userId);
		
	}
	
	@Override
	public int deleteN(String userId) throws SQLException{
		return msgDao.deleteN(userId);
	}
	
	@Override
	public int updateReadCheck(MsgVO msgVO) throws SQLException{
		return msgDao.updateReadCheck(msgVO);
	}
	
	@Override
	public MsgVO get(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return  msgDao.get(msgVO);
	}
	
	@Override
	public int getAllCount(String userId) throws SQLException{
		return msgDao.getAllCount(userId);
	}

	@Override
	public int getNCount(String userId) throws SQLException{
		return msgDao.getNCount(userId);
	}
	
	@Override
	public List<MsgVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return msgDao.getAll();
	}

	
	@Override
	public List<MsgVO> do_retrieve(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return msgDao.do_retrieve(msgVO);
	}
	

	


	@Override
	public int do_deleteMulti(List<MsgVO> list) throws RuntimeException, SQLException {
		int flag = 0;
		try {
			for(MsgVO vo :list) {
				String userId = null;
				vo.setUserId(userId);
				flag+=msgDao.deleteSAll(userId);
			}
			
		}catch(RuntimeException e) {
			log.debug("========================");
			log.debug("RuntimeException: "+e.getMessage());
			log.debug("========================");			
			throw e;
		}
		log.debug("========================");
		log.debug("=flag="+flag);
		log.debug("========================");
		return flag;
	}


	@Override
	public int do_upsert(MsgVO msgVO) throws SQLException {
		return msgDao.do_upsert(msgVO);
	}
}



