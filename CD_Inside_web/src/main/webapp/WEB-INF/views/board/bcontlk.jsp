<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 뷰단에서 뿌려주는거 포 이치해서 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sist.cd.domain.BoardVO"%>
<%	String userId = (String) session.getAttribute("sessionId");
	String context = request.getContextPath();
	String sessionYn = (String) session.getAttribute("sessionYn");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<%
// 	BoardVO vo = (BoardVO) request.getAttribute("list");

%>

<!-- 스타일 분리 -->
<link href="/cd/resources/css/scrollcomment.css" rel="stylesheet" type="text/css">


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
	var userId = '<%=userId%>';
	if(userId != 'null'){
		var parent = $(this).parents(".container");
		var commTextNum = $(parent).find(".commTextNum").val();
		var params = {
				commTextNum : commTextNum
		};
		commentAjax(params,"do_hitComment.do");
	}else{
		alert('비회원은 추천할수 없습니다.');
		return false;
	}
});

//삭제
$(document).on('click','#coomentDelete', function() {
	
	if(false==confirm("삭제를 하시겠습니까?"))return;
	
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

	var next = parent.next();
	var nextClass = next.attr('class');
		
	if(nextClass=='replyDiv'){
		$(next).remove();
	}else if (nextClass=='addReplyDiv'){
		$(next).remove();
	}
	
	$(parent).remove();
});
  
//댓글달기
$(document).on('click','#commentadd', function() {
	var cont = $("#commentcont").val();
	var n = cont.length;
	
	var regexp = /[A-Za-z0-9]{140}/g;
	
	if(cont.length == 0){
		alert('내용을 입력해주세요.');
		return false;
	}
	
	if(cont.match(regexp)){
		alert('연속된영어및숫자140개는 입력하실수없습니다.')
		return false;
	}
	
	if(false==confirm("댓글을 다시겠습니까?"))return;
	
	$.ajax({
		 type : "POST", 
		 url : "addComment.do",    
       dataType:"json",// JSON
       data:{
           "userId": '<%=userId%>',
           "commCont": cont,
           "bNum": $(".hiddenbNum").text(),
           "modId": '1'
       },
		success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
			var str ='';
			var divIn = '';
			divIn += 	'<div class="media-heading">'
				+				'<div id="container">'
				+					'<div>'
				+						'<label class="commId">' + data.userId + '</label>&nbsp;'
				+						'<label class="commTime">' + data.regDt + '</label>'
				+					'</div>'
				+					'<input type="hidden" class="commTextNum" value="' + data.commTextNum + '"/>'
				+					'<input type="hidden" class="commGroupNo" value="' + data.commGroupNo + '"/>'
				+					'<input type="hidden" class="commDepth" value="' + data.commDepth + '"/>'
				+				'</div>'
				+			'</div>'
				+			'<div class="p">'
				+				'<p>'+data.commCont+'</p>'
				+			'</div>'
				+				'<img class="cursor" id="like" src="/cd/resources/img/like.jpg"'
				+				'onmouseover="bigImg(this)" onmouseout="normalImg(this)"'
				+					'width="30px" height="30px"/>&nbsp;'
				+				'<label class="hitNum">'+'0'+'</label>'
				+				'<a class="cursor" data-toggle="collapse" id="commentReply" aria-expanded="false" aria-controls="commentReplyadd' + data.commTextNum + '" href="#commentReplyadd' + data.commTextNum + '">답글</a>'
				+				'&nbsp;'
				+				'<a class="cursor" id="commentUpdate" >수정</a>'
				+				'&nbsp;'
				+				'<a class="cursor" id="coomentDelete" >삭제</a>'
				+			'<div class="comment-meta">'
				+				'<div class="bocollapse collapse" id="commentReplyadd' + data.commTextNum + '">'
				+					'<div class="form-group">'
				+						'<label for="comment">답글</label>'
				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
				+					'</div>'
				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
				+				'</div>'
				+			'</div>'
				
		  		str +=		'<div class="container">' 
					+		'<div class="media">' 
					+ 			divIn
					+		'</div>'
					+		'</div>';
			$('.commentAddDiv').before(str); 
			$('.commentAddDiv').remove();
			$('.absoluteDiv').after('<div class="commentAddDiv"></div>');
		},
       complete: function(data){//무조건 수행
       	
       },
       error: function(xhr,status,error){
    	   
       }
	});
	

	
});

