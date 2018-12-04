package com.sist.cd;

import java.sql.SQLException;

import org.junit.Before;
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

import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.CommentDAO;
import com.sist.cd.domain.CommentVO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = 
                        {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class CommentDAOTest {
	
	private final Logger LOG= LoggerFactory.getLogger(this.getClass());
	@Autowired
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Autowired
	private CommentDAO commentDAO;
	CommentVO  inVO1 = null;
	CommentVO  inVO2 = null;
	CommentVO  inVO3 = null;
	SearchVO searchVO = null;
	
	@Before
	public void setUp() {
		inVO1 = new CommentVO("101","1","댓글1","1","1","1","jamesol@paran.com","2018-11-15","1","1");
		inVO2 = new CommentVO("102","1","댓글2","1","1","1","jamesol@paran.com","2018-11-15","1","1");
		inVO3 = new CommentVO("103","1","댓글3","1","1","1","jamesol@paran.com","2018-11-15","1","1");		
	
		searchVO = new SearchVO(10,1,"","");
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("userDao:"+commentDAO);
	}
	
	@Test
	public void add() throws SQLException, ClassNotFoundException {
		commentDAO.add(inVO1);
	}
	
	

}
