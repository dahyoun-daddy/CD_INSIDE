package com.sist.cd;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
import java.util.List;

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
import com.sist.cd.domain.BoardVO;
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
		inVO1 = new MsgVO("400","보낸이","받는이","내용","2018-11-15","읽지않음","0","0");
		inVO2 = new MsgVO("401","보낸이","받는이","내용","2018-11-15","읽지않음","1","0");
		inVO3 = new MsgVO("402","보낸이","받는이","내용","2018-11-15","읽지않음","0","1");
		inVO4 = new MsgVO("403","보낸이","받는이","내용","2018-11-15","읽지않음","1","1");
		inVO5 = new MsgVO("404","test","abc","내용","2018-11-15","읽지않음","0","0");

		searchVO = new SearchVO(10,1,"","");
		  
		LOG.info("context:"+context);
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		LOG.info("mockMvc:"+mockMvc);
		LOG.info("msgDao:"+msgDao);
	}

//	@Ignore
	@Test
	public void update() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//0. 읽지않음 -> 읽음 수정
		//--------------------------------------------
		msgDao.add(inVO2); 
		msgDao.updateReadCheck(inVO2); 	
		//		inVO1 = new MsgVO("400","보낸이","받는이","내용","2018-11-15","읽지않음");

	}
	
//	@Ignore
	@Test
	public void delete() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//0.1건 삭제 
		//--------------------------------------------
		msgDao.add(inVO4); 
		msgDao.delete(inVO4); //됨
		//		inVO1 = new MsgVO("400","보낸이","받는이","내용","2018-11-15","읽지않음");

		//--------------------------------------------
		//1.보낸쪽지 전부 삭제   ex) "보낸이가" 가 보낸 보낸쪽지 전부 삭제 
		//--------------------------------------------
		msgDao.deleteSAll("보낸이"); //됨 

		//--------------------------------------------
		//2.받은쪽지 전부 삭제   ex) "받는이2" 가 받은 받은쪽지 전부 삭제 
		//--------------------------------------------
		msgDao.deleteRAll("받는이");  //됨
		
		//--------------------------------------------
		//3.안 읽은쪽지 전부 삭제   ex) "받는이3" 가 받은 받은쪽지 중 읽지않은 쪽지 전부 삭제 
		//--------------------------------------------
		msgDao.deleteN("받는이");  //됨		
	}

//	@Ignore	
	@Test
	public void add() throws SQLException, ClassNotFoundException {
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------	
		msgDao.delete(inVO1);
		LOG.info("★★★inVO1" + inVO1);

		msgDao.add(inVO1); 
		LOG.info("★★★inVO1" + inVO1);
		
//		inVO1 = new MsgVO("406","보낸이","받는이","내용","2018-11-15","읽지않음");

	}	
	
//	@Ignore
	@Test	
	public void count() throws SQLException, ClassNotFoundException {
	//	msgDao.add(inVO5); 
		LOG.info("★★★inVO5" + inVO5);
		//--------------------------------------------
		//0. 받은쪽지 전체 갯수
		//--------------------------------------------
		assertThat(msgDao.getAllCount("abc"),is(6)); //abc 기준, 받은쪽지 갯수
		
		//--------------------------------------------
		//1. 받은쪽지 중 안 읽은 쪽전체 갯수
		//--------------------------------------------
		assertThat(msgDao.getNCount("abc"),is(6)); //abc 기준, 안읽은쪽지 갯수 

	}	
	
//	@Ignore		
	@Test
	public void addAndGet() throws SQLException, ClassNotFoundException {
	
		//--------------------------------------------
		//0.1건 삭제 
		//--------------------------------------------
		msgDao.delete(inVO1);
		
		//--------------------------------------------
		//1. 단건 추가
		//--------------------------------------------		
		msgDao.add(inVO1);

		//--------------------------------------------
		//2. 단건 조회
		//--------------------------------------------
		MsgVO getVO = msgDao.get(inVO1);
		LOG.info("★★★inVO1" + inVO1);
		
		//--------------------------------------------
		//3. 전체 데이터 조회
		//--------------------------------------------
		List<MsgVO> getVO1 = msgDao.getAll();
		LOG.info("★★★getVO1" + getVO1);		

	}
	
//	@Ignore		
	@Test
	public void do_Rretrieve() throws SQLException, ClassNotFoundException {
		List<MsgVO> list = msgDao.do_Rretrieve(inVO1);
			LOG.info("do_retrieve_list:"+list);
	}	
	
//	@Ignore		
	@Test
	public void do_Sretrieve() throws SQLException, ClassNotFoundException {
		List<MsgVO> list = msgDao.do_Sretrieve(inVO1);
			LOG.info("do_retrieve_list:"+list);
	}	
	
}
