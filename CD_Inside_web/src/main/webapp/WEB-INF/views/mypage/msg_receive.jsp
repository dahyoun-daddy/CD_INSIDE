<%@page import="com.sist.cd.common.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
	String context = request.getContextPath();//context path

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
        <form  name="frm" id="frm" action="receive.do" method="get" class="form-horizontal">
		  <div class="form-group">
		    <label for="inputRecvId" class="col-sm-2 control-label">보낸 사람</label>
		      <div class="col-xs-2">		    
		      <input type="text" class="form-control" id="send_id" readonly maxlength="20">
		    </div>
		  </div>

		  <div class="form-group">
		    <label for="inputRecvId" class="col-sm-2 control-label">받은 시간</label>
		      <div class="col-xs-2">		    
		      <input type="text" class="form-control" id="send_time" readonly maxlength="20">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="inputContent" class="col-sm-2 control-label">메시지 내용</label>
		    <div class="col-sm-10">
				<textarea name="cont" rows="10" cols="40" readonly maxlength="400"></textarea>
		    </div>
		  </div>
		<!--// 입력폼 -->

		<!-- 버튼 -->
		<div class="form-group">
		  <div class="col-sm-offset-2 col-sm-10">
		    <button type="submit" class="btn btn-default" id="do_resend">답장</button>
		    <button type="submit" class="btn btn-default" id="do_delete">삭제</button>	

		  </div>
		</div>
		<!--// 버튼 -->
		  
		</form>
	
	    <script src="<%=context%>/resources/js/jquery.min.js"></script>
	    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	    <script type="text/javascript">

	    $(document).ready(function(){   
		    
		  //do_resend 답장
			$("#do_resend").on("click",function(){
			
			});
		  
		 //do_delete 삭제
			$("#do_delete").on("click",function(){
				
			});
	    
		</script>

</body>
</html>