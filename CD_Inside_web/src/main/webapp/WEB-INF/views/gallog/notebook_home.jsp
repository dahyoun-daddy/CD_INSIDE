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
    
<style>
</style>
<meta charset="UTF-8">
<title>notebook</title>
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
		<div class="row">
		  <div class="text-left col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<button type="button" class="btn btn-default" onclick=" location.href='<%=context%>/gallog/gallog_home.jsp'">갤로그홈</button>
				<button type="button" class="btn btn-primary" onclick=" location.href='<%=context%>/gallog/notebook_home.do'">낙서장</button>
				<button type="button" class="btn btn-default" onclick=" location.href='<%=context%>/gallog/guestbook_home.jsp'">방명록</button>
		  </div>	
		</div>
		<!--// 갤로그 이동 버튼 영역----------------------------------------------------->
		<br>
		
		<!-- 메모장 상단 영역------------------------------------------------------------>
		<div class="text-danger" style="width:auto;height:70px;">
			<div style="float:left;">
				<strong>·메모장 ()</strong>
			</div>
			<div style="float:right;">
				<button type="button" class="btn btn-default" onclick=" location='<%=context%>/gallog/notebook_write.jsp'">글쓰기</button>
			</div>
		</div>
		<!--// 메모장 상단 영역------------------------------------------------------------>
		
		
		<!-- 메모장 출력 영역 ------------------------------------------------------------->
		<form  name="frm" id="frm" action="notebook_home.do" method="get" class="form-inline">
		<input type="hidden" name="page_num" id="page_num">
			<c:choose>
				<c:when test="${list.size()>0}">
					<c:forEach var="gallogVo" items="${list}">
					<div id="note">
						<input type="hidden" name="${gallogVo.gSeq}" id="${gallogVo.gSeq}">
						<div id="title" style="width:auto;height:20px">
							<div style="float:left;">
								<strong><c:out value="${gallogVo.gTitle}"></c:out></strong>
							</div>
							<div style="float:right;">
								<c:out value="${gallogVo.regDt}"></c:out>
							</div>
						</div>
						<div id="contents">
						<hr/>
							<c:out value="${gallogVo.gCont}"></c:out>
						</div>
						<hr/>
						<div style="float:right;">
							<button type="button" class="btn btn-default" onclick=" location='<%=context%>/gallog/notebook_write.jsp'">수정</button>
							<button type="button" class="btn btn-default" id="do_delete" value="${gallogVo.gSeq}">삭제</button>
						</div>
						<br><br><br><br><br>
					</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					등록된 메모장이 없습니다.
				</c:otherwise>
			</c:choose>

		<!--// 메모장 출력 영역 ------------------------------------------------------------->
								
		</form>
				<!-- 페이징 처리 ---------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "notebook_home.do", "search_page") %>
		</div>
		
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    search
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    
	    function search_page(url,page_num){
		   	 alert(url+":search_page:"+page_num);
		   	 var frm = document.frm;
		   	 frm.page_num.value = page_num;
        	 console.log(frm.page_num.value);
		   	 frm.action = url;
		   	 frm.submit();
	    }
	    
        function doSearch(){
       	 var frm = document.frm;
       	 frm.page_num.value =1;
       	 frm.action = "notebook_home.do";
       	 frm.submit();
        }
	    
	    
	    $(document).ready(function(){
	    	//alert("ready");
	    	
	    	$("#appendBtn").click(function(){ 
	    		   var tag = "<button type='button' id='do_delete'/>";
	    		   var dlt = "<input type='text' name='${gallogVo.gSeq}' id='${gallogVo.gSeq}'/>"
	    		   $("body").append(tag);
	    		   $("body").append(dlt);
	    		});
	    		$(document).on("click","#do_delete",function(){ 
	    			var items = [];
	    			var gSeq = $(this).val();
	    		   console.log("gSeq:"+gSeq);
	    		   
	    		   items.push(gSeq);
	    		   
	    		   if(false==confirm("삭제하시겠습니까?"))return;
	    		    
	    		   var jsonGSeq = JSON.stringify(items);
	    		   
	    		   console.log("jsonGSeq"+jsonGSeq);   
	    		   
	    		   $.ajax({
	    			 	type:"POST",
	    			 	url:"delete.do",
	    			 	dataType:"html",
	    			 	data:{
	    			 		"gSeq": gSeq
	    			 	},
	    			 	success: function(data){//통신 성공시
	    			 		var parseData = $.parseJSON(data);
	    			 	    console.log("parseData.flag="+parseData.flag);
			               console.log("parseData.message="+parseData.message);
				         if(parseData.flag > 0){
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
	    		   });//ajax
	    		   
	    		   
	    		   
	    		 });
	    	
	    		
	    	
	    });
	    
    </script>

</body>
</html>