package com.sist.cd.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.google.gson.Gson;
import com.sist.cd.common.SearchVO;
import com.sist.cd.common.StringUtil;
import com.sist.cd.ctrl.UserCtrl;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CodeVO;
import com.sist.cd.domain.CommentVO;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.CodeSvc;
import com.sist.cd.service.MsgSvc;
import com.sist.cd.service.UserSvc;

@Controller
public class UserCtrl {

	Logger log = LoggerFactory.getLogger(UserCtrl.class);
	
	@Autowired
	private UserSvc userSvc;
	@Autowired
	private CodeSvc codeSvc;
	@Autowired
	private MsgSvc msgSvc;
	
	@RequestMapping(value="/mypage/bo_delete.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String bo_deleteMulti(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String boardNum = req.getParameter("boardNum");
		log.info("commNum : "+boardNum);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(boardNum, List.class);
		log.info("commNum: "+listParam);
		
		List<BoardVO> paramList = new ArrayList<BoardVO>();
		for(int i=0;i<listParam.size();i++) {
			BoardVO vo =new BoardVO();
			vo.setbNum(listParam.get(i));//삭제 where조건
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.userSvc.bo_deleteMulti(paramList);
//		CommentVO coVo = new CommentVO();
//		int flag = this.userSvc.delete(userVO);
		log.info("====================");
		log.info("flag : "+flag);
		log.info("====================");
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "삭제 되었습니다.\n("+flag+"건 삭제.)");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패....");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	
	
	
	@RequestMapping(value="/mypage/co_delete.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String co_deleteMulti(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String commNum = req.getParameter("commNum");
		log.info("commNum : "+commNum);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(commNum, List.class);
		log.info("commNum: "+listParam);
		
		List<CommentVO> paramList = new ArrayList<CommentVO>();
		for(int i=0;i<listParam.size();i++) {
			CommentVO vo =new CommentVO();
			vo.setCommTextNum(listParam.get(i));//삭제 where조건
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.userSvc.co_deleteMulti(paramList);
//		CommentVO coVo = new CommentVO();
//		int flag = this.userSvc.delete(userVO);
		log.info("====================");
		log.info("flag : "+flag);
		log.info("====================");
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "삭제 되었습니다.\n("+flag+"건 삭제.)");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패....");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	
	
	//mypage 활동내역 조회(게시글/댓글)------------------------------
	@RequestMapping(value="/mypage/user_act_c.do",method = RequestMethod.GET )
	public String idCommnet(@ModelAttribute CommentVO  invo,Model model, HttpServletRequest req) 
			throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		log.info("CommentVO" + invo);
//		String aTag = req.getParameter("aTag");
//		log.info(">>>>>>>aTag:" + aTag);
		
		//세션받기
		HttpSession session = req.getSession(true);
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		
		String page_num = (String) req.getParameter("page_num");
		if (page_num == null) {
			invo.setPage_num(1);
		} else {
			invo.setPage_num(Integer.parseInt(page_num));
		}

		if(invo.getPage_size() == 0) {
			invo.setPage_size(10);
		}
		
		log.info("page_num:" + page_num);
		log.info("***page_size:" + invo.getPage_size());


		List<CommentVO> list = userSvc.idCommnet(invo);

		int total_cnt = 0;
		if (null != list && list.size() > 0) {
			total_cnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + total_cnt);
		}
		log.info("list: " + list);
		model.addAttribute("param", invo);
		model.addAttribute("total_cnt",total_cnt);
		model.addAttribute("list", list);
		
		return "/mypage/user_act_c.do";
	}
		
	//mypage 활동내역 조회(게시글/댓글)------------------------------
	@RequestMapping(value="/mypage/user_act.do",method = RequestMethod.GET )
	public String idBoard(@ModelAttribute BoardVO  invo,Model model, HttpServletRequest req) 
			throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		log.info("BoardVO" + invo);
//		String aTag = req.getParameter("aTag");
//		log.info(">>>>>>>aTag:" + aTag);
		
