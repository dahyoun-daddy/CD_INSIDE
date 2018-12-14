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
        <form  name="frm" id="frm" action="send.do" method="get" class="form-horizontal">
		  <div class="form-group">
		    <label for="inputRecvId" class="col-sm-2 control-label">받는 사람</label>
		      <div class="col-sm-2">			    
		      <input type="text" class="form-control" id="recv_id" placeholder="아이디 입력" maxlength="20">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="inputContent" class="col-sm-2 control-label">메시지 내용</label>
		    <div class="col-sm-10">
				<textarea name="cont" rows="10" cols="40" maxlength="400" placeholder="내용을 입력하세요"
					onKeyUp="javascript:fnChkByte(this,'400')"></textarea>
				<span id="byteInfo">0</span>/400 Byte
		    </div>
		  </div>

		<!--// 입력폼 -->

		<!-- 버튼 -->
		<div class="form-group">
		  <div class="col-sm-offset-2 col-sm-10">
		    <button type="submit" class="btn btn-default" id="do_send" onclick="closePopup();">보내기</button>
		    <button type="submit" class="btn btn-default" id="do_cancel" onclick="closePopup();">취소</button>	

		  </div>
		</div>
		<!--// 버튼 -->
		
		
		<div class="container">
			<div class="panel panel-primary">
				<div class="panel-body">
					<c:out value="${list.bTitle}"></c:out>
		  
		</form>
	
	    <script src="<%=context%>/resources/js/jquery.min.js"></script>
	    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	    <script type="text/javascript">

	    //보내기 버튼 누르면 보내고  팝업 닫기
	    function closePopup(){
	    	 javascript:window.close();
	    }
	    
	    //취소 버튼 누르면 팝업 닫기
	    function closePopup(){
	    	 javascript:window.close();
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
	    	    str2 = str.substr(0,rlen);   //문자열 자르기
	    	    obj.value = str2;
	    	    fnChkByte(obj, maxByte);
	    	}else{
	    	    document.getElementById('byteInfo').innerText = rbyte;
	    	}	    
	    	
	    }

		</script>

</body>
</html>