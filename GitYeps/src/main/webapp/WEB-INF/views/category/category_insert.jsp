<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Yeps 카테고리 등록</title>
</head>
<body>
	<div align="center">
	<form name="f" action="category_insert" method="post">
		<table border="1" width="300" height="100">
		<caption align="top">카테고리 등록</caption>
			<tr>
				<td bgcolor="yellow">카테고리 이름</td>
				<td><input type="text" name="cname"></td>
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