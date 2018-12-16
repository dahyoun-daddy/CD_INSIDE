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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.CodeVO;
import com.sist.cd.domain.GallogVO;
import com.sist.cd.domain.MsgVO;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.CodeSvc;
import com.sist.cd.service.MsgSvc;
import com.sist.cd.service.UserSvc;


@Controller
public class MymsgCtrl {

	Logger log = LoggerFactory.getLogger(MymsgCtrl.class);
	
	@Autowired
	private MsgSvc msgSvc;
	@Autowired
	private UserSvc userSvc;
	@Autowired
	private CodeSvc codeSvc;	
	
	private static final String RESEND="/mypage/msg_resend.do";
	private static final String SEND="/mypage/msg_send.do";
	private static final String RECEIVE="/mypage/msg_receive.do";
	private static final String RECEIVEINDEX="/mypage/msg_receive_index.do";
	private static final String SENDINDEX="/mypage/msg_send_index.do";

	private static final String VIEW_NAME="/mypage/msg.do";
	
	@RequestMapping(value= "/msg/save.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String save(@ModelAttribute MsgVO msgVO, HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("msgVO="+msgVO);
		log.info("!2========================");	

		//수정
		
		//등록		
		int flag = msgSvc.add(msgVO);
		 
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
	
	
	
	
	
	
	
	//쪽지답장 페이지 나옴
	@RequestMapping(value="/msg/resend.do")
	public String resend() {
		return RESEND;
	}



	//쪽지쓰기 페이지 나옴
	@RequestMapping(value="/msg/send.do")
	public String send() {
		return SEND;
	}
	
	//쪽지읽기 페이지 나옴
	@RequestMapping(value="/msg/receive.do")
	public String receive() {
		return RECEIVE;
	}
	
	//받은쪽지함 페이지 나옴
	@RequestMapping(value="/msg/receiveIndex.do")
	public String do_receiveIndex(@ModelAttribute SearchVO invo,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {	
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
		
		//받은쪽지 수
		int total_cnt = 0;
		if(null != list && list.size()>0) {
			total_cnt = list.get(0).getTotalCnt();
			log.info("total_cnt: "+total_cnt);
		}
		
		//읽지않은쪽지수
		int n_cnt = msgSvc.getNCount("test"); //test 는 아이디임
		log.info("n_cnt: "+n_cnt);

		//읽지않은쪽지수
		int t_cnt = msgSvc.getAllCount("test"); //test 는 아이디임 앞으로 아이디를 넣어야함
		log.info("t_cnt: "+t_cnt);
		
		
		CodeVO codePage=new CodeVO();
		codePage.setCd_id("C_001");
		
		model.addAttribute("code_page",codeSvc.do_retrieve(codePage));
		model.addAttribute("n_cnt",n_cnt);
		model.addAttribute("t_cnt",t_cnt);

		model.addAttribute("total_cnt",total_cnt);
		model.addAttribute("list",list);
		
		return RECEIVEINDEX;  
	}	
	
	//보낸쪽지함 페이지 나옴
	@RequestMapping(value="/msg/sendIndex.do")
	public String do_sendIndex(@ModelAttribute SearchVO invo,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {	
		log.info("SearchVO: "+invo);
		//param -> view
		
		MsgVO msgVO = new MsgVO();
		msgVO.setUserId("test");
		
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
		
		return SENDINDEX;  
	}

	
	@RequestMapping(value="/msg/delete.do")
	public String delete(@ModelAttribute SearchVO invo,Model model,HttpServletRequest req) throws RuntimeException, SQLException, ClassNotFoundException{
		
		String msgSeq = req.getParameter("msgSeq");
		MsgVO vo = new MsgVO();
		vo.setMsgSeq(msgSeq);
		log.info("MsgVO:"+vo);
		msgSvc.delete(vo);
		
		return SENDINDEX;
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
	
	@RequestMapping(value="/msg/get.do",method=RequestMethod.POST
			        ,produces="application/json;charset=utf8"  
			)
	@ResponseBody
	public String get(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String msgSeq = req.getParameter("msgSeq");
		log.info("2========================");
		log.info("get=");
		log.info("2========================");	
		MsgVO msgVO=new MsgVO();
		msgVO.setMsgSeq(msgSeq);
		
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
		model.addAttribute("msgVO", msgSvc.get(msgVO));
		
		return RECEIVE;
	}
	

}
