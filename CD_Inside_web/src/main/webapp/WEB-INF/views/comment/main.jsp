<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

</style>
</head>
<body>

	<div class="mainall">
		<div class="left-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">링크 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<a href="">
					<div class="boardList">
						<span class="boardText">기레기들 전시하는 사이트 어떠냐 ㄷㄷ</span>
						<span class="commentNum">25</span>
					</div>
				</a>
				<a href="">
					<div class="boardList">
						쌍용1
					</div>
				</a>
		</div>
		
		<div class="left-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">링크 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<a href="">
					<div class="boardList">
						<span class="boardText">기레기들 전시하는 사이트 어떠냐 ㄷㄷ</span>
						<span class="commentNum">25</span>
					</div>
				</a>
				<a href="">
					<div class="boardList">
						쌍용1
					</div>
				</a>
		</div>

		<div class="right-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">링크 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<a href="">
					<div class="boardList">
						<span class="boardText">기레기들 전시하는 사이트 어떠냐 ㄷㄷ</span>
						<span class="commentNum">25</span>
					</div>
				</a>
				<a href="">
					<div class="boardList">
						쌍용1
					</div>
				</a>
		</div>

		<div class="right-box">
				<div class="boardTitleDiv">
					<a class="boardTitle" href="">링크 커뮤니티</a>
				</div>
				<div class="boardTitleMargin"></div>
				<a href="">
					<div class="boardList">
						<span class="boardText">기레기들 전시하는 사이트 어떠냐 ㄷㄷ</span>
						<span class="commentNum">25</span>
					</div>
				</a>
				<a href="">
					<div class="boardList">
						쌍용1
					</div>
				</a>
		</div>
		
	</div>
	
</body>
</html>