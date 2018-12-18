<%@page import="com.sist.cd.domain.CommentVO"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.cd.domain.CodeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.sist.cd.common.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String context = request.getContextPath();//context path
	Logger log = LoggerFactory.getLogger(this.getClass());
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//검색구분
	String search_word="";//검색어
	
	int totalCnt      =0;
	int bottomCount   =10;
	
	CommentVO vo =  (CommentVO)request.getAttribute("param");
	//out.print("vo:"+vo);
	
	if(null !=vo ){
		search_div  = StringUtil.nvl(vo.getSearch_div(), ""); 
		search_word = StringUtil.nvl(vo.getSearch_word(), ""); 
		page_size   = StringUtil.nvl(vo.getPage_size(), "10"); 
		page_num   = StringUtil.nvl(vo.getPage_num(), "1"); 
	}else{ 
		search_div  = StringUtil.nvl(request.getParameter("search_div"), ""); 
		search_word = StringUtil.nvl(request.getParameter("search_word"), "");
		page_size = StringUtil.nvl(request.getParameter("page_size"), "10");
		page_num = StringUtil.nvl(request.getParameter("page_num"), "1");
	}
	
	
	
	int oPageSize = Integer.parseInt(page_size);
	int oPageNum  = Integer.parseInt(page_num);
	
	String iTotalCnt = (null == request.getAttribute("total_cnt"))?"0":request.getAttribute("total_cnt").toString();
	totalCnt = Integer.parseInt(iTotalCnt);
	
	List<CodeVO> code_page = (null == request.getAttribute("code_page"))
			     ?new ArrayList<CodeVO>():(List<CodeVO>)request.getAttribute("code_page");
			     
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">
    
<title>:::마이페이지 활동내역:::</title>
</head>
<body>
	 <div class="container" style="padding-top:3%">
	    <div class="col-sm-1" ></div>
		<div class="col-sm-2" >
			<a >${sessionName}</a>님<br/>
			쪽지<a >value</a> 
		</div>
		<ul class="nav nav-pills col-sm-9" align="center" >
		<c:choose>
			<c:when test="${sessionYn==1 }">
		  <li role="presentation" ><a href="/cd/mypage/user_list.do" >회원관리</a></li>
			</c:when>
		</c:choose>
		  <li role="presentation" ><a href="/cd/mypage/user_update.do">개인정보 수정</a></li>
		  <li role="presentation" class="active" ><a href="/cd/mypage/user_act.do">활동내역</a></li>
		  <li role="presentation"><a href="/cd/msg/receiveIndex.do">쪽지함</a></li>
		  <li role="presentation"><a href="/cd/gallog/notebook_home.do">갤로그 가기</a></li>
		</ul>
        <form  name="frm" id="frm" action="user_act" method="get" class="form-inline">
     		<input type="hidden" name="page_num" id="page_num">
		<div class="col-xs-12"><hr/></div>
		<div class="col-xs-1"></div>
		<div class="table-responsive col-xs-10" >
     	<div class="row">
	         <div class="col-sm-12" >
	         	<ul class="nav nav-tabs">
					<li role="presentation"><a href="user_act.do">등록한 게시글</a></li>
					<li role="presentation" class="active"><a href="user_act_c.do">등록한 댓글</a></li>
				</ul>

<!-- 	          <ul class="nav nav-tabs"> -->
<!-- 	              <li class="active"><a href="#first" >등록한 게시글</a></li> -->
<!-- 	              <li><a href="#second" >등록한 댓글</a></li> -->
<!-- 	          </ul> -->
<!-- 		         <input type="hidden" id="aTag" name="aTag" value="board" > -->
		     </div>
<!-- 	         <div class="col-sm-12" ><hr/></div> -->
	         <div style="text-align: right"><br/>
	         	<input type="button" class="btn btn-default btn-sm" style="height: 35px" id="do_delete" value="삭제"/> 
	         </div>
	         </div>
			<table id="listTable" class="table table-striped table-bordered table-hover ">
			<thead class="bg-primary">
			    <tr>
			        <th class=" col-lg-1" style="text-align: center" > 전체<br/><input type="checkbox" id="checkAll" name="checkAll" onclick="checkAlls();" ></th> 
					<th style="display:none" class="text-center col-lg-2" >게시판번호 본문이동</th>
					<th class="text-center col-lg-5" >내용</th>
					<th class="text-center col-lg-3" >작성일</th>
					<th style="display:none" class=" col-lg-1">댓글번호 삭제용</th>
				</tr>
			</thead>
			</div>
			
			 <tbody>
				<c:choose>
					<c:when test="${list.size()>0}">
						<c:forEach var="commentVo" items="${list}">
							<tr>
							    <td align="center"><input type="checkbox" id="check" name="check"></td>
								<td style="display:none" align="center" ><c:out value="${commentVo.bNum}"></c:out></td>
								<td align="center" ><c:out value="${commentVo.commCont}"></c:out></td>
								<td align="center" ><c:out value="${commentVo.regDt}"></c:out></td>
								<td style="display:none" align="center" ><c:out value="${commentVo.commTextNum}"></c:out></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
						    <td class="text-center" colspan="99">등록된 게시글이 없습니다.</td>
						</tr>					
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<div class="col-xs-1"></div>
		<!--// Grid영역 ---------------------------------------------------->
		<div class="form-inline">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "user_act_c.do", "search_page") %>
		</div>
	    </form>
	   </div>
	 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    //page
    function search_page(url,page_num){
   	 //alert(url+":search_page:"+page_num);
   	 var frm = document.frm;
   	 frm.page_num.value = page_num;
   	 frm.action = url;
   	 frm.submit();
   	 
    }
    
	//check 전체 선택
	function checkAlls(){
	//alert("checkAll");
		if($("#checkAll").is(':checked') == true  ){
			$("input[name='check']").prop("checked",true);
		}else{
		 	$("input[name='check']").prop("checked",false);
		}
	   
	}
	
	//검색
    function doSearch(){
	 	var frm = document.frm;
		frm.page_num.value =1;
	   	frm.action = "user_act_c.do";
	   	frm.submit();
    }
    
	$(document).ready(function(){   
		
		$("#do_delete").on("click",function(){
			//alert("do_delete");
			
			var items = [];//var items=new Array(); 
			$( "input[name='check']:checked" ).each(function( index,row ) {
				console.log("index="+index);
				//console.log("row="+row);
				var record = $(row).parents("tr");
				var coNum = $(record).find("td").eq(4).text();
				console.log("coNum="+coNum);
				items.push(coNum);
			});
			console.log("items.length="+items.length);
			if(items.length<=0){
				alert("삭제할 데이터를 선택 하세요.")
				return;
			}
			
			if(false==confirm("삭제 하시겠습니까?"))return;
			
			var jsonIdList = JSON.stringify(items);
			//jsonIdList=["107","108"]
			console.log("jsonIdList="+jsonIdList);
			
	        $.ajax({
	            type:"POST",
	            url:"co_delete.do",
	            dataType:"html",
	            data:{
	            	"commNum": jsonIdList
	            },
	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
	                 console.log("parseData.flag="+parseData.flag);
	                 console.log("parseData.message="+parseData.message);
		         	 if(parseData.flag > 0){
		         		alert(parseData.message);
		         		doSearch();
		         	 }else{
		         		alert(parseData.message);
		         		
		         	 }				             
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	         });//--ajax
			
		});//--do_delete
		
 	});
    
    </script>
</body>
</html>