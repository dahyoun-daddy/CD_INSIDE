<%@page import="java.io.PrintWriter"%>
<%@page import="com.sist.cd.common.StringUtil"%>
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
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>쪽지쓰기</title>

    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

	</head>
	<body>
	    <div class="container-fluid">
    	<!-- Title영역 -->
    	<div class="page-header">
    		<h3>쪽지쓰기</h3>

		<!-- 입력폼 -->
		<hr/>

        <form  name="frm" id="frm" action="sendIndex.do" method="post" class="form-horizontal">
		  <div class="form-group">
	  		<input type="hidden" name="msgSeq" id="msgSeq" value="${list.msgSeq}">		  
		    <label for="msgRectRecvId" class="col-sm-2 control-label">받는이</label>
		      <div class="col-sm-2">			    
		      <input type="text" class="form-control" name="msgRecvId" id="msgRecvId" value="${reId}" maxlength="20" disabled />
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="inputContent" class="col-sm-2 control-label">메시지 내용</label>
		    <div class="col-sm-10">
				<textarea style ="resize:none;" name="msgCont" id="msgCont" rows="10" cols="40" maxlength="400" placeholder="내용을 입력하세요" onKeyUp="javascript:fnChkByte(this,'400')">${list.msgCont}</textarea>
				<span id="byteInfo">0</span>/400 Byte
		    </div>
		  </div>

		<!--// 입력폼 -->

		<!-- 버튼 -->
		<div class="form-group">
		  <div class="col-sm-offset-2 col-sm-10">
		    <button type="submit" class="btn btn-default" id="do_add">보내기</button>
		    <button type="submit" class="btn btn-default" onclick="back()">취소</button>	
		  </div>
		</div>
		<!--// 버튼 -->

	    <script src="<%=context%>/resources/js/jquery.min.js"></script>
	    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	    <script type="text/javascript">
	    

	    function back(){
	    	window.history.back();
	    }
	    
	    //글자수 세기
	    function fnChkByte(obj, maxByte){
	    	var str = obj.value;
	    	var str_len = str.length;

	    	var rbyte = 0;
	    	var rlen = 0;
	    	var one_char = "";
	    	var str2 = "";

	    	for(var i=0; i<str_len; i++){
		    	one_char = str.charAt(i);
		    	if(escape(one_char).length > 4){
		    	    rbyte += 2;  //한글2Byte
		    	}else{
		    	    rbyte++;     //영문 등 나머지 1Byte
		    	}
	
		    	if(rbyte <= maxByte){
		    	    rlen = i+1;   //return할 문자열 갯수
		    	}
	    	}
	    	
	    	
	    	

	    	if(rbyte > maxByte){
	    	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    	    str2 = str.substr(0,rlen);//문자열 자르기   
	    	    obj.value = str2;
	    	    fnChkByte(obj, maxByte);
	    	}else{
	    	    document.getElementById('byteInfo').innerText = rbyte;
	    	}	    
	    	
	    }
	    
	    $(document).ready(function(){   
	    	
	    	$("#do_add").on("click",function(){
	    		
	    		 var msgCont = $("#msgCont").val();
	    		 
	    		 if(msgCont.trim()==""||null==msgCont){
	    			 alert("내용을 입력하세요.");
	    			 return false;
	    		 }
	    		 
	    		 
	    		 
				 if(false==confirm("전송 하시겠습니까?"))return;
				  
			     $.ajax({
			         type:"POST",
			         url:"add.do",
			         dataType:"html",// JSON
			         data:{
			        	"msgSeq": "msgSeq",
			         	"userId": $("#userId").val(),
				        "msgRecvId": $("#msgRecvId").val(),
				        "msgCont": $("#msgCont").val()
			         },
			         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
			              var parseData = $.parseJSON(data);

			              $("#msgSeq").val(parseData.msgSeq);
			              $("#userId").val(parseData.userId);
			              $("#msgRecvId").val(parseData.msgRecvId);		              
			              $("#msgCont").val(parseData.msgCont);
			              $("#regDt").val(parseData.regDt);
			              $("#msgReadYn").val(parseData.msgReadYn);
			              
			              $("#msgSeq").prop("disabled",true);
			              
			         },
			         complete: function(data){//무조건 수행
		         		 location.href="sendIndex.do";

			         },
			         error: function(xhr,status,error){
			          
			         }
			        });//--ajax					
				
				
			});//--do_add
	    });//ready

		</script>

</body>
</html>