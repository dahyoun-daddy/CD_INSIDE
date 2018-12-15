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
	
	@RequestMapping(value="comment/commentList.do")
    public ModelAndView openCommentList() throws Exception{
    	ModelAndView mv = new ModelAndView("/comment/comment");
    	return mv;
    }
	
	@RequestMapping(value="comment/scrollcomment.do")
    public ModelAndView scrollCommentList() throws Exception{
    	ModelAndView mv = new ModelAndView("/comment/scrollcomment");
    	return mv;
    }
	
	@RequestMapping(value = "/comment/addComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String addComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.add(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/updateComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String updateComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.update(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/deleteComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteComment (CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("====================");
		log.info("commentVO:"+commentVO);
		log.info("====================");
		commentSvc.delete(commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/addreplyComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String addreplyComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("commentVO:"+commentVO);
		commentSvc.addreply(commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/comment/do_hitComment.do",method=RequestMethod.POST , produces = "application/json;charset=utf8")
	@ResponseBody
	public String do_hitComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("commentVO:"+commentVO);
		int flag = commentSvc.do_hit(commentVO);
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "추천 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "이미 추천한 댓글입니다.");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	@RequestMapping(value = "/comment/comm/do_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String getUserList(CommentVO invo) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("invo:"+invo.getPage_num());
		log.info("invo:"+invo.getbNum());
		
		log.info("invo:"+invo);
		List<CommentVO> listVO = commentSvc.do_retrieve(invo);
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
	
	@RequestMapping(value = "/comment/comm/paging_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String getPagingList(CommentVO invo) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		List<CommentVO> listVO = commentSvc.scroll_retrieve(invo);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="";
		jsonList += mapper.writeValueAsString(listVO);
		return jsonList;
	}
	
}
