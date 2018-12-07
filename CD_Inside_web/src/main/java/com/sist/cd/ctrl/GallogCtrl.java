package com.sist.cd.ctrl;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.GallogVO;
import com.sist.cd.service.GallogSvc;



@Controller
public class GallogCtrl {

	Logger log = LoggerFactory.getLogger(GallogCtrl.class);
	
	@Autowired
	private GallogSvc gallogSvc;
	
	private static final String GALLOG_HOME="/gallog/galloghome";
	private static final String NOTE_BOOK="/gallog/notebook";
	private static final String GUEST_BOOK="/gallog/guestbook";
	private static final String NOTE_BOOK_WRITE="/gallog/notebookwrite";
	
	
	@RequestMapping(value="/gallog/notebookhome.do")	
	public String do_retrieve(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		log.info("SearchVO: "+invo);
		
		String page_num = (String) req.getParameter("page_num");
		if(page_num == null) {
			invo.setPage_num(1);
		}else {
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		log.info("page_num:"+page_num);
		
		if(invo.getPage_size() == 0) {
			invo.setPage_size(5);
		}
		
		if(null == invo.getSearch_div()) {
			invo.setSearch_div("0");
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word("test05");
		}		
		
		model.addAttribute("param",invo);
		
		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
		}
		
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		
		return NOTE_BOOK;
	}
}