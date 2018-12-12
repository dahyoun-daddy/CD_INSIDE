package com.sist.cd;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

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

import com.sist.cd.common.SearchVO;
import com.sist.cd.dao.GallogDAO;
import com.sist.cd.domain.GallogVO;




@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration 
//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
//		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"	})
@ContextConfiguration( locations = 
{"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class GallogDAOTest {
	
	private final Logger LOG= LoggerFactory.getLogger(GallogDAOTest.class);
	
	
	
	@Autowired
	private GallogDAO gallogDao;
	GallogVO inVO1 = null;
	GallogVO inVO2 = null;
	SearchVO inVO3 = null;
	GallogVO inVO4 = null;
	GallogVO inVO5 = null;

	@Before
	public void setUp() {
		inVO1 = new GallogVO("","test05","","","22title","cont","0","sysdate","test03","sysdate");	
		inVO2 = new GallogVO("52","test03","","","@@title!!","!!cont!!","0","2018-12-04","test03","2018-12-04");
		inVO3 = new SearchVO(10, 1, "test05", "0");
		inVO4 = new GallogVO("","toast","","","toast1","toast1","0","sysdate","toast1","sysdate");
		inVO5 = new GallogVO("","toast","","","toast2","toast2","0","sysdate","toast2","sysdate");
	}
	
	
	private void checkSameUser(GallogVO user01, GallogVO user02) {
		assertThat(user01.getUserId(), is(user02.getUserId()));
		assertThat(user01.getgTitle(), is(user02.getgTitle()));
		assertThat(user01.getgCont(), is(user02.getgCont()));
		
		assertThat(user01.getModId(), is(user02.getModId()));
	}
	
	
	@Test
//	@Ignore
	public void save() throws SQLException, ClassNotFoundException {
		
		gallogDao.save(inVO1);
		gallogDao.save(inVO1);
		gallogDao.save(inVO1);
		gallogDao.save(inVO1);
		gallogDao.save(inVO1);
	
	}
	
	@Test
//	@Ignore
	public void delete() throws SQLException, ClassNotFoundException {
		
		gallogDao.delete(inVO1);
	}
	
	@Test
//	@Ignore
	public void update() throws SQLException, ClassNotFoundException {
		
		gallogDao.update(inVO2);
	}
	
	@Test
//	@Ignore
	public void do_retrieve() throws SQLException, ClassNotFoundException {
		
		gallogDao.do_retrieve(inVO3);
	}
	
	@Test
//	@Ignore
	public void get() throws SQLException, ClassNotFoundException {
		
		gallogDao.get(inVO1);
	}
	
	@Test
	@Ignore
	public void test()throws SQLException, ClassNotFoundException{
		
		//삭제
		gallogDao.delete(inVO4);
		gallogDao.delete(inVO5);
		
		//등록
		gallogDao.save(inVO4);
		
		//카운트
		assertThat(gallogDao.getCount("toast"),is(1));
		
		//단건조회
		GallogVO getVO = gallogDao.get(inVO4);
		
		//추가한거랑 비교
		checkSameUser(inVO4, getVO);
	}
	
	
}