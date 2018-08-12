<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>findPw</title>
<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css"/>"/>
</head>
<body>
	<c:choose>
		<c:when test="${temporaryPw==1}">
			<div id="member_popup">
				<div id="member_popup_head">
					<p class="subused">회원님의 가입된 E-MAIL로 
					<p class="subused">임시 비밀번호가 발송되었습니다.</p>
					<br>
					<p class="subused_pw_change">로그인 후 비밀번호를 변경해주시기 바랍니다.</p>
				</div>
				<div id="member_popup_body">
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="확인" onclick='self.close()'>
				</div>
			</div>
		</c:when>
		<c:when test="${temporaryPw==-1}">
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
				<div id="member_popup_empty_head">
				<p class="subused">잠시 후 다시 시도해주세요.</p>
				</div>
				<div id="member_popup_body">
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="확인" onclick='self.close()'>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>