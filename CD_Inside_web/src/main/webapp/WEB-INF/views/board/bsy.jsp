<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
    
    
<%   String context = request.getContextPath();//context path  %>    
    
    
<!DOCTYPE html>
<html>
<head>

  <!-- 부트스트랩 -->
  
    <link href="<%=context%>/resources/css/bootstrap.min.css" rel="stylesheet">
		


<meta charset="UTF-8">
<title>Insert title here</title>

<style>

   th{font-size : 14px;
   	  font-style : inherit;
   	  color: black; 
   	  background-color: white;
   	  
   	  vertical-align: middle;
   	  
   	  }
   	  
   td{ text-align: left; 
   } 

 table {
 
    width: 500px ;
    height: 200px;
 
    margin-left: auto;
    margin-right: auto;
    
    
    
    
}


</style>

</head>
<body>
	<div class="table-basic">
		<div class="table-responsive" >
			<table id="listTable" class="table table-striped table-bordered table-hover">
				<thead class="bg-primary">
				    <tr>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">번호</th>
						<th class="text-center col-xs-11 col-sm-11 col-md-8 col-lg-7">제목</th>
						<th class="text-center col-xs-1 col-sm-1 col-md-2 col-lg-2">글쓴이</th>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">추천 수</th>
						<th class="text-center col-xs-0 col-sm-0 col-md-1 col-lg-1">날짜</th>
					</tr>
				</thead>
				<tbody>  
				<c:choose>
					<c:when test="${list.size()>0}">
						<c:forEach var="userVo" items="${list}">
							<tr>
								<td class="text-center"><c:out value="${userVo.no}"></c:out></td>
								<td class="text-left"><c:out value="${userVo.userId}"></c:out></td>
								<td class="text-left"><c:out value="${userVo.name}"></c:out></td>
								<td class="text-center"><c:out value="${userVo.userLevel}"></c:out></td>
								<td class="text-center"><c:out value="${userVo.recommend}"></c:out></td>
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
		
		</div>
		<!--// Grid영역 ---------------------------------------------------->
		
		
		
	



<!-- <table class="table"> -->
<!--  	<tr class="active">1</tr> -->
<!-- 	<tr class="success">2</tr> -->
<!-- 	<tr class="warning">3</tr> -->
<!-- 	<tr class="danger">4</tr> -->
<!-- 	<tr class="info">5</tr> -->

<!--   </table> -->

     <!-- On rows -->

<!-- On cells (`td` or `th`) -->
<!-- <tr> -->
<!--   <td class="active">...</td> -->
<!--   <td class="success">...</td> -->
<!--   <td class="warning">...</td> -->
<!--   <td class="danger">...</td> -->
<!--   <td class="info">...</td> -->
<!-- </tr> -->
  



</body>
</html>