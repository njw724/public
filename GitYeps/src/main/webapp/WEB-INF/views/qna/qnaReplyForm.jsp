<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<html>
<head>
	<title>QnA</title>
<script type="text/javascript">		
	window.onload = document.qnareplyf.content.focus();
	
		function replyCheck(){
			if (qnareplyf.content.value==""){
				alert("내용을 입력해 주세요!!")
				qnareplyf.content.focus()
				return false
			}
			return true
		}
	</script>
</head>
<body>
	<% 
	pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
	%>
<div align="center">
	<form name="qnareplyf" action="qna_reply" method="post" onsubmit="return replyCheck()">
	<h3>답변하기</h3>
	<input type="hidden" name="qnum" value="${getQnA.qnum}"/>
	<table border="1" width="500">
		<tr>
			<th bgcolor="yellow" width="20%">작 성 자</th>
			<td>${getQnA.writer}</td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">제 목</th>
			<td><input type="text" name="title" class="box" size="50" value="${getQnA.title}" readOnly></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">내 용</th>
			<td>
				<textarea name="content" rows="13" cols="50" class="box">${fn:replace(getQnA.content,"crcn","br")}

------------------------------
답변>
	</textarea>
			</td>
		</tr>
		<tr bgcolor="yellow">
			<td colspan="2" align="center">
				<input type="submit" value="답변완료">
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" onclick="window.location='qna_list'">
			</td>	
		</tr>
	</table>
	</form>
</div>
</body>
</html>