//답글달기
$(document).on('click','#replyadd', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var cont   = $(parent).find("#commentReplyTextarea").val(); 
	
	var n = cont.length;
	
	if(cont.length == 0){
		alert('내용을 입력해주세요.');
		return false;
	}
	
	var regexp = /[A-Za-z0-9]{140}/g;
	
	if(cont.match(regexp)){
		alert('연속된영어및숫자140개는 입력하실수없습니다.')
		return false;
	}
	
	if(false==confirm("답글을 다시겠습니까?"))return;
	
	var commGroupNo = $(parent).find(".commGroupNo").val();
	var next = parent.next();
	var nextClass = next.attr('class');
	
	
	
	$.ajax({
		 type : "POST", 
		 url : "addreplyComment.do",    
      dataType:"json",// JSON
      data:{
          "userId": '<%=userId%>',
          "commCont": cont,
          "bNum": $(".hiddenbNum").text(),
          "commGroupNo" : commGroupNo,
          "modId": '1'
      },
		success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
			var str ='';
			var divIn = '';
			divIn += 	'<div class="media-heading">'
				+				'<div id="container">'
				+					'<div>'
				+						'<label class="commId">' + data.userId + '</label>&nbsp;'
				+						'<label class="commTime">' + data.regDt + '</label>'
				+					'</div>'
				+					'<input type="hidden" class="commTextNum" value="' + data.commTextNum + '"/>'
				+					'<input type="hidden" class="commGroupNo" value="' + data.commGroupNo + '"/>'
				+					'<input type="hidden" class="commDepth" value="' + data.commDepth + '"/>'
				+				'</div>'
				+			'</div>'
				+			'<div class="p">'
				+				'<p>'+data.commCont+'</p>'
				+			'</div>'
				+				'<img class="cursor" id="like" src="/cd/resources/img/like.jpg"'
				+				'onmouseover="bigImg(this)" onmouseout="normalImg(this)"'
				+					'width="30px" height="30px"/>&nbsp;'
				+				'<label class="hitNum">'+'0'+'</label>'
				+				'<a class="cursor" data-toggle="collapse" id="commentReply" aria-expanded="false" aria-controls="commentReplyadd' + data.commTextNum + '" href="#commentReplyadd' + data.commTextNum + '">답글</a>'
				+				'&nbsp;'
				+				'<a class="cursor" id="commentUpdate" >수정</a>'
				+				'&nbsp;'
				+				'<a class="cursor" id="coomentDelete" >삭제</a>'
				+			'<div class="comment-meta">'
				+				'<div class="bocollapse collapse" id="commentReplyadd' + data.commTextNum + '">'
				+					'<div class="form-group">'
				+						'<label for="comment">답글</label>'
				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
				+					'</div>'
				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
				+				'</div>'
				+			'</div>'
				
		  		str +=		'<divc class="addReplyDiv">'
		  			+		'<div class="container">' 
					+		'<div class="media_reply">' 
					+ 			divIn
					+		'</div>'
					+		'</div>'
					+		'</div>';
					
			if(nextClass=='replyDiv'){
				$(next).prepend(str);
			}else{
				$(parent).after(str); 
			}
		},
      complete: function(data){//무조건 수행
      	
      },
      error: function(xhr,status,error){
   	   
      }
	});
	
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
            "userId": '<%=userId%>',
            "commCont": commCont,
            "bNum": $(".hiddenbNum").text(),
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

//대댓글 감추기
$(document).on('click','.cursor_reply_hide', function() {
	var text = $(this).attr('replyNum');
	var parent = $(this).parents(".container");
	var replyDiv = parent.next();
	replyDiv.hide();
	$('.onlyHidden').show();
	$(this).attr("class","cursor_reply");
	$(this).text(text);
});

