package com.sist.cd;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.sist.cd.dao.UserDAO;
import com.sist.cd.domain.UserVO;


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = 
                        {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class UserDAOTest {
	private final Logger LOG= LoggerFactory.getLogger(UserDAOTest.class);
	
	@Autowired
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Autowired
	private UserDAO userDao;
	UserVO inVO1 = null;
	UserVO inVO2 = null;
	UserVO inVO3 = null;
	UserVO inVO4 = null;
	
	@Before
	public void setup() {
		inVO1 = new UserVO("11user","dlfma1","11234","22@z.z","질의응답","답변","11user");
		inVO2 = new UserVO("12user","dlfma2","11234","22@z.z","질의응답","답변","12user");
		inVO3 = new UserVO("13user","dlfma3","11234","22@z.z","질의응답","답변","13user");
		inVO4 = new UserVO("14user","dlfma4","11234","22@z.z","질의응답","답변","13user");
		
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("userDao:"+userDao);
	}
	
	@Test
//	@Ignore
	public void idFind() throws SQLException, ClassNotFoundException {
		UserVO vo = new UserVO();
		vo.setUserName("dlfma4");
		vo.setUserQues("질의응답");
		vo.setUserAnsw("답변");
		//userDaoImple 에서 들어가지가 않는듯?
		String userId = userDao.idFind(vo);
		LOG.info(" ***. userId : "+userId);
	}
	
	@Test
	@Ignore
	public void idCheck() throws SQLException, ClassNotFoundException {
		UserVO vo = new UserVO();
		vo.setUserId("111user");
		String userId = userDao.idCheck(vo.getUserId());
		LOG.info(" ***. userId : "+userId);
	}
	
	@Test
	@Ignore
	public void selectOne() throws SQLException, ClassNotFoundException {
		UserVO vo = new UserVO();
		vo.setUserId("11user");
		LOG.info("***selectOne : "+userDao.selectOne(vo));
	}
	
	
	@Test
	@Ignore
	public void delete() throws SQLException, ClassNotFoundException {
		userDao.delete(inVO1);
		userDao.delete(inVO2);
		userDao.delete(inVO3);
		userDao.delete(inVO4);
	}

	@Test
	@Ignore //됨ㅋ
	public void update() throws SQLException, ClassNotFoundException {
		UserVO vo = new UserVO("11user","test22","11234","22@z.z","수정2","수정2","11user");
		userDao.update(vo);

		LOG.info("UserVO update:"+vo);
	}
	
	
	@Test
	@Ignore
	public void save() throws SQLException, ClassNotFoundException {

		userDao.save(inVO1);
		userDao.save(inVO2);
		userDao.save(inVO3);
		userDao.save(inVO4);

		LOG.info("userDao:"+userDao);
	}

}
