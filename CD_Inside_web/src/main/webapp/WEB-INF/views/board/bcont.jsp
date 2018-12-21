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


 
 
<%
// 	BoardVO vo = (BoardVO) request.getAttribute("list"); 

%> 

<style>
.row-centered {
	text-align: center;
}

.col-centered {
	display: inline-block;
	float: none;
	/* reset the text-align */
	text-align: left;
	/* inline-block space fix */
	margin-right: -4px;
}
 

</style> 
 
<link href="/cd/resources/css/comment.css" rel="stylesheet" type="text/css">
 



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
	$(this).parents(".container").remove();
});
  
//Ajax 분리
function commentAjax(params,url){
	var userId = params.userId
	var commCont = params.commCont
	var bNum = $(".hiddenbNum").text();
	var modId = params.modId
	var commTextNum = params.commTextNum
	var commGroupNo = params.commGroupNo
	var commDepth = params.commDepth
	$.ajax({
		 type : "POST", 
		 url : url,    
        dataType:"json",// JSON
        data:{
            "userId": '<%=userId %>',
            "commCont": commCont,
            "bNum": bNum,
            "modId": '<%=userId %>',
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
        	if(this.url == "addComment.do"){
            	_movePage(totalIndexCount);
        	}
        	
        	if(total == 0){
        		_movePage(totalIndexCount-1);
        	}
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
	var n = cont.length;
	
	if(n > 500){
		alert('댓글수가 너무 많습니다. 500자 이하로 작성해주세요.');
		return false;
	}
	
	var regexp = /[A-Za-z0-9]{140}/g;
	
	if(cont.length == 0){
		alert('내용을 입력해주세요.');
		return false;
	}
	 
	if(n > 500){
		alert('댓글수가 너무 많습니다. 500자 이하로 작성해주세요.');
		return false;
	}
	
	if(cont.match(regexp)){
		alert('연속된영어및숫자140개는 입력하실수없습니다.')
		return false;
	}
	
	if(false==confirm("댓글을 다시겠습니까?"))return;
	
	var params = {
			commCont : cont
	};
	commentAjax(params,"addComment.do");
	$("#commentcont").val('');
});

//답글달기
$(document).on('click','#replyadd', function() {
	var parent = $(this).parents(".container");
	var commTextNum = $(parent).find(".commTextNum").val();
	var cont   = $(parent).find("#commentReplyTextarea").val(); 
	var n = cont.length;
	
	if(n > 500){
		alert('댓글수가 너무 많습니다. 500자 이하로 작성해주세요.');
		return false;
	}
	
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
		var bNum = $(".hiddenbNum").text();
		$.ajax({
			url : this.url,    
			type : "POST",   
			//data : this.param,
            data:{
	            "page_num": this.value,
	            "bNum": bNum,
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
var page_size = 10;
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
			str += "<strong><a href='#this' class='pad_5 pad_5strong' onclick='_movePage("+i+")'>"+i+"</a></strong>";
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

$(document).on('shown.bs.collapse', '.bocollapse', function (e) {
	var parent = $(this).parents(".container");
	$(parent).find("#commentReplyTextarea").focus();
});

</script>
 
<body>
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
        	frm.action = "get.do";
        	frm.submit();
        }
	    
       function delgo(gSeq){ //수정
       	var frm = document.frm;
       	frm.gSeq.value = gSeq;
       	frm.action = "history.go(-1)";
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
		        	frm.action = "bsy.do";  
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
			        	frm.action = "write.do"; 
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
	             <div class="bContbofrm">  <textarea style=" resize: vertical; background-color:#f9ffa9;" readonly="readonly" rows="20" cols="125" > <c:out value="${list.bCont}"></c:out>  </textarea></div> 
	     		  </div>  
		 <div style=”clear:both;”></div>

		
    
		<!-- <hr style="border: solid 2px gray;"> -->
		 
		<div class="row"> 
		  <div class="text-right col-xs-12 col-sm-12 col-md-12 col-lg-12"  style="border-bottom:1px solid;">
		  <a type="button" class="btn btn-default" href="/cd/board/bsy.do">목록</a>
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
	<div id="bocomment"></div>
	<div class="container">
		<div id="PAGE_NAVI"></div>
	</div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
	<form id="commonForm" name="commonForm"></form>
	
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
		
		var total;
		function fn_selectBoardListCallback(data){
			console.log('fn_selectBoardListCallback!!');
			total = data.TOTAL;
			var body = $("#bocomment");
			body.empty();
			if(total == 0){
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
	    				+						'<a class="commId" href="' + '/cd/gallog/gallog_home.do?userId=' + value.userId + '">' + value.userId + '</a>&nbsp;'
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
			    				+	'</div>';
		            	}
	            });
				body.append(str);
			}
		}
	</script>

<!-------------------------------------------------------------------댓글 끝---------------------------------------------------------- -->

</body>
</html>