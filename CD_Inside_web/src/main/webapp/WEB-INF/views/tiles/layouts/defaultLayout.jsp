<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	String cPath = request.getContextPath();//context path
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><tiles:getAsString name="title" /></title>
</head>
  <style>
  
  
  
  #sideleft {
        width: 15%;
        padding: 0px;
        margin-bottom: 0px; 
        float: left;  
       
      }
   #sideright {
        width: 15%;
        padding: 0px;
        margin-bottom: 20px;
        float: right;
      }
  
  
  </style>
  
  
<body>
    <header id="header">
        <tiles:insertAttribute name="header" />
    </header>

    <section id="#siderigth">
        <tiles:insertAttribute name="menu" />
    </section> 
	              
    <section id="siteContent">
								<!-- 오른쪽  왼쪽  타일즈 사이드박스 -->
						        <div>
						    	   <div id="sideleft"> </div>
						    	</div>
						    	
						    	<div>
						    	  <div id="sideright"> </div>
						    	</div>
						 		  <!--///////오른쪽  왼쪽  타일즈 사이드박스 -->
        <tiles:insertAttribute name="body" />
    </section>

    <footer id="footer">
        <tiles:insertAttribute name="footer" />
    </footer>
	<script src="<%=cPath%>/resources/js/jquery.js"></script>
	<script src="<%=cPath%>/resources/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=cPath%>/resources/js/jquery.oLoader.min.js"></script>
	
</body>
</html>
