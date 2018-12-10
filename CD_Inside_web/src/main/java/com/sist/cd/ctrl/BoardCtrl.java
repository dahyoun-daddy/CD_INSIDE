package com.sist.cd.ctrl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.cd.dao.BoardDAO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CodeVO;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.BoardSvc;

@Controller
@RequestMapping(value="/board")	
public class BoardCtrl {

	Logger log = LoggerFactory.getLogger(UserCtrl.class);
	
	
	
	
	@RequestMapping(value="/bsy")	
	public String boardsy(@ModelAttribute BoardVO invo, Model model) {
	
	
		return "/board/bsy.do";
	
		
	}
}
