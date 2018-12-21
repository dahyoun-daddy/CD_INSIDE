<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String context = request.getContextPath();//context path
	String pwFind  = request.getParameter("pwFind");
	
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
	       		<input type="hidden" id="userId" value="<%=pwFind %>" >
				<input class ="form-control" type="password" id ="userPw1" name = "userPw1" style="WIDTH: 200pt" maxlength="20" placeholder="비밀번호를 8글자 이상 입력하세요.">
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
	        <div class="col-sm-6" align="center">
		    	<input class="btn btn-primary " type="button" id="pwUpdateCheck" value="확인">
			</div>
	        <div class="col-sm-3" ></div>
	        <div class="col-sm-12"><br></div>
	    </form>
	</tbody>
	   </div>     
		
			
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
        <script type="text/javascript">
	$(document).ready(function(){
		
		$("#pwUpdateCheck").on("click",function(){
			
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
			
			$.ajax({
		         type:"POST",
		         url:"pwFindUpdate.do",
		         dataType:"html",// JSON
		         data:{
		         	"userPw" : $("#userPw1").val(),
		         	"userId" : $("#userId").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		           	var parseData = $.parseJSON(data);
		         	if(parseData.flag>0){
		         		alert(parseData.message);
		         		var msg = confirm("로그인 화면으로 이동하시겠습니까?");
		         		if(msg==true){
			         		location.href ="login.do";
		         		}else{
		         			return;
		         		}
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