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
    
<title>:::마이페이지 활동내역:::</title>
</head>
<body>
	 <div class="container" style="padding-top:3%">
	<thead>
	    <div class="col-sm-1" ></div>
		<div class="col-sm-2" >
			<a >일반회원</a>님<br/>
			쪽지<a >value</a> 
		</div>
		<ul class="nav nav-pills col-sm-9" align="center" >
		  <li role="presentation" ><a href=user_list.do>회원관리</a></li>
		  <li role="presentation" ><a href="user_update.jsp">개인정보 수정</a></li>
		  <li role="presentation" class="active" ><a href="user_act.jsp">활동내역</a></li>
		  <li role="presentation"><a href="#">쪽지함</a></li>
		  <li role="presentation"><a href="#">갤로그 가기</a></li>
		</ul>
	</thead>
	 <tbody>
		 <form method="post" action="" >
	         <div class="col-sm-12" ><hr/></div>
	         <div class="col-sm-12" >
	         <a > 등록한 게시글</a>&nbsp;&nbsp;&nbsp;&nbsp;
	         <a > 등록한 댓글</a>  </div>
	         <div class="col-sm-12" ><hr/></div>
	         
	    </form>
	</tbody>
	   </div>     
		
			
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
</body>
</html>