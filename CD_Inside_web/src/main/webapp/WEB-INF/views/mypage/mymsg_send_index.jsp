<%@page import="java.io.PrintWriter"%>
<%@page import="com.sist.cd.common.SearchVO"%>
<%@page import="java.util.List"%>
<%@page import="com.sist.cd.domain.CodeVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.cd.common.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="tiles"  
    uri="http://tiles.apache.org/tags-tiles" %>    
 
<%

	String context = request.getContextPath();//context path
	
	//세션 타임아웃시 경고창과 함께 로그인페이지로 이동하는 부분!!
	session = request.getSession(false);
	PrintWriter outt = response.getWriter();
	if(null==session || session.getAttribute("sessionId")==null){
		outt.print("<script>alert('로그인이 필요한 화면입니다.');location.href='/cd/user/login.do'</script>");
		return;
	}
	
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//검색구분
	String search_word="";//검색어
	
	int tCnt          =0; //받은쪽지수
	int nCnt          =0; //안읽은쪽지수
	int totalCnt      =0;
	int bottomCount   =10;
    
	SearchVO vo =  (SearchVO)request.getAttribute("param");
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
	String inCnt = (null == request.getAttribute("n_cnt"))?"0":request.getAttribute("n_cnt").toString();
	String itCnt = (null == request.getAttribute("t_cnt"))?"0":request.getAttribute("t_cnt").toString();

	totalCnt = Integer.parseInt(iTotalCnt);
	nCnt = Integer.parseInt(inCnt);
	tCnt = Integer.parseInt(itCnt);

	List<CodeVO> code_page = (null == request.getAttribute("code_page"))
			     ?new ArrayList<CodeVO>():(List<CodeVO>)request.getAttribute("code_page");
	