//대댓글 출력
$(document).on('click','.cursor_reply', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var commGroupNo = $(parent).find(".commGroupNo").val();
	
	var page_num = 1;
	var page_size = 10;
	
	var target = $(this).text();
	var num = target.replace(/[^0-9]/g,"");
	
	var body = $(this);
	
	$('.fakeLoading2').remove();
	$(this).after('<div class="fakeLoading2">&nbsp;</div>')
<%-- 	$(".fakeLoading2").oLoader({
		  backgroundColor: '255,255,255',
		  fadeInTime: 500,
		  fadeLevel: 0.8,
		  image: '<%=context%>/resources/img/ajax-loader.gif',
		  imagePadding: 5,
		  imageBgColor: 'white',
		  hideAfter: 1000
	}); --%>
	 
/* 	setTimeout(	function replyRetrieve(){ */
		
	    $.ajax({
	        type:"POST",
	        url:"comm/scroll_reply_retrieve.do",
	        dataType:"json",// JSON
	        data:{
	            "page_num": page_num,
	            "bNum": $(".hiddenbNum").text(),
	            "page_size": num,
	            "commGroupNo":commGroupNo,
	            "userId":'<%=userId%>'
	        },
	        success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
				  	 var str = '<div class=replyDiv>';
		            var depth = '';
		            $.each(data.list, function(key, value){
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
			    				if('<%=userId%>' != 'null') {
							    	divIn  +=				'<a class="cursor" data-toggle="collapse" id="commentReply" aria-controls="commentReplyadd' + value.commTextNum + '" href="#commentReplyadd' + value.commTextNum + '">답글</a>'
							    			+				'&nbsp;' 
		    				}
	 
			    				if(<%=sessionYn%> == '1') {
				    				if(value.userId == '<%=userId%>' ) {
				    					   divIn +=				'<a class="cursor" id="commentUpdate" >수정</a>'
				    				       +				'&nbsp;'
				    				       +				'<a class="cursor" id="coomentDelete" >삭제</a>'
			    					}else{
			    					   divIn +=				'<a class="cursor" id="coomentDelete" >삭제</a>'
			    					}
		    					}else {
				    				if(value.userId == '<%=userId%>' ) {
				    					   divIn +=				'<a class="cursor" id="commentUpdate" >수정</a>'
				    				       +				'&nbsp;'
				    				       +				'<a class="cursor" id="coomentDelete" >삭제</a>'
			    					}
		    					}
		    							if('<%=userId%>' != 'null') {
			    	 divIn +=	 		'<div class="comment-meta">'
							+				'<div class="bocollapse collapse" id="commentReplyadd' + value.commTextNum + '">'
		    				+					'<div class="form-group">'
		    				+						'<label for="comment">답글</label>'
		    				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
		    				+					'</div>'
		    				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
		    				+				'</div>'
		    				+			'</div>'
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
			    				+	   '</div>';
		            	}
		            });
		          str += '</div>';
		          	
			    	var next = parent.next();
			    	var nextClass = next.attr('class');
			    		
			    	if(nextClass=='container'){
			    		$(next).remove();
			    	}
					
		          parent.after(str);
					page_num++;
					body.attr("class","cursor_reply_hide");
					var text = body.text();
					body.attr("replyNum",text);
					body.text("답글 숨기기△");
					$('.onlyHidden').hide();
	        },
	        complete: function(data){//무조건 수행
	         	
	        },
	        error: function(xhr,status,error){
	         
	        }
	   }); //--ajax
	   
/* 		}, 1000); // --setTimeout */
	

	
});



var page_num = 1;
var page_size = 10;


