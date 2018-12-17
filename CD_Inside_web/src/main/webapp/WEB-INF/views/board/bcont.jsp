<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 뷰단에서 뿌려주는거 포 이치해서 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sist.cd.domain.BoardVO"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<%
// 	BoardVO vo = (BoardVO) request.getAttribute("list");

%>




<style>
.row-centered {
	text-align: center;
}

.col-centered {
	display: inline-block;
	float: none;
	/* reset the text-align */
	text-align: left;
	/* inline-block space fix */
	margin-right: -4px;
}
</style>


</head>
<body>

	<div class="container">
		<div>
		<button class="update" href="/cd/board/update.do"> 수정 버튼 </button>
		<button class="update"> 삭제 버튼  </button> 
		</div>



		<div class="panel panel-primary">
			

							<div class="panel-body">
								<b><c:out value="${list.bTitle}"></c:out></b>
							</div>
							<div class="panel-footer">
								<b><c:out value="${list.userId}"></c:out></b>
								<d>time:</d><c:out value="${list.regDt}"></c:out>
							</div>
		</div>

		<div class="row"></div> 

		<c> <c:out value="${list.bCont}"></c:out> </c>

		

		<!-- <hr style="border: solid 2px gray;"> -->
		
		<div class="row">
		  <div class="text-right col-xs-12 col-sm-12 col-md-12 col-lg-12">
		     <button type="submit" class="btn btn-info">reco+1</button>
		  </div>
		</div>

	</div>


</body>
</html>