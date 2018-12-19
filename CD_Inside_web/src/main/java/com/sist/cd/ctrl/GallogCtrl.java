package com.sist.cd.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	private static final String GALLOG_HOME="/gallog/gallog_home.do";
	private static final String NOTE_BOOK="/gallog/notebook_home.do";
	private static final String GUEST_BOOK="/gallog/guestbook_home.do";
	private static final String NOTE_BOOK_WRITE="/gallog/notebook_write.do";
	
	
	@RequestMapping(value= "/gallog/notebook_home.do", method=RequestMethod.GET)	
	public String do_retrieve(@ModelAttribute SearchVO invo,HttpSession session, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
	
		String aaa= req.getParameter("userId");
		log.info("@@@@@:"+aaa);
		//String userId = (String) session.getAttribute("sessionId");
		
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
			invo.setSearch_word(aaa);
		}		
		
		model.addAttribute("param",invo);
		
		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
		}

		model.addAttribute("userId",aaa);
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		return NOTE_BOOK;
	}
	
	@RequestMapping(value="/gallog/delete.do")
	public String delete(@ModelAttribute SearchVO invo,HttpSession session, Model model,HttpServletRequest req) throws RuntimeException, SQLException, ClassNotFoundException{
		
		String userId = (String) session.getAttribute("sessionId");
		String aaa= req.getParameter("userId");
		String gSeq = req.getParameter("gSeq");
		String gCate = req.getParameter("gCate");
		GallogVO vo = new GallogVO();
		vo.setgSeq(gSeq);
		log.info("GallogVO:"+vo);
		gallogSvc.delete(vo);
		log.info("%%%%"+gCate);
		
		String page_num = (String) req.getParameter("page_num");
		if(page_num == null) {
			invo.setPage_num(1);
		}else {
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		log.info("page_num:"+page_num);
		
		if(invo.getPage_size() == 0) {
			if(gCate != null) {
				invo.setPage_size(10);
			}else {
				invo.setPage_size(5);
			}
		}
		
		if(null == invo.getSearch_div()) {
			if(gCate != null) {
				invo.setSearch_div("1");
			}else {
			invo.setSearch_div("0");
			}
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word(userId);
		}		
		
		model.addAttribute("param",invo);

		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
			model.addAttribute("page_num",page_num);
		}
		
		String totalCntLast = Integer.toString(totalCnt);
		char last = totalCntLast.charAt(totalCntLast.length() - 1);
		
		if(Integer.parseInt(page_num) != 1) {
		if(last == '0' || last == '5') {
			int page_num1 = Integer.parseInt(page_num)-1;
			log.info("여기까지옴");
			
			String page_num2 = Integer.toString(page_num1);
			if(page_num2 == null) {
				invo.setPage_num(1);
			}else {
				invo.setPage_num(Integer.parseInt(page_num2));
			}
			
			log.info("page_num2:"+page_num2);
			
			if(invo.getPage_size() == 0) {
				if(gCate != null) {
					invo.setPage_size(10);
				}else {
					invo.setPage_size(5);
				}
			}
			
			if(null == invo.getSearch_div()) {
				if(gCate != null) {
					invo.setSearch_div("1");
				}else {
				invo.setSearch_div("0");
				}
			}
			
			if(null == invo.getSearch_word()) {
				invo.setSearch_word(userId);
			}		
			
			model.addAttribute("param",invo);
			
			List<GallogVO> list2 = gallogSvc.do_retrieve(invo);
			log.info("list2: "+list2);
			
			int totalCnt2 = 0;
			if(null != list2 && list2.size()>0) {
				totalCnt2 = list2.get(0).getTotalCnt();
				log.info("totalCnt: "+totalCnt2);
			}
			model.addAttribute("userId",aaa);		
			model.addAttribute("totalCnt",totalCnt2);
			model.addAttribute("list",list2);
			model.addAttribute("page_num",page_num2);
			
			if(gCate != null) {
				return GUEST_BOOK;
				
			}else {
			return NOTE_BOOK;
			}
		}
		}
		model.addAttribute("userId",aaa);
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		if(gCate != null) {
			return GUEST_BOOK;
			
		}else {
		return NOTE_BOOK;
		}
	}
	
	@RequestMapping(value="/gallog/get.do")
	public String get(@ModelAttribute SearchVO invo,Model model,HttpSession session, HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		String userId = (String) session.getAttribute("sessionId");
		String aaa= req.getParameter("userId");
		
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
			invo.setSearch_word(aaa);
		}		
		
		GallogVO list = gallogSvc.get(vo);
		log.info("list: "+list);
		
		model.addAttribute("param",invo);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		model.addAttribute("check",gSeq);
		
		return NOTE_BOOK_WRITE;
	}
	
	@RequestMapping(value= "/gallog/save.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String save(@ModelAttribute GallogVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		String aaa= req.getParameter("userId");
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		invo.setUserId(aaa);
		log.info("++++++++++++++++++"+invo.getgCate());
		//수정
		
		//등록		
		int flag = gallogSvc.save(invo);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "등록 성공");
		}else {
			object.put("flag", flag);
			object.put("message", "등록 실패");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	 
	
	@RequestMapping(value="/gallog/update.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String update(@ModelAttribute GallogVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		String aaa= req.getParameter("userId");
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		invo.setUserId(aaa);
		//수정
		
		//등록		
		int flag = gallogSvc.update(invo);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "수정 성공");
		}else {
			object.put("flag", flag);
			object.put("message", "수정 실패");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	 
	
	
	@RequestMapping(value="/gallog/guestbook_home.do")	
	public String do_retrieve2(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		log.info("SearchVO: "+invo);
		String aaa= req.getParameter("userId");
		log.info("######: "+aaa);		
		String page_num = (String) req.getParameter("page_num");
		if(page_num == null) {
			invo.setPage_num(1);
		}else {
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		log.info("page_num:"+page_num);
		
		if(invo.getPage_size() == 0) {
			invo.setPage_size(10);
		}
		
		if(null == invo.getSearch_div()) {
			invo.setSearch_div("1");
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word(aaa);
		}		
		
		model.addAttribute("param",invo);
		
		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
		}

		model.addAttribute("userId",aaa);		
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		return GUEST_BOOK;
	}
	
	@RequestMapping(value="/gallog/delete2.do")
	public String delete2(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req, HttpServletResponse response) throws RuntimeException, SQLException, ClassNotFoundException, IOException{
		
		String aaa= req.getParameter("userId");
		String gSeq = req.getParameter("gSeq");
		String gPw = req.getParameter("gPw");
		GallogVO vo = new GallogVO();
		vo.setgSeq(gSeq);
		vo.setgPw(gPw);
		log.info("@@GallogVO:"+vo);
		
		int flag = gallogSvc.delete2(vo);
		
		 
		if(flag>0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('삭제성공');</script>");
			out.flush(); 
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호를 확인하세요.');</script>");
			out.flush();
		}
		
		String page_num = (String) req.getParameter("page_num");
		if(page_num == null) {
			invo.setPage_num(1);
		}else {
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		log.info("page_num:"+page_num);
		
		if(invo.getPage_size() == 0) {
			invo.setPage_size(10);
		}
		
		if(null == invo.getSearch_div()) {
			invo.setSearch_div("1");
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word(aaa);
		}	
		
		model.addAttribute("param",invo);

		
		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
			model.addAttribute("page_num",page_num);
		}
		
		String totalCntLast = Integer.toString(totalCnt);
		char last = totalCntLast.charAt(totalCntLast.length() - 1);
		
		if(Integer.parseInt(page_num) != 1) {
		if(last == '0') {
			int page_num1 = Integer.parseInt(page_num)-1;
			log.info("여기까지옴");
			
			String page_num2 = Integer.toString(page_num1);
			if(page_num2 == null) {
				invo.setPage_num(1);
			}else {
				invo.setPage_num(Integer.parseInt(page_num2));
			}
			
			log.info("page_num2:"+page_num2);
			
			if(invo.getPage_size() == 0) {
				invo.setPage_size(10);
			}
			
			if(null == invo.getSearch_div()) {
				invo.setSearch_div("1");
			}
			
			if(null == invo.getSearch_word()) {
				invo.setSearch_word(aaa);
			}	
			
			model.addAttribute("param",invo);
			
			List<GallogVO> list2 = gallogSvc.do_retrieve(invo);
			log.info("list2: "+list2);
			
			int totalCnt2 = 0;
			if(null != list2 && list2.size()>0) {
				totalCnt2 = list2.get(0).getTotalCnt();
				log.info("totalCnt: "+totalCnt2);
			}
			
			model.addAttribute("totalCnt",totalCnt2);
			model.addAttribute("list",list2);
			model.addAttribute("page_num",page_num2);
			
			return GUEST_BOOK;
		}
		}

		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("list",list);
		model.addAttribute("page_num",page_num);
		
		return GUEST_BOOK;
	}
	
	@RequestMapping(value="/gallog/pwCheck.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String pwCheck(@ModelAttribute GallogVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		
		//수정
		
		//등록		
		int flag = gallogSvc.pwCheck(invo);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "비밀번호 일치");
		}else {
			object.put("flag", flag);
			object.put("message", "비밀번호를 확인해주세요.");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	 
	
	@RequestMapping(value= "/gallog/gallog_home.do", method=RequestMethod.GET)	
	public String do_retrieve3(@ModelAttribute SearchVO invo,HttpSession session, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
	
		SearchVO invo2 = new SearchVO();
		String aaa= req.getParameter("userId");
		log.info("@@@@@:"+aaa);
		//String userId = (String) session.getAttribute("sessionId");
		
		
		String page_num = (String) req.getParameter("page_num");
		if(page_num == null) {
			invo.setPage_num(1);
			invo2.setPage_num(1);
		}else {
			invo.setPage_num(Integer.parseInt(page_num));
			invo2.setPage_num(Integer.parseInt(page_num));
		}
		
		log.info("page_num:"+page_num);
		
		if(invo.getPage_size() == 0) {
			invo.setPage_size(3);
			invo2.setPage_size(5);
		}
		
		if(null == invo.getSearch_div()) {
			invo.setSearch_div("0");
			invo2.setSearch_div("1");
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word(aaa);
			invo2.setSearch_word(aaa);
		}		
		
		model.addAttribute("param",invo);
		
		List<GallogVO> list = gallogSvc.do_retrieve(invo);
		log.info("list: "+list);
		
		List<GallogVO> list2 = gallogSvc.do_retrieve(invo2);
		log.info("list2: "+list2);
		
		
		
		int totalCnt = 0;
		if(null != list && list.size()>0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: "+totalCnt);
		}
		
		int totalCnt2 = 0;
		if(null != list2 && list2.size()>0) {
			totalCnt2 = list2.get(0).getTotalCnt();
			log.info("totalCnt2: "+totalCnt2);
		}

		model.addAttribute("userId",aaa);
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("totalCnt2",totalCnt2);
		model.addAttribute("list",list);
		model.addAttribute("list2",list2);
		model.addAttribute("page_num",page_num);
		
		return GALLOG_HOME;
	}
	
}