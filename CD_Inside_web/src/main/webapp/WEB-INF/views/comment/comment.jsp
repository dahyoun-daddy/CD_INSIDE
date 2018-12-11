<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
}

#PAGE_NAVI {
	padding-left: 200px;
}

.form-group {
	padding-top: 20px;
}
</style>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
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
});
  
//Ajax 분리
function commentAjax(params,url){
	
	var userId = params.userId
	var commCont = params.commCont
	var bNum = params.bNum
	var modId = params.modId
	var commTextNum = params.commTextNum
	var commGroupNo = params.commGroupNo
	var commDepth = params.commDepth
	console.log(userId);
	console.log(commCont);
	console.log(bNum);
	console.log(modId);
	console.log(commTextNum);
	console.log(commGroupNo);
	console.log(url);
	$.ajax({
		 type : "POST", 
		 url : url,    
        dataType:"json",// JSON
        data:{
            "userId": '3',
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
	         	}else{
	         		alert(data.message);
	            }	
        	}
        	fn_selectBoardList();

		},
        complete: function(data){//무조건 수행
        	
        },
        error: function(xhr,status,error){
        }
	});
}

//댓글달기
$(document).on('click','#commentadd', function() {
	var cont = $("#commentcont").val();
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

function gfn_isNull(str) {
	if (str == null) return true;
	if (str == "NaN") return true;
	if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}

function ComSubmit(opt_formId) {
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.url = "";
	
	this.setUrl = function setUrl(url){
		this.url = url;
	};
	
	this.addParam = function addParam(key, value){
		$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
	};
	
}
function ComAjax(opt_formId){
	this.url = "";		
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.param = "";
	
	this.setUrl = function setUrl(url){
		this.url = url;
	};
	
	this.setCallback = function setCallback(callBack){
		fv_ajaxCallback = callBack;
	};

	this.addParam = function addParam(key,value){ 
		this.value = value;
		if(value == ''){
			this.value = "1";
		}
	};
	
	this.ajax = function ajax(){
		$.ajax({
			url : this.url,    
			type : "POST",   
			//data : this.param,
            data:{
	            "page_num": this.value,
	            "bNum": '1',
	            "page_size": page_size
	        },
			async : false, 
			success : function(data, status) {
				if(typeof(fv_ajaxCallback) == "function"){
					fv_ajaxCallback(data);
				}
				else {
					eval(fv_ajaxCallback + "(data);");
				}
			}
		});
	};
}

/*
divId : 페이징 태그가 그려질 div
pageIndx : 현재 페이지 위치가 저장될 input 태그 id
recordCount : 페이지당 레코드 수
page_size : 전체 조회 건수 
eventName : 페이징 하단의 숫자 등의 버튼이 클릭되었을 때 호출될 함수 이름
*/
var gfv_pageIndex = null;
var gfv_eventName = null;
var totalIndexCount;
var page_size = 5;
function gfn_renderPaging(params){
	var divId = params.divId; //페이징이 그려질 div id
	gfv_pageIndex = params.pageIndex; //현재 위치가 저장될 input 태그
	var totalCount = params.totalCount; //전체 조회 건수
	var currentIndex = $("#"+params.pageIndex).val(); //현재 위치
	if($("#"+params.pageIndex).length == 0 || gfn_isNull(currentIndex) == true){
		currentIndex = 1;
	}
	
	totalIndexCount = Math.ceil(totalCount/page_size); // 전체 인덱스 수
	gfv_eventName = params.eventName;
	
	$("#"+divId).empty();
	var preStr = "";
	var postStr = "";
	var str = "";
	
	var first = (parseInt((currentIndex-1) / 10) * 10) + 1;
	var last = (parseInt(totalIndexCount/10) < parseInt(currentIndex)/10) ? totalIndexCount%10 : 10;
	var prev = (parseInt((currentIndex-1)/10)*10) - 9 > 0 ? (parseInt((currentIndex-1)/10)*10) - 9 : 1; 
	var next = (parseInt((currentIndex-1)/10)+1) * 10 + 1 < totalIndexCount ? (parseInt((currentIndex-1)/10)+1) * 10 + 1 : totalIndexCount;
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨앞, 앞 태그 작성
		preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>" +
				"<a href='#this' class='pad_5' onclick='_movePage("+prev+")'>[<]</a>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨앞 태그 작성
		preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>";
	}
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨뒤, 뒤 태그 작성
		postStr += "<a href='#this' class='pad_5' onclick='_movePage("+next+")'>[>]</a>" +
					"<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨뒤 태그 작성
		postStr += "<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
	}
	
	for(var i=first; i<(first+last); i++){
		if(i != currentIndex){
			str += "<a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a>";
		}
		else{
			str += "<strong><a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a></strong>";
		}
	}
	$("#"+divId).append(preStr + str + postStr);
}

function _movePage(value){
	$("#"+gfv_pageIndex).val(value);
	if(typeof(gfv_eventName) == "function"){
		gfv_eventName(value);
	}
	else {
		eval(gfv_eventName + "(value);");
	}
}

</script>
</head>
<body>
	<div id="bocomment"></div>
	<div class="container">
		<div id="PAGE_NAVI"></div>
	</div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
	<form id="commonForm" name="commonForm"></form>
	<div class="container">
		<div class="form-group">
			<label for="comment">댓글</label>
			<textarea id="commentcont" class="form-control" rows="3"
				placeholder="댓글을 입력하세요."></textarea>
		</div>
		<button id="commentadd" class="btn btn-default">댓글달기</button>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			fn_selectBoardList();
		});
		
		function fn_selectBoardList(){
			var comAjax = new ComAjax();
			comAjax.setUrl("comm/do_retrieve.do");
			comAjax.setCallback("fn_selectBoardListCallback");
			comAjax.addParam("PAGE_INDEX",$("#PAGE_INDEX").val());
			comAjax.ajax();
		}
		
		function fn_selectBoardListCallback(data){
			console.log('fn_selectBoardListCallback!!');
			var total = data.TOTAL;
			var body = $("#bocomment");
			body.empty();
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4'>댓글이 없습니다. 댓글을 달아주세요.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectBoardList",
				};
				gfn_renderPaging(params);
				
				  var str = "";
	            var depth = "";
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
		    				+				'<a class="cursor" data-toggle="collapse" id="commentReply" href="#commentReplyadd' + value.commTextNum + '">답글</a>'
		    				+				'&nbsp;'
		    				+				'<a class="cursor" id="commentUpdate" >수정</a>'
		    				+				'&nbsp;'
		    				+				'<a class="cursor" id="coomentDelete" >삭제</a>'
		    				+			'<div class="comment-meta">'
		    				+				'<div class="collapse" id="commentReplyadd' + value.commTextNum + '">'
		    				+					'<div class="form-group">'
		    				+						'<label for="comment">답글</label>'
		    				+						'<textarea name="commentTextarea" id="commentReplyTextarea" class="form-control" rows="3" placeholder="댓글을 입력하세요."></textarea>'
		    				+					'</div>'
		    				+					'<button id="replyadd" class="btn btn-default">답글달기</button>'
		    				+				'</div>'
		    				+			'</div>'
	            	if(value.commDepth == 0) {
	          		str +=		'<div class="container">' 
	    				+		'<div class="media">' 
						+			divIn
	    				+		'</div>'
	    				+	'</div>';
	            	}else {
		          		str +=		'<div class="container">' 
		    				+		'<div class="media_reply">' 
							+ 			divIn
		    				+		'</div>'
		    				+	'</div>';
	            	}
	            });
				body.append(str);
			}
		}
	</script>
</body>
</html>