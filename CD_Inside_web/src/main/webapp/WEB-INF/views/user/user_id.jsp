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
	 <tbody>
		 <form method="post" action="" align="center">
	        <div class="col-sm-2" ><br/></div>
	       <label class="col-sm-2 control-label">이름(닉네임) </label>
	       <div class="col-sm-8">
				<input class ="form-control col-sm-8" style="WIDTH: 200pt" type="text" 
					id ="userName" name = "userName" maxlength="20" placeholder="이름(닉네임)을 입력하세요.">
	       </div>
	       <div class="col-sm-2" ><br/></div>
	       <label class="col-sm-2 control-label"><br/>질의응답 </label>
	       <div class="col-sm-8"><br/>
				<select name="userQues" id="userQues" class="form-control input-sm" style="WIDTH: 200pt">
					<option value="내가 가장 좋아하는 사람은?" selected="selected">내가 가장 좋아하는 사람은?</option>
					<option value="내가 가장 좋아하는 음식은?">내가 가장 좋아하는 음식은?</option>
					<option value="살면서 가장 하기 싫은 일은?">살면서 가장 하기 싫은 일은?</option>
					<option value="기억에 남는 장소는?">기억에 남는 장소는?</option>
				</select>
	        </div>
	        <div class="col-sm-2" ><br/></div>
		    <label class="col-sm-2 control-label"><br/>답변 </label>
	        <div class="col-sm-8"><br/>
				<input class ="form-control" type="text" id ="userAnsw" name = "userAnsw" 
					style="WIDTH: 200pt" maxlength="20" placeholder="질문의 답변을 입력하세요.">
	        </div>
	        <div class="col-sm-2" ></div>
	        <div class="col-sm-8" ><hr/></div>
	        <div class="col-sm-2" ></div>
	        
	        <div class="col-sm-3" ></div>
	        <div class="col-sm-6" align="center"><br/>
		    	<input class="btn btn-primary" type="button" value="취소" onclick="history.go(-1)">
		    	<input class="btn btn-primary " type="button" id="idCheck" value="확인">
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
	$(document).ready(function(){
		
		$("#idCheck").on("click",function(){
			
			var userName = $("#userName").val();
			var userQues= $("#userQues").val();
			var userAnsw= $("#userAnsw").val();
			console.log("userName : "+userName);
			console.log("userQues : "+userQues);
			console.log("userAnsw : "+userAnsw);
			
			$.ajax({
		         type:"POST",
		         url:"idFind.do",
		         dataType:"html",// JSON
		         data:{
		         	"userName"  : $("#userName").val(),
		         	"userQues"  : $("#userQues").val(),
		         	"userAnsw"  : $("#userAnsw").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		           	var parseData = $.parseJSON(data);
		         	if(parseData.idFind!=null){
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