%>    
<%-- 
  /**
  * @Class Name  : user.jsp
  * @Description : 사용자관리 화면
  * @Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ---------------------------
  *  2018.11.22             최초 생성
  *
  * author HR 개발팀
  * since 2018.11.22
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%> 
    
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title><tiles:putAttribute name="title"></tiles:putAttribute></title>

    <!-- 부트스트랩 -->
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
  <body>
	<!-- contents -------------------------------------------------------->
	<div class="container">
		<!-- Title영역 -->
	
	<!-- 마이페이지 공통------------------------------------------------------->
		 <div class="container" style="padding-top:3%">
	<thead>
	    <div class="col-sm-1" ></div>
		<div class="col-sm-2" >
			<a >${sessionName}</a>님<br/>
			안읽은 쪽지<a href="/cd/msg/receiveIndex.do" style="cursor:pointer" >&nbsp;&nbsp;${sessionMsg}</a>개
		</div>
		<ul class="nav nav-pills col-sm-9" align="center" >
		  <li role="presentation" ><a href="/cd/mypage/user_update.do">개인정보 수정</a></li>
		  <li role="presentation" ><a href="/cd/mypage/user_act.do">활동내역</a></li>
		  <li role="presentation" class="active" ><a href="/cd/msg/receiveIndex.do" >쪽지함</a></li>
		  <li role="presentation"><a href="/cd/gallog/notebook_home.do" >갤로그 가기</a></li>
		<c:choose>
			<c:when test="${sessionYn==1 }">
		  <li role="presentation"><a href="/cd/mypage/user_list.do" >회원관리</a></li>
			</c:when>
		</c:choose>
		</ul>
	</thead>
		</div>
	<!--// 마이페이지 공통------------------------------------------------------->
	
		<!-- 이동 버튼 영역------------------------------------------------------->
		<div class="container" style="padding-top:3%">
		<ul class="nav nav-pills col-sm-9">
			<li role="presentation"><a href="<%=context%>/msg/receiveIndex.do">받은쪽지함</a></li>
			<li role="presentation"class="active"><a href="<%=context%>/msg/sendIndex.do">보낸쪽지함</a></li>
		</ul>		
		</div>
		
		<!--// 이동 버튼 영역----------------------------------------------------->
		
	</div>
	<!-- //contents -------------------------------------------------------->
	<form name="frm_get" id="frm" action="sendIndex.do" method="get" class="form-inline">
		<input type="hidden" name="msgSeq" id="msgSeq">
		<input type="hidden" name="userId" id="userId">
		<input type="hidden" name="msgRecvId" id="msgRecvId">
		
		<input type="hidden" name="msgCont" id="msgCont">
		<input type="hidden" name="regDt" id="regDt">
	</form>

	<!--// Title영역 -->
	<form name="frm" id="frm" action="sendIndex.do" method="get"
		class="form-inline">
		<input type="hidden" name="page_num" id="page_num">

		<!-- 검색영역 -->
		<div class="container">
			<div class="text-left col-xs-10 col-sm-10 col-md-10 col-lg-10">
			</div>
					
			<div class="text-right col-xs-10 col-sm-10 col-md-10 col-lg-10">		
				<form action="#" class="form-inline">
					<div class="form-group">
					
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
						<div class="form-group">
							<%=StringUtil.makeSelectBox(code_page, page_size, "page_size", false)%>
						</div>
							<select name="search_div" id="search_div" class="form-control input-sm">
								<option value="">::전체::</option>
								<option value="40" <%if(search_div.equals("40"))out.print("selected='selected'"); %> >받는이</option>					
								<option value="30" <%if(search_div.equals("30"))out.print("selected='selected'"); %> >내용</option>					
								
							</select>							
						<input type="text" name="search_word" id="search_word" value="${param.search_word}" class="form-control input-sm" placeholder="쪽지검색" />
							
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
						<!-- 버튼 -->
						<button type="button" class="btn btn-default btn-sm"
							onclick="javascript:doSearch();">검색</button>
						<button type="button" class="btn btn-default btn-sm" id="do_SDeleteMulti">삭제</button>						
						<br/><br/>					
					</div>
				</form>
			</div>
		</div>	

		<!--// 검색영역----------------------------------------------------->

		<!-- Grid영역 -->
		<div class="container" 
		style="position:relative; width=200px; text-overflow:ellipsis;overflow:hidden; cursor:hand" >
			<nobr>
			
			<table id="listTable" class="table table-striped table-bordered table-hover"
				style="table-layout :fixed">
				<thead class="bg-primary">
				    <tr>
				        <th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-1"><input type="checkbox" id="checkAll" name="checkAll" onclick="checkAll();" ></th> 
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-1">번호</th>
						<th style="display: none" class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-2">보낸이</th>
						<th class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-2">받는이</th>
						
						<th class="text-center col-xs-3 col-sm-3 col-md-3 col-lg-3">내용</th>
						<th class="text-center col-xs-3 col-sm-3 col-md-3 col-lg-3">날짜</th>
						<th style="display: none" class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-2">수신여부</th>
					</tr>
				</thead>
				<tbody>  
				<c:choose>
					<c:when test="${list.size()>0}">
						<c:forEach var="msgVo" items="${list}">
							<tr>
							    <td class="text-center" onclick='event.cancelBubble=true;'><input type="checkbox" id="check" name="check"></td>								
								<td class="text-center" onclick='event.cancelBubble=true;'><c:out value="${msgVo.msgSeq}"></c:out></td>																							
								<td style="display: none" class="text-center" onclick='event.cancelBubble=true;'><c:out value="${msgVo.userId}"></c:out></td>																															
								<td class="text-center" onclick='event.cancelBubble=true;'><c:out value="${msgVo.msgRecvId}"></c:out></td>																															
								
								<td class="text-center"
								style="position:relative; width:200px; text-overflow:ellipsis; overflow:hidden; cursor:hand">
           						<nobr>
								<c:out value="${msgVo.msgCont}"></c:out>
           						</nobr>
								</td>								

								<td class="text-center" onclick='event.cancelBubble=true;'><c:out value="${msgVo.regDt}"></c:out></td>																							
								<td style="display: none" class="text-center" onclick='event.cancelBubble=true;'><c:out value="${msgVo.msgReadYn}"></c:out></td>
								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
						    <td class="text-center" colspan="99">받은 쪽지가 없습니다.</td>
						</tr>					
					</c:otherwise>
				</c:choose>						
				</tbody>
			</table>
			</nobr>
		</div>
		<!--// Grid영역 ---------------------------------------------------->
		
		<!--pagenation ---------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "sendIndex.do", "search_page") %>
		</div>
		<!--// pagenation영역 ----------------------------------------------->
	</form>	

	<!--// contents ------------------------------------------------------>

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
	//보낸쪽지함 호출 msg_send.jsp
	function sendIndex() {
		var comSubmit = new comSubmit();
		comSubmit.setUrl("<c:url value='send_index.do' />");
		comSubmit.submit();
	}
        
    
    function search_page(url,page_num){
   	 //alert(url+":search_page:"+page_num);
	   	var frm = document.frm;
	   	frm.page_num.value = page_num;
	   	frm.action = url;
	   	frm.submit();
    }
   

	 //check 전체 선택
     function checkAll(){
	   	 //alert("checkAll");
	   	 if($("#checkAll").is(':checked') == true  ){
	   		 $("input[name='check']").prop("checked",true);
	   	 }else{
	   		 $("input[name='check']").prop("checked",false);
	   	 }
     }
        
     function doSearch(){
	   	 var frm = document.frm;
	   	 frm.page_num.value =1;
	   	 frm.action = "sendIndex.do";
	   	 frm.submit();
     }
 	 
 	$(document).ready(function(){   
		
		$("#do_SDeleteMulti").on("click",function(){
			//alert("do_delete");
			
			var items = [];//var items=new Array(); 
			$( "input[name='check']:checked" ).each(function( index,row ) {
				console.log("index="+index);
				//console.log("row="+row);
				var record = $(row).parents("tr");
				var msgSeq = $(record).find("td").eq(1).text()
				console.log("msgSeq="+msgSeq);
				items.push(msgSeq);
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
	            url:"do_SDeleteMulti.do",
	            dataType:"html",
	            data:{
	            	"userId_list": jsonIdList
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
		         		location.href="sendIndex.do";

		         	 }				             
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){

	            }
	         });//--ajax
			
		});//--do_SDeleteMulti	
		
		$("#listTable>tbody").on("click","tr",function(){
			console.log("1 #listTable>tbody");
			
			var tr = $(this);
			var td = tr.children();
			var msgSeq = td.eq(1).text();
			var userId = td.eq(2).text();
			var msgRecvId = td.eq(3).text();
			var msgCont = td.eq(4).text();
			var regDt = td.eq(5).text();	
			
		   	var frm = document.frm_get;
			frm.msgSeq.value = msgSeq;
			frm.userId.value = userId;
			frm.msgRecvId.value = msgRecvId;
			frm.msgCont.value = msgCont;
		   	frm.regDt.value = regDt;
		   	frm.action = 'getS.do';
		   	frm.submit();
			
			if(""==msgSeq)return;

		});//--#listTable>tbody
			
			
			
     });  
	</script>
  </body>
</html>