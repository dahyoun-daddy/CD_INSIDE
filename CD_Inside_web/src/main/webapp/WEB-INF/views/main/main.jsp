<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String context = request.getContextPath();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<style type="text/css">

.boardTitle { 
	font-size: 25px;
	color: blue;
	margin-bottom: 30px;
	border-bottom: black;
} 

.boardTitle:hover {
	text-decoration: underline;
}

.left-box {
	margin-right:20px;
   float: left;
   width: 45%;
}

.right-box {
   float: left;
   width: 45%;
   margin-right : 20px;
   margin-top: 50px;
}
 
.mainall {
	margin-top: 50px;
}

a:hover{
	text-decoration:none;
}

a {
	color: black;
}

.boardListText :hover {
	text-decoration: none;
}

.boardTitleMargin {
	margin-top: 20px;
}

.boardList {
	margin-top: 5px;
}

.boardList:hover {
	background-color: rgb(250,250,250);
}

.boardText {
	font-size: 15px; 

}

.commentNum {
	color: red;
	margin-left: 15px;
}

.boardList { 
	border-bottom: dotted 2px rgb(240,240,240);
}

.boardTitleDiv {
	border-bottom: solid 2px rgb(240,240,240); 
}

.boartHit {
	float: right;
	margin-right: 30px;
}

.HitImg {
	float: right;
	margin-right: 5px;
}

.bCate {
	margin-left: 5px;
}

</style>
</head>
<body>
		<div class="container">
	<div class="mainall">
		<div class="left-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">인기글 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div> 
				<c:forEach var="boardVo" items="${hitList}">
				<a href='<%=context%>/board/get.do?bNum=<c:out value="${boardVo.bNum}"></c:out>'>
					<div class="boardList">
						<span class="bCate"> [<c:out value="${boardVo.bCate}"></c:out>]</span>
						<span class="boardText"><c:out value="${boardVo.bTitle}"></c:out></span>
						<span class="commentNum"><c:out value="${boardVo.commentNo}"></c:out></span>
						<span class="boartHit"><c:out value="${boardVo.bHit}"></c:out></span>
						<img class="HitImg" src="/cd/resources/img/like.jpg" width="20px" height="20px"/>
					</div>
				</a>
				</c:forEach>
		</div>
		 
		<div class="left-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">전체글 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<c:forEach var="boardVo" items="${totalList}">
				<a href='<%=context%>/board/get.do?bNum=<c:out value="${boardVo.bNum}"></c:out>'>
					<div class="boardList">
						<span class="bCate"> [<c:out value="${boardVo.bCate}"></c:out>]</span>
						<span class="boardText"><c:out value="${boardVo.bTitle}"></c:out></span>
						<span class="commentNum"><c:out value="${boardVo.commentNo}"></c:out></span>
						<span class="boartHit"><c:out value="${boardVo.bHit}"></c:out></span>
						<img class="HitImg" src="/cd/resources/img/like.jpg" width="20px" height="20px"/>
					</div>
				</a>
				</c:forEach>
		</div>

		<div class="right-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">쌍용 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<c:forEach var="boardVo" items="${sistList}">
				<a href='<%=context%>/board/get.do?bNum=<c:out value="${boardVo.bNum}"></c:out>'>
					<div class="boardList">
						<span class="bCate"> [<c:out value="${boardVo.bCate}"></c:out>]</span>
						<span class="boardText"><c:out value="${boardVo.bTitle}"></c:out></span>
						<span class="commentNum"><c:out value="${boardVo.commentNo}"></c:out></span>
						<span class="boartHit"><c:out value="${boardVo.bHit}"></c:out></span>
						<img class="HitImg" src="/cd/resources/img/like.jpg" width="20px" height="20px"/>
					</div>
				</a>
				</c:forEach>
		</div>

		<div class="right-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">링크 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<c:forEach var="boardVo" items="${linkList}">
				<a href='<%=context%>/board/get.do?bNum=<c:out value="${boardVo.bNum}"></c:out>'>
					<div class="boardList">
						<span class="bCate"> [<c:out value="${boardVo.bCate}"></c:out>]</span>
						<span class="boardText"><c:out value="${boardVo.bTitle}"></c:out></span>
						<span class="commentNum"><c:out value="${boardVo.commentNo}"></c:out></span>
						<span class="boartHit"><c:out value="${boardVo.bHit}"></c:out></span>
						<img class="HitImg" src="/cd/resources/img/like.jpg" width="20px" height="20px"/>
					</div>
				</a>
				</c:forEach>
		</div>
		
	</div>
	 
	</div>
</body>
</html>