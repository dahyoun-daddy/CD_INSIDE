<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String context = request.getContextPath();//context path
	Logger log = LoggerFactory.getLogger(this.getClass());
	String outId= (String)request.getAttribute("outId");
	log.debug("-*-outId : "+outId);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    
    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">
    
<title>Class D Inside 회원가입</title>
</head>
<body>
   	<div class ="container">
		<form role="form" id="frmSave" name="frmSave"
			  method="post" class="form-horizontal">
				<input type="hidden" name="upsert_div" id="upsert_div" value="">
			<table class ="table table-borderd table-hover" style="text-align: center; border :3px solid #dddddd ; margin-top:5%">
				<thead>
					<tr >
						<th colspan ="3" style="text-align: center" ><h2>Class D Inside 회원가입</h2></th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style="width:110px; padding-top:15px">아이디</td>
						<td><input class="form-control " type="text" id="userId" name="userId" onkeydown="inputIdChk()"
							maxlength="15" placeholder="아이디를 4글자 이상 입력하세요."></td>
						<td align="left">
							<input type="button" class="btn btn-default" id="idCheck" value="중복 확인">
							<input type="hidden" name="idDuplication" id="idDuplication" value="idUnCheck">
						</td>
					</tr>
					<tr>
						<td style="width:110px; padding-top:15px">비밀번호</td>
						<td><input class="form-control " type="password" id="userPw1" name="userPw1"  
							maxlength="15" placeholder="비밀번호를 8글자 이상 입력하세요."></td>
						<td></td>
					</tr>
					<tr>
						<td style="width:110px; padding-top:15px">비밀번호 재확인</td>
						<td><input class="form-control " type="password" id="userPw2" name="userPw2"  
							maxlength="15" placeholder="비밀번호를 한번 더 입력하세요."></td>
						<td></td>
					</tr>
					<tr>
						<td style="width:110px; padding-top:15px">이름(닉네임)</td>
						<td><input class="form-control " type="text" id="userName" name="userName" onkeydown="inputNameChk()"
							maxlength="10" placeholder="이름(닉네임)을 입력하세요."></td>
						<td align="left">
							<input type="button" class="btn btn-default" id="nameCheck" value="중복 확인">
							<input type="hidden" name="nameDuplication" id="nameDuplication" value="nameUnCheck">
						</td>
					</tr>
					<tr>
						<td style="width:150px; padding-top:15px">질의응답</td>
							<td style="padding-top:15px">
							<select name="userQues" id="userQues" class="form-control input-sm ">
							<option value="내가 가장 좋아하는 사람은?" selected="selected">내가 가장 좋아하는 사람은?</option>
							<option value="내가 가장 좋아하는 음식은?">내가 가장 좋아하는 음식은?</option>
							<option value="살면서 가장 하기 싫은 일은?">살면서 가장 하기 싫은 일은?</option>
							<option value="기억에 남는 장소는?">기억에 남는 장소는?</option>
						</select>
						<td></td>
					</tr>	
					<tr>
						<td style="width:110px; padding-top:15px">답변</td>
						<td><input class="form-control " type="text" id="userAnsw" name="userAnsw"  
							maxlength="20" placeholder="질문의 답변을 입력하세요."></td>
						<td></td>
					</tr>
					<tr>
						<td style="width:110px; padding-top:15px">이메일 주소</td>
						<td><input class="form-control " type="email" id="userEmail" name="userEmail"  
							maxlength="20" placeholder="이메일을 입력하세요."></td>
						<td></td>
					</tr>
					<tr>
						<td style="text-align: center" colspan="3">
							<input class="btn btn-primary " type="button" value="취소" onclick="history.go(-1)">
							<input class="btn btn-primary " type="button" value="확인" id="do_save" ">
						</td>
					</tr>
					
					
				</tbody>
			</table>
		</form>
	</div>
 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    
<script type="text/javascript">

	//id 인풋텍스트에 입력 또는 수정할때마다
	//중복확인을 누르도록 idDuplication에 값을 넣어줌?
	function inputIdChk(){
	    document.frmSave.idDuplication.value ="idUnCheck";
	}
	function inputNameChk(){
	    document.frmSave.nameDuplication.value ="nameUnCheck";
	}
	
	
	$(document).ready(function(){
		
		//엔터키 막기
		document.addEventListener('keydown', function(event) {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		}, true);
		
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

			var upsert_div = $("#upsert_div").val();
			console.log("upsert_div:"+upsert_div);
			$.ajax({
		         type:"POST",
		         url:"nameCheck.do",
		         dataType:"html",// JSON
		         data:{
		         	"upsert_div": upsert_div,
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
		
		
		//아이디 중복체크 및 유효성 검사
		$("#idCheck").on("click",function(){

			var userId = $("#userId").val();
			console.log("userId : "+userId.length);
			var blank_pattern = /[\s]/g;// 공백
			
			var kor=/[ㄱ-ㅎㅏ-ㅣ]/;//한글 자음,모음
			if( userId.match(blank_pattern)){
			    alert("아이디에 공백을 사용할 수 없습니다. ");
			    $("#userId").val("");
			    return;
			}else if(userId.match(kor)){
			    alert("한글 자음과 모음을 단독으로 사용할 수 없습니다.");//리뷰때 같이 생각좀
			    $("#userId").val("");
			    return;
				
				
			}else if(userId.length<4 || userId==""){
				
				alert("아이디를 4글자 이상 입력하세요.");
				$("#userId").focus();
				return;
			}

			var upsert_div = $("#upsert_div").val();
			console.log("upsert_div:"+upsert_div);
			$.ajax({
		         type:"POST",
		         url:"idCheck.do",
		         dataType:"html",// JSON
		         data:{
		         	"upsert_div": upsert_div,
		         	"userId"   : $("#userId").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(null==parseData.outId){
		         		alert(parseData.message);
		         		$("#idDuplication").val("idCheck");
		         	 }else{
		         		alert(parseData.message);
		         		$("#idDuplication").val("idUnCheck");
		         	 }				          
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		    });//--ajax
		});//--idCheck
		
		
		//등록
		$("#do_save").on("click",function(){

			var idDuplication = $("#idDuplication").val();
			console.log("idDuplication : "+idDuplication);

			if(idDuplication=="idUnCheck"){
				alert("아이디 중복확인을 하세요!");
				return;
			}
			
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
			
			
			//alert("do_save");
			var upsert_div = $("#upsert_div").val();
			console.log("upsert_div:"+upsert_div);
			 
			if(false==confirm("회원가입 하시겠습니까?"))return;
			 
			$.ajax({
		         type:"POST",
		         url:"save.do",
		         dataType:"html",// JSON
		         data:{
		         	"upsert_div": upsert_div,
		         	"userId"   : $("#userId").val(),
		         	"userName" : $("#userName").val(),
		         	"userPw"   : $("#userPw1").val(),
		         	"userEmail": $("#userEmail").val(),
		         	"userQues" : $("#userQues").val(),
		         	"userAnsw" : $("#userAnsw").val(),
		         	"modId"    : $("#userId").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag=="1"){
		         		alert(parseData.message);
		         		location.href ="login.jsp"; 
		         	 }else{
		         		alert(parseData.message);
		         	 }				          
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		    });//--ajax
			
		});
	});
	
</script>
    
</body>
</html>