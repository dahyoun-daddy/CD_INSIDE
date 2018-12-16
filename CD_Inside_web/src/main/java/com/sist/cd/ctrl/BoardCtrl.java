package com.sist.cd.ctrl;

import java.sql.SQLException;
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

import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.GallogVO;
import com.sist.cd.service.BoardSvc;

@Controller
@RequestMapping(value = "/board")
public class BoardCtrl {

	Logger log = LoggerFactory.getLogger(BoardCtrl.class);
	
	@Autowired
	private BoardSvc boardSvc;

	private static final String BOARD_ALLRET = "/board/ball.do";
	private static final String BOARD_SSANGYONG = "/board/bsy.do";
	private static final String BOARD_LINK = "board/blk.do";
	private static final String BOARD_CONTEXT = "board/bcont.do";
	private static final String BOARD_WRITE = "board/bup.do";

	@RequestMapping(value = "/ball.do")
	public String do_retrieve(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "전체게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {   
			invo.setbCate("쌍용");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_retrieve(invo);   
		log.info("list: " + list); 

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_ALLRET;
	}
	
	
	@RequestMapping(value = "/bsy.do")
	public String do_cateret(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "쌍용게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {   
			invo.setbCate("쌍용");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_cateret(invo);
		log.info("list: " + list);

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_SSANGYONG;   
	}
	
	 
	@RequestMapping(value = "/blk.do")  
	public String do_cateretLK(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "링크게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {      
			invo.setbCate("링크");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_cateret(invo);
		log.info("list: " + list);

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_SSANGYONG; 
	}
	
	
	 /*단건조회  게시글 하나 눌려서 들어가기루해요*/
	@RequestMapping(value="/get.do") 
	public String get(@ModelAttribute BoardVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!========================");
		log.info("invo="+invo);
		log.info("!========================");
		
		
		
		
		BoardVO list = boardSvc.get(invo);
		
		log.info("list: "+list);
		
		
		model.addAttribute("list",list);
		
		
		
		return BOARD_CONTEXT;
	}
	
	
	 /*글쓰기*/
		@RequestMapping(value="/write.do")
		public String write(@ModelAttribute BoardVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
			
			log.info("!========================");
			log.info("invo="+invo);
			log.info("!========================");
			String name = "게시글 작성";
			
			
			
			BoardVO list = boardSvc.get(invo);
			
			log.info("list: "+list);
			
			
			model.addAttribute("list",list);
			model.addAttribute("name", name);
			
			
			return BOARD_WRITE;
		}
	
	

	
	
	
	
	
	@RequestMapping(value= "/addSY.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String addSY(@ModelAttribute BoardVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	

		//log.info("++++++++++++++++++"+invo.getgCate());
		//수정
		
		//등록		
		int flag = boardSvc.addSY(invo);
		 
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
	
	
	@RequestMapping(value="update.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String update(@ModelAttribute BoardVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		
		//수정
		
		//등록		
		int flag = boardSvc.update(invo);
		 
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
	
	

}
