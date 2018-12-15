<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String context = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글</title>
<style type="text/css">
.container {
	margin-top: 30px;
}
 
.media {
	margin-bottom: 5px;
	padding-left: 30px;
}
 
.media_reply {
	margin-bottom: 5px;
	padding-left: 100px;
}

.hitNum {
	width: 18px;
	height: 18px;
	color: gray;
}

.cursor {
	cursor: pointer;
}

#commentReply {
	padding-left: 8px;
}

#commentUpdateComplete {
	padding-left: 8px;
}

.commTime {
	color: gray;
}

.wdp_90 {
	width: 90%
}

.pad_5 {
	padding: 5px;
    color: black;
	loat: left;
	padding: 8px 16px;
	text-decoration: none;
 	border: 1px solid #ddd
}

.pad_5strong {
	background-color: rgb(217,229,255);
}

#PAGE_NAVI {
	padding-left: 200px;
}

.form-group {
	padding-top: 20px;
}

.cursor {
	color: gray;
}

.cursor:hover {
	text-decoration:none;
}

.cursor_reply {
	color: black;
	cursor: pointer;
}

.cursor_reply:hover {
	text-decoration:none;
}

.replyDiv {
	margin-top: 10px;
}

</style>
<script src="<%=context%>/resources/js/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=context%>/resources/js/jquery.oLoader.min.js"></script>

<script type="text/javascript">

//수정버튼 눌렸을때
$(document).on('click','#commentUpdate', function() {
	var parent = $(this).parents(".container");
	var commentmeta = $(this).parents(".comment-meta");
	var cont = $(parent).find("p").text();
	
	console.log($(parent).find('.collapse').val());
	
	$(parent).find('.collapse.in').collapse('hide');
	
	$(parent).find("p").remove();
	$(parent).find(".p").append('<textarea id="commentTextarea" class="form-control" rows="3" onfocus="this.value = this.value;">'+cont+'</textarea>');
	
	$(parent).find("#commentTextarea").focus();
	
	var val = $(parent).find("#commentTextarea").val();
	
	$(parent).find("#commentTextarea").val("").val(val);

	$(parent).find("#coomentDelete").before(' <a class="cursor" id="commentUpdateComplete" >수정완료</a>');
	$(parent).find("#coomentDelete").before(' <a class="cursor" id="commentUpdateCancel" >수정취소</a>');
	$(parent).find("#commentUpdate").remove();
	$(parent).find("#commentReply").remove();
	$(parent).find("#coomentDelete").remove();
});

//수정완료
$(document).on('click','#commentUpdateComplete', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var commCont = $(parent).find("#commentTextarea").val();
	var params = {
			commTextNum : commTextNum,
			commCont		  : commCont
		};
	commentAjax(params,"	updateComment.do");
	
	
	
	$(parent).find("#commentUpdateComplete").remove();
	$(parent).find("#commentUpdateCancel").remove();
	$(parent).find("#commentTextarea").remove();
	$(parent).find(".hitNum").after(' <a class="cursor" id="coomentDelete" >삭제</a> ');
	$(parent).find(".hitNum").after(' <a class="cursor" id="commentUpdate" >수정</a> ');
	$(parent).find(".hitNum").after('<a class="cursor" data-toggle="collapse" id="commentReply" href="#commentReplyadd' + commTextNum + '">답글</a>');
	
	$(parent).find(".p").after('<p>'+commCont+'</p>');
	
	
});

//수정취소
$(document).on('click','#commentUpdateCancel', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var cont = $(parent).find("#commentTextarea").text();
	console.log(commTextNum);
	console.log(cont);
	$(parent).find("#commentUpdateComplete").remove();
	$(parent).find("#commentUpdateCancel").remove();
	$(parent).find("#commentTextarea").remove();
	$(parent).find(".p").append('<p>'+cont+'</p>');
	$(parent).find(".hitNum").after(' <a class="cursor" id="coomentDelete" >삭제</a> ');
	$(parent).find(".hitNum").after(' <a class="cursor" id="commentUpdate" >수정</a> ');
	$(parent).find(".hitNum").after('<a class="cursor" data-toggle="collapse" id="commentReply" href="#commentReplyadd' + commTextNum + '">답글</a>');
});

