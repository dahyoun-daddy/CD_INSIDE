<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		  <li role="presentation" class="active" ><a href="/cd/mypage/user_list.do" >회원관리</a></li>
			</c:when>
		</c:choose>
		  <li role="presentation" ><a href="/cd/mypage/user_act.do">활동내역</a></li>
		  <li role="presentation"><a href="/cd/msg/receiveIndex.do" >쪽지함</a></li>
		  <li role="presentation"><a href="/cd/gallog/notebook_home.do" >갤로그 가기</a></li>
		</ul>
	</thead>
	 <tbody>
		 <form method="post" action="" align="center" id="frmSave" name="frmSave" >
		 <div class="col-sm-12" ><hr/></div>
	       <div class="col-sm-2" ></div>
	       <label class="col-sm-3 control-label"><br/>아이디 </label>
	       <div class="col-sm-7"><br/>
				<input class ="form-control" type="test" id ="userId" name = "userId" 
				 style="WIDTH: 200pt" maxlength="20" value="${userVo.userId }" disabled >
	        </div>
	       <div class="col-sm-2" ></div>
	       <label class="col-sm-3 control-label"><br/>비밀번호 </label>
	       <div class="col-sm-7"><br/>
				<input class ="form-control" type="password" id ="userPw" name = "userPw"
				 style="WIDTH: 200pt" maxlength="20"  >
	        </div>
	        
	        <div class="col-sm-12" ><hr/></div>
	        
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label">이름(닉네임) </label>
	        <div class="col-sm-7" >
		  		<input class ="form-control" type="text" id ="userName" name = "userName" onkeydown="inputNameChk()"
		  		 value="${userVo.userName }" style="WIDTH: 200pt" maxlength="20" disabled >
		  		 
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
		  		<input class ="form-control input-sm" type="email" id ="userEmail" name = "userEmail"
		  		 value ="${userVo.userEmail }" style="WIDTH: 200pt" maxlength="20" placeholder="이메일을 입력하세요.">
	        </div>
	        
	        <div class="col-sm-2" ></div>
	        <label class="col-sm-3 control-label"><br/>회원 등급 </label>
	        <div class="col-sm-7" align="left"><br/>
	        	<input type="radio"  name="userYn" id="userYn0" 
	        		value="0" <c:if test="${userVo.userYn==0 }">checked="checked"</c:if> />일반회원 &nbsp;&nbsp;&nbsp;&nbsp;
	        	<input type="radio"  name="userYn" id="userYn1" 
	        		value="1" <c:if test="${userVo.userYn==1 }">checked="checked"</c:if> />관리자
	        </div>
	        
	         <div class="col-sm-12" ><hr/></div>
	         
	         <div class="col-sm-3" ></div>
	         <div class="col-sm-6" align="center">
	            <input class="btn btn-primary " type="button" value="취소" onclick="history.go(-1)">
		     	<input class="btn btn-primary " type="button" id ="do_update" value="수정">
		     	<input class="btn btn-primary " type="button" id ="do_delete" value="삭제">
		  	</div>
	         <div class="col-sm-3" ><br/></div>
	         <div class="col-sm-12"><br/></div>
	    </form>
	</tbody>
	   </div>
	<script type="text/javascript">
    $(document).ready(function(){ 
    	
		$("#do_delete").on("click",function(){
			//alert("do_delete");
			
			var userId =$("#userId").val();
			
			if(false==confirm("삭제 하시겠습니까?"))return;
			
			
	        $.ajax({
	            type:"POST",
	            url:"deleteOne.do",
	            dataType:"html",
	            data:{
	            	"userId": userId
	            },
	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag>0){
		         		 alert(parseData.message);
		         		 location.href="user_list.do";
		         	 }else{
		         		alert(parseData.message);
		         	 }
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	         });//--ajax
			
		});//--do_delete
    	
    	
    	$("#do_update").on("click",function(){
    		
//     		if($("input:radio[name='userYn']").is(":checked") == true){
//     		}
    		var radioVal = $("input:radio[name='userYn']:checked").val();
// 			alert("radioVal :"+radioVal);
    		var userPw = $("#userPw").val();
    	
    		if(userPw.trim()==""||userPw==null){
    			alert("비밀번호를 입력하세요");
    			return;
    		}
			
			
	    	if(false==confirm("수정 하시겠습니까?"))return;
	    	
		     $.ajax({
		         type:"POST",
		         url:"aUpdate.do",
		         dataType:"html",// JSON
		         data:{
		        	"userId":$("#userId").val(),
		         	"userPw": $("#userPw").val(),
		         	"userQues": $("#userQues").val(),
		         	"userAnsw": $("#userAnsw").val(),
		         	"userEmail": $("#userEmail").val(),
		         	"userYn" : radioVal,
		         	"modId": $("#modId").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag>0){
		         		 alert(parseData.message);
		         		 location.href="user_list.do";
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