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
    <script type="text/javascript" src="<%=context%>/resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
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
<script type="text/javascript">
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
</script>	 


<body>

		<div class="container">
			
			
				<div class="row">
			<div class="text-left col-xs-12 col-sm-12 col-md-12 col-lg-12"><h2>${name}</h2></div>
    	      </div>    
			  
		
			
				<div class="form-group">
					 <label for="Name">Title</label><br/> 
					 
					 <input type="text" name="gTitle" id="gTitle" maxlength="50" style="width:1000px" value="${list.gTitle}"/>
				</div> 
				<div> 
					<label for="textarea">Context</label><br/>
					
					<!-- html 에디터 바디에 추가---------------- -->
	<form action="./insertBoard.do" method="post" id="insertBoardFrm" enctype="multipart/form-data">
        <textarea name="editor" id="editor" style="width: 1000px; height: 400px;"> </textarea>
    </form> 
   
					
 

					
					
 <%-- textarea name="gCont" id="gCont" rows=20 cols=115  maxlength="3000" style="width:1000px;height:500px;">${list.gCont}</textarea> --%>
				 </div>  
				  <p></p>
				  <input class="btn btn-info" type="button" id="insertBoard" value="등록" />
				<button type="submit" class="btn btn-info">취소</button>
		</div>
  
   

		
 				  
 				 
 		
 				 
 			
 				 
 				 
 				  
 				  



</body>
</html>