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
    <title>쪽지읽기</title>

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
    		<h3>쪽지읽기</h3>

		<!-- 입력폼 -->
		<hr/>
        <form  name="frm" id="frm" action="receiveIndex.do" method="post" class="form-horizontal">
		  <div class="form-group">
	  		<input type="hidden" name="msgSeq" id="msgSeq" value="${list.msgSeq}">		  
		    <label for="msgRectRecvId" class="col-sm-2 control-label">보낸이</label>
		      <div class="col-sm-2">			    
		      <input type="text" class="form-control" name="userId" id="userId" value="${list.userId}" readonly maxlength="20"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="msgRectRecvId" class="col-sm-2 control-label">받는이</label>
		      <div class="col-sm-2">			    
		      <input type="text" class="form-control" name="msgRecvId" id="msgRecvId" value="${list.msgRecvId}" readonly maxlength="20"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="inputRecvId" class="col-sm-2 control-label">보낸 시간</label>
		      <div class="col-xs-2">		    
		      <input type="text" class="form-control" name="regDt" id="regDt" value="${list.regDt}" readonly >
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="inputContent" class="col-sm-2 control-label">메시지 내용</label>
		    <div class="col-sm-10">
				<textarea style ="resize:none;" name="msgCont" id="msgCont" rows="10" cols="40" readonly maxlength="400">${list.msgCont}</textarea>
		    </div>
		  </div> 
		  
		<!-- 버튼 -->
		<div class="form-group">
		  <div class="col-sm-offset-2 col-sm-10">
		    <button type="submit" class="btn btn-default" id="do_delete" value="${msgVO.msgSeq}">삭제</button>	
			<button type="submit" class="btn btn-default" onclick="back()">닫기</button>
		  </div>
		</div>
		<!--// 버튼 -->  		  
		</form>
		<!--// 입력폼 -->
	
	    <script src="<%=context%>/resources/js/jquery.min.js"></script>
	    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	    <script type="text/javascript">
	    

	    function back(){
	    	window.history.back();
	    }
	    
        function doDelete(msgSeq){ // 삭제
        	var frm = document.frm;
        	frm.msgSeq.value = msgSeq;
        	frm.action = "delete.do";
        	frm.submit();
        }

        
        
	    $(document).ready(function(){
	    	//alert("ready");
	    	
	    	$("#appendBtn").click(function(){ 
	    		   var dlt = "<button type='button' id='do_delete'/>";
	    		   var tag = "<input type='text' name='${msgVO.msgSeq}' id='${msgVO.msgSeq}'/>"
	    		   $("body").append(dlt);
	    		   $("body").append(tag);
	    		});
	    	
	    		$(document).on("click","#do_delete",function(){ //삭제
	    			var msgSeq = $(this).val();
	    		   console.log("msgSeq:"+msgSeq);
	    		   
	    		   if(false==confirm("삭제하시겠습니까?"))return;
	    		    
	    		   doDelete(msgSeq);
	    		   
	    		 });//delete
	    		 

		    		 	    	
	    });//ready
	    
		</script>

</body>
</html>