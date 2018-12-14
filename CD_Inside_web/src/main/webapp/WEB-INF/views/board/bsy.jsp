<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>

<!-- 뷰단에서 뿌려주는거 포 이치해서 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.sist.cd.common.SearchVO"%>
<%@page import="com.sist.cd.common.StringUtil"%>




<%
	Logger LOG = LoggerFactory.getLogger(this.getClass());
	String context = request.getContextPath();//context path  

	String page_size = "5";//page_size
	String page_num = "1";//page_num
	String search_div = "";//유저아이디
	String search_word = "";//메모장:0 방명록:1
	

	int totalCnt = 0;
	int bottomCount = 10;

	SearchVO vo = (SearchVO) request.getAttribute("param");
	LOG.info("vo:" + vo);

	int oPageSize = vo.getPage_size();
	int oPageNum = vo.getPage_num();

// 	String iTotalCnt = (null == request.getAttribute("totalCnt")) ? "0"
// 			: request.getAttribute("totalCnt").toString();
// 	totalCnt = Integer.parseInt(iTotalCnt);
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
th {
	font-size: 14px;
	font-style: inherit;
	color: black;
	background-color: white;
	vertical-align: middle;
}

td {
	text-align: left;
}

table {
	width: 500px;
	height: 200px;
	margin-left: auto;
	margin-right: auto;
}
</style>

</head>
<body>
	<div class="table-basic">
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
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">날짜</th>
					</tr>
				</thead>
				<tbody>
						<!-- 메모장 출력 영역 ------------------------------------------------------------->
				<form  name="frm" id="frm" action="/board.do" method="get" class="form-inline">
				
					<c:choose> 
						<c:when test="${list.size()>0}">
							<c:forEach var="boardVo" items="${list}">
								<tr>
									<td id="bNum" class="text-center"><c:out value="${boardVo.bNum}"></c:out></td>
									<td id="bTitle" class="text-left"><c:out value="${boardVo.bTitle}"></c:out></td>
									  
									<td class="text-left" >
									<div class="dropdown">
									  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" 
									  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    <c:out value="${boardVo.userId}"></c:out>
									  </button>
									  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									    <a class="dropdown-item" href="/cd/gallog/notebook_home.do">Gallog</a>
									    <a class="dropdown-item" href="#">Another action</a>
									    <a class="dropdown-item" href="#">Something else here</a>
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
	</div>
	

	
	
				<form  name="boform" id="boform" action="/board.do" method="get" class="form-inline">
				<input type="hidden" name="bNum" id="bNum">
				</form>

	<!--// Grid영역 ---------------------------------------------------->


		<!-- 페이징 처리 ---------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "notebook_home.do", "search_page") %>
		</div>
		
	
	
	
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
        	frm.page_num.value = <%=oPageNum%>;
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