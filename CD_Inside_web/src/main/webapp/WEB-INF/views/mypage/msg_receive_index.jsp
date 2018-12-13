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
	
	String page_size ="10";//page_size
	String page_num  ="1";//page_num
	String search_div ="";//검색구분
	String search_word="";//검색어
	
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
	totalCnt = Integer.parseInt(iTotalCnt);
	
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
	<div class="container-fluid">
		<!-- Title영역 -->
		<div class="page-header">
			<h1>받은쪽지함</h1>
		</div>
		
		<!-- 버튼 -->
		
		<button type="button" class="btn btn-default">받은쪽지함</button>
		<button type="button" class="btn btn-default" id="do_sendindex">보낸쪽지함</button>
		<input type="button" class="btn btn-default" value="쪽지쓰기"
			onclick="showPopup();" />
		<!--// 버튼 -->
		
	</div>
	<!--// Title영역 -->
	<form name="frm" id="frm" action="receiveIndex.do" method="get"
		class="form-inline">
		<input type="hidden" name="page_num" id="page_num">

	<!-- 검색영역 -->
	<div class="container-fluid">
		<div class="text-right col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<form action="#" class="form-inline">
				<div class="form-group">
					<%=StringUtil.makeSelectBox(code_page, page_size, "page_size", false)%>
				</div>
				<div class="form-group">
					<select name="search_div" id="search_div"
						class="form-control input-sm">
						<option value="">::전체::</option>
						<option value="30"
							<%if (search_div.equals("30"))out.print("selected='selected'");%>>보낸이</option>
						<option value="60"
							<%if (search_div.equals("60"))out.print("selected='selected'");%>>내용</option>
						</select>
					<input type="text" name="search_word" id="search_word"
						value="${param.search_word}" class="form-control input-sm"
						placeholder="쪽지검색" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<!-- 버튼 -->
					<button type="button" class="btn btn-default btn-sm"
						onclick="javascript:doSearch();">검색</button>

					<a href="javascript:check()">안 읽은 쪽지 삭제</a>
				</div>
			</form>
		</div>
	</div>	
	
					<button type="button" class="btn btn-default btn-sm" id="do_delete">삭제</button>
					
			</div>					
		</form>
	  </div>	
	</div>
		<!--// 검색영역----------------------------------------------------->

		
		<!-- Grid영역 -->
		<div class="container-fluid" 
		style="position:relative; width=200px; text-overflow:ellipsis;overflow:hidden; cursor:hand" >
			<nobr>
			
			<table id="listTable" class="table table-striped table-bordered table-hover"
				style="table-layout :fixed">
				<thead class="bg-primary">
				    <tr>
				        <th class="text-center"><input type="checkbox" id="checkAll" name="checkAll" onclick="checkAll();" ></th> 
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-1">번호</th>
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-2">받는이</th>
						<th class="text-center col-xs-4 col-sm-4 col-md-4 col-lg-4">내용</th>
						<th class="text-center col-xs-3 col-sm-3 col-md-3 col-lg-2">날짜</th>
						<th class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-1">읽음여부</th>
					</tr>
				</thead>
				<tbody>  
				<c:choose>
					<c:when test="${list.size()>0}">
						<c:forEach var="msgVo" items="${list}">
							<tr>
							    <td class="text-center"><input type="checkbox" id="check" name="check"></td>								
								<td class="text-center"><c:out value="${msgVo.no}"></c:out></td>																							
								<td class="text-center"><c:out value="${msgVo.userId}"></c:out></td>																															
								<td class="text-center"
								style="position:relative; width:200px; text-overflow:ellipsis; overflow:hidden; cursor:hand">
           						<nobr>
								<c:out value="${msgVo.msgCont}"></c:out>
           						</nobr>
								</td>								

								<td class="text-center"><c:out value="${msgVo.regDt}"></c:out></td>																							
								<td class="text-center"><c:out value="${msgVo.msgReadYn}"></c:out></td>
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
			</nobr>
		</div>
		<!--// Grid영역 ---------------------------------------------------->
		
		<!--pagenation ---------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "search.do", "search_page") %>
		</div>
		<!--// pagenation영역 ----------------------------------------------->
	</form>	
				</div>																
			</form>
			<!--// Form영역--------------------------------------------->
		
		</div>
		<!--// 입력 Form영역---- ----------------------------------------------->				  
	</div>

	<!--// contents ------------------------------------------------------>

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    
    
    <script src="<%=context%>/resources/js/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="<%=context%>/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    
	//쪽지 쓰기 팝업창 호출 msg_send.jsp
	function showPopup() {
		var comSubmit = new comSubmit();
		comSubmit.setUrl("<c:url value='send.do' />");
		comSubmit.submit();
		window.open("msg_send.jsp", "msg_send",
				"width=500, height=500, left=100, top=50");
	}
    
    
    function search_page(url,page_num){
   	 //alert(url+":search_page:"+page_num);
	   	var frm = document.frm;
	   	frm.page_num.value = page_num;
	   	frm.action = url;
	   	frm.submit();
   	 
    }
   
    function onReset(){
   	 $("#upsert_div").val("save");
   	 $("#userId").prop("disabled",false);
   	 
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
	   	 frm.action = "search.do";
	   	 frm.submit();
     }
   
     $(document).ready(function(){   
		//alert("ready");
		
		//var items = [];
		//$('input:checkbox[type=checkbox]:checked').each(function () {
		//    items.push($(this).val());
		//});
		
		$("#do_delete").on("click",function(){
			//alert("do_delete");
			
			var items = [];//var items=new Array(); 
			$( "input[name='check']:checked" ).each(function( index,row ) {
				console.log("index="+index);
				//console.log("row="+row);
				var record = $(row).parents("tr");
				var userId = $(record).find("td").eq(2).text()
				console.log("userId="+userId);
				items.push(userId);
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
	            url:"delete.do",
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
		         		
		         	 }				             
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	         });//--ajax
			
		});//--do_delete
		
		//do_save
		//등록
		$("#do_save").on("click",function(){
			//alert("do_save");
			var upsert_div = $("#upsert_div").val();
			console.log("upsert_div:"+upsert_div);
			 
			if(false==confirm("등록 하시겠습니까?"))return;
			 
			$.ajax({
		         type:"POST",
		         url:"update.do",
		         dataType:"html",// JSON
		         data:{
		         	"upsert_div": upsert_div,
		         	"msgSeq": $("#msgSeq").val(),
		         	"userId": $("#userId").val(),
		         	"msgRecvId": $("#msgRecvId").val(),
		         	"msgCont": $("#msgCont").val(),
		         	"regDt": $("#regDt").val(),
		         	"msgReadYn": $("#msgReadYn").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag=="1"){
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
			
		});//--do_save
		
		
		$("#do_update").on("click",function(){
			 if(false==confirm("수정 하시겠습니까?"))return;
			  
			 var upsert_div = $("#upsert_div").val();
			 upsert_div = (upsert_div == "")?"update":"";
			 console.log("upsert_div:"+upsert_div);			 
			 
		     $.ajax({
		         type:"POST",
		         url:"update.do",
		         dataType:"html",// JSON
		         data:{
		         	"upsert_div": upsert_div,
		         	"msgSeq": $("#msgSeq").val(),
		         	"userId": $("#userId").val(),
		         	"msgRecvId": $("#msgRecvId").val(),
		         	"msgCont": $("#msgCont").val(),
		         	"regDt": $("#regDt").val(),
		         	"msgReadYn": $("#msgReadYn").val()
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		             var parseData = $.parseJSON(data);
		         	 if(parseData.flag=="1"){
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
			
			
		});//--do_update
		
		
		$("#listTable>tbody").on("click","tr",function(){
			console.log("1 #listTable>tbody");
			
			var tr = $(this);
			var td = tr.children();
			var userId = td.eq(2).text();
			console.log("2 userId="+userId);
			
			if(""==userId)return;
			
	        $.ajax({
	            type:"POST",
	            url:"do_search_one.do",
	            dataType:"html",// JSON
	            data:{
	            "userId": userId
	            },
	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
	              var parseData = $.parseJSON(data);
	              /* console.log("3 parseData.u_id="+parseData.u_id);
	              console.log("3 parseData.name="+parseData.name);
	              console.log("3 parseData.password="+parseData.password);
	              console.log("3 parseData.login="+parseData.login);
	              console.log("3 parseData.recommend="+parseData.recommend);
	              console.log("3 parseData.email="+parseData.email);
	              console.log("3 parseData.userIntLevel="+parseData.userIntLevel);
	              console.log("3 parseData.regDt="+parseData.regDt); */
	              
	              console.log("3 parseData.userIntLevel="+parseData.userIntLevel);

	              $("#msgSeq").val(parseData.msgSeq);
	              $("#userId").val(parseData.userId);
	              $("#msgRecvId").val(parseData.msgRecvId);
	              
	              $("#msgCont").val(parseData.msgCont);
	              $("#regDt").val(parseData.regDt);
	              $("#msgReadYn").val(parseData.msgReadYn);
	              
	              $("#userId").prop("disabled",true);
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	       }); //--ajax
			
		});//--#listTable>tbody
			
			
			
     });  
	</script>
  </body>
</html>