//추천
$(document).on('click','#like', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var params = {
			parent : parent,
			commTextNum : commTextNum
	};
	commentAjax(params,"do_hitComment.do");
});

//삭제
$(document).on('click','#coomentDelete', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var commGroupNo = $(parent).find(".commGroupNo").val();
	var commDepth = $(parent).find(".commDepth").val();
	var params = {
		commTextNum : commTextNum,
		commDepth : commDepth,
		commGroupNo : commGroupNo
	};
	commentAjax(params,"deleteComment.do");
	$(parent).remove();
});
  
//댓글달기
$(document).on('click','#commentadd', function() {
	var cont = $("#commentcont").val();
	var n = cont.length;
	
	alert(n);
	var regexp = /[A-Za-z0-9]{140}/g;
	
	if(cont.match(regexp)){
		alert('연속된영어및숫자140개는 입력하실수없습니다.')
		return false;
	}
	
	var params = {
			commCont : cont
	};
	commentAjax(params,"addComment.do");
});

//답글달기
$(document).on('click','#replyadd', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var cont   = $(parent).find("#commentReplyTextarea").val(); 
	var commGroupNo = $(parent).find(".commGroupNo").val();
	var params = {
			commCont    : cont,
			commGroupNo : commGroupNo
	};
	commentAjax(params,"addreplyComment.do");
});

function bigImg(x) {
    x.style.height = "40px";
    x.style.width = "40px";
}

function normalImg(x) {
    x.style.height = "30px";
    x.style.width = "30px";
}

$(document).on('shown.bs.collapse', '.bocollapse', function (e) {
	var parent = $(this).parents(".container");
	$(parent).find("#commentReplyTextarea").focus();
});

//Ajax 분리
function commentAjax(params,url){
	
	var parent = params.parent
	var userId = params.userId
	var commCont = params.commCont
	var bNum = params.bNum
	var modId = params.modId
	var commTextNum = params.commTextNum
	var commGroupNo = params.commGroupNo
	var commDepth = params.commDepth
	$.ajax({
		 type : "POST", 
		 url : url,    
        dataType:"json",// JSON
        data:{
            "userId": 'test',
            "commCont": commCont,
            "bNum": '1',
            "modId": '1',
            "commTextNum":commTextNum,
            "commGroupNo":commGroupNo,
            "commDepth":commDepth
        },
		success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
        	if(this.url == "do_hitComment.do"){
        		console.log('추천');
	         	if(data.flag=="1"){
	         		alert(data.message);
	         	 	var hitNum = $(parent).find(".hitNum").text();
	         	 	hitNum ++; 
	         	 	$(parent).find(".hitNum").text(hitNum);
	         	}else{
	         		alert(data.message);//이미 추천한 댓글입니다.
	            }	
        	}
		
        	if(this.url == "addComment.do"){
        		
        	}
        	
		},
        complete: function(data){//무조건 수행
        	
        },
        error: function(xhr,status,error){
        }
	});
}



var page_num = 1;
var page_size = 20;

