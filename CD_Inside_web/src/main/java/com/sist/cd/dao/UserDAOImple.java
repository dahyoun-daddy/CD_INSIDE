package com.sist.cd.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CommentVO;
import com.sist.cd.domain.UserVO;

@Repository
public class UserDAOImple implements UserDAO{
	
	Logger  log = LoggerFactory.getLogger(UserDAOImple.class);
    
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String NAME_SPACE ="com.sist.cd.mappers.user";
	
	private RowMapper<UserVO> userMapper = new RowMapper<UserVO>() {

		public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserVO userVo=new UserVO();
			userVo.setUserId(rs.getString("user_id"));
			userVo.setUserName(rs.getString("user_name"));
			userVo.setUserPw(rs.getString("user_pw"));
			userVo.setUserEmail(rs.getString("user_email"));
			userVo.setUserQues(rs.getString("user_ques"));
			userVo.setUserAnsw(rs.getString("user_answ"));
			userVo.setUserYn(rs.getString("user_yn"));
			
			userVo.setRegDt(rs.getString("reg_dt"));
			userVo.setModId(rs.getString("mod_id"));
			userVo.setModDt(rs.getString("mod_dt"));
			return userVo;
		}  
	};

	/**
	 * 로그인시 회원가입 유무 확인
	 */
	@Override
	public int loginIdFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".loginIdFind";
		log.info("1.statement: "+statement);
		log.info("2.param: "+userVO);

		int flag  = this.sqlSession.selectOne(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

	
	/**
	 * 로그인
	 */
	@Override
	public int login(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".user_login";
		log.info("1.statement: "+statement);
		log.info("2.param: "+userVO);

		int flag  = this.sqlSession.selectOne(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

	
	/**
	 * 일반 개인정보 수정
	 */
	@Override
	public int uUpdate (UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".uUpdate";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userVO);

		int flag  = this.sqlSession.update(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	/**
	 * 일반 비밀번호 변경
	 */
	@Override
	public int pwFindUpdate (UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException{
		String statement = NAME_SPACE+".pwFindUpdate";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userVO);

		int flag  = this.sqlSession.update(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	/**
	 * 아이디 찾기
	 */
	@Override
	public String pwFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".pwFind";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userVO);

		String result = this.sqlSession.selectOne(statement, userVO);
		log.info("3.result: "+result);
		return result;
	}

	@Override
	public String idFind(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".idFind";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userVO);

		String result = this.sqlSession.selectOne(statement, userVO);
		log.info("3.result: "+result);
		return result;
	}
	
	/**
	 * name 중복확인
	 */
	@Override
	public String nameCheck(String userName) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".nameCheck";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userName);

		String result = this.sqlSession.selectOne(statement, userName);
		log.info("3.result: "+result);
		return result;
	}

	/**
	 * id 중복확인
	 */
	@Override
	public String idCheck(String userId) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".idCheck";
		log.info("1.statement: "+statement);		
		log.info("2.param: "+userId);

		String result = this.sqlSession.selectOne(statement, userId);
		log.info("3.result: "+result);
		return result;
	}

	/**
	 * 단건조회
	 */
	@Override
	public UserVO selectOne(UserVO userVO) throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".selectOne";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+userVO);
		UserVO outVO = this.sqlSession.selectOne(statement, userVO);
		log.debug("3.outVO: "+outVO);

		return outVO;
	}

	
	/**
	 * 삭제
	 */
	@Override
	public int delete(UserVO userVO) throws SQLException {
		String statement = NAME_SPACE+".delete";
		log.info("1.statement: "+statement);
		log.info("2.param: "+userVO);
		int flag  = this.sqlSession.delete(statement, userVO);
		log.info("3.flag: "+flag);
		return flag;
	}

	/**
	 * 수정
	 */
	@Override
	public int update(UserVO userVO) throws SQLException {
		String statement = NAME_SPACE+".update";
		log.debug("1.statement: "+statement);
		log.debug("2.param: "+userVO);
		int flag  = this.sqlSession.update(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}
	
	/**
	 * 등록
	 */
	@Override
	public int save(UserVO userVO) throws DuplicateUserIdException {
		String statement = NAME_SPACE+".save";
		log.debug("1.statement: "+statement);
		log.debug("2.param: "+userVO);
		int flag  = this.sqlSession.insert(statement, userVO);
		log.debug("3.flag: "+flag);
		return flag;
	}

	@Override
	public int getCount(String userId) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> getAll() throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserVO> do_retrieve(SearchVO searchVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".do_retrieve";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+searchVO);
		List<UserVO> list  = this.sqlSession.selectList(statement, searchVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;
	}

	/** 활동내역 아이디별 댓글 조회*/
	@Override
	public List<CommentVO> idCommnet(CommentVO commentVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".idCommnet";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+commentVO);
		List<CommentVO> list  = this.sqlSession.selectList(statement, commentVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;
	}

	/** 활동내역 아이디별 글 조회*/
	@Override
	public List<BoardVO> idBoard(BoardVO boardVO)
			throws ClassNotFoundException, SQLException, EmptyResultDataAccessException {
		String statement = NAME_SPACE+".idBoard";
		log.debug("1.statement: "+statement);		
		log.debug("2.param: "+boardVO);
		List<BoardVO> list  = this.sqlSession.selectList(statement, boardVO);
		log.debug("*****************************");
		log.debug("3.list: "+list);
		log.debug("*****************************");
		return list;
	}


}
