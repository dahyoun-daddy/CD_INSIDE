package com.sist.cd.ctrl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.GallogVO;
import com.sist.cd.service.GallogSvc;



@Controller
public class GallogCtrl {

	Logger log = LoggerFactory.getLogger(GallogCtrl.class);
	
	@Autowired
	private GallogSvc gallogSvc;
	
	private static final String GALLOG_HOME="/gallog/gallog_home";
	private static final String NOTE_BOOK="gallog/notebook_home.do";
	private static final String GUEST_BOOK="/gallog/guestbook_home";
	private static final String NOTE_BOOK_WRITE="/gallog/notebook_write.do";
	
	
	@RequestMapping(value="/gallog/notebook_home.do")	
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
		}else{
			totalCnt = list.get(0).getTotalCnt();
			invo.setPage_num(Integer.parseInt(page_num)-1);
		}

		
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		return NOTE_BOOK;
	}
	
	@RequestMapping(value="/gallog/delete.do")
	public String delete(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req) throws RuntimeException, SQLException, ClassNotFoundException{
		
		String gSeq = req.getParameter("gSeq");
		GallogVO vo = new GallogVO();
		vo.setgSeq(gSeq);
		log.info("GallogVO:"+vo);
		gallogSvc.delete(vo);
		
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
		model.addAttribute("page_num",page_num);
		
		
		return NOTE_BOOK;
	}
	
	@RequestMapping(value="/gallog/get.do")
	public String get(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		String gSeq = req.getParameter("gSeq");
		GallogVO vo = new GallogVO();
		vo.setgSeq(gSeq);
		log.info("GallogVO:"+vo);
		gallogSvc.get(vo);
		
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
		
		GallogVO list = gallogSvc.get(vo);
		log.info("list: "+list);
		
		model.addAttribute("param",invo);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		return NOTE_BOOK_WRITE;
	}
}