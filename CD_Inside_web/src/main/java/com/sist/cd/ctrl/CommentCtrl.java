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
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping(value="comment/commentList.do")
    public ModelAndView openBoardList() throws Exception{
    	ModelAndView mv = new ModelAndView("/comment/comment");
    	return mv;
    }
	
	@RequestMapping(value = "/comment/addComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String addComment(HttpServletRequest req,CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.add(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/updateComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String updateComment(HttpServletRequest req,CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.update(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/deleteComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteComment (HttpServletRequest req,CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.delete(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/addreplyComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String addreplyComment(HttpServletRequest req,CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("commentVO:"+commentVO);
		commentSvc.addreply(commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/comm/do_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String getUserList(HttpServletRequest req,CommentVO invo) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("invo:"+invo.getPage_num());
		log.info("invo:"+invo.getbNum());
		
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