function pagingList(){
	var body = $("#enters");
	
    $.ajax({
        type:"POST",
        url:"comm/paging_retrieve.do",
        dataType:"json",// JSON
        data:{
            "page_num": page_num,
            "bNum": '1',
            "page_size": page_size,
            "userId":'강보승'
        },
        success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
			  	 var str = '';
	            var depth = "";
	            $.each(data, function(key, value){
	            	var divIn = "";
	            		divIn += 	'<div class="media-heading">'
		    				+				'<div id="container">'
		    				+					'<div>'
		    				+						'<label class="commId">' + value.userId + '</label>&nbsp;'
		    				+						'<label class="commTime">' + value.regDt + '</label>'
		    				+					'</div>'
		    				+					'<input type="hidden" class="commTextNum" value="' + value.commTextNum + '"/>'
		    				+					'<input type="hidden" class="commGroupNo" value="' + value.commGroupNo + '"/>'
		    				+					'<input type="hidden" class="commDepth" value="' + value.commDepth + '"/>'
		    				+				'</div>'
		    				+			'</div>'
		    				+			'<div class="p">'
		    				+				'<p>'+value.commCont+'</p>'
		    				+			'</div>'
		    				+				'<img class="cursor" id="like" src="/cd/resources/img/like.jpg"'
		    				+				'onmouseover="bigImg(this)" onmouseout="normalImg(this)"'
		    				+					'width="30px" height="30px"/>&nbsp;'
		    				+				'<label class="hitNum">'+value.commHit+'</label>'
		    				+				'<a class="cursor" data-toggle="collapse" id="commentReply" aria-expanded="false" aria-controls="commentReplyadd' + value.commTextNum + '" href="#commentReplyadd' + value.commTextNum + '">답글</a>'
		    				+				'&nbsp;'
		    				+				'<a class="cursor" id="commentUpdate" >수정</a>'
		    				+				'&nbsp;'
		    				+				'<a class="cursor" id="coomentDelete" >삭제</a>'
		    				+			'<div class="comment-meta">'
		    				+				'<div class="bocollapse collapse" id="commentReplyadd' + value.commTextNum + '">'
		    				+					'<div class="form-group">'
		    				+						'<label for="comment">답글</label>'
		    				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
		    				+					'</div>'
		    				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
		    				+				'</div>'
		    				+			'</div>'
		    				if(value.commentNo > 0){
		    					divIn +=			'<div class="replyDiv">'
		    					divIn +=			'<a class="cursor_reply">답글 '+ value.commentNo+'개 보기 ▽</a>'
		    					divIn +=			'</div>'
		    				}
	            	if(value.commDepth == 0) {
	          		str +=		'<div class="container">' 
	    				+		'<div class="media">' 
						+			divIn
	    				+		'</div>'
	    				+		'</div>';
	            	}else {
		          		str +=		'<div class="container">' 
		    				+		'<div class="media_reply">' 
							+ 			divIn
		    				+		'</div>'
		    				+	'</div>';
	            	}
	            });
	        	$('.fakeLoading').remove();
	            str += '<div class="fakeLoading">&nbsp;</div>';
				body.append(str);
				page_num++;
        },
        complete: function(data){//무조건 수행
         	
        },
        error: function(xhr,status,error){
         
        }
   }); //--ajax
}

//새로고침하면 맨 위로 포커스를 맞춰준다.
window.onbeforeunload = function () {
	  window.scrollTo(0, 0);
}

$(window).scroll(function(){ 

    if  ($(window).scrollTop() >= $(document).height() - $(window).height()){
    	 
    	$(".fakeLoading").oLoader({
  		  backgroundColor: '255,255,255',
  		  fadeInTime: 500,
  		  fadeLevel: 0.8,
  		  image: '<%=context%>/resources/img/ajax-loader.gif',
  		  imagePadding: 5,
  		  imageBgColor: 'white',
  		  hideAfter: 1000
  		});
  		
    	setTimeout("pagingList()", 1000);
 		
		};
	});
	




$(document).ready(function(){
});

</script>
</head>
<body>

	<img src="https://t1.daumcdn.net/cfile/tistory/9940D03D5A584CCD0C"><br />
    <img src="https://t1.daumcdn.net/cfile/tistory/99F7323D5A584CCE1C"><br />
    

    
   	<div class="container">
		<div class="form-group">
			<label for="comment">댓글</label>
			<textarea id="commentcont" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>
		</div>
		<button id="commentadd" class="btn btn-default btn-sm">댓글달기</button>
	</div>
	
	<div class="fakeLoading">&nbsp;</div>
	
	
	<div id="enters">
	</div>
	

</body>
</html>