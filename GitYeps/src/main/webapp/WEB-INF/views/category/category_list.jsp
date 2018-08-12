<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Yeps 카테고리 리스트</title>
</head>
<%@ include file="../top.jsp"%>
<div align="center" style="margin: 30px;">
	<h2 style="height: 50px; margin-top: 40px;">카 테 고 리 목 록</h2>
	<table width="70%">
		<tr>
			<td align="right" colspan="4"><a href="category_insert">글쓰기</a>
			</td>
		</tr>
		<tr>
			<th align="center" width="10%">번호</th>
			<th align="center" width="50%">카테고리명</th>
			<th align="center" width="10%">삭제</th>
			<th align="center" width="10%">수정</th>
		</tr>
		<c:if test="${empty categoryList}">
			<tr>
				<td colspan="4" align="center">등록된 카테고리가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="dto" items="${categoryList}">
			<tr>
				<td align="center">${dto.cnum}</td>
				<td align="center">${dto.cname}</td>
				<td align="center"><a href="category_delete?cnum=${dto.cnum}">삭제</a>|</td>
				<td align="center"><a href="category_edit?cnum=${dto.cnum}">수정</a></td>
			</tr>
		</c:forEach>
	</table>
	</td>
	</tr>
	</table>
</div>
<%@ include file="../bottom.jsp"%>