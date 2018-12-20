<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 뷰단에서 뿌려주는거 포 이치해서 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sist.cd.domain.BoardVO"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
	String context = request.getContextPath();

	// 	BoardVO vo = (BoardVO) request.getAttribute("list");
%>
<!-- html 에디터 추가 스크립트 설정----------------------------------- -->
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="<%=context%>/resources/editor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<!-- https://handcoding.tistory.com/16 -->

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>








</head>


<!--  html 에디터  헤더에 추가----------------------------------------------- -->
<%-- <script type="text/javascript">
    $(function(){
        //전역변수
        var obj = [];              
        //스마트에디터 프레임생성
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: obj,
            elPlaceHolder:"editor",
            sSkinURI: "<%=context%>/resources/editor/SmartEditor2Skin.html",  
            htParams : {  
                // 툴바 사용 여부
                bUseToolbar : true,            
                // 입력창 크기 조절바 사용 여부
                bUseVerticalResizer : true,    
                // 모드 탭(Editor | HTML | TEXT) 사용 여부
                bUseModeChanger : true,
            }
        });
        //전송버튼
        $("#insertBoard").click(function(){
            //id가 smarteditor인 textarea에 에디터에서 대입
            obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
            //폼 submit
            $("#insertBoardFrm").submit();
        });
    });   
</script>	  --%>


<body>

	<div class="container">
		<form name="frm" id="frm" action="bsy.do" method="get"
			class="form-inline">
			<input type="hidden" name="page_num" id="page_num">
			<%-- 		<input type="hidden" name="gSeq" id="gSeq" value="${list.gSeq}"> --%>

			<div class="row">
				<div class="text-left col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<h2>${name}</h2>
				</div>
			</div> 


			<input type="hidden" id="bNum" name="bNum" value="<c:out value="${list.bNum}"></c:out>"/>
			<div class="form-group">
				<label for="Name">Title</label><br /> 
				<input type="text" name="bTitle" id="bTitle" maxlength="50" style="width: 1000px" value="<c:out value="${list.bTitle}"></c:out>" />
			</div>
			<br /> <label for="textarea">Context</label><br/>

			<div>
				<textarea name="bCont" id="bCont"
					style="width: 1000px; height: 400px;"><c:out
						value="${list.bCont}"></c:out> </textarea>
			</div>
		</form>


		<button type="button" class="btn btn-default" onClick="history.go(-1)">취소</button>
		<%
			BoardVO check = (BoardVO) request.getAttribute("list");
			if (check == null) {
		%>
		<button type="button" class="btn btn-default" id="do_save">등록</button>
		<%
			} else {
		%>
		<button type="button" class="btn btn-default" id="do_update">수정</button>
		<%
			}
		%>


	</div>
	<!-- 					html 에디터 바디에 추가---------------- -->
	<!-- 	<form action="addSY.do" method="post" id="insertBoardFrm" enctype="multipart/form-data"> -->
	<%--         <textarea name="editor" id="editor" style="width: 1000px; height: 400px;">${list.bCont} </textarea> --%>
	<!--     </form>  -->






	<%-- textarea name="gCont" id="gCont" rows=20 cols=115  maxlength="3000" style="width:1000px;height:500px;">${list.gCont}</textarea> --%>


<!-- 	<input class="btn btn-info" type="button" id="insertBoard"
		value="등록아님 낚시용" />
	<button type="submit" class="btn btn-info">취소</button>
	</div> -->




	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->

	<script src="<%=context%>/resources/js/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="<%=context%>/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
    
    
	 function doSearch(){ // 등록후 1페이지로 가서 전체조회
      	 var frm = document.frm;
    	 frm.page_num.value = 1;  
      	 frm.action = "getlk.do";
      	 frm.submit();
    }
    
    function doUpdate(){ // 등록후 1페이지로 가서 전체조회
     	 var frm = document.frm;
   	     frm.page_num.value = 1;
     	 frm.action = "update.do";
     	 frm.submit();
   }
    
<%--     function doSearch1(){ // 수정후 그페이지로 다시가서 조회
     	 var frm = document.frm;
         frm.page_num.value = <%=oPageNum%>;
        alert(frm.page_num.value);
    	 frm.action = "notebook_home.do";
    	 frm.submit();
   } --%>
    
    
    $(document).ready(function(){   
    	
    	$("#do_save").on("click",function(){
    		
			 if(false==confirm("등록 하시겠습니까?"))return;
			 
			 
		     $.ajax({
		         type:"POST",
		         url:"addLK.do",
		         dataType:"html",// JSON
		         data:{
		         	"bTitle": $("#bTitle").val(),
		         	"bCont": $("#bCont").val(),
		         	"bCate": "링크",
		         	"bHit": "0"
		         
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
			 
	         alert($("#bTitle").val());
	         alert($("#bCont").val());
	         alert($("#bNum").val());
			 
		     $.ajax({
		         type:"POST",
		         url:"update.do",
		         dataType:"json",// JSON
		         data:{
		        	    "bNum": $("#bNum").val(),
		        	    "bTitle": $("#bTitle").val(),
			         	"bCont" : $("#bCont").val(),
			         	"userId": "test05",
			         	"modId" : "test05"
		         },
		         success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
		         		doSearch();
		         		alert('수정완료');
		         },
		         complete: function(data){//무조건 수행
		          
		         },
		         error: function(xhr,status,error){
		          
		         }
		        });//--ajax					
			
			
		});//--do_update
   
		
		
		
		
		
   	
    });//ready
    
    
    
    </script>





</body>
</html>