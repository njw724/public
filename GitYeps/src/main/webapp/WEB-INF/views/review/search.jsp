<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<html>
<head>
	<title>타이틀 미설정 설정하세요</title>
</head>
<body>
	
	<c:if test="${empty SearchedDTO_Rv}">
		목록 존재 하지 않음 
	</c:if>
	
	<c:forEach var="rvdto" items="${SearchedDTO_Rv}">
		${rvdto.content}
	</c:forEach>
	
</body>
</html>
