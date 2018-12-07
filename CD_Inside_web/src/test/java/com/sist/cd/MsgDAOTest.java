package com.sist.cd;

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

import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.MsgDAO;
import com.sist.cd.domain.MsgVO;

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
		inVO1 = new MsgVO("1","보낸이","받는이","내용","2018-11-15","읽음");
		inVO2 = new MsgVO("2","보낸이2","받는이2","내용2","2018-11-15","읽음");
		inVO3 = new MsgVO("3","보낸이3","받는이3","내용3","2018-11-15","읽지않음");
		inVO4 = new MsgVO("4","보낸이","받는이3","내용3","2018-11-15","읽음");
		inVO5 = new MsgVO("5","from","to","cont","2018-11-15","읽음");

		searchVO = new SearchVO(10,1,"","");
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("msgDao:"+msgDao);
	}
	
	
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
	public void addAndGet() throws SQLException, ClassNotFoundException {

	
		//--------------------------------------------
		//0.모두삭제 
		//--------------------------------------------
	//	userDao.deleteAll();
		
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------
		/** 했음
		msgDao.add(inVO1);
		msgDao.add(inVO2);
		msgDao.add(inVO3);
		msgDao.add(inVO4);
		msgDao.add(inVO5);
	
		//--------------------------------------------
		//1.1 Count
		//--------------------------------------------
		//했음
		assertThat(msgDao.getCount("보낸이"),is(19));
		
		//--------------------------------------------
		//2. 단건 조회
		//--------------------------------------------
		//했음
		MsgVO getVO = msgDao.get(inVO5);
		
		//--------------------------------------------
		//3. 추가Data와 비교
		//--------------------------------------------		
		checkSameUser(inVO1, getVO);
		
	*/	
	}
}
