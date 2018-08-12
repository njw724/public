<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Yeps 카테고리 수정</title>
</head>
<body>
	<div align="center">
	<form name="f" action="category_edit" method="post">
	<input type="hidden" name="cnum" value="${getCategory.cnum}">
		<table border="1" width="300" height="100">
		<caption align="top">카테고리 수정</caption>
			<tr>
				<td bgcolor="yellow">카테고리 이름</td>
				<td><input type="text" name="cname" value="${getCategory.cname}"></td>
			</tr>
			<tr>
				<td align="center" colspan="2" class="m2"> 
				<input type="submit" value="등록">
				<input type="button" value="취소" onclick="window.location='category_list'">
				</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>