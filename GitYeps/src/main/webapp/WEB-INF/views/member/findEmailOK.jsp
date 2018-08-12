<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>findID</title>
<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css"/>"/>
</head>
<body>
	<c:choose>
		<c:when test="${empty emailList}">
			<div id="member_popup">
				<div id="member_popup_empty_head">
				<p class="subused">회원정보가 존재하지 않습니다.</p>
				</div>
				<div id="member_popup_body">
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="확인" onclick='self.close()'>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div id="member_popup">
				<div id="member_popup_head">
					<p class="subused">회원님의 Email은</p>
					<c:forEach var="email" items="${emailList}">
						<p class="subemail">${email}</p>
					</c:forEach>
					<div id="member_popup_head_len">
						<p class="subused">입니다.</p>
					</div>
				</div>
				<div id="member_popup_body">
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="확인" onclick='self.close()'>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>