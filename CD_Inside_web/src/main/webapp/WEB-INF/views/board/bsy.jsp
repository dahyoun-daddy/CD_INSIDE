<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.cd.domain.CodeVO"%>
<%@page import="com.sist.cd.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.sist.cd.common.SearchVO"%>
	
<%	String userId = (String) session.getAttribute("sessionId");
%>
	
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>

<!-- 뷰단에서 뿌려주는거 포 이치해서 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.sist.cd.common.StringUtil"%>

<%
	Logger LOG = LoggerFactory.getLogger(this.getClass());
	String context = request.getContextPath();
	
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//유저아이디 
	String search_word="";//메모장:0 방명록:1
	
	int totalCnt      =0;
	int bottomCount   =10; 
	
	BoardVO vo =  (BoardVO)request.getAttribute("param");
	LOG.info("vo:"+vo);
	
	int oPageSize = vo.getPage_size();
	int oPageNum  = vo.getPage_num();
	
	String iTotalCnt = (null == request.getAttribute("totalCnt"))?"0":request.getAttribute("totalCnt").toString();
	totalCnt = Integer.parseInt(iTotalCnt);

	List<CodeVO> code_page = (null == request.getAttribute("code_page"))
	?new ArrayList<CodeVO>():(List<CodeVO>)request.getAttribute("code_page");
	
	
	
	if(null !=vo ){
		search_div  = StringUtil.nvl(vo.getSearch_div(), ""); 
		search_word = StringUtil.nvl(vo.getSearch_word(), ""); 
		page_size   = StringUtil.nvl(vo.getPage_size(), "10"); 
		page_num   = StringUtil.nvl(vo.getPage_num(), "1"); 
	}else{ 
		search_div  = StringUtil.nvl(request.getParameter("search_div"), ""); 
		search_word = StringUtil.nvl(request.getParameter("search_word"), "");
		page_size = StringUtil.nvl(request.getParameter("page_size"), "10");
		page_num = StringUtil.nvl(request.getParameter("page_num"), "1");
	}
	
	
%>


<!DOCTYPE html>
<html>
<head>
 
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>



<!-- 부트스트랩 -->

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" -->
<!--  integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous"> -->

<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" -->
<!--  integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"  -->
<!-- integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"  -->
<!-- integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script> -->


<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.table-bordered>thead>tr>th {
	font-size: 4px;
	font-style: inherit;
	color: black;
	background-color: white;
	vertical-align: middle;
}


.boardtext.span {  
    font-size: 40px; 
	text-align: left;
}



#listTable {
	width: 960px;
	height: 100px;
	margin-left: auto;
	margin-right: auto;
}

.wr{ 
position: relative;
left: 8px;
}
   
.goodhit{  
position: relative;  
left: 90px;  
} 

.sangdan{
position: relative;
right: -90px;   
  
}

.value{ font-size: 2px; } 


 .ctt { 
 font-size: 14px;   
	color:black ; 
	font-weight : lighter;
	margin-left: 15px;
}

 .ct { 
	color:#a133ca ;
	 font-size: 14px; 
	margin-left: 15px; 
}

.cu { 
	font-size: 14px;
	color:#ff7626 ;
	margin-left: 15px; 
}
  
.hrc{
	font-size: 14px;

}
  
</style>   

</head>
<body>
	
	
			<div class="container">
			 <div class="row">
			 <div class="sangdan">
			<div class="text-left col-xs-12 col-sm-12 col-md-12 col-lg-12"><h2>${name}</h2></div>
			</div> 
    	   </div>   
    	   
    	  
				 <%	
				if(userId == null){
				%>
    		
				<% } else { %>
				 <div class="row"> 
		    		  <div class="wr">
					   <div class="text-right col-xs-11 col-sm-11 col-md-11 col-lg-11"><button><a class="update" href="/cd/board/write.do">쓰기 </a></button></div>
					  </div>
					 </div>  
				<% } %>	       
			     
			
			   <p></p>
				<div class="table-responsive"> 
		
		
				<table id="listTable"
					class="table table-striped table-bordered table-hover">
						 
			  
			
					<thead class="bg-primary"> 
					<tr>
						<th class="text-center          		 col-md-1 col-lg-1">번호</th>
						<th class="text-center col-xs-8 col-sm-8 col-md-6 col-lg-6">제목</th>
						<th class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-2">글쓴이</th>
						<th class="text-center col-xs-2 col-sm-2 col-md-1 col-lg-1">추천수</th>
						<th class="text-center                   col-md-1 col-lg-1">날짜</th>
						<th class="text-center                   col-md-1 col-lg-1">조회수</th>
					</tr>
				</thead>
				<tbody>
							<!-- 메모장 출력 영역 -------------------------------------------------------------> 
				<form  name="frm" id="frm" action="/board.do" method="get" class="form-inline">
				<input type="hidden" name="page_num" id="page_num">
					<c:choose> 
						<c:when test="${list.size()>0}">
							<c:forEach var="boardVo" items="${list}">
								<tr>
									<td id="bNum" class="text-center"><c:out value="${boardVo.bNum}"></c:out></td>
									<td id="bTitle" class="text-left"><span class="ctt"><c:out value="${boardVo.bTitle}"></c:out></span> <span class="ct"><c:out value="${boardVo.commentNo}"></c:out></span></td>
									  
									<td class="text-left" >    
									<div class="dropdown"> 
 									 <button class="text-center" id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" 
 									   style="border:none; padding:0; background:none;">
									  <span class="cu" >  <c:out value="${boardVo.userId}"></c:out></span>
									  </button> 
									  <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
										<li><button type="button" style="border:none; padding:0; background:none;" value="${boardVo.userId}" class="dropdown-item" id="gallog">　 Gallog</button></li>
									    <li><button type="button" style="border:none; padding:0; background:none;" value="${boardVo.userId}" class="dropdown-item reId" >　 쪽지 보내기</button><li>  
									    <li><a class="dropdown-item" href="/cd/mypage/user_update.do">마이페이지</a><li>
									</ul>
									</div></td>
									<td onclick='event.cancelBubble=true;'​ class="text-center"><span class="hrc"><c:out value="${boardVo.bHit}"></c:out></span></td>
									<td onclick='event.cancelBubble=true;'​ class="text-left"><span class="hrc"><c:out value="${boardVo.regDt}"></c:out></span></td>
									<td onclick='event.cancelBubble=true;'​ class="text-center"><span class="hrc"><c:out value="${boardVo.bCount}"></c:out></span></td>
								</tr> 
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="text-center" colspan="99">등록된 게시글이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</form>
				</tbody>
			</table>
		</div>
		
		
		
		 <!--  인기글 ------------------------------------------------ --> 
    		 <div class="row">
    		  <div class="goodhit">
			   <div class="text-left col-xs-11 col-sm-11 col-md-11 col-lg-11"><button><a class="update" href="/cd/board/bsyhit.do">린끼글 </a></button></div>
			  </div>
			 </div>   
		 <!--  인기글 ------------------------------------------------ --> 
		 
	
	
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "/cd/board/bsy.do", "search_page") %>
		</div>
	
	
				<form  name="boform" id="boform" action="/board.do" method="get" class="form-inline">
				<input type="hidden" name="bNum" id="bNum">
				</form>

	<!--// Grid영역 ---------------------------------------------------->


