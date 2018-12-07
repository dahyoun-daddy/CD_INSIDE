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
    
<title>:::로그인 페이지:::</title>
</head>
<body>
	   <div class="container">
	     <div class="page-header">
	       <h1>Class D Inside 로그인</h1>
	     </div>
	     
	      <div class=" col-xs-10 col-sm-10 col-md-10 col-lg-10">
		      <form class="form-horizontal" action="" method="post" name="frmLogin" id="frmLogin">
		         <input type="hidden" name="work_div"  >
		   		 <div class="form-group input-sm" align="center">
		   		    <input type="text"  class="form-control" style="WIDTH: 200pt" name="user_id"  id="user_id"  placeholder="아이디">
		   		    
		         </div>
	 	   		 <div class="form-group input-sm" align="center">
		   		    <input type="password"  class="form-control" style="WIDTH: 200pt" name="passwd"  id="passwd"  placeholder="비밀번호">
		         </div>
		         <div class="form-group input-sm" align="center" >
		         	<button id="login" class="btn btn-primary" style="WIDTH: 200pt">로그인</button>
		         </div>
		    	<div class="col-sm-3"></div>
		         <div class="form-group input-sm col-sm-7" align="center"  ><hr/>
		         	<a style="text-left" href="user_join.jsp"  id="login" value="Login"> 회원가입  </a> ┃ 
		         	<a style="text-left" href="user_id.jsp"  id="login" value="Login"> 아이디 찾기 </a> ┃ 
		         	<a style="text-left" href="user_pw.jsp"  id="login" value="Login"> 비밀번호 찾기</a><hr/>
		         </div>
		     </form>
	     </div>  
	      
	   </div>     


			
	</form>
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
</body>
</html>