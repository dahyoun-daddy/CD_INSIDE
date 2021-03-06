<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cPath = request.getContextPath();//context path
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <title>One Page Bootstrap Template</title>

  <!-- Bootstrap -->
  <link href="<%=cPath%>/resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=cPath%>/resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=cPath%>/resources/css/font-awesome.min.css" rel="stylesheet">
  <link href="<%=cPath%>/resources/css/animate.min.css" rel="stylesheet">
  <link href="<%=cPath%>/resources/css/animate.css" rel="stylesheet" />
  <link href="<%=cPath%>/resources/css/prettyPhoto.css" rel="stylesheet">
  <link href="<%=cPath%>/resources/css/style.css" rel="stylesheet">
  <!-- =======================================================
    Theme Name: OnePage
    Theme URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
    Author: BootstrapMade
    Author URL: https://bootstrapmade.com
  ======================================================= -->
</head>

<body>
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div class="row">
        <div class="site-logo">  
          <a href="/cd/main/main.do" class="brand">Class D Inside</a>
        </div>

        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu">
            <i class="fa fa-bars"></i>
          </button>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="menu">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="/cd/board/bsy.do">쌍용 커뮤니티</a></li>
            <li><a href="/cd/board/blk.do">링크 사이트</a></li>
		<c:choose>
			<c:when test="${empty sessionId}">
	            <li><a href="/cd/user/user_join.do">회원가입</a></li>
	            <li><a href="/cd/user/login.do">로그인</a></li>
			</c:when>
			<c:otherwise>
	            <li><a href="/cd/mypage/user_update.do">마이페이지</a></li>
				<li><a id="log_out" style="cursor:pointer" onclick="location.href='<%=cPath%>/user/logout.do'">${sessionName}님 로그아웃</a></li>
			</c:otherwise>
		</c:choose>
          </ul>
        </div>
        <!-- /.Navbar-collapse -->
      </div>
    </div>
  </nav>

	<div id="home">
	    <div class="slider">
	      <div id="about-slider">
	        <div id="carousel-slider" class="carousel slide" data-ride="carousel">
	          <!-- Indicators -->
	          <ol class="carousel-indicators visible-xs">
	            <li data-target="#carousel-slider" data-slide-to="0" class="active"></li>
	            <li data-target="#carousel-slider" data-slide-to="1"></li>
	            <li data-target="#carousel-slider" data-slide-to="2"></li>
	          </ol>
	
	          <div class="carousel-inner">
	            <div class="item active">
	              <img src="<%=cPath%>/resources/images/slide1.jpg" class="img-responsive" alt="">
	            </div>
	            <div class="item">
	              <img src="<%=cPath%>/resources/images/slide2.jpg" class="img-responsive" alt="">
	            </div>
	            <div class="item">
	              <img src="<%=cPath%>/resources/images/slide3.jpg" class="img-responsive" alt="">
	            </div>
	          </div>
	
	          <a class="left carousel-control hidden-xs" href="#carousel-slider" data-slide="prev">
	            <i class="fa fa-angle-left"></i>
	          </a>
	
	          <a class=" right carousel-control hidden-xs" href="#carousel-slider" data-slide="next">
	            <i class="fa fa-angle-right"></i>
	          </a>
	        </div>
	        <!--/#carousel-slider-->
	      </div>
	      <!--/#about-slider-->
	    </div>
	 </div>


  

  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="<%=cPath%>/resources/js/jquery.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->


</body>

</html>
