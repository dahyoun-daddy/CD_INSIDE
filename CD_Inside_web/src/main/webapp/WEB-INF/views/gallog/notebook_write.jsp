<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.sist.cd.domain.GallogVO" %>
<%@page import="com.sist.cd.common.SearchVO" %>
<!DOCTYPE html>
<html>
<head>
<%
	Logger LOG = LoggerFactory.getLogger(this.getClass());
	String context = request.getContextPath();
	SearchVO vo =  (SearchVO)request.getAttribute("param");
	LOG.info("vo:"+vo);
	int oPageNum  = vo.getPage_num();
	LOG.info("oPageNum:"+oPageNum);
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
    
<meta charset="UTF-8">
<title>notebook_write</title>
</head>
<body>

<div class="container">

		<!-- 갤로그 공통 부분 --------------------------------------------------------->
		<div class="bg-success" style="width:955px;">
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
				<li role="presentation" class="active"><a href="<%=context%>/gallog/notebook_home.do">메모장</a></li>
				<li role="presentation" ><a href="<%=context%>/gallog/guestbook_home.do">방명록</a></li>
		  </ul>	
		
		<!--// 갤로그 이동 버튼 영역----------------------------------------------------->

		<!-- 메모장 글쓰기 영역 --------------------------------------------------------->
		<form  name="frm" id="frm" action="notebook_home.do" method="get" class="form-inline">
		<input type="hidden" name="page_num" id="page_num">
		<input type="hidden" name="gSeq" id="gSeq" value="${list.gSeq}">
		<div>
			<input type="text" name="gTitle" id="gTitle" maxlength="50" style="width:800px" value="${list.gTitle}"/>
		</div>
		
		<div>
			<textarea name="gCont" id="gCont" maxlength="3000" style="width:800px;height:500px;">${list.gCont}</textarea>
		</div>
		</form>
		
		
		<button type="button" class="btn btn-default" onClick="history.go(-1)">취소</button>
		
		<%
			GallogVO check =  (GallogVO)request.getAttribute("list");
			if(check==null){
		%>
		<button type="button" class="btn btn-default" id="do_save">등록</button>
		<%
			}
			else{
		%>
		<button type="button" class="btn btn-default" id="do_update">수정</button>
			<% 
		}
		%>
		
		<!--// 메모장 글쓰기 영역 --------------------------------------------------------->
</div>
		
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    
    function doSearch(){ // 등록후 1페이지로 가서 전체조회
      	 var frm = document.frm;
      	 frm.action = "notebook_home.do";
      	 frm.submit();
    }
    
    function doSearch1(){ // 수정후 그페이지로 다시가서 조회
     	 var frm = document.frm;
         frm.page_num.value = <%=oPageNum%>;
//       alert(frm.page_num.value);
    	 frm.action = "notebook_home.do";
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
		         	"gTitle": $("#gTitle").val(),
		         	"gCont": $("#gCont").val(),
		         	"gCate": "0",
		         	"userId": "test05",
		         	"modId": "test05"
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
		
		
		$("#do_update").on("click",function(){
    		
			 if(false==confirm("수정 하시겠습니까?"))return;
			  
		     $.ajax({
		         type:"POST",
		         url:"update.do",
		         dataType:"html",// JSON
		         data:{
		        	"gSeq": $("#gSeq").val(),
		         	"gTitle": $("#gTitle").val(),
		         	"gCont": $("#gCont").val(),
		         	"gCate": "1",
		         	"modId": "test05"
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag=="1"){
		         		 alert(parseData.message);
		         		 doSearch1();
		         	 }else{
		         		alert(parseData.message);
		         	 }
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		        });//--ajax					
			
			
		});//--do_update
   
   	
    });//ready
    
    
    
    
    
    </script>

</body>
</html>