function pagingList(){
	var body = $("#enters");
	
    $.ajax({
        type:"POST",
        url:"comm/paging_retrieve.do",
        dataType:"json",// JSON
        data:{
            "page_num": page_num,
            "bNum": $(".hiddenbNum").text(),
            "page_size": page_size,
            "userId":'<%=userId%>'
        },
        success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
			  	 var str = '';
	            var depth = '';
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
		    				if('<%=userId%>' != 'null') {
						    	divIn  +=				'<a class="cursor" data-toggle="collapse" id="commentReply" aria-controls="commentReplyadd' + value.commTextNum + '" href="#commentReplyadd' + value.commTextNum + '">답글</a>'
						    			+				'&nbsp;' 
	    				}
 
		    				if(<%=sessionYn%> == '1') {
			    				if(value.userId == '<%=userId%>' ) {
			    					   divIn +=				'<a class="cursor" id="commentUpdate" >수정</a>'
			    				       +				'&nbsp;'
			    				       +				'<a class="cursor" id="coomentDelete" >삭제</a>'
		    					}else{
		    					   divIn +=				'<a class="cursor" id="coomentDelete" >삭제</a>'
		    					}
	    					}else {
			    				if(value.userId == '<%=userId%>' ) {
			    					   divIn +=				'<a class="cursor" id="commentUpdate" >수정</a>'
			    				       +				'&nbsp;'
			    				       +				'<a class="cursor" id="coomentDelete" >삭제</a>'
		    					}
	    					}
	    							if('<%=userId%>' != 'null') {
		    	 divIn +=	 		'<div class="comment-meta">'
						+				'<div class="bocollapse collapse" id="commentReplyadd' + value.commTextNum + '">'
	    				+					'<div class="form-group">'
	    				+						'<label for="comment">답글</label>'
	    				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
	    				+					'</div>'
	    				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
	    				+				'</div>'
	    				+			'</div>'
	    						}
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
	    				+		'</div>'
	    				+ 		'<div class="addReplayDiv"></div>';
	            	}else {
		          		str +=		'<div class="container">' 
		    				+		'<div class="media_reply">' 
							+ 			divIn
		    				+		'</div>'
		    				+		'</div>';
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
	if($(window).scrollTop() == $(document).height() - $(window).height()){
<%--     	$(".fakeLoading").oLoader({
  		  backgroundColor: '255,255,255',
  		  fadeInTime: 500,
  		  fadeLevel: 0.8,
  		  image: '<%=context%>/resources/img/ajax-loader.gif',
  		  imagePadding: 5,
  		  imageBgColor: 'white',
  		  hideAfter: 1000
  		}); --%>
  		
    	/* setTimeout("pagingList()", 1000); */
 		pagingList();
    	
		};
	});
	
</script>
 
<body>
<%=sessionYn %>
	<div style="width:900px;" class="container">
		<div style="padding-top : 40px;">
		
		

			<c:choose>
				<c:when test="${list.userId eq sessionId || sessionYn eq 1 }">
  <input style="float:right; " class="btn btn-default" type="button" id="update" value="수정" />
		  
		  <button style="float:right;" type="submit" class="btn btn-default" id="delete" >삭제</button>
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>
		 
		
		
<%-- 					<% } %> --%>
		
	
  
   <script type="text/javascript">
    
	    function search_page(url,page_num){
		   	 alert(url+":search_page:"+page_num);
		   	 var frm = document.frm;
		   	 frm.page_num.value = page_num;
        	 console.log(frm.page_num.value);
		   	 frm.action = url;
		   	 frm.submit();
	    }
	    
       function doUpdate(gSeq){ //수정
        	var frm = document.frm; 
        	frm.gSeq.value = gSeq;
        	frm.action = "getlk.do";
        	frm.submit();
        }
	    
       function delgo(gSeq){ //수정
       	var frm = document.frm;
       	frm.gSeq.value = gSeq;
       	frm.action = "blk.do";
       	frm.submit();
       }
       
	    $(document).ready(function(){
	    	//alert("ready");
	    	
	    	$("#delete").on("click",function(){
	    		alert("삭제하시겟습니까여?");
	    		
	    		 if(false==confirm("삭제 ㅇㅋ?"))return;
	    		 
	    		var bNum = $(".hiddenbNum").text();
				var bTitle = $("#bTitlebofrm").text();
				var bCont =$('.bContbofrm').text();
	    	
			     $.ajax({
			         type:"POST",
			         url:"delete.do",
			         dataType:"json",// JSON
			         data:{
			         	"bNum": bNum
			         },
			         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
			        	 delgo();
			         },
			         complete: function(data){//무조건 수행
			          
			         },
			         error: function(xhr,status,error){
			          
			         }
			        });//--ajax		
				    
	    		 var frm = document.boform;
		        	frm.bNum.value = bNum;
		        	frm.bTitle.value = bTitle;
		        	frm.bCont.value = bCont;
		        	frm.action = "blk.do";  
		        	frm.submit(); 
	    	});
		    
			$("#update").on("click",function(){
				alert('수정할께여');
				
				var bNum = $(".hiddenbNum").text();
				var bTitle = $("#bTitlebofrm").text();
				var bCont =$('.bContbofrm').text();
				
				var frm = document.boform;
			        	frm.bNum.value = bNum;
			        	frm.bTitle.value = bTitle;
			        	frm.bCont.value = bCont;
			        	frm.action = "writelk.do"; 
			        	frm.submit(); 

			});//--#listTable>tbody
			
			//추천
			$("#BoardHit").on("click",function(){
				
				if('<%=userId %>' == 'null'){
					alert('비회원은 추천하실수 없습니다.');
					return false;
				}else {
					var bNum = $(".hiddenbNum").text();
				     $.ajax({
				         type:"POST",
				         url:"board_hitComment.do",
				         dataType:"json",// JSON
				         data:{
				         	"bNum": bNum,
				            "userId": '<%=userId %>'
				         },
				         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
				        		console.log('추천');
					         	if(data.flag=="1"){
					         		alert(data.message);
					 				var frm = document.boform;
						        	frm.bNum.value = bNum;
						        	frm.bTitle.value = bTitle;
						        	frm.bCont.value = bCont;
						        	frm.action = "get.do"; 
						        	frm.submit();  
					         	}else{
					         		alert(data.message);
					         	}

				         },
				         complete: function(data){//무조건 수행
				          
				         },
				         error: function(xhr,status,error){
				          
				         }
				    });//--ajax	
				}
	
				


			});//--#listTable>tbody
	    	
	    });
 
	    </script>
   
   
		    <form  name="boform" id="boform" action="/board.do" method="get" class="form-inline">
				<input type="hidden" name="bNum" id="bNum">
				<input type="hidden" name="bTitle" id="bTitle">
				<input type="hidden" name="bCont" id="bCont">
			</form>
		      
		     <div style=" color:black; font-size:20px;"  class="row" >
		     <div id="bTitlebofrm" style="float:left;"> <b>제목 :<c:out value="${list.bTitle}"></c:out> </b></div>
		     </div>
		     </div> 
		     
		    <div style="color:white; background-color:#BF00FF; border-top:3px solid black; padding:7px; " class="row" >
  				<div style="float:left;"><b>작성자:<c:out value="${list.userId}"></c:out></b></div>  
              <div style="float:left;"><b>　<c:out value="${list.regDt}">　</c:out>　조회수: <c:out value="${list.bCount}"></c:out>　</b></div>
		       <div style="float:right;"><b>+<c:out value="${list.bHit}"></c:out></b></div>
		       
		       <div class="hiddenbNum"><c:out value="${list.bNum}"></c:out></div>
		       
           </div>  
           
              <div class="row" >
              <!-- float 속성에 따른 div의 겹침 현상 -->
                <div style=”clear:both;”></div>
	             <div class="bContbofrm" style="border-bottom:1px solid;"><c:out value="${list.bCont}"></c:out></div> 
	     		  </div>  
		 <div style=”clear:both;”></div>

		
    
		<!-- <hr style="border: solid 2px gray;"> -->
		 
		<div class="row">
		  <div class="text-right col-xs-12 col-sm-12 col-md-12 col-lg-12">
		  <button type="button" class="btn btn-default" onClick="history.go(-1)">목록</button>
		     <button id="BoardHit" type="submit" class="btn btn-default">추천+1</button>
		  </div>
		</div>
</div>

<!--  ----------------------------------------------------------------------------------------- -->
<form  name="cform" id="cform" action="/bcont.do" method="get" class="form-inline">
				<input type="hidden" name="bNum" id="bNum">
				</form>

<!--  ----------------------------------------------------------------------------------------- -->




<!------------------------------------댓글-------------------------------------------------------------------------------------------------->
<body>


	<%if(userId == null){ %>
	<div class="container">
		<div class="form-group">
			<label for="comment">댓글</label>
			<textarea id="commentcont" class="form-control" rows="3"
				placeholder="로그인을 해주세요" readonly="readonly" ></textarea>
		</div>
	</div>
	<%}else {%>
	<div class="container">
		<div class="form-group">
			<label for="comment">댓글</label>
			<textarea id="commentcont" class="form-control" rows="3"
				placeholder="댓글을 입력하세요." ></textarea>
		</div>
		<button id="commentadd" class="btn btn-default">댓글달기</button>
	</div>
<%} %>


	<div class="fakeLoading">&nbsp;</div>
	
	<div class="absoluteDiv"></div>
	
	<div class="commentAddDiv"></div>
	
	<div id="enters">
	</div>
<!-------------------------------------------------------------------댓글 끝---------------------------------------------------------- -->

</body>
</html>