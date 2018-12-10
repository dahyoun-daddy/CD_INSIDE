package com.sist.cd;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.sist.cd.common.DTO;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.MsgDAO;
import com.sist.cd.domain.MsgVO;
import com.sist.cd.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = 
                        {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MsgDAOTest {

	private final Logger LOG= LoggerFactory.getLogger(MsgDAOTest.class);
	@Autowired
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Autowired
	private MsgDAO msgDao;
	MsgVO  inVO1 = null;
	MsgVO  inVO2 = null;
	MsgVO  inVO3 = null;
	MsgVO  inVO4 = null;
	MsgVO  inVO5 = null;

	SearchVO searchVO = null;
	
	
	@Before
	public void setUp() {
		inVO1 = new MsgVO("406","보낸이","받는이","내용","2018-11-15","읽지않음");
		inVO2 = new MsgVO("401","보낸이2","받는이2","내용2","2018-11-15","읽지않음");
		inVO3 = new MsgVO("402","보낸이3","받는이3","내용3","2018-11-15","읽지않음");
		inVO4 = new MsgVO("403","보낸이","받는이3","내용3","2018-11-15","읽지않음");
		inVO5 = new MsgVO("404","from","to","cont","2018-11-15","읽음");

		searchVO = new SearchVO(10,1,"","");
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("msgDao:"+msgDao);
	}
	
	@Ignore
	@Test
	public void get() throws Exception {
		LOG.info("1==========================");
		LOG.info("=get=");
		LOG.info("1==========================");
		
		MockHttpServletRequestBuilder createMessage =
				MockMvcRequestBuilders.get("/msg/do_search_one.do")
				.param("user_id", "from")
				;
		
		mockMvc.perform(createMessage)
		.andDo(print())
		.andExpect(status().is2xxSuccessful());
		
	}
	
	@Ignore
	@Test
	public void delete() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//0.1건 삭제 
		//--------------------------------------------
//		msgDao.delete(inVO1); 됨
		//		inVO1 = new MsgVO("400","보낸이","받는이","내용","2018-11-15","읽지않음");

		//--------------------------------------------
		//1.보낸쪽지 전부 삭제 
		//--------------------------------------------
	//	msgDao.deleteSAll(); 안됨

		//--------------------------------------------
		//2.받은쪽지 전부 삭제 
		//--------------------------------------------
	//	msgDao.deleteRAll(); 안됨
		
		//--------------------------------------------
		//3.안 읽은쪽지 전부 삭제 
		//--------------------------------------------
	//	msgDao.deleteN(); 안됨		
	}
	
	@Ignore
	@Test
	public void add() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------	
//		msgDao.delete(inVO1);// 됨

//		msgDao.add(inVO1); // 됨
//		inVO1 = new MsgVO("406","보낸이","받는이","내용","2018-11-15","읽지않음");

	}	
	
	@Ignore
	@Test	
	public void count() throws SQLException, ClassNotFoundException {
		assertThat(msgDao.getAllCount("받는이3"),is(4)); //받는이3 기준, 받은쪽지 갯수
	//	assertThat(msgDao.getNCount("읽지않음"),is(4)); //받는이3 기준, 안읽은쪽지 갯수 안됨

	}		
	
	@Ignore
	@Test
	public void addAndGet() throws SQLException, ClassNotFoundException {

	
		//--------------------------------------------
		//0.1건 삭제 
		//--------------------------------------------
//		msgDao.deleteAll();
		
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------
		
//		msgDao.add(inVO1);

//		msgDao.add(inVO2);
//		msgDao.add(inVO3);
//		msgDao.add(inVO4);
//		msgDao.add(inVO5);
		
		//--------------------------------------------
		//1.1 Count
		//--------------------------------------------
		//했음
//		MsgVO getVO01 = msgDao.get(inVO1);
//		MsgVO getVO02 = msgDao.get(inVO2);
//		LOG.info("getVO01:"+getVO01);
//		LOG.info("getVO02:"+getVO02);		
//		assertThat(msgDao.getCount("보낸이"),is(4));
	
		
		
		//--------------------------------------------
		//2. 단건 조회
		//--------------------------------------------
		//했음
//		MsgVO getVO = msgDao.get(inVO5);
//		UserVO vo = new UserVO();
//		vo.setUserId("11user");
//		LOG.info("***selectOne : "+userDao.selectOne(vo));
		
		
		/**
		//--------------------------------------------
		//3. 추가Data와 비교
		//--------------------------------------------		
		checkSameUser(inVO1, getVO);
		
	*/
	}
}