<!-- 검색영역 -->

			<!-- 검색영역 -->
		<div class="row">
		  <div class="text-center col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<form action="#" class="form-inline">
				<div class="col-xs-12"><hr/></div>
				<div class="col-xs-1"></div>
				<div class="form-group col-xs-10">
					<select name="search_div" id="search_div" class="form-control input-sm" style="height: 35px" >
					    <option value="" >::선택::</option>
						<option value="10" <%if(search_div.equals("10"))out.print("selected='selected'"); %> >ID</option>
						<option value="60" <%if(search_div.equals("60"))out.print("selected='selected'"); %> >제목</option>					
						<option value="70" <%if(search_div.equals("70"))out.print("selected='selected'"); %> >내용</option>					
					</select>
					<input type="text" name="search_word" id="search_word" value="${param.search_word}"  class="form-control input-sm" placeholder="검색어" style="height: 35px" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!-- 					<button type="button" class="btn btn-default btn-sm" style="height: 35px" onclick="javascript:doSearch();">검색</button> -->
				</div>					
				<div class="col-xs-1"></div>
			</form> 
		  </div>	
		</div>
			<!--// 검색영역----------------------------------------------------->






		<!-- 페이징 처리 ---------------------------------------------------->
	
	
	
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    function doSearch(){
	   	 var frm = document.frm;
	   	 frm.page_num.value =1;
	   	 frm.action = "bsy.do";
	   	 frm.submit();
    }
    
	    function search_page(url,page_num){
// 		   	 alert(url+":search_page:"+page_num);
		   	 var frm = document.frm;
		   	 frm.page_num.value = page_num;
         	 console.log(frm.page_num.value);
		   	 frm.action = url;
		   	 frm.submit();
	    }
	    
       function doUpdate(gSeq){ //수정
        	var frm = document.frm;
        	frm.gSeq.value = gSeq;
        	frm.action = "get.do";
        	frm.submit();
        }
	    
	    $(document).ready(function(){
	    	//alert("ready");
	    	
	    	$(".reId").on("click",function(){
	    		var reId = $(this).val();
// 	    		alert("click"+reId);
    		   
	    		
	    		$.ajax({
      	            type:"GET",
      	            url:"/cd/msg/send.do", 
      	            dataType:"html",
      	            data:{
      	            	"reId": reId
      	            },
      	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
      		         	location.href="/cd/msg/send.do?reId="+reId;
      	            },
      	            complete: function(data){//무조건 수행
      	             
      	            },
      	            error: function(xhr,status,error){
      	             
      	            }
      	         });
	    	});
	    	
	    	$("#note").on("click","button",function(){
	    		alert("delete");
	    		
	    	});
		    
			$("#listTable>tbody").on("click","#bTitle",function(){
				console.log("1 #listTable>tbody");

				var tr = $(this).parent();
				var td = tr.children();
				var bNum = td.eq(0).text();
				console.log(bNum);
				var frm = document.boform;
			        	frm.bNum.value = bNum;
			        	frm.action = "/cd/board/get.do";
			        	//frm.action = "cnt.do";
// 			        	alert('전송');
			        	
			        	
			        	
			        	frm.submit();
				

			});//--#listTable>tbody
			
			$(document).on("click","#gallog",function(){ 
    			var userId = $(this).val();
    		   console.log("userId:"+userId); 
    		   
    		   $.ajax({
   	            type:"GET",
   	            url:"/cd/gallog/gallog_home.do", 
   	            dataType:"html",
   	            data:{
   	            	"userId": userId
   	            },
   	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
   		         		location.href="/cd/gallog/gallog_home.do?userId="+userId;
   	            },
   	            complete: function(data){//무조건 수행
   	             
   	            },
   	            error: function(xhr,status,error){
   	             
   	            }
   	         });
    		   
    		 });//gallog
	    	
	    });
 
	    </script>


</body>
</html>