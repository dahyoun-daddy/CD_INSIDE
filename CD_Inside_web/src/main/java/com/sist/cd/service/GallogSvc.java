package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.GallogVO;

public interface GallogSvc {
	
	//등록
	int save(GallogVO gallogVO) throws DuplicateUserIdException;
	
	//메모장 삭제
	int delete(GallogVO gallogVO) throws SQLException;
	
	//메모장 수정
	int update(GallogVO gallogVO) throws SQLException;
	
	//전체조회
	List<GallogVO> do_retrieve(SearchVO searchVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;

	//메모장 단건조회
	GallogVO get(GallogVO gallogVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException;
	
	//카운트
	int getCount(String userId) throws SQLException;
	
	//방명록 삭제
	int delete2(GallogVO gallogVO) throws SQLException;
	
	int pwCheck(GallogVO gallogVO) throws SQLException;
}

