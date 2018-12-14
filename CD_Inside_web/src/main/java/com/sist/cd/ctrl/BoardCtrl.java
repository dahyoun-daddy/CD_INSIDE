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
import com.sist.cd.dao.BoardDAO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.service.BoardSvc;

@Controller
@RequestMapping(value = "/board")
public class BoardCtrl {

	Logger log = LoggerFactory.getLogger(UserCtrl.class);

	@Autowired
	private BoardSvc boardSvc;
	private BoardDAO boardDAO;

	private static final String BOARD_SSANGYONG = "board/bsy.do";
	private static final String BOARD_CONTEXT = "board/bcont.do";

//	@RequestMapping(value="/bsy.do")
//    public String bsy() throws Exception{

	@RequestMapping(value = "/bsy.do")
	public String do_retrieve(@ModelAttribute SearchVO invo, Model model, HttpServletRequest req)
			throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		log.info("SearchVO: " + invo);

		String page_num = (String) req.getParameter("page_num");
		if (page_num == null) {
			invo.setPage_num(1);
		} else {
			invo.setPage_num(Integer.parseInt(page_num));
		}

		log.info("page_num:" + page_num);

		if (invo.getPage_size() == 0) {
			invo.setPage_size(20);
		}

		if (null == invo.getSearch_div()) {
			invo.setSearch_div("쌍용");
		}

		if (null == invo.getSearch_word()) {
			invo.setSearch_word("test05");
		}

		model.addAttribute("param", invo);

		List<BoardVO> list = boardSvc.do_retrieve(invo);
		log.info("list: " + list);

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		
		//int cnt = boardDAO.viewcnt(invo);
		//model.addAttribute("cnt",cnt);
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);

		return BOARD_SSANGYONG;
	}

//	@RequestMapping(value = "/user/do_search_one.do", method = RequestMethod.POST, produces = "application/json;charset=utf8")
//	@ResponseBody
//	public String get(HttpServletRequest req, Model model)
//			throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
//		String userId = req.getParameter("userId");
//		log.info("2========================");
//		log.info("get=");
//		log.info("2========================");
//		UserVO userVO = new UserVO();
//		userVO.setUserId(userId);
//
////JSON Convertor
//		UserVO outVO = userSvc.get(userVO);
//		JSONObject object = new JSONObject();
//		object.put("userId", outVO.getUserId());
//		object.put("name", outVO.getName());
//		object.put("password", outVO.getPassword());
//		object.put("userIntLevel", outVO.getUserIntLevel());
//		object.put("login", outVO.getLogin());
//		object.put("recommend", outVO.getRecommend());
//		object.put("email", outVO.getEmail());
//		object.put("regDt", outVO.getRegDt());
//
//		String jsonData = object.toJSONString();
//
//		log.info("3========================");
//		log.info("jsonData=" + jsonData);
//		log.info("3========================");
//		model.addAttribute("vo", userSvc.get(userVO));
//		return jsonData;
//	}

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

}
