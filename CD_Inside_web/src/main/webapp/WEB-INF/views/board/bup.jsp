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
</head>
<body>

		<div class="container">
			<form>
				<div class="form-group">
					 <label for="Name">Title</label>
					 
					 <input type="text" name="gTitle" id="gTitle" maxlength="50" style="width:800px" value="${list.gTitle}"/>
				</div>
				<div>
					<label for="textarea">Context</label><br/>
				 <textarea name="gCont" id="gCont" rows=20 cols=115  maxlength="3000" style="width:800px;height:500px;">${list.gCont}</textarea>
				 </div>
			</form>
				<button type="submit" class="btn btn-info">Submit Information</button>
		</div>



				<form name="frame">
 				
 				 </form>
 </BODY>




 



</body>
</html>