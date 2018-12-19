package com.sist.cd.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.BoardDAO;
import com.sist.cd.dao.CommentDAO;
import com.sist.cd.dao.UserDAO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CommentVO;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.UserSvc;
import com.sist.cd.service.UserSvcImple;

@Service
public class UserSvcImple implements UserSvc{
	 private Logger log = LoggerFactory.getLogger(UserSvcImple.class);
		
	@Autowired
	private UserDAO userDao;
	@Autowired
	private CommentDAO commentDAO;
	@Autowired
	private BoardDAO boardDao;


	@Override
	public List<BoardVO> idBoard(BoardVO boardVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.idBoard(boardVO);
	}

	@Override
	public List<CommentVO> idCommnet(CommentVO commentVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.idCommnet(commentVO);
	}

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
	public int aUpdate(UserVO userVO) throws SQLException {
		return userDao.aUpdate(userVO);
	}

	@Override
	public int save(UserVO userVO) throws DuplicateUserIdException {
		return userDao.save(userVO);
	}

	/**
	 * 관리자 멀티 삭제
	 */
	@Override
	public int do_deleteMulti(List<UserVO> list) throws RuntimeException, SQLException {
		int flag = 0;
		try {
			for(UserVO vo :list) {
				flag+=userDao.delete(vo);
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
	public List<UserVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.do_retrieve(searchVO);
	}

	@Override
	public int login(UserVO userVO ) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
//		UserVO outVO = this.userDao.login(userVO);
//		
//        session.setAttribute("sessionId", outVO.getUserId());
//        session.setAttribute("sessionName", outVO.getUserName());
//        session.setAttribute("sessionYn", outVO.getUserYn());
		return userDao.login(userVO);
	}

	@Override
	public int loginIdFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.loginIdFind(userVO);
	}
	/**아이디 찾기*/
	@Override
	public String idFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.idFind(userVO);
	}
	/**개인정보 수정*/
	@Override
	public int uUpdate(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.uUpdate(userVO); 
	}
	/**비밀번호 찾기>변경*/
	@Override
	public int pwFindUpdate(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.pwFindUpdate(userVO);
	}

	/**비밀번호 찾기*/
	@Override
	public String pwFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		return userDao.pwFind(userVO);
	}

	@Override
	public int co_deleteMulti(List<CommentVO> list) throws RuntimeException, SQLException {
		int flag = 0;
		try {
			for(CommentVO vo :list) {
				flag+=commentDAO.delete(vo);
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
	public int bo_deleteMulti(List<BoardVO> list) throws RuntimeException, SQLException {
		int flag = 0;
		try {
			for(BoardVO vo :list) {
				flag+=boardDao.delete(vo);
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


}