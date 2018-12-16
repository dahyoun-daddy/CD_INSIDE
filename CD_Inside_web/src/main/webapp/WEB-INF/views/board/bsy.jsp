<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.cd.domain.CodeVO"%>
<%@page import="com.sist.cd.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	
%>


<!DOCTYPE html>
<html>
<head>

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

.table>tbody>tr>td {
    font-size: 2px;
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

.value{ font-size: 2px; } 
  
</style>   

</head>
<body>
	
	
			<div class="container">
			 <div class="row">
			<div class="text-center col-xs-4 col-sm-4 col-md-4 col-lg-4"><h2>${name}</h2></div>
			<div></div> 
			<div></div>
    	   </div>   
    	   
    	  
    	  <!--  이거슨 세션값 가져왓을때 쓰기 나와야함 -->
    		 <div class="row"> 
    		  <div class="wr">
			   <div class="text-right col-xs-11 col-sm-11 col-md-11 col-lg-11"><a class="update" href="/cd/board/write.do">쓰기 </a></div>
			  </div>
			 </div>  
			       
			     
			
			   <p></p>
				<div class="table-responsive"> 
		
		
				<table id="listTable"
					class="table table-striped table-bordered table-hover">
						
			
			
					<thead class="bg-primary">
					<tr>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">번호</th>
						<th class="text-center col-xs-11 col-sm-11 col-md-8 col-lg-7">제목</th>
						<th class="text-center col-xs-1 col-sm-1 col-md-2 col-lg-2">글쓴이</th>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">추천수</th>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">날짜</th>
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
									<td id="bTitle" class="text-left"><c:out value="${boardVo.bTitle}"></c:out></td>
									  
									<td class="text-left" >
									<div class="dropdown">
									  <a class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" 
									  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    <c:out value="${boardVo.userId}"></c:out>
									  </a> 
									  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									    <li><a class="dropdown-item" href="/cd/gallog/notebook_home.do">Gallog</a></li>
									    <li> <a class="dropdown-item" href="#">쪽지</a> <li>  
									    <li> <a class="dropdown-item" href="#">음 뭐추가 하지</a> <li>
									  </div>
									</div>
									</td>
									<td onclick='event.cancelBubble=true;'​ class="text-center"><c:out value="${boardVo.bHit}"></c:out></td>
									<td onclick='event.cancelBubble=true;'​ class="text-center"><c:out value="${boardVo.regDt}"></c:out></td>
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
			   <div class="text-left col-xs-11 col-sm-11 col-md-11 col-lg-11"><a class="update" href="/cd/board/write.do">린끼글 </a></div>
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


			<div class="row">
			  <div class="text-center col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<form action="#" >
					<%-- <div >
						<%=StringUtil.makeSelectBox(code_page, page_size, "page_size", false) %>
					</div> --%>
						<select name="search_div" id="search_div" >
						    <option value="" >::전체::</option>
							<option value="10" <%if(search_div.equals("10"))out.print("selected='selected'"); %> >ID</option>
							<option value="20" <%if(search_div.equals("20"))out.print("selected='selected'"); %> >이름</option>					
						</select>
						<input type="text" name="search_word" id="search_word" value="${param.search_word}"  placeholder="검색어" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default btn-sm" onclick="javascript:doSearch();">조회</button>
						</form>
					</div>					
				<div></div>
				<div></div> 
			  </div>	  
			</div> 
			<!--// 검색영역----------------------------------------------------->






		<!-- 페이징 처리 ---------------------------------------------------->
	
	
	
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
	    
       function doUpdate(gSeq){ //수정
        	var frm = document.frm;
        	frm.gSeq.value = gSeq;
        	frm.action = "get.do";
        	frm.submit();
        }
	    
	    $(document).ready(function(){
	    	//alert("ready");
	    	
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
			        	alert('전송');
			        	frm.submit();
				

			});//--#listTable>tbody
	    	
	    });

	    </script>







	<!-- <table class="table"> -->
	<!--  	<tr class="active">1</tr> -->
	<!-- 	<tr class="success">2</tr> -->
	<!-- 	<tr class="warning">3</tr> -->
	<!-- 	<tr class="danger">4</tr> -->
	<!-- 	<tr class="info">5</tr> -->

	<!--   </table> -->

	<!-- On rows -->

	<!-- On cells (`td` or `th`) -->
	<!-- <tr> -->
	<!--   <td class="active">...</td> -->
	<!--   <td class="success">...</td> -->
	<!--   <td class="warning">...</td> -->
	<!--   <td class="danger">...</td> -->
	<!--   <td class="info">...</td> -->
	<!-- </tr> -->




</body>
</html>