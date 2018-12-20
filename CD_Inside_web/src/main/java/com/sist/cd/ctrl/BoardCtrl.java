package com.sist.cd.ctrl;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RespectBinding;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.cd.common.SearchVO;
import com.sist.cd.domain.BoardVO;
import com.sist.cd.domain.CommentVO;
import com.sist.cd.domain.GallogVO;
import com.sist.cd.service.BoardSvc;
import com.sist.cd.service.CommentSvc;

@Controller
@RequestMapping(value = "/board")
public class BoardCtrl {

	Logger log = LoggerFactory.getLogger(BoardCtrl.class);
	
	@Autowired
	private BoardSvc boardSvc;
	
	@Autowired
	private CommentSvc commentSvc;

	private static final String BOARD_ALLRET = "/board/ball.do";
	private static final String BOARD_SSANGYONG = "/board/bsy.do";
	private static final String BOARD_LINK = "board/blk.do";
	private static final String BOARD_CONTEXT = "board/bcont.do";
	private static final String BOARD_WRITE = "board/bup.do";
	private static final String BOARD_DELSY = "board/bsy.do";
	private static final String BOARD_DELLK = "board/bsy.do";

	
	@RequestMapping(value = "/board_hitComment.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String do_hitComment(BoardVO boardVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("boardVO:"+boardVO);
		int flag = boardSvc.do_hit(boardVO);
		
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
	
	@RequestMapping(value = "/ball.do")
	public String do_retrieve(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "전체게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {   
			invo.setbCate("쌍용");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_retrieve(invo);   
		log.info("list: " + list); 

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_ALLRET;
	}
	
	
	@RequestMapping(value = "/bsy.do")
	public String do_cateret(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "쌍용게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {   
			invo.setbCate("쌍용");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_cateret(invo);
		log.info("list: " + list);

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_SSANGYONG;   
	}
	
	 
	@RequestMapping(value = "/blk.do")  
	public String do_cateretLK(@ModelAttribute BoardVO invo, Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {

		String page_num = (String) req.getParameter("page_num");
		String b_cate = (String) req.getParameter("b_cate");
		String name = "링크게시판";
		
		if(page_num == null) {
			invo.setPage_num(1);
		}
		 
		if(b_cate == null) {      
			invo.setbCate("링크");  
				 
		} else{
			invo.setPage_num(Integer.parseInt(page_num));
		}
		
		
		log.info("page_num:"+invo);
		
		invo.setPage_size(20);
		
		model.addAttribute("param", invo); 

		List<BoardVO> list = boardSvc.do_cateret(invo);
		log.info("list: " + list);

		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			log.info("totalCnt: " + totalCnt);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return BOARD_SSANGYONG; 
	}
	
	
	 /*단건조회  게시글 하나 눌려서 들어가기루해요*/
	@RequestMapping(value="/get.do") 
	public String get(@ModelAttribute BoardVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!========================");
		log.info("invo="+invo);
		log.info("!========================");
		
		boardSvc.cnt(invo);
		
		log.info("!========================");
		log.info("invo="+invo);
		log.info("!========================");
		
		
		BoardVO list = boardSvc.get(invo);
		
		log.info("list: "+list);
		log.info("invo.getUserId()!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! : "+invo.getUserId());
		
//		model.addAttribute("userid", invo.getUserId());
		model.addAttribute("list",list);
		
		
		
		return BOARD_CONTEXT;
	}
	
	
	 /*글쓰기 화면만 맵핑*/
		@RequestMapping(value="/write.do")
		public String write(@ModelAttribute BoardVO invo,Model model,HttpServletRequest req) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
			
			log.info("!========================");
			log.info("invo="+invo);
			log.info("!========================");
			String name = "게시글 작성";
			
			
			
			BoardVO list = boardSvc.get(invo);
			
			log.info("list: "+list);
			
			
			model.addAttribute("list",list);
			model.addAttribute("name", name);
			
			
			return BOARD_WRITE;
		}
	
	
	@RequestMapping(value= "/addSY.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String addSY(@ModelAttribute BoardVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	

		//log.info("++++++++++++++++++"+invo.getgCate());
		//수정
		
		//등록
		
//		if(null == invo.getUserId()) {
//			invo.setUserId("갓미니");
//		}
		HttpSession session = req.getSession(true);
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		
		
		int flag = boardSvc.addSY(invo);
		 
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
	
	
	@RequestMapping(value= "/addLK.do",method=RequestMethod.POST
	        ,produces="application/json;charset=utf8"  
	)
	@ResponseBody
	public String addLK(@ModelAttribute BoardVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	

		//log.info("++++++++++++++++++"+invo.getgCate());
		//수정
		
		//등록
		
//		if(null == invo.getUserId()) {
//			invo.setUserId("갓미니");
//		}
		HttpSession session = req.getSession(true);
		String userId = (String) session.getAttribute("sessionId");
		invo.setUserId(userId); //TODO 세션 받을곳
		
		
		int flag = boardSvc.addLK(invo);
		 
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
	
	/*파일까지 업로드 할수 있는 에디터*/ 
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
    public String insertBoard(String editor) {
        System.err.println("저장할 내용 : " + editor);
        return "redirect:/coding.do";
    }
 
    // 다중파일업로드
    @RequestMapping(value = "/file_uploader_html5.do",
                  method = RequestMethod.POST)
    @ResponseBody
    public String multiplePhotoUpload(HttpServletRequest request) {
        // 파일정보
        StringBuffer sb = new StringBuffer();
        try {
            // 파일명을 받는다 - 일반 원본파일명
            String oldName = request.getHeader("file-name");
            // 파일 기본경로 _ 상세경로                    이 방법 쓰기  @Value("classpath*:test/*.xml") private Resource[] resources;
            String filePath = "D:/workspace/Spring/src/main/webapp/resources/photoUpload/";
            String saveName = sb.append(new SimpleDateFormat("yyyyMMddHHmmss")
                          .format(System.currentTimeMillis()))
                          .append(UUID.randomUUID().toString())
                          .append(oldName.substring(oldName.lastIndexOf("."))).toString();
            InputStream is = request.getInputStream();
            OutputStream os = new FileOutputStream(filePath + saveName);
            int numRead;
            byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
            while ((numRead = is.read(b, 0, b.length)) != -1) {
                os.write(b, 0, numRead);
            }
            os.flush();
            os.close();
            // 정보 출력
            sb = new StringBuffer();
            sb.append("&bNewLine=true")
              .append("&sFileName=").append(oldName)
              .append("&sFileURL=").append("http://localhost:8090/Spring/resources/photoUpload/")
        .append(saveName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }


	
	
	
	@RequestMapping(value="update.do",method=RequestMethod.POST ,produces="application/json;charset=utf8" )
	@ResponseBody
	public String update(@ModelAttribute BoardVO invo,HttpServletRequest req,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		log.info("!2========================");
		log.info("invo="+invo);
		log.info("!2========================");	
		//수정
		
		//등록		
		int flag = boardSvc.update(invo);
		 
		JSONObject object=new JSONObject();
		
		if(flag>0) {
			object.put("flag", flag);
			object.put("message", "수정 성공");
		}else {
			object.put("flag", flag);
			object.put("message", "수정 실패");			
		}
		
		String jsonData = object.toJSONString();
		
		log.info("3========================");
		log.info("jsonData="+jsonData);
		log.info("3========================");			
		return jsonData;
	}	 
	
	
	@RequestMapping(value="delete.do")
	@ResponseBody
	public String delete(BoardVO invo,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("=======================");
		log.info("invo:"+invo);
		log.info("=======================");
		
		boardSvc.delete(invo);
		
		return "123";  
	}
	
	@RequestMapping(value="cnt.do")
	@ResponseBody
	public String cnt(BoardVO invo,Model model) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException {
		
		log.info("=======================");
		log.info("invo:"+invo);
		log.info("=======================");
		
		boardSvc.cnt(invo);
		
		return "123";  
	}
	
	
	
	
	
/**
 * 댓글 컨트롤러----------------------------------------------------------------------------------------------------------------------------
 * @return
 * @throws Exception
 */
	
	@RequestMapping(value = "/addComment.do",method=RequestMethod.POST, produces = "application/json;charset=utf8")
	@ResponseBody
	public String addComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.add(commentVO);
		log.info("commentVO:"+commentVO);
		CommentVO outVO = commentSvc.get(commentVO);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="";
		jsonList += mapper.writeValueAsString(outVO);
		return jsonList;
	}
	
	@RequestMapping(value = "/updateComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String updateComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.update(commentVO);
		log.info("commentVO:"+commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/deleteComment.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteComment (CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		log.info("====================");
		log.info("commentVO:"+commentVO);
		log.info("====================");
		commentSvc.delete(commentVO);
		return "123";
	}
	
	@RequestMapping(value = "/addreplyComment.do",method=RequestMethod.POST , produces = "application/json;charset=utf8")
	@ResponseBody
	public String addreplyComment(CommentVO commentVO) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		commentSvc.addreply(commentVO);
		log.info("commentVO:"+commentVO);
		CommentVO outVO = commentSvc.get(commentVO);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="";
		jsonList += mapper.writeValueAsString(outVO);
		return jsonList;
	}
	
	@RequestMapping(value = "/do_hitComment.do",method=RequestMethod.POST , produces = "application/json;charset=utf8")
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
	 
	@RequestMapping(value = "/comm/do_retrieve.do", produces = "application/json;charset=utf8")
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
	
	@RequestMapping(value = "/comm/paging_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String getPagingList(CommentVO invo) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		List<CommentVO> listVO = commentSvc.scroll_retrieve(invo);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="";
		jsonList += mapper.writeValueAsString(listVO);
		return jsonList;
	}
	
	@RequestMapping(value = "/comm/scroll_reply_retrieve.do", produces = "application/json;charset=utf8")
	@ResponseBody
	public String scroll_reply_retrieve(CommentVO invo) throws EmptyResultDataAccessException, ClassNotFoundException, SQLException, JsonProcessingException {
		List<CommentVO> listVO = commentSvc.scroll_reply_retrieve(invo);
		int total_cnt = 0;
		if(null != listVO && listVO.size()>0) {
			total_cnt = listVO.get(0).getTotalCnt();
			log.info("total_cnt: "+total_cnt);
		}
		ObjectMapper mapper = new ObjectMapper();
		String jsonList="{\"list\":";
		jsonList += mapper.writeValueAsString(listVO);
		jsonList += ",\"TOTAL\":"+total_cnt+"}";
		
		log.info("jsonList:"+jsonList);

		return jsonList;
	}
	
	
	
	
	

}