		//세션받기
		HttpSession session = req.getSession(true);
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		
		String page_num = (String) req.getParameter("page_num");
		if (page_num == null) {
			invo.setPage_num(1);
		} else {
			invo.setPage_num(Integer.parseInt(page_num));
		}

		if(invo.getPage_size() == 0) {
			invo.setPage_size(10);
		}
		
		log.info("page_num:" + page_num);
		log.info("***page_size:" + invo.getPage_size());


		List<BoardVO> list = userSvc.idBoard(invo);

		int total_cnt = 0;
		if (null != list && list.size() > 0) {
			total_cnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + total_cnt);
		}
		log.info("list: " + list);
		model.addAttribute("param", invo);
		model.addAttribute("total_cnt",total_cnt);
		model.addAttribute("list", list);

		return "/mypage/user_act.do";
	}
		
	
	@RequestMapping(value="/mypage/deleteUser.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteUser(@ModelAttribute UserVO invo,HttpSession session,HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String userId = req.getParameter("userId");
		
		invo.setUserId(userId);
		
		int flag = this.userSvc.delete(invo);
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "정상적으로 탈퇴 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "탈퇴 실패....");			
		}		
		String jsonData = object.toJSONString();
		session.invalidate();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	
	
	//mypage 관리자 회원목록 조회------------------------------
	@RequestMapping(value="/mypage/user_list.do",method = RequestMethod.GET )
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
		
		List<UserVO> list = userSvc.do_retrieve(invo);
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
		return "/mypage/user_list.do";  
	}

	@RequestMapping(value="/user/pwFindUpdate.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String pwFindUpdate(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");

		log.info("*pwFindUpdate*userId : "+userId);
		UserVO pwUpdateVo = new UserVO();
		pwUpdateVo.setUserId(userId);
		pwUpdateVo.setUserPw(userPw);
		pwUpdateVo.setModId(userId);
		
		JSONObject object=new JSONObject();
		int flag = userSvc.pwFindUpdate(pwUpdateVo);
		log.info("*flag* : "+flag);
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "비밀번호가 수정되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "수정 실패ㅠㅠ");			
		}		
		
		
		String jsonData = object.toJSONString();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
		
	
	@RequestMapping(value="/user/pwFind.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String pwFind(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId   = req.getParameter("userId");
		String userQues = req.getParameter("userQues");
		String userAnsw = req.getParameter("userAnsw");
		
		UserVO pwFindVO = new UserVO();
		pwFindVO.setUserId(userId);
		pwFindVO.setUserQues(userQues);
		pwFindVO.setUserAnsw(userAnsw);
		
		String pwFind = userSvc.pwFind(pwFindVO);
		log.info("***idFind : "+pwFind);
		JSONObject object=new JSONObject();
		
		if(pwFind!=null) {
			object.put("pwFind", pwFind);
//			object.put("message", "회원가입 하신 아이디는 [ "+pwFind+" ] 입니다.");
		}else {
			object.put("pwFind", pwFind);
			object.put("message", "일치하는 정보가 없습니다.");			
		}
		String jsonData = object.toJSONString();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
		
	
	@RequestMapping(value="/user/idFind.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String idFind(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userName = req.getParameter("userName");
		String userQues = req.getParameter("userQues");
		String userAnsw = req.getParameter("userAnsw");
		
		UserVO idFindVO = new UserVO();
		idFindVO.setUserName(userName);
		idFindVO.setUserQues(userQues);
		idFindVO.setUserAnsw(userAnsw);
		
		String idFind = userSvc.idFind(idFindVO);
		log.info("***idFind : "+idFind);
		JSONObject object=new JSONObject();
		
		if(idFind!=null) {
			object.put("idFind", idFind);
			object.put("message", "회원가입 하신 아이디는 [ "+idFind+" ] 입니다.");
		}else {
			object.put("idFind", idFind);
			object.put("message", "일치하는 정보가 없습니다.");			
		}
		
		String jsonData = object.toJSONString();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
		
	}
	
	/**
	 * 로그인 
	 * (아이디 없으면 등록한정보없음)
	 * (아이디와 비밀번호가 틀리면 다시확인)
	 * @throws IOException 
	 */
	@RequestMapping(value="/user/login_act.do",method=RequestMethod.POST 
			  ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String login(HttpServletResponse res,HttpServletRequest req, HttpSession session, Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, IOException {
		//TODO 로그인좀제발
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");
		
		UserVO loginVo = new UserVO();
		
		
		loginVo.setUserId(StringUtil.nvl(userId,""));
		loginVo.setUserPw(StringUtil.nvl(userPw,""));
		log.info("***userVO : "+loginVo);
		
	    
	    
		int flag1 = userSvc.loginIdFind(loginVo); //아이디 있는지 확인
		int flag = userSvc.login(loginVo);//로그인 맞게입력시 result=1
		JSONObject object=new JSONObject();
		UserVO outVO = new UserVO();
		if(flag1<=0) {
			object.put("flag1", flag1);
		}
		
		if(flag>0) {
//			out.println("<script>alert('"+outVO.getUserName()+"님 로그인 되었습니다.'); </script>");
			object.put("flag", flag);
			object.put("message", outVO.getUserName()+"님 환영합니다.");
			
			outVO=userSvc.selectOne(loginVo);
//			boolean create = true;         
//			session = req.getSession(create);
			// Step 2: Get the session data value
			Integer ival = null;         
			session.getAttribute ("session_counter");         
			if (ival == null) ival = new Integer (1);         
			else ival = new Integer (ival.intValue () + 1);  
			session.setAttribute("sessionId", outVO.getUserId());
			session.setAttribute("sessionName", outVO.getUserName());
			session.setAttribute("sessionYn", outVO.getUserYn());
			session.setAttribute("sessionMsg", msgSvc.getNCount(userId));
			log.info("****session : "+session.getAttribute("sessionId"));
			
		}else {
//			out.println("<script>alert('아이디와 비밀번호를 확인하세요.'); </script>");
			object.put("flag", flag);
			object.put("message", "비밀번호를 확인하세요.");
		}

		log.info("****flag1 : "+flag1);
		
		// Step 1: Get the Session object

		
//		log.info("***outVO!!! : "+outVO);
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", outVO.getUserName()+"님 환영합니다.");
		}
		else {
			object.put("flag", flag);
			object.put("message", "비밀번호를 확인하세요.");
		}
		String jsonData = object.toJSONString();
//		
//		log.info("3========================");
//		log.info("jsonData="+jsonData);
//		log.info("3========================");
//		return "/mypage/user_act.do";
		return jsonData;
		
	}
	
    // 로그아웃
	@RequestMapping(value="/user/logout.do",method=RequestMethod.GET )
    public String logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
//		
//		session.setAttribute("sessionId", null);
//		session.setAttribute("sessionName", null);
//		session.setAttribute("sessionYn", null);
//		
    	session.invalidate();//세션 해제
        return "redirect:/user/login.do";
    }
	
	/**
	 * 이름 중복확인
	 * @param req
	 * @param model
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@RequestMapping(value="/user/nameCheck.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String nameCheck(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userName = req.getParameter("userName");//input text id
		UserVO userVO=new UserVO();
		userVO.setUserName(userName);
		
		//JSON Convertor
		String outName = userSvc.nameCheck(userVO.getUserName());//db에 값이 없으면 null 리턴?
		log.info("2========================");
		log.info("userName="+userName);
		log.info("2========================");
		
		JSONObject object=new JSONObject();
//		object.put("userName"   , outname   );
		
		if(null!=outName) {
			object.put("outName", outName);
			object.put("message", outName+"은(는) 중복된 이름(닉네임) 입니다.");
		}else {
			object.put("outName", outName);
			object.put("message", "사용 가능한 이름(닉네임) 입니다.");
		}
		
		String jsonData = object.toJSONString();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");
		model.addAttribute("outName",outName);
		model.addAttribute("nameChk", userSvc.nameCheck(userVO.getUserName()));
		model.addAttribute("vo", userSvc.nameCheck(userVO.getUserName()));
		return jsonData;
	}
		
	/**
	 * 아이디 중복확인 
	 * @param req
	 * @param model
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@RequestMapping(value="/user/idCheck.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String idCheck(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = req.getParameter("userId");//input text id
		UserVO userVO=new UserVO();
		userVO.setUserId(userId);
		
		//JSON Convertor
		String outId = userSvc.idCheck(userVO.getUserId());//db에 값이 없으면 null 리턴?
		log.info("2========================");
		log.info("outId="+outId);
		log.info("2========================");	
		
		JSONObject object=new JSONObject();
//		object.put("userId"   , outId   );
		
		if(null!=outId) {
			object.put("outId", outId);
			object.put("message", outId+"은(는) 중복된 아이디 입니다.");
		}else {
			object.put("outId", outId);
			object.put("message", "사용 가능한 아이디 입니다.");
			
		}
		
		String jsonData = object.toJSONString();
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");
		model.addAttribute("outId",outId);
		model.addAttribute("idChk", userSvc.idCheck(userVO.getUserId()));
		model.addAttribute("vo", userSvc.idCheck(userVO.getUserId()));
		return jsonData;
	}
	
	/**
	 * 단건 조회
	 * @param req
	 * @param model
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@RequestMapping(value="/user/do_search_one.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf-8"  
	)
	@ResponseBody
	public String selectOne(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = req.getParameter("userId");
		log.info("2========================");
		log.info("get=");
		log.info("2========================");	
		UserVO userVO=new UserVO();
		userVO.setUserId(userId);
		
		//JSON Convertor
		UserVO outVO = userSvc.selectOne(userVO);
		JSONObject object=new JSONObject();
		object.put("userId"   , outVO.getUserId()   );
		object.put("userName" , outVO.getUserName() );
		object.put("userPw"   , outVO.getUserPw()   );
		object.put("userEmail", outVO.getUserEmail());
		object.put("userQues" , outVO.getUserQues() );
		object.put("userAnsw" , outVO.getUserAnsw() );
		object.put("userYn"   , outVO.getUserYn()   );
		object.put("regDt"    , outVO.getRegDt()    );
		object.put("modId"    , outVO.getModId()    );
		object.put("modDt"    , outVO.getModDt()    );
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");
		model.addAttribute("vo", userSvc.selectOne(userVO));
		return jsonData;
	}

	/**
	 * 단건 삭제
	 * @param req
	 * @param model
	 * @return
	 * @throws RuntimeException
	 * @throws SQLException
	 */
	@RequestMapping(value="/mypage/delete.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String delete(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String uIdList = req.getParameter("userId_list");
		log.info("uIdList: "+uIdList);
		
		Gson gson=new Gson();
		List<String>  listParam = gson.fromJson(uIdList, List.class);
		log.info("uIdList: "+listParam);
		
		List<UserVO> paramList = new ArrayList<UserVO>();
		for(int i=0;i<listParam.size();i++) {
			UserVO vo =new UserVO();
			vo.setUserId(listParam.get(i));
			
			paramList.add(vo);
		}
		log.info("paramList: "+paramList);
		
		int flag = this.userSvc.do_deleteMulti(paramList);
		UserVO userVO = new UserVO();
//		int flag = this.userSvc.delete(userVO);
		log.info("====================");
		log.info("flag : "+flag);
		log.info("====================");
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "삭제 되었습니다.\n("+flag+"건 삭제.)");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패....");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	
	//회원 단건 추방
	@RequestMapping(value="/mypage/deleteOne.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteOne(@ModelAttribute UserVO invo,HttpServletRequest req,Model model) throws RuntimeException, SQLException{
		String userId = req.getParameter("userId");
		
		invo.setUserId(userId);
		
		int flag = this.userSvc.delete(invo);
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "삭제 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "삭제 실패....");			
		}		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
	/**
	 * 수정 
	 * @param invo
	 * @param req
	 * @param model
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@RequestMapping(value="/mypage/uUpdate.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String uUpdate(@ModelAttribute UserVO invo, HttpSession session,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		//세션 받기
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		invo.setModId(userId); //로그인한 사람이 수정함
		
		UserVO outVO = userSvc.selectOne(invo);

		int flag1 = userSvc.login(invo);//로그인 맞게입력시 result=1

		JSONObject object=new JSONObject();

		if(flag1>0) {
			
			invo.setUserPw(req.getParameter("userPw1"));
			log.info("-*-*-*-invo"+invo);
			int flag = userSvc.uUpdate(invo);
			if(flag>0) {
				object.put("flag", flag);
				object.put("message", "수정 되었습니다.");
				session.setAttribute("sessionName",invo.getUserName());
				
			}else {
				object.put("flag", flag);
				object.put("message", "수정 실패....");			
			}
			
		}else {
			object.put("flag", flag1);
			object.put("message", "현재 비밀번호가 맞지 않습니다.");
		}

		log.info("****flag1 : "+flag1);
		
		
		model.addAttribute("userVo",outVO);
		log.info("---*---"+outVO);
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}

	@RequestMapping(value="/mypage/aUpdate.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String aUpdate(@ModelAttribute UserVO invo, HttpSession session,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = (String) session.getAttribute("sessionId");
		invo.setModId(userId); //관리자로 로그인 한 사람이 수정함
		JSONObject object=new JSONObject();
		log.info("userVO : "+invo);
		
		int flag = userSvc.aUpdate(invo);
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "수정 되었습니다.");
			
		}else {
			object.put("flag", flag);
			object.put("message", "수정 실패....");			
		}
		
		String jsonData = object.toJSONString();
		return jsonData;
	}
		
	/**
	 * 저장
	 * @param invo
	 * @param req
	 * @param model
	 * @return
	 * @throws EmptyResultDataAccessException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@RequestMapping(value="/user/save.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String save(@ModelAttribute UserVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("2========================");
		log.info("invo="+invo);
		log.info("2========================");	
		
		int flag = userSvc.save(invo);
		log.info("3add=================");	

		JSONObject object=new JSONObject();			
		object.put("message", "회원가입 되었습니다.");

		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "회원가입 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "회원가입 실패....");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}
	
//------------------------------user 뷰단 링크------------------------------
	@RequestMapping(value="/user/user_join.do")	
	public String join_view() {
		log.info("=====user_join_view======");
		return "/user/user_join.do";
	}    
	
	@RequestMapping(value="/user/login.do")	
	public String login_view() {
		log.info("=====login_view======");
		return "/user/login.do";
	}
	
	@RequestMapping(value="/user/user_id.do")	
	public String user_id_view() {
		log.info("=====user_id_view======");
		return "/user/user_id.do";
	}
	
	@RequestMapping(value="/user/user_pw.do")	
	public String user_pw_view() {
		log.info("=====user_pw_view======");
		return "/user/user_pw.do";
	}
	
	@RequestMapping(value="/user/user_pw_update.do")	
	public String user_pw_update_view() {
		log.info("=====user_pw_update_view======");
		return "/user/user_pw_update.do";
	}

	//------------------------------------마이페이지 개인정보수정뷰
	@RequestMapping(value="/mypage/user_update.do")	
	public String user_update_view(HttpServletRequest req, Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		UserVO invo = new UserVO();
		HttpSession session = req.getSession(true);
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		invo.setModId(userId); //로그인한 사람이 수정함
		UserVO outVO = userSvc.selectOne(invo);
		model.addAttribute("userVo",outVO);
		log.info("---*---"+outVO);
		
		log.info("=====user_update_view======");
		return "/mypage/user_update.do";
	}
	
	@RequestMapping(value="/mypage/user_list_update.do", method=RequestMethod.GET)	
	public String user_list_update_view(HttpServletRequest req, Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		UserVO invo = new UserVO();
		
		
		invo.setUserId(req.getParameter("userId")); //수정할 아이디
		log.info("---/*/---"+invo);
		
		UserVO outVO = userSvc.selectOne(invo);
		model.addAttribute("userVo",outVO);
		log.info("---*outVO*---"+outVO);
		
		log.info("=====user_list_update_view======");
		return "/mypage/user_list_update.do";
	}
}