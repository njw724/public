<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<html>
<head>
	<title>아직 미 설정</title>
</head>
<body>

	<h2>관리항목 선택한 목록보기</h2>
	
	<c:if test="${empty select}&${empty isManager}">
		선택된 select가 없습니다.
	</c:if> 	
	
	<c:if test="${!empty isManager}">
		${isManager}<br>
	</c:if>	
	
	<c:forEach var="selectlist" items="${select}" step="1">
			${selectlist}<br>
	</c:forEach>		
	
	<hr>
	<form name="authority_transfer" method="post" action="">
		<input type="submit" value="권한부여하기">	
	</form>
	
</body>
</html>