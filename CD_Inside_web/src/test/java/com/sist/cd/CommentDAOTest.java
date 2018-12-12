package com.sist.cd;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

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

import com.sist.cd.common.DTO;
import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.CommentDAO;
import com.sist.cd.domain.CommentVO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
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
	DTO dto = null;
	
	@Before
	public void setUp() {
		inVO1 = new CommentVO("100","1","천재냐?","강보승","0","1","0","2018-11-15","1","1");
		inVO2 = new CommentVO("44","1","호일","1","0","1","1","2018-11-15","1","1");
		inVO3 = new CommentVO("45","1","보승","강보승","1","1","jamesol@paran.com","2018-11-15","1","1");		
		
		inVO1.setPage_num(1);
		inVO1.setPage_size(10);
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("userDao:"+commentDAO);
	}
	
	@Test(timeout=2000)
	public void addAndGet() throws SQLException, ClassNotFoundException {

		//--------------------------------------------
		//0.모두삭제 : 건건이로 수정
		//--------------------------------------------
		commentDAO.delete(inVO1);
		commentDAO.delete(inVO2);
		
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------
		commentDAO.add(inVO1);
		commentDAO.addreply(inVO2);
		
		//--------------------------------------------
		//2. 단건 조회
		//--------------------------------------------
		CommentVO getVO01 = commentDAO.get(inVO1);
		CommentVO getVO02 = commentDAO.get(inVO2);
		LOG.info("getVO01:"+getVO01);
		LOG.info("getVO02:"+getVO02);
		//--------------------------------------------
		//3. 추가Data와 비교
		//--------------------------------------------		
		checkSameUser(inVO1, getVO01);
		checkSameUser(inVO2, getVO02);
	}
	
	@Test
	public void update() throws SQLException, ClassNotFoundException {
		commentDAO.update(inVO1);
		commentDAO.update(inVO2);
	}
	
	@Test
	public void do_retrieve() throws SQLException, ClassNotFoundException {
		List<CommentVO> list = commentDAO.do_retrieve(inVO1);
		LOG.info("do_retrieve_list:"+list);
	}
	
	@Test
	public void do_code_select() throws SQLException, ClassNotFoundException {
		assertThat(commentDAO.do_code_getCount(inVO1),is(6));
	}
	
	@Test
	public void add() throws SQLException, ClassNotFoundException {
		inVO1.setNo('6');
		commentDAO.do_code_insert(inVO1);
	}
	
	@Test
	public void do_hit() throws SQLException, ClassNotFoundException {
		commentDAO.do_hit(inVO1);
	}
	
	private void checkSameUser(CommentVO comm01, CommentVO comm02) {
		assertThat(comm01.getCommTextNum(), is(comm02.getCommTextNum()));
		assertThat(comm01.getbNum(), is(comm02.getbNum()));
		assertThat(comm01.getCommCont(), is(comm02.getCommCont()));
		assertThat(comm01.getUserId(), is(comm02.getUserId()));
		assertThat(comm01.getCommHit(), is(comm02.getCommHit()));
		assertThat(comm01.getCommGroupNo(), is(comm02.getCommGroupNo()));
		assertThat(comm01.getCommDepth(), is(comm02.getCommDepth()));
		assertThat(comm01.getModId(), is(comm02.getModId()));
	}
	

}
