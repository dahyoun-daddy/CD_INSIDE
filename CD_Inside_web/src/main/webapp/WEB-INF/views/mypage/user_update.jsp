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
    
<title>:::마이페이지 개인정보 수정:::</title>
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
		  <li role="presentation" class="active"><a href="user_update.jsp">개인정보 수정</a></li>
		  <li role="presentation" ><a href="user_act.jsp">활동내역</a></li>
		  <li role="presentation"><a href="#">쪽지함</a></li>
		  <li role="presentation"><a href="#">갤로그 가기</a></li>
		</ul>
	</thead>
	 <tbody>
		 <form method="post" action="" align="center">
		 <div class="col-sm-12" ><hr/></div>
	       <div class="col-sm-2" ></div>
	       <label class="col-sm-3 control-label"><br/>현재 비밀번호 </label>
	       <div class="col-sm-7"><br/>
				<input class ="form-control" type="password" id ="userPw" name = "userPw" 
				 style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 입력하세요.">
	        </div>
	       <div class="col-sm-2" ></div>
	       <label class="col-sm-3 control-label"><br/>비밀번호 </label>
	       <div class="col-sm-7"><br/>
				<input class ="form-control" type="password" id ="userPw1" name = "userPw1"
				 style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 입력하세요.">
	        </div>
	        <div class="col-sm-2" ></div>
		    <label class="col-sm-3 control-label"><br/>비밀번호 재확인 </label>
	        <div class="col-sm-7" ><br/>
				<input class ="form-control" type="password" id ="userPw2" name = "userPw2" 
				style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 한번 더 입력하세요.">
	        </div>
	        
	        <div class="col-sm-12" ><hr/></div>
	        
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label">이름(닉네임) </label>
	        <div class="col-sm-7" >
		  		<input class ="form-control" type="text" id ="userName" name = "userName"
		  		 style="WIDTH: 200pt" maxlength="20" placeholder="이름(닉네임)을 입력하세요.">
	        </div>
	        
	        <div class="col-sm-5" ></div>
	        <div class="col-sm-7" align="left" >
		  		 <button class="btn btn-default" onclick="" >중복 확인</button>
		  	</div>
	        
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label"><br/>질의응답 </label>
	        <div class="col-sm-7"><br/>
		  		<select name="userQues" id="userQues" class="form-control input-sm" style="WIDTH: 200pt">
		  			<option value="1">내가 가장 좋아하는 사람은?</option>
		  			<option value="2">내가 가장 좋아하는 음식은?</option>
		  			<option value="3">살면서 가장 하기 싫은 일은?</option>
		  			<option value="4">기억에 남는 장소는?</option>
		  		</select>
	         </div>
	         <div class="col-sm-2" ></div>
		     <label class="col-sm-3 control-label"><br/>답변 </label>
	         <div class="col-sm-7"><br/>
		  		<input class ="form-control" type="text" id ="userAns" name = "userAns" style="WIDTH: 200pt" maxlength="20" placeholder="질문의 답변을 입력하세요.">
	         </div>
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label"><br/>이메일 </label>
	        <div class="col-sm-7"><br/>
		  		<input class ="form-control" type="text" id ="userEmail" name = "userEmail"
		  		 style="WIDTH: 200pt" maxlength="20" placeholder="이메일을 입력하세요.">
	        </div>
	        
	         <div class="col-sm-12" ><hr/></div>
	         
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