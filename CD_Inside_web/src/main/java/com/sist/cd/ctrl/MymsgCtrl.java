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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.CodeVO;
import com.sist.cd.domain.MsgVO;
import com.sist.cd.service.CodeSvc;
import com.sist.cd.service.MsgSvc;


@Controller
public class MymsgCtrl {

	Logger log = LoggerFactory.getLogger(MymsgCtrl.class);
	
	@Autowired
	private MsgSvc msgSvc;
    
	@Autowired
	private CodeSvc codeSvc;	
	
	
	private static final String VIEW_NAME="/msg/msg";
	
	
	@RequestMapping(value="/msg/{msg_send}")
	public String getSinglePage(@PathVariable("msg_send")String msg_send){
		return "/msg"+msg_send;
	}
	
	
	@RequestMapping(value="/msg/search.do")	
	public String do_search(@ModelAttribute SearchVO invo,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {	
		log.info("SearchVO: "+invo);
		//param -> view
		
		if(invo.getPage_size() == 0) {
			invo.setPage_size(10);
		}
		
		if(invo.getPage_num() == 0) {
			invo.setPage_num(1);
		}
		
		if(null == invo.getSearch_div()) {
			invo.setSearch_div("");
		}
		
		if(null == invo.getSearch_word()) {
			invo.setSearch_word("");
		}		
		
		
		model.addAttribute("param",invo);
		
		List<MsgVO> list = msgSvc.do_retrieve(invo);
		log.info("list: "+list);
		//총글수
		int total_cnt = 0;
		if(null != list && list.size()>0) {
			total_cnt = list.get(0).getTotalCnt();
			log.info("total_cnt: "+total_cnt);
		}
		
		CodeVO codePage=new CodeVO();
		codePage.setCd_id("C_001");
		
		model.addAttribute("code_page",codeSvc.do_retrieve(codePage));
		model.addAttribute("total_cnt",total_cnt);
		model.addAttribute("list",list);
		return VIEW_NAME;  
	}
	
	@RequestMapping(value="/msg/delete.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String delete(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String uIdList = req.getParameter("userId_list");
		log.info("uIdList: "+uIdList);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(uIdList, List.class);
		log.info("uIdList: "+listParam);
		
		List<MsgVO> paramList = new ArrayList<MsgVO>();
		for(int i=0;i<listParam.size();i++) {
			MsgVO vo =new MsgVO();
			vo.setUserId(listParam.get(i));
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.msgSvc.do_deleteMulti(paramList);
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "삭제 되었습니다.\n("+flag+"건 삭제.)");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패^^.");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	
	@RequestMapping(value="/msg/update.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String update(@ModelAttribute MsgVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String upsert_div = req.getParameter("upsert_div");
		
		log.info("2========================");
		log.info("invo="+invo);
		log.info("upsert_div="+upsert_div);
		
		log.info("2========================");	
		
		int flag = 0;
		//수정
		
		//등록		
		flag = msgSvc.do_upsert(invo);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "등록 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "등록 실패^^.");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	 
	
	@RequestMapping(value="/msg/do_search_one.do",method=RequestMethod.POST
			        ,produces="application/json;charset=utf8"  
			)
	@ResponseBody
	public String get(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = req.getParameter("userId");
		log.info("2========================");
		log.info("get=");
		log.info("2========================");	
		MsgVO msgVO=new MsgVO();
		msgVO.setUserId(userId);
		
		//JSON Convertor
		MsgVO outVO = msgSvc.get(msgVO);
		JSONObject object=new JSONObject();   
		object.put("msgSeq", outVO.getMsgSeq());
		object.put("userId", outVO.getUserId());
		object.put("msgRecvId", outVO.getMsgRecvId());
		object.put("msgCont", outVO.getMsgCont());   
		object.put("regDt", outVO.getRegDt());
		object.put("msgReadYn", outVO.getMsgReadYn());

		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		model.addAttribute("vo", msgSvc.get(msgVO));
		return jsonData;
	}
	
	
	

}
