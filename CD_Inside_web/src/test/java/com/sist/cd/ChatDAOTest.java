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

import com.sist.cd.dao.ChatDAO;
import com.sist.cd.domain.ChatVO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = 
                        {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ChatDAOTest {

	private final Logger LOG= LoggerFactory.getLogger(MsgDAOTest.class);
	@Autowired
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Autowired
	private ChatDAO chatDao;
	ChatVO  inVO1 = null;
	ChatVO  inVO2 = null;
	ChatVO  inVO3 = null;
	ChatVO  inVO4 = null;
	ChatVO  inVO5 = null;
	
	@Before
	public void setUp() {
		inVO1 = new ChatVO("스프링","abc123","내용","2018-11-15");
		inVO2 = new ChatVO("오라클","def456","내용1","2018-11-15");
		inVO3 = new ChatVO("자바","abc1234","내용2","2018-11-15");
		inVO4 = new ChatVO("JSP","jsp123","내용3","2018-11-15");
		inVO5 = new ChatVO("파이썬","ppp123","내용4","2018-11-15");
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("chatDao:"+chatDao);
	}
	
	@Test
	public void add() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------	
		chatDao.add(inVO1); 
		LOG.info("★★★inVO1" + inVO1);
		
//		inVO1 = new ChatVO("스프링","abc123","내용","2018-11-15");

	}	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
