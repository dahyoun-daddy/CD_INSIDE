package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.ChatVO;

public interface ChatSvc {

	/**
	 * 1.전송(add)
	 * 2.1건가져오기(get)
	 * 3.쪽지전체갯수(getAllCount)
	 * 4.안읽은쪽지갯수(getNCount)
	 * 5.쪽지전체목록,시간순정렬(getAll) 
	*/

	
	
	
	int add(ChatVO chatVO) throws DuplicateUserIdException;
	ChatVO get(ChatVO chatVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;	
	int getAllCount(String userId) throws SQLException;
	int getNCount(String msgReadYn) throws SQLException;
	List<ChatVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;	

}
