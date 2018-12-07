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

	@Before
	public void setUp() {
		inVO1 = new GallogVO("180","test05","","","22title","cont","0","sysdate","test03","sysdate");	
		inVO2 = new GallogVO("123","test03","","","!!title!!","!!cont!!","0","2018-12-04","test03","2018-12-04");
		inVO3 = new SearchVO(10, 1, "test06", "0");
	}
	
	
	@Test
	@Ignore
	public void save() throws SQLException, ClassNotFoundException {
		
		gallogDao.save(inVO1);
	}
	
	@Test
	@Ignore
	public void delete() throws SQLException, ClassNotFoundException {
		
		gallogDao.delete(inVO1);
	}
	
	@Test
	@Ignore
	public void update() throws SQLException, ClassNotFoundException {
		
		gallogDao.update(inVO2);
	}
	
	@Test
	public void do_retrieve() throws SQLException, ClassNotFoundException {
		
		gallogDao.do_retrieve(inVO3);
	}
	
}