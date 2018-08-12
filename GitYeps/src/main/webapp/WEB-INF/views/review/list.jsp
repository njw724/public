<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<html>
<head>
	<title>yeps_review reviewList</title>
</head>
<body>
<div align="center">
	<b>글 목 록</b>
	<table border="0" width="800">
		<tr bgcolor="yellow">
			<td align="right"><a href="review_write">글쓰기</a></td>
		</tr>
	</table>
	<table border="1" width="800">
		<tr bgcolor="green">
			<th>번호</th>
			<th>외래키1(rnum)</th>
			<th>외래키2(mnum)</th>
			<th>내용</th>
			<th>작성일</th>
			<th>평점</th>
			<th>파일이미지</th>
			<th>IP</th>
			<th>recentreview</th>
			<th>useful</th>
			<th>funny</th>
			<th>cool</th>
			<td>삭제</td>
			<td>수정</td>
		</tr>
	<c:if test="${empty reviewList}">
		<tr>
			<td colspan="14">등록된 게시글이 없습니다.</td>
		</tr>	
	</c:if> 	
	<c:forEach var="dto" items="${reviewList}">
		<tr>
			<td>${dto.rvnum}</td>
			<td>${dto.rnum}</td>
			<td>${dto.mnum}</td>
			<td>${dto.content}</td>
			<td>${dto.joindate}</td>
			<td>${dto.gradepoint}</td>
			<td>${dto.filenum}</td>
			<td>${dto.ip}</td>
			<td>${dto.recentreview}</td>
			<th>${dto.useful}</th>
			<th>${dto.funny}</th>
			<th>${dto.cool}</th>
			<td><a href="review_delete?rvnum=${dto.rvnum}">삭제</a></td>
			<td><a href="review_update?rvnum=${dto.rvnum}">수정</a></td>
		
		</tr>
	</c:forEach>		
	</table>
</div>
</body>
</html>

