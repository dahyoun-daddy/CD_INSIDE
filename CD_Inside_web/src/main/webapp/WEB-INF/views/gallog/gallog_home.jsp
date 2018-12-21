<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.sist.cd.common.SearchVO" %>
<%@page import="com.sist.cd.common.StringUtil" %>

<!DOCTYPE html>
<html>
<head>
<%
	Logger LOG = LoggerFactory.getLogger(this.getClass());
	String context = request.getContextPath();
	
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//유저아이디
	String search_word="";//메모장:0 방명록:1
	
	int totalCnt      =0;
	int totalCnt2     =0;
	int bottomCount   =10;
	
	SearchVO vo =  (SearchVO)request.getAttribute("param");
	LOG.info("vo:"+vo);
	
	int oPageSize = vo.getPage_size();
	int oPageNum  = vo.getPage_num();
	
	String iTotalCnt = (null == request.getAttribute("totalCnt"))?"0":request.getAttribute("totalCnt").toString();
	totalCnt = Integer.parseInt(iTotalCnt);
	
	String iTotalCnt2 = (null == request.getAttribute("totalCnt2"))?"0":request.getAttribute("totalCnt2").toString();
	totalCnt2 = Integer.parseInt(iTotalCnt2);
	
	String userId = (String) session.getAttribute("sessionId");
	String userId2 = request.getParameter("userId");
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
    
<style>
</style>
<meta charset="UTF-8">
<title>notebook</title>
</head>
<body>

<div class="container">

		<!-- 갤로그 공통 부분 --------------------------------------------------------->
		<div style="width:955px; background-color: #BE81F7; color: #FFFFFF; height:40px;">
			(<%= userId2%>)님의 갤로그입니다.
		</div>
		<!--// 갤로그 공통 부분 ------------------------------------------------------->
		<br>
		       
		<!-- 갤로그 이동 버튼 영역------------------------------------------------------->
		<ul class="nav nav-pills">
				<li role="presentation" class="active"><a style="background-color: #BE81F7; color: #FFFFFF" href="<%=context%>/gallog/gallog_home.do?userId=<%=userId2%>">갤로그홈</a></li>
				<li role="presentation"><a style=" color: #BE81F7" href="<%=context%>/gallog/notebook_home.do?userId=<%=userId2%>">메모장</a></li>
				<li role="presentation" ><a style=" color: #BE81F7" href="<%=context%>/gallog/guestbook_home.do?userId=<%=userId2%>">방명록</a></li>
		  </ul>	
		
		<!--// 갤로그 이동 버튼 영역----------------------------------------------------->
		<br>

		<!-- 메모장 상단 영역------------------------------------------------------------>
		<div class="text-danger" style="width:955px;height:70px;">
			<div style="float:left;">
				<strong>·메모장 (<%=totalCnt %>)</strong>
			</div>
		</div>
		<!--// 메모장 상단 영역------------------------------------------------------------>



		<!-- 메모장 출력 영역 ------------------------------------------------------------->
		<div style="width:955px;">
		<input type="hidden" name="userId" value="<%=userId2%>">  
			<c:choose>
				<c:when test="${list.size()>0}">
					<c:forEach var="gallogVo" items="${list}">
					<div id="note">
						<div id="title" style="width:auto;height:20px">
							<div style="float:left;">
								<strong><c:out value="${gallogVo.gTitle}"></c:out></strong>
							</div>
							<div style="float:right;">
								<c:out value="${gallogVo.regDt}"></c:out>
							</div>
						</div>
						<div id="contents" style="width:955px;word-break:break-all;word-wrap:break-word;">
						<hr/>
							<pre style="border:0; overflow: auto; white-space: pre-wrap; background-color:white;"><c:out value="${gallogVo.gCont}"></c:out></pre>
						</div>
						<hr/>
					</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					등록된 메모장이 없습니다.
					<br/><br/><br/>
				</c:otherwise>
			</c:choose>
				<!--// 메모장 출력 영역 ------------------------------------------------------------->	
		</div>

		<div class="text-danger" style="width:955px;height:70px;">
			<div style="float:left;">
				<strong>·방명록 (<%=totalCnt2 %>)</strong>
			</div>
		</div>
		
		<!-- 방명록 출력 영역 -------------------------------------------------------------->
			<c:choose> 
				<c:when test="${list2.size()>0}">
					<c:forEach var="gallogVo" items="${list2}">
						<div class="parent" style="width:955px;" >
							<table style="margin-top:20px; width:955px">
							<tr>
								<td style="word-break:break-all;word-wrap:break-word;"class="col-xs-3 col-sm-3 col-md-3 col-lg-3"><c:out value="${gallogVo.gId}"></c:out></td>
								<td style="width:955px;word-break:break-all;word-wrap:break-word;" class="col-xs-7 col-sm-7 col-md-7 col-lg-7"><pre style="border:0; overflow: auto; white-space: pre-wrap; background-color:white;"><c:out value="${gallogVo.gCont}"></c:out></pre></td>
								<td align="center" class="col-xs-2 col-sm-2 col-md-2 col-lg-2"><c:out value="${gallogVo.regDt}"></c:out></td>
							</tr>
							</table>
						<br/><br/><br/>
						</div>
							<div class="mama">
							</div>
						<hr class="hr">
					</c:forEach>
				</c:when>
				<c:otherwise>
					등록된 방명록이 없습니다.
				</c:otherwise>
			</c:choose>
		
		
		<!--// 방명록 출력 영역 -------------------------------------------------------------->

</div>	
		
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
     
	    
    </script>

</body>
</html>