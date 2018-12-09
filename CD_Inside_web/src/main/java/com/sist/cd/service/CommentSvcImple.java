package com.sist.cd.service;


import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.dao.CommentDAO;
import com.sist.cd.domain.CommentVO;

@Service
public class CommentSvcImple implements CommentSvc {
    private Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CommentDAO commentDAO;
	
	@Override
	public int add(CommentVO commentVO) throws DuplicateUserIdException, SQLException {
		String comm_seq = ""+commentDAO.COMM_SEQ();
		String group_seq = ""+commentDAO.GROUP_SEQ();
		log.info("comm_seq:"+comm_seq);
		commentVO.setCommTextNum(comm_seq);
		commentVO.setCommGroupNo(group_seq);
		return commentDAO.add(commentVO);
	}

	@Override
	public int delete(CommentVO commentVO) throws SQLException {
		return commentDAO.delete(commentVO);
	}

	@Override
	public int update(CommentVO commentVO) throws SQLException {
		return commentDAO.update(commentVO);
	}

	@Override
	public CommentVO get(CommentVO commentVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return commentDAO.get(commentVO);
	}

	@Override
	public int addreply(CommentVO commentVO) throws DuplicateUserIdException {
		return commentDAO.addreply(commentVO);
	}

	@Override
	public List<CommentVO> do_retrieve(CommentVO commentVO)
			throws ClassNotFoundException, SQLException {
		return commentDAO.do_retrieve(commentVO);
	}

	@Override
	public int do_code_getCount(CommentVO commentVO) throws SQLException {
		return commentDAO.do_code_getCount(commentVO);
	}

	@Override
	public int do_code_insert(CommentVO commentVO) throws SQLException {
		return commentDAO.do_code_insert(commentVO);
	}

	@Override
	public int do_hit(CommentVO commentVO) throws SQLException {
		return commentDAO.do_hit(commentVO);
	}

	@Override
	public void onehit(CommentVO commentVO) throws SQLException, RuntimeException {
		int flag = commentDAO.do_code_getCount(commentVO);
		if(flag == 1) {
			log.debug("이미 존재하는 데이터입니다.");
		}else {
			int insert = commentDAO.do_code_insert(commentVO);
			log.debug("========================");
			log.debug("code 테이블 삽입여부:"+insert);
			log.debug("========================");
			int hit = commentDAO.do_hit(commentVO);
			log.debug("========================");
			log.debug("code 테이블 삽입여부:"+hit);
			log.debug("========================");
		}
	}
	
	

}
