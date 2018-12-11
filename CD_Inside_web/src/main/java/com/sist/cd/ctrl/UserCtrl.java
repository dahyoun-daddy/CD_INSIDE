package com.sist.cd.ctrl;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

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

import com.sist.cd.ctrl.UserCtrl;
import com.sist.cd.domain.UserVO;
import com.sist.cd.service.UserSvc;

@Controller
public class UserCtrl {

	Logger log = LoggerFactory.getLogger(UserCtrl.class);
	
	@Autowired
	private UserSvc userSvc;
    

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
	 */
	@RequestMapping(value="/user/user_login.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String login(HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");
		
		UserVO loginVo = new UserVO();
		
		
		loginVo.setUserId(userId);
		loginVo.setUserPw(userPw);
		log.info("userVO : "+loginVo);

		int flag1 = this.userSvc.loginIdFind(loginVo);
		int flag = this.userSvc.login(loginVo);
		JSONObject object=new JSONObject();
		
		if(flag1<=0) {
			object.put("flag1", flag1);
		}
		log.info("****flag1 : "+flag1);
		UserVO outVO = this.userSvc.selectOne(loginVo);
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", outVO.getUserName()+"님 환영합니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "아이디와 비밀번호를 확인하세요.");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
		
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
			object.put("message", "중복된 이름(닉네임) 입니다.");
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
			object.put("message", "중복된 아이디 입니다.");
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
	@RequestMapping(value="/user/delete.do",method=RequestMethod.POST
			,consumes= {"text/plain", "application/*"}
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public String delete(HttpServletRequest req,Model model) throws RuntimeException, SQLException{
//		String uIdList = req.getParameter("userId_list");
//		log.info("uIdList: "+uIdList);
//		
//		Gson gson=new Gson();
//		List<String>  listParam = gson.fromJson(uIdList, List.class);
//		log.info("uIdList: "+listParam);
//		
//		List<UserVO> paramList = new ArrayList<UserVO>();
//		for(int i=0;i<listParam.size();i++) {
//			UserVO vo =new UserVO();
//			vo.setUserId(listParam.get(i));
//			
//			paramList.add(vo);
//		}
//		log.info("paramList: "+paramList);
//		
//		int flag = this.userSvc.do_deleteMulti(paramList);
		UserVO userVO = new UserVO();
		int flag = this.userSvc.delete(userVO);
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
	@RequestMapping(value="/user/update.do",method=RequestMethod.POST
	        ,produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String update(@ModelAttribute UserVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		int flag = flag = userSvc.update(invo);
		
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "수정 되었습니다.");
		}else {
			object.put("flag", flag);
			object.put("message", "수정 실패....");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
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
    
	@RequestMapping(value="/user/user_join.do")	
	public String join_view() {
		log.info("=====user_join_view======");
		return "/user/user_join";
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

}
