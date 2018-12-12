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
		   		    <input type="text"  class="form-control" style="WIDTH: 300px" name="userId"  id="userId"  placeholder="아이디">
		   		    
		         </div>
	 	   		 <div class="form-group input-sm" align="center">
		   		    <input type="password"  class="form-control" style="WIDTH: 300px" name="userPw1"  id="userPw1"  placeholder="비밀번호">
		         </div>
		         <div class="form-group input-sm" align="center" >
		         	<input type="button" id="login" class="btn btn-primary" style="WIDTH: 300px" value="로그인">
		         </div>
		         <div style="height:100px">
		    	<div class="col-sm-3"></div>
		         <div class="form-group input-sm col-sm-7" align="center"  ><hr/>
		         	<a style="text-left" href="user_join.do" id="login" value="login"> 회원가입  </a> ┃ 
		         	<a style="text-left" href="user_id.do"  id="idFind" value="idFind"> 아이디 찾기 </a> ┃ 
		         	<a style="text-left" href="user_pw.do"  id="pwFind" value="pwFind"> 비밀번호 찾기</a><hr/>
		         </div>
		         </div>
		     </form>
	     </div>  
	      
	   </div>     


			
	</form>
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    
    <script type="text/javascript">
    
    

	$(document).ready(function(){
		
		$("#login").on("click",function(){
// 			alert("로그인 버튼");
			
			var userId = $("#userId").val();
			var userPw1= $("#userPw1").val();
			console.log("userId : "+userId);
			console.log("userPw1 : "+userPw1);

			var blank_pattern = /[\s]/g;// 공백
			if(userId.trim()==""||userPw1.trim()==""){
				alert("아이디와 비밀번호를 입력하세요.");
				return;
			}else if(userId.match(blank_pattern)||userPw1.match(blank_pattern)){
				alert("공백은 사용할 수 없습니다!");
				return;
			}
			
			$.ajax({
		         type:"POST",
		         url:"user_login.do",
		         dataType:"html",// JSON
		         data:{
		         	"userId"  : $("#userId").val(),
		         	"userPw"  : $("#userPw1").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	if(parseData.flag1<=0){
		         		alert("회원가입한 정보가 없습니다.");
		         		return;
		         	}
		         	 if(parseData.flag>0){
		         		alert(parseData.message);
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