package com.sist.cd.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.MsgVO;


public interface MsgDAO { 
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

	int add(MsgVO msgVO) throws DuplicateUserIdException;
	int delete(MsgVO msgVO) throws SQLException;
	int deleteSAll(String userId) throws SQLException;
	int deleteRAll(String userId) throws SQLException;
	int deleteN(String userId) throws SQLException;
	int updateReadCheck(MsgVO msgVO) throws SQLException;
	MsgVO get(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	int getAllCount(String userId) throws SQLException;
	int getNCount(String userId) throws SQLException;
	List<MsgVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

	int do_upsert(MsgVO msgVO) throws SQLException;	
	int updateSDeleteCheck(MsgVO msgVO) throws SQLException;
	int updateRDeleteCheck(MsgVO msgVO) throws SQLException;
	int updateNRDeleteCheck(MsgVO msgVO) throws SQLException;
	List<MsgVO> do_Rretrieve(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	List<MsgVO> do_Sretrieve(MsgVO msgVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;


}