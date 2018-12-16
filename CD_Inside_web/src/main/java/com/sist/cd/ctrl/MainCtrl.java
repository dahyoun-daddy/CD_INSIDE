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

import com.sist.cd.common.DTO;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.service.BoardSvc;

@Controller
@RequestMapping(value = "/main")
public class MainCtrl {
	
	Logger log = LoggerFactory.getLogger(UserCtrl.class);

	@Autowired
	private BoardSvc boardSvc;
	
	@RequestMapping(value = "/main.do")
	public String do_retrieve(@ModelAttribute BoardVO invo, Model model, DTO dto) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		invo.setPage_num(1);
		invo.setPage_size(10);
		
		List<BoardVO> totalList = boardSvc.do_retrieve(invo);
		model.addAttribute("totalList", totalList);
		
		invo.setbCate("쌍용");
		List<BoardVO> sistList = boardSvc.do_cateret(invo);
		model.addAttribute("sistList", sistList);
		
		invo.setbCate("링크");
		List<BoardVO> linkList = boardSvc.do_cateret(invo);
		model.addAttribute("linkList", linkList);
		
		invo.setbHit("10");
		
		List<BoardVO> hitList = boardSvc.do_hitretreive(invo);
		model.addAttribute("hitList", hitList);
		
		return "/main/main";
	}
	
}
