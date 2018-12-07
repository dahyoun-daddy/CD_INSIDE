<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String context = request.getContextPath();//context path
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">
    
<title>:::아이디 찾기:::</title>
</head>
<body>
	   <div class="container">
	     <div class="page-header">
	       <h1>Class D Inside 아이디 찾기</h1>
	     </div>
		 <form class="form-horizontal" method="post" action="" >
	 <tbody>
		<div class="col-sm-6" style="height:40px; padding-top:6px; border :3px solid #01DFD7 ">
			회원가입 한 아이디는 [&nbsp;  &nbsp;] 입니다.
		</div>
		<div class="col-sm-12" align="center"><br/>
			<input class="btn btn-primary " type="submit" value="확인">
		</div>
		<tr>
	</tbody>
	    </form>
	   </div>     
		
			
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
</body>
</html>