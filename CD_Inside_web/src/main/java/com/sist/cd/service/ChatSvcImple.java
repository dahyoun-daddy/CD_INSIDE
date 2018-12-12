package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.dao.ChatDAO;
import com.sist.cd.domain.ChatVO;
import com.sist.cd.domain.MsgVO;


@Service
public class ChatSvcImple implements ChatSvc {
    private Logger log = LoggerFactory.getLogger(ChatSvcImple.class);
	
	
	@Autowired
	private ChatDAO chatDao;
	
	
	
	/**
	 * 1.전송(add)
	 * 2.1건가져오기(get)
	 * 3.쪽지전체갯수(getAllCount)
	 * 4.안읽은쪽지갯수(getNCount)
	 * 5.쪽지전체목록, 시간순정렬(getAll) 
	*/
	@Override
	public int add(ChatVO chatVO) throws DuplicateUserIdException{
		return chatDao.add(chatVO);
	}	
	
	@Override
	public ChatVO get(ChatVO chatVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return  chatDao.get(chatVO);
	}
	
	@Override
	public int getAllCount(String userId) throws SQLException{
		return chatDao.getAllCount(userId);
	}
	
	@Override
	public int getNCount(String msgReadYn) throws SQLException{
		return chatDao.getAllCount(msgReadYn);
	}
	
	@Override
	public List<ChatVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		return chatDao.getAll();
	}



	

}