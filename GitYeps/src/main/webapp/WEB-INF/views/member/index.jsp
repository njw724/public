<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../top.jsp"%>
<html>
<head>
<title>YEPS회원관리</title>
</head>
<body>
	<div align="center">
		<hr color="green" width="300">
		<h2>YEPS 회원관리 프로그램</h2>
		<hr color="green" width="300">
		<table border="1" width="600" height="400">
			<tr height="50">
				<th><a href="member_join">회원가입</a></th>
				<th><a href="member_manager">회원관리</a></th>
				<th><a href="member_login">로그인</a></th>
			</tr>
			<tr>
				<td colspan="4">아무 사진이나 넣어주세요!!</td>
			</tr>
			<tr height="50">
				<td colspan="4" align="center"><a href="qna_index">QnA로 가기</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>