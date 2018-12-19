<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String context = request.getContextPath();//context path
	
	//세션 타임아웃시 경고창과 함께 로그인페이지로 이동하는 부분!!
	session = request.getSession(false);
	PrintWriter outt = response.getWriter();
	if(null==session || session.getAttribute("sessionId")==null){
		outt.print("<script>alert('로그인이 필요한 화면입니다.');location.href='/cd/user/login.do'</script>");
		return;
	}
	
	
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
			<a >${sessionName}</a>님<br/>
			쪽지<a >value</a> 
		</div>
		<ul class="nav nav-pills col-sm-9" align="center" >
		<c:choose>
			<c:when test="${sessionYn==1 }">
		  <li role="presentation" ><a href="/cd/mypage/user_list.do" >회원관리</a></li>
			</c:when>
		</c:choose>
		  <li role="presentation" class="active"><a href="/cd/mypage/user_update.do">개인정보 수정</a></li>
		  <li role="presentation" ><a href="/cd/mypage/user_act.do">활동내역</a></li>
		  <li role="presentation"><a href="/cd/msg/receiveIndex.do" >쪽지함</a></li>
		  <li role="presentation"><a href="/cd/gallog/notebook_home.do" >갤로그 가기</a></li>
		</ul>
	</thead>
	 <tbody>
		 <form method="post" action="" align="center" id="frmSave" name="frmSave" >
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
		  		<input class ="form-control" type="text" id ="userName" name = "userName" onkeydown="inputNameChk()"
		  		 value="${userVo.userName }" style="WIDTH: 200pt" maxlength="20" placeholder="이름(닉네임)을 입력하세요.">
		  		 
				<input type="hidden" name="nameDuplication" id="nameDuplication" value="nameCheck">
	        </div>
	        
	        <div class="col-sm-5" ></div>
	        <div class="col-sm-7" align="left" >
		  		 <input type="button" class="btn btn-default" id="nameCheck" value="중복 확인">
		  	</div>
	        
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label"><br/>질의응답 </label>
	        <div class="col-sm-7"><br/>
		  		<select name="userQues" id="userQues" class="form-control input-sm" style="WIDTH: 200pt">
		  			<option value="내가 가장 좋아하는 사람은?" <c:if test="${userVo.userQues=='내가 가장 좋아하는 사람은?' }">selected='selected'</c:if> >내가 가장 좋아하는 사람은?</option>
		  			<option value="내가 가장 좋아하는 음식은?" <c:if test="${userVo.userQues=='내가 가장 좋아하는 음식은?' }">selected='selected'</c:if> >내가 가장 좋아하는 음식은?</option>
		  			<option value="살면서 가장 하기 싫은 일은?" <c:if test="${userVo.userQues=='살면서 가장 하기 싫은 일은?' }">selected='selected'</c:if> >살면서 가장 하기 싫은 일은?</option>
		  			<option value="기억에 남는 장소는?" <c:if test="${userVo.userQues=='기억에 남는 장소는?' }">selected='selected'</c:if> >기억에 남는 장소는?</option>
		  		</select>
	         </div>
	         <div class="col-sm-2" ></div>
		     <label class="col-sm-3 control-label"><br/>답변 </label>
	         <div class="col-sm-7"><br/>
		  		<input class ="form-control" type="text" id ="userAnsw" name = "userAnsw" 
		  		value ="${userVo.userAnsw }" style="WIDTH: 200pt" maxlength="20" placeholder="질문의 답변을 입력하세요.">
	         </div>
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label"><br/>이메일 </label>
	        <div class="col-sm-7"><br/>
		  		<input class ="form-control" type="text" id ="userEmail" name = "userEmail"
		  		 value ="${userVo.userEmail }" style="WIDTH: 200pt" maxlength="20" placeholder="이메일을 입력하세요.">
	        </div>
	        
	         <div class="col-sm-12" ><hr/></div>
	         
	         <div class="col-sm-3" ></div>
	         <div class="col-sm-6" align="center"><br/>
		     	<input class="btn btn-primary " type="button" id ="do_update" value="수정">
		     	<input class="btn btn-primary " type="button" id ="do_delete" value="삭제">
		  	</div>
	         <div class="col-sm-3" ></div>
	    </form>
	</tbody>
	   </div>
		
			
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    
    <script type="text/javascript">
    
	function inputNameChk(){
	    document.frmSave.nameDuplication.value ="nameUnCheck";
	}
	
    
    
    
    $(document).ready(function(){ 
    	
    	//name 중복체크 및 유효성 검사
		$("#nameCheck").on("click",function(){

			var userName = $("#userName").val();
			console.log("userName : "+userName.length);
			var blank_pattern = /[\s]/g;// 공백
			var kor=/[ㄱ-ㅎㅏ-ㅣ]/;//한글 자음,모음
			
			if( userName.match(blank_pattern)){
			    alert('이름(닉네임)에 공백을 사용할 수 없습니다. ');
			    $("#userName").val("");
			    return;
			}else if(userName.match(kor)){
			    alert('한글 자음과 모음을 단독으로 사용할 수 없습니다.');//리뷰때 같이 생각좀
			    $("#userName").val("");
			    return;
				
				
			}else if(userName.length<2 || userName==""){
				alert("2글자 이상 입력하세요.");
				$("#nameCheck").focus();
				return;
			}

			$.ajax({
		         type:"POST",
		         url:"<%=context%>/user/nameCheck.do",
		         dataType:"html",// JSON
		         data:{
		         	"userName"  : $("#userName").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(null==parseData.outName){
		         		alert(parseData.message);
		         		$("#nameDuplication").val("nameCheck");
		         		console.log("***"+$("#nameDuplication").val());
		         	 }else{
		         		alert(parseData.message);
		         		$("#nameDuplication").val("nameUnCheck");
		         		console.log("***"+$("#nameDuplication").val());
		         	 }				          
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		    });//--ajax
		});//--nameCheck
    	
    	
    	
    	
	    $("#do_update").on("click",function(){
			var nameDuplication = $("#nameDuplication").val();
			console.log("nameDuplication : "+nameDuplication);

			if(nameDuplication=="nameUnCheck"){
				alert("이름(닉네임) 중복확인을 하세요!");
				return;
			}

			var userPw1 = $("#userPw1").val();
			var userPw2 = $("#userPw2").val();
			
			//공백 체크
			var blank_pattern = /[\s]/g;
			if(userPw1.match(blank_pattern)||userPw2.match(blank_pattern)){
			    alert("비밀번호에 공백을 사용할 수 없습니다. ");
				$("#userPw1").val("");
				$("#userPw2").val("");
			    return;
			}
			
			if(userPw1.length<8){
				alert("비밀번호를 8글자 이상 입력하세요.");
				$("#userPw1").focus();
				return;
			}else if(userPw1!=userPw2){
				alert("비밀번호가 일치하지 않습니다.");
				$("#userPw1").focus();
				return;
			}else if(userPw1=="" ){
				alert("비밀번호를 입력하세요.");
				$("#userPw1").focus();
				return;
			}else if(userPw2==""){
				alert("비밀번호를 입력하세요.");
				$("#userPw2").focus();
				return;
			}
			
			if($("#userName").val()==""){
				alert("이름(닉네임)을 입력하세요.");
				$("#userName").focus();
				return;
			}			 
	    	
			if($("#userName").val()==""){
				alert("이름(닉네임)을 입력하세요.");
				$("#userName").focus();
				return;
			}
			if($("#userAnsw").val()==""){
				alert("답변을 입력하세요.");
				$("#userAnsw").focus();
				return;
			}
			
			//이메일 유효성 검사 
			var userEmail = $("#userEmail").val();
			var email_check=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if($("#userEmail").val()==""){
				alert("이메일을 입력하세요.");
				$("#userEmail").focus();
				return;
			}else if(!email_check.test(userEmail)){
				alert("유효하지 않은 이메일 형식입니다.");
				return;
			}	    	
	    	
	    	
	    	if(false==confirm("수정 하시겠습니까?"))return;
	
		     $.ajax({
		         type:"POST",
		         url:"uUpdate.do",
		         dataType:"html",// JSON
		         data:{
		         	"userName": $("#userName").val(),
		         	"userPw": $("#userPw").val(),
		         	"userPw1": $("#userPw1").val(),
		         	"userQues": $("#userQues").val(),
		         	"userAnsw": $("#userAnsw").val(),
		         	"userEmail": $("#userEmail").val(),
		         	"modId": $("#modId").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag>0){
		         		 alert(parseData.message);
		         		 location.href="user_update.do";
		         	 }else{
		         		alert(parseData.message);
		         	 }
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
			});//--ajax					
	
	
		});//--do_update
	});
    
    </script>
    
    
</body>
</html>