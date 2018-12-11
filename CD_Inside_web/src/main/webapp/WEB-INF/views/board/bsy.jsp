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

<link href="<%=context%>/resources/css/bootstrap.min.css"
	rel="stylesheet">



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
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">추천
							수</th>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${list.size()>0}">
							<c:forEach var="boardVo" items="${list}">
								<tr>
									<td class="text-center"><c:out value="${boardVo.bNum}"></c:out></td>
									<td class="text-left"><c:out value="${boardVo.bTitle}"></c:out></td>
									<td class="text-left"><c:out value="${boardVo.userId}"></c:out></td>
									<td class="text-center"><c:out value="${boardVo.bHit}"></c:out></td>
									<td class="text-center"><c:out value="${boardVo.regDt}"></c:out></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="text-center" colspan="99">등록된 게시글이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

	</div>
	<!--// Grid영역 ---------------------------------------------------->


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
	    
	    
	    $(document).ready(function(){
	    	//alert("ready");
	    	
	    	$("#note").on("click","button",function(){
	    		alert("delete");
	    		
	    	});
	    	
	    	//$("#do_delete").on("click",function(){
	    	//	alert("delete");
	    		
	    		
	    	//});
	    	
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