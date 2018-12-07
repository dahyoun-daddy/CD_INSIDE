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
    
<title>:::비밀번호 변경:::</title>
</head>
<body>
	   <div class="container">
	     <div class="page-header">
	       <h1>Class D Inside 비밀번호 변경</h1>
	     </div>
	 <tbody>
		 <form method="post" action="" align="center">
	       <div class="col-sm-2" ><br/></div>
	       <label class="col-sm-3 control-label"><br/>비밀번호 </label>
	       <div class="col-sm-7"><br/>
				<input class ="form-control" type="password" id ="userPw1" name = "userPw1" style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 입력하세요.">
	        </div>
	        <div class="col-sm-2" ><br/></div>
		    <label class="col-sm-3 control-label"><br/>비밀번호 재확인 </label>
	        <div class="col-sm-7" ><br/>
				<input class ="form-control" type="password" id ="userPw2" name = "userPw2" style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 한번 더 입력하세요.">
	        </div>
	        <div class="col-sm-2" ></div>
	        <div class="col-sm-8" ><hr/></div>
	        <div class="col-sm-2" ></div>
	        
	        <div class="col-sm-3" ></div>
	        <div class="col-sm-6" align="center"><br/>
		    	<input class="btn btn-primary " type="submit" value="확인">
			</div>
	        <div class="col-sm-3" ></div>
	    </form>
	</tbody>
	   </div>     
		
			
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
</body>
</html>