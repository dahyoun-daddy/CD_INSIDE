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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.cd.common.DTO;
import com.sist.cd.common.StringUtil;
import com.sist.cd.dao.CommentDAO;
import com.sist.cd.domain.CommentVO;
import com.sist.cd.service.CommentSvc;

@Controller
public class CommentCtrl {
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommentSvc commentSvc;
	
	@Autowired
	private CommentDAO commentDao;
	
	@RequestMapping(value = "/comment/comm/do_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String getUserList(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		CommentVO invo = new CommentVO("43","1","천재냐?","강보승","0","1","0","2018-11-15","1","1");
		
		String page_num_String = StringUtil.nvl(req.getParameter("pageIndex"), "1");
		log.info("page_num_String");
		int page_num = Integer.parseInt(page_num_String);
		invo.setPage_num(page_num);
		log.info("page_num:"+page_num);
		
		if (invo.getPage_size() == 0) {
			invo.setPage_size(20);
		}

		if (null == invo.getSearch_div()) {
			invo.setSearch_div("");
		}

		if (null == invo.getSearch_word()) {
			invo.setSearch_word("");
		}
		
		log.info("1111111");
		log.info("invo:"+invo);
		List<CommentVO> listVO = commentDao.do_retrieve(invo);
		int total_cnt = 0;
		if(null != listVO && listVO.size()>0) {
			total_cnt = listVO.get(0).getTotalCnt();
			log.info("total_cnt: "+total_cnt);
		}
		log.info("listVO:"+listVO);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="{\"list\":";
		log.info(jsonList);
		jsonList += mapper.writeValueAsString(listVO);
		log.info(jsonList);
		jsonList += ",\"TOTAL\":"+total_cnt+"}";
		return jsonList;
	}
	
}
