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
import com.sist.cd.dao.BoardDAO;
import com.sist.cd.domain.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//                               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		                    
//})
@ContextConfiguration( locations = 
                        {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BoardDAOTest {

	
	private final Logger LOG= LoggerFactory.getLogger(this.getClass());
	@Autowired
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Autowired
	private BoardDAO boardDAO;
	BoardVO  inVO1 = null;
	BoardVO  inVO2 = null;
	BoardVO  inVO3 = null;
	DTO dto = null;

	
	@Before
	public void setUp() {
		inVO1 =  new BoardVO("10014", "smd", "연진이냐", "덮밥쓰", "쌍용", "0", "2018-11-15", "smd", "2018-11-15", "0");
		inVO2 =  new BoardVO("10001", "digh", "딜리트되냐구", "딜리트만 남음", "쌍용", "0", "2018-11-15", "smd", "2018-11-15", "0");
		inVO3 =  new BoardVO("100000", "smd", "연진이냐", "덮밥쓰", "쌍용", "0", "2018-11-15", "smd", "2018-11-15", "0");
		
		
		inVO1.setPage_num(1);
		inVO1.setPage_size(5);
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("userDao:"+boardDAO);
		
	
	}

	//ccccccccccccccccccccccccccccccccccccccccccccccc
	@Test(timeout=2000)
	@Ignore
	public void add() throws SQLException, ClassNotFoundException {


		
		//--------------------------------------------
		//1. 게시글 작성
		//--------------------------------------------
			boardDAO.addSY(inVO2);
			boardDAO.addLK(inVO2);
		
		//--------------------------------------------
	}
	
	
	//rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
	@Test(timeout=2000)
	//@Ignore
	public void addAndGet() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//2. 단건 조회
		//--------------------------------------------
		BoardVO getVO02 = boardDAO.get(inVO2);
		LOG.info("getVO01:"+getVO02);
		//--------------------------------------------
	
	}
	
	@Test
	@Ignore
	public void do_retrieve() throws SQLException, ClassNotFoundException {
		//전체글 조회
	List<BoardVO> list = boardDAO.do_retrieve(inVO1);
		LOG.info("do_retrieve_list:"+list);
	}
	
	
	//uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
	@Test
	@Ignore
	public void update() throws SQLException, ClassNotFoundException {
		boardDAO.update(inVO3);
		
	}
	
	//dddddddddddddddddddddddddddddddddddddddddddddddd
	@Test
	@Ignore
	public void delete() throws SQLException, ClassNotFoundException {
		boardDAO.delete(inVO1);
		
	}
	
	
	
	
//	
//	
//	@Test
//	@Ignore
//	public void update() throws SQLException, ClassNotFoundException {
//		commentDAO.update(inVO1);
//		commentDAO.update(inVO2);
//	}
//	
	

//	@Test
//	@Ignore
//	public void do_code_select() throws SQLException, ClassNotFoundException {
//		assertThat(commentDAO.do_code_getCount(inVO1),is(1));
//	}
//	
//	@Test
//	@Ignore
//	public void add() throws SQLException, ClassNotFoundException {
//		commentDAO.do_code_insert(inVO1);
//	}
//	
//	@Test
//	@Ignore
//	public void do_hit() throws SQLException, ClassNotFoundException {
//		commentDAO.do_hit(inVO1);
//	}
//	
//	private void checkSameUser(CommentVO comm01, CommentVO comm02) {
//		assertThat(comm01.getCommTextNum(), is(comm02.getCommTextNum()));
//		assertThat(comm01.getbNum(), is(comm02.getbNum()));
//		assertThat(comm01.getCommCont(), is(comm02.getCommCont()));
//		assertThat(comm01.getUserId(), is(comm02.getUserId()));
//		assertThat(comm01.getCommHit(), is(comm02.getCommHit()));
//		assertThat(comm01.getCommGroupNo(), is(comm02.getCommGroupNo()));
//		assertThat(comm01.getCommDepth(), is(comm02.getCommDepth()));
//		assertThat(comm01.getModId(), is(comm02.getModId()));
//	}
//	
	
}
