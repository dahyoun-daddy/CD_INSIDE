<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%
	String context = request.getContextPath();
%>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>부트스트랩 리스트 템플릿</title>

    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    
<meta charset="UTF-8">
<title>guestbook_home</title>
</head>
<body>
		<!-- 갤로그 공통 부분 --------------------------------------------------------->
		<div class="bg-success">
			<div class="text-primary">
			()님의 갤로그입니다.
			</div>	
			<div class="text-right text-primary" >
		    <span class="today_num">Today <em>()</em></span>
		    <span class="total_num">Total <em>()</em></span>
		    </div>
			 
		</div>
		<!--// 갤로그 공통 부분 ------------------------------------------------------->
		<br>	
		<!-- 갤로그 이동 버튼 영역------------------------------------------------------->
		<ul class="nav nav-pills">
				 <li role="presentation"><a href="<%=context%>/gallog/gallog_home.jsp">갤로그홈</a></li>
				<li role="presentation"><a href="<%=context%>/gallog/notebook_home.do">메모장</a></li>
				<li role="presentation" class="active"><a href="<%=context%>/gallog/guestbook_home.jsp'">방명록</a></li>
		  </ul>	
		<br>
		<!--// 갤로그 이동 버튼 영역----------------------------------------------------->

		<!-- 방명록 상단 영역------------------------------------------------------------>
		<div class="text-danger" style="width:auto;height:40px;">
				<strong>·방명록 ()</strong>
		</div>
		<!--// 방명록 상단 영역------------------------------------------------------------>
		
		<!-- 방명록 등록 영역 ------------------------------------------------------------>
		<div style="width:955px; height:200px; border:1px solid #A6A6A6; background-color: #F6F6F6; padding-top: 20px;">
		<div style="float:left;">
			<input type="text" style="width:250px; height:40px;" maxlength="30"><br/>
			<input type="text" style="width:250px; height:40px;" maxlength="30"><br/><br/><br/>
			<input type="button" class="btn btn-default" value="등록" style="width:100px; margin-left:70px;">
		</div>
		<div style="float:right">
			<textarea style="width:700px; height:150px;" maxlength="2000"></textarea>
		</div>
		</div>
		<!--// 방명록 등록 영역 ----------------------------------------------------------->
		
		<!-- 방명록 출력 영역 -------------------------------------------------------------->
		
		
		
		
		
		<!--// 방명록 출력 영역 -------------------------------------------------------------->
		
		
				<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    </script>

</body>
</html>