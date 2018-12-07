<%@page import="com.sist.cd.common.SearchVO"%>
<%@page import="java.util.List"%>
<%@page import="com.sist.cd.domain.CodeVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.cd.common.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String context = request.getContextPath();//context path

	String page_size = "10";//page_size
	String page_num = "1";//page_num
	String search_div = "";//검색구분
	String search_word = "";//검색어

	int totalCnt = 0;
	int bottomCount = 10;

	SearchVO vo = (SearchVO) request.getAttribute("param");
	//out.print("vo:"+vo);

	if (null != vo) {
		search_div = StringUtil.nvl(vo.getSearch_div(), "");
		search_word = StringUtil.nvl(vo.getSearch_word(), "");
		page_size = StringUtil.nvl(vo.getPage_size(), "10");
		page_num = StringUtil.nvl(vo.getPage_num(), "1");
	} else {
		search_div = StringUtil.nvl(request.getParameter("search_div"), "");
		search_word = StringUtil.nvl(request.getParameter("search_word"), "");
		page_size = StringUtil.nvl(request.getParameter("page_size"), "10");
		page_num = StringUtil.nvl(request.getParameter("page_num"), "1");
	}

	int oPageSize = Integer.parseInt(page_size);
	int oPageNum = Integer.parseInt(page_num);

	String iTotalCnt = (null == request.getAttribute("total_cnt"))
			? "0"
			: request.getAttribute("total_cnt").toString();
	totalCnt = Integer.parseInt(iTotalCnt);

	List<CodeVO> code_page = (null == request.getAttribute("code_page"))
			? new ArrayList<CodeVO>()
			: (List<CodeVO>) request.getAttribute("code_page");
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
<title>받은쪽지함</title>

<!-- 부트스트랩 -->
<link href="<%=context%>/resources/css/bootstrap.min.css"
	rel="stylesheet">

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

		<button type="button" class="btn btn-default">받은쪽지함</button>
		<button type="button" class="btn btn-default" id="do_sendindex">보낸쪽지함</button>
		<input type="button" class="btn btn-default" value="쪽지쓰기"
			onclick="showPopup();" />

	</div>
	<!--// 사이드바 -->

	<!--// Title영역 -->
	<form name="frm" id="frm" action="search.do" method="get"
		class="form-inline">
		<input type="hidden" name="page_num" id="page_num">

		<!-- 검색영역 -->
		<div class="row">
			<div class="text-right col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<form action="#" class="form-inline">
					<div class="form-group">
						<%=StringUtil.makeSelectBox(code_page, page_size, "page_size", false)%>
					</div>
					<div class="form-group">
						<select name="search_div" id="search_div"
							class="form-control input-sm">
							<option value="">::전체::</option>
							<option value="10"
								<%if (search_div.equals("10"))
				out.print("selected='selected'");%>>ID</option>
							<option value="20"
								<%if (search_div.equals("20"))
				out.print("selected='selected'");%>>내용</option>
						</select> <input type="text" name="search_word" id="search_word"
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
		<!--// 검색영역----------------------------------------------------->
		<!-- 버튼 -->
		<button type="button" class="btn btn-default btn-sm" id="do_delete">삭제</button>
		<button type="button" class="btn btn-default btn-sm" id="do_resave" onclick="showPopup();">답장</button>


		<!-- Grid영역 -->
		<div class="table-responsive">
			<table id="listTable"
				class="table table-striped table-bordered table-hover">
				<thead class="bg-primary">
					<tr>
						<th class="text-center"><input type="checkbox" id="checkAll"
							name="checkAll" onclick="checkAll();"></th>
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-1">번호</th>
						<th class="text-center col-xs-2 col-sm-2 col-md-2 col-lg-2">ID</th>
						<th class="text-center col-xs-4 col-sm-4 col-md-4 col-lg-4">내용</th>
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-2">날짜</th>
						<th class="text-center col-xs-1 col-sm-1 col-md-1 col-lg-2">읽음여부</th>

					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${list.size()>0}">
							<c:forEach var="userVo" items="${list}">
								<tr>
									<td class="text-center"><input type="checkbox" id="check"
										name="check"></td>
									<td class="text-center"><c:out value="${userVo.no}"></c:out></td>
									<td class="text-left"><c:out value="${userVo.u_id}"></c:out></td>
									<td class="text-center"><c:out value="${userVo.name}"></c:out></td>
									<td class="text-right"><c:out value="${userVo.level}"></c:out></td>
									<td class="text-right"><c:out value="${userVo.recommend}"></c:out></td>
									<td class="text-center"><c:out value="${userVo.regDt}"></c:out></td>
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
		</div>
		<!--// Grid영역 ---------------------------------------------------->

		<!--pagenation ---------------------------------------------------->
		<div class="form-inline text-center">
			<%=StringUtil.renderPaging(totalCnt, oPageNum, oPageSize, bottomCount, "search.do", "search_page")%>
		</div>
		<!--// pagenation영역 ----------------------------------------------->
	</form>
	</div>

	<!--// contents ------------------------------------------------------>

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->


	<script src="<%=context%>/resources/js/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		//쪽지 쓰기 팝업창 호출 msg_send.jsp
		function showPopup() {
			window.open("msg_send.jsp", "msg_send",
					"width=500, height=500, left=100, top=50");
		}

		//페이징 처리
		function search_page(url, page_num) {
			alert(url + ":search_page:" + page_num);
			var frm = document.frm;
			frm.page_num.value = page_num;
			frm.action = url;
			frm.submit();

		}

		//check 전체 선택
		function checkAll() {
			//alert("checkAll");
			if ($("#checkAll").is(':checked') == true) {
				$("input[name='check']").prop("checked", true);
			} else {
				$("input[name='check']").prop("checked", false);
			}

		}

		function doSearch() {
			var frm = document.frm;
			frm.page_num.value = 1;
			frm.action = "search.do";
			frm.submit();
		}

		$(document).ready(function() {
			//alert("ready");

			//var items = [];
			//$('input:checkbox[type=checkbox]:checked').each(function () {
			//    items.push($(this).val());
			//});

			$("#do_delete").on("click", function() {
				//alert("do_delete");

				var items = [];//var items=new Array(); 
				$("input[name='check']:checked").each(function(index, row) {
					console.log("index=" + index);
					//console.log("row="+row);
					var record = $(row).parents("tr");
					var u_id = $(record).find("td").eq(2).text()
					console.log("u_id=" + u_id);
					items.push(u_id);
				});
				console.log("items.length=" + items.length);
				if (items.length <= 0) {
					alert("삭제할 데이터를 선택 하세요.")
					return;
				}

				if (false == confirm("삭제 하시겠습니까?"))
					return;

				var jsonIdList = JSON.stringify(items);
				//jsonIdList=["107","108"]
				console.log("jsonIdList=" + jsonIdList);

				$.ajax({
					type : "POST",
					url : "delete.do",
					dataType : "html",
					data : {
						"u_id_list" : jsonIdList
					},
					success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
						var parseData = $.parseJSON(data);
						console.log("parseData.flag=" + parseData.flag);
						console.log("parseData.message=" + parseData.message);
						if (parseData.flag > 0) {
							alert(parseData.message);
							doSearch();
						} else {
							alert(parseData.message);

						}
					},
					complete : function(data) {//무조건 수행

					},
					error : function(xhr, status, error) {

					}
				});//--ajax

			});//--do_delete

			//do_save
			//쪽지보내기
			$("#do_save").on("click", function() {
				//alert("do_save");
				var upsert_div = $("#upsert_div").val();
				console.log("upsert_div:" + upsert_div);

				$.ajax({
					type : "POST",
					url : "update.do",
					dataType : "html",// JSON
					data : {
						"upsert_div" : upsert_div,
						"u_id" : $("#u_id").val(),
						"name" : $("#name").val(),
						"password" : $("#password").val(),
						"level" : tmpLevel,
						"loginValue" : $("#login").val(),
						"recommend" : $("#recommend").val(),
						"email" : $("#email").val()
					},
					success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
						var parseData = $.parseJSON(data);
						if (parseData.flag == "1") {
							alert(parseData.message);
							doSearch();
						} else {
							alert(parseData.message);
						}
					},
					complete : function(data) {//무조건 수행

					},
					error : function(xhr, status, error) {

					}
				});//--ajax

			});//--do_save

			//do_resave
			//답장
			$("#do_resave").on("click", function() {
				//alert("do_save");
				var upsert_div = $("#upsert_div").val();
				console.log("upsert_div:" + upsert_div);

				$.ajax({
					type : "POST",
					url : "update.do",
					dataType : "html",// JSON
					data : {
						"upsert_div" : upsert_div,
						"u_id" : $("#u_id").val(),
						"name" : $("#name").val(),
						"password" : $("#password").val(),
						"level" : tmpLevel,
						"loginValue" : $("#login").val(),
						"recommend" : $("#recommend").val(),
						"email" : $("#email").val()
					},
					success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
						var parseData = $.parseJSON(data);
						if (parseData.flag == "1") {
							alert(parseData.message);
							doSearch();
						} else {
							alert(parseData.message);
						}
					},
					complete : function(data) {//무조건 수행

					},
					error : function(xhr, status, error) {

					}
				});//--ajax

			});//--do_save

			//보낸편지함
			//
			$("#do_sendindex").on("click", function() {
				alert("do_save");
				var upsert_div = $("#upsert_div").val();
				console.log("upsert_div:" + upsert_div);

				$.ajax({
					type : "POST",
					url : "msg_send_index.jsp",
					dataType : "html",// JSON
					data : {
						"upsert_div" : upsert_div,
						"u_id" : $("#u_id").val(),
						"name" : $("#name").val(),
						"password" : $("#password").val(),
						"level" : tmpLevel,
						"loginValue" : $("#login").val(),
						"recommend" : $("#recommend").val(),
						"email" : $("#email").val()
					},
					success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
						var parseData = $.parseJSON(data);
						if (parseData.flag == "1") {
							alert(parseData.message);
							doSearch();
						} else {
							alert(parseData.message);
						}
					},
					complete : function(data) {//무조건 수행

					},
					error : function(xhr, status, error) {

					}
				});//--ajax

			});//--do_save

			$("#listTable>tbody").on("click", "tr", function() {
				console.log("1 #listTable>tbody");

				var tr = $(this);
				var td = tr.children();
				var u_id = td.eq(2).text();
				console.log("2 u_id=" + u_id);

				if ("" == u_id)
					return;

				$.ajax({
					type : "POST",
					url : "do_search_one.do",
					dataType : "html",// JSON
					data : {
						"u_id" : u_id
					},
					success : function(data) {//통신이 성공적으로 이루어 졌을때 받을 함수
						var parseData = $.parseJSON(data);
						/* console.log("3 parseData.u_id="+parseData.u_id);
						console.log("3 parseData.name="+parseData.name);
						console.log("3 parseData.password="+parseData.password);
						console.log("3 parseData.login="+parseData.login);
						console.log("3 parseData.recommend="+parseData.recommend);
						console.log("3 parseData.email="+parseData.email);
						console.log("3 parseData.level="+parseData.level);
						console.log("3 parseData.regDt="+parseData.regDt); */
						$("#u_id").val(parseData.u_id);
						$("#name").val(parseData.name);
						$("#password").val(parseData.password);

						$("#login").val(parseData.login);
						$("#recommend").val(parseData.recommend);
						$("#email").val(parseData.email);
						$("#level").val(parseData.level);
						$("#regDt").val(parseData.regDt);

						$("#u_id").prop("disabled", true);
					},
					complete : function(data) {//무조건 수행

					},
					error : function(xhr, status, error) {

					}
				}); //--ajax

			});//--#listTable>tbody

		});
	</script>
</body>
</html>