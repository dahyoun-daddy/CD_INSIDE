<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.sist.cd.common.SearchVO" %>
<%@page import="com.sist.cd.common.StringUtil" %>
<!DOCTYPE html>
<html>
<head>
<%
	Logger LOG = LoggerFactory.getLogger(this.getClass());
	String context = request.getContextPath();
	
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//유저아이디
	String search_word="";//메모장:0 방명록:1
	
	int totalCnt      =0;
	int bottomCount   =10;
	
	SearchVO vo =  (SearchVO)request.getAttribute("param");
	LOG.info("vo:"+vo);
	
	int oPageSize = vo.getPage_size();
	int oPageNum  = vo.getPage_num();
	
	String iTotalCnt = (null == request.getAttribute("totalCnt"))?"0":request.getAttribute("totalCnt").toString();
	totalCnt = Integer.parseInt(iTotalCnt);
%>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>부트스트랩 리스트 템플릿</title>

    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


<style type="text/css">
.add{
	width:955px; 
	height:200px; 
	border-top:2px solid #003399; 
	border-bottom:2px solid #003399; 
	background-color: #F6F6F6; 
	padding-top: 20px;
}
hr.hr{
	width:955px;
	text-align: left;
	margin-left: 0px;
}

</style>    
    
<meta charset="UTF-8">
<title>guestbook_home</title>
</head>
<body>
		<!-- 갤로그 공통 부분 --------------------------------------------------------->
		<div class="bg-success">
			<div class="text-primary">
			()님의 갤로그입니다.
			</div>	
			<div class="text-right text-primary" >
		    <span class="today_num">Today <em>()</em></span>
		    <span class="total_num">Total <em>()</em></span>
		    </div>
			 
		</div>
		<!--// 갤로그 공통 부분 ------------------------------------------------------->
		<br>	
		<!-- 갤로그 이동 버튼 영역------------------------------------------------------->
		<ul class="nav nav-pills">
				 <li role="presentation"><a href="<%=context%>/gallog/gallog_home.jsp">갤로그홈</a></li>
				<li role="presentation"><a href="<%=context%>/gallog/notebook_home.do">메모장</a></li>
				<li role="presentation" class="active"><a href="<%=context%>/gallog/guestbook_home.do">방명록</a></li>
		  </ul>	
		<br>
		<!--// 갤로그 이동 버튼 영역----------------------------------------------------->

		<!-- 방명록 상단 영역------------------------------------------------------------>
		<div class="text-danger" style="width:auto;height:40px;">
				<strong>·방명록 (<%=totalCnt %>)</strong>
		</div>
		<!--// 방명록 상단 영역------------------------------------------------------------>
		
		<!-- 방명록 등록 영역 ------------------------------------------------------------>
		<div class="add">
		<div style="float:left;">
			<input type="text" style="width:250px; height:40px;" maxlength="30" placeholder="닉네임"><br/>
			<input type="text" style="width:250px; height:40px;" maxlength="30" placeholder="비밀번호"><br/><br/><br/>
			<input type="button" class="btn btn-default" value="등록" style="width:100px; margin-left:70px;" id="do_save">
		</div>
		<div style="float:right">
			<textarea style="width:700px; height:150px;" maxlength="2000"></textarea>
		</div>
		</div>
		<!--// 방명록 등록 영역 ----------------------------------------------------------->
		
		<!-- 방명록 출력 영역 -------------------------------------------------------------->
		<form  name="frm" id="frm" action="notebook_home.do" method="get" class="form-inline">
		<input type="hidden" name="page_num" id="page_num">
		<c:choose>
				<c:when test="${list.size()>0}">
					<c:forEach var="gallogVo" items="${list}">
						<div style="width:955px; height:100px;">
							<table style="margin-top:20px; width:955px">
							<tr>
								<td class="col-xs-3 col-sm-3 col-md-3 col-lg-3"><c:out value="${gallogVo.gId}"></c:out></td>
								<td class="col-xs-7 col-sm-7 col-md-7 col-lg-7"><c:out value="${gallogVo.gCont}"></c:out></td>
								<td align="center" class="col-xs-2 col-sm-2 col-md-2 col-lg-2"><c:out value="${gallogVo.regDt}"></c:out></td>
							</tr>
							</table>
						</div>
						<div style="float:right; width:955px; margin-right:115px;">
							<button type="button" class="btn btn-default btn-sm" id="do_update" value="${gallogVo.gSeq}">수정</button>
							<button type="button" class="btn btn-default btn-sm" id="do_delete" value="${gallogVo.gSeq}">삭제</button>
						</div>
						<hr class="hr">
					</c:forEach>
				</c:when>
				<c:otherwise>
					등록된 방명록이 없습니다.
				</c:otherwise>
			</c:choose>
		</form>
		
		
		<!--// 방명록 출력 영역 -------------------------------------------------------------->
		
		<!-- 페이징 처리 -------------------------------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "guestbook_home.do", "search_page") %>
		</div>
		<!--// 페이징 처리 -------------------------------------------------------------------------->
		
		
				<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    function search_page(url,page_num){
	   	 //alert(url+":search_page:"+page_num);
	   	 var frm = document.frm;
	   	 frm.page_num.value = page_num;
   	 	 console.log(frm.page_num.value);
	   	 frm.action = url;
	   	 frm.submit();
   	}
    
    function doSearch(){ // 전체조회
     	 var frm = document.frm;
    	 frm.page_num.value = 1;
     	 frm.action = "guestbook_home.do";
     	 frm.submit();
   }
    
    $(document).ready(function(){   
    	
    	$("#do_save").on("click",function(){
    		
			 if(false==confirm("등록 하시겠습니까?"))return;
			  
		     $.ajax({
		         type:"POST",
		         url:"save.do",
		         dataType:"html",// JSON
		         data:{
		         	"gCont": $("#gCont").val(),
		         	"gCate": "0",
		         	"userId": "test05",
		         	"modId": "test05",
		         	"gId": $("#gId").val(),
		         	"gPw": $("#gPw").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag=="1"){
		         		 alert(parseData.message);
			         	 doSearch();
		         	 }else{
		         		alert(parseData.message);
		         	 }
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		        });//--ajax					
			
			
		});//--do_save
		
    });//-- ready
    
    </script>

</body>
</html>