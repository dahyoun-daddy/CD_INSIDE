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
	private static final String SEND="/mypage/mymsg_send.do";
	private static final String RECEIVE="/mypage/mymsg_receive.do";
	private static final String RECEIVEINDEX="/mypage/mymsg_receive_index.do";
	private static final String SENDINDEX="/mypage/mymsg_send_index.do";
	
	//보낸이가 test면 test만 나오게 하기 현재 전체 나옴
	//전송 시 없는 사용자에게는 못 보내게 하기 (그냥 보냄)
	//보완사항 : 쪽지 쓰거나 삭제후 다시 이전 페이지로 돌아가기
	
	/**
	 * 1. 받은쪽지함 가기 /msg/receiveIndex.do
	 * 2. 보낸쪽지함 가기 /msg/sendIndex.do
	 * 3. 쪽지 쓰기 가기 /msg/send.do     --> 팝업띄우기
	 * 4. 쪽지 읽기 가기 /msg/receive.do  --> 팝업 + 읽기 나오게  하기
	 */
	
	/**
	 * 1. 전송 save  보낸이(test)가 받는이에게 쪽지 전송
	 * 2. 삭제 delete 1건 삭제 및 다건(체크박스선택)삭제
	 * 3. 보낸쪽지전부삭제 deleteSAll 체크박스선택없이 전부삭제
	 * 4. 받은쪽지전부삭제 deleteRAll 체크박스선택없이 전부삭제
	 * 5. 안읽은쪽지전부삭제 deleteNAll 체크박스선택없이 전부삭제
	 * 6. 검색 search/retrieve                                  ->하기
	 * 7. 선택+읽음여부 수정 get 선택하면 무조건 읽지않음 -> 읽음 으로 수정               ->보완하기 / 보낸편지에서 클릭하면 읽음 수정됨
	 */

	//쪽지답장 페이지 나옴
	@RequestMapping(value="/msg/resend.do")
	public String resend() {
		return RESEND;
	}

	@RequestMapping(value="/msg/send.do")
	public String send() {
		return SEND;
	}
	
	@RequestMapping(value="/msg/receive.do")
	public String receive() {
		return RECEIVE;
	}
	
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
		
		//글수
		int total_cnt = 0;
		if(null != list && list.size()>0) {
			total_cnt = list.get(0).getTotalCnt();
			log.info("total_cnt: "+total_cnt);
		}
		
		//읽지않은쪽지수
		int n_cnt = msgSvc.getNCount("test");//test가 받은 쪽지 중 안 읽은 쪽지
		log.info("n_cnt: "+n_cnt);

		//받은쪽지수
		int t_cnt = msgSvc.getAllCount("test"); //test가 받은 전체 쪽지
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
	
	
//전송--------------------------------------------------------------------------------------------	
	@RequestMapping(value= "/msg/save.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String save(@ModelAttribute MsgVO msgVO, HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("msgVO="+msgVO);
		log.info("!2========================");	
		
		//등록		
		int flag = msgSvc.add(msgVO);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "전송 성공");
		}else {
			object.put("flag", flag);
			object.put("message", "전송 실패");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
//삭제--------------------------------------------------------------------------------------------	
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
			vo.setMsgSeq(listParam.get(i));
			
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
	
//보낸쪽지전부삭제--------------------------------------------------------------------------------------------	

	@RequestMapping(value="/msg/deleteSAll.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteSAll(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String uIdList = req.getParameter("userId_list");
		log.info("uIdList: "+uIdList);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(uIdList, List.class);
		log.info("uIdList: "+listParam);
		
		List<MsgVO> paramList = new ArrayList<MsgVO>();
		for(int i=0;i<listParam.size();i++) {
			MsgVO vo =new MsgVO();
			vo.setMsgSeq(listParam.get(i));
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.msgSvc.deleteSAll("test");
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "보낸 쪽지가 전부 삭제 되었습니다.\n("+flag+"건 삭제.)");
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
	
//받은쪽지전부삭제--------------------------------------------------------------------------------------------	
	
	@RequestMapping(value="/msg/deleteRAll.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteRAll(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String uIdList = req.getParameter("userId_list");
		log.info("uIdList: "+uIdList);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(uIdList, List.class);
		log.info("uIdList: "+listParam);
		
		List<MsgVO> paramList = new ArrayList<MsgVO>();
		for(int i=0;i<listParam.size();i++) {
			MsgVO vo =new MsgVO();
			vo.setMsgSeq(listParam.get(i));
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.msgSvc.deleteRAll("test");
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "받은 쪽지가 전부 삭제 되었습니다.\n("+flag+"건 삭제.)");
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

//읽지않은쪽지전부삭제--------------------------------------------------------------------------------------------	

	@RequestMapping(value="/msg/deleteN.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteN(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String uIdList = req.getParameter("userId_list");
		log.info("uIdList: "+uIdList);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(uIdList, List.class);
		log.info("uIdList: "+listParam);
		
		List<MsgVO> paramList = new ArrayList<MsgVO>();
		for(int i=0;i<listParam.size();i++) {
			MsgVO vo =new MsgVO();
			vo.setMsgSeq(listParam.get(i));
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.msgSvc.deleteN("test");
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "읽지 않은 쪽지가 전부 삭제 되었습니다.\n("+flag+"건 삭제.)");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패^^.");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");	
		
		return RECEIVEINDEX;
	}		
	
//받은쪽지 읽기+ 읽음여부 수정-----------------------------------------------------------------------------------

	@RequestMapping(value="/msg/getR.do",produces="application/json;charset=utf8"  
	)
	public String getR(@ModelAttribute SearchVO invo, HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
	String msgSeq = req.getParameter("msgSeq");
	log.info("2========================");
	log.info("get="+msgSeq);
	log.info("2========================");	

	
	//-----------------------------------------------
	//누르면 update 써서 읽지않음 -> 읽음 으로 바꾸기   실시간 x
	//-----------------------------------------------
	MsgVO msgVO=new MsgVO();
	msgVO.setMsgSeq(msgSeq);	
	int outVO1 = msgSvc.updateReadCheck(msgVO);


	
	return RECEIVE;
	}
	
//보낸쪽지 읽기-----------------------------------------------------------------------------------

	@RequestMapping(value="/msg/getS.do",produces="application/json;charset=utf8"  
	)
	public String getS(@ModelAttribute SearchVO invo, HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
	String msgSeq = req.getParameter("msgSeq");
	log.info("2========================");
	log.info("get="+msgSeq);
	log.info("2========================");	
	
	return RECEIVE;
	}	
//선택-----------------------------------------------------------------------------------

	
	@RequestMapping(value="/mypage/update.do",method=RequestMethod.POST
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
	


	

}
