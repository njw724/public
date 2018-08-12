<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>타이틀을 입력해주세요.</title>
	<script type="text/javascript">
		function check(){
			if (updateF.writer.value==""){
				alert("작성자명을 입력해 주세요!!")
				updateF.writer.focus()
				return false
			}
			if (updateF.content.value==""){
				alert("내용을 입력해 주세요!!")
				updateF.subject.focus()
				return false
			}
			if (updateF.gradepoint.value==""){
				alert("평점을 입력해 주세요!!")
				updateF.content.focus()
				return false
			}
			return true
		}
	</script>
</head>
<body>
<div align="center">
	<form name="updateF" action="review_update" method="post" onsubmit="javascript:return check()">
	<h3>글수정</h3>
	<input type="hidden" name="rvnum" value="${getReview.rvnum}"/>

	<table border="1" width="500">
		<tr>
			<th bgcolor="yellow" width="20%">내용</th>
			<td><input type="text" name="content" class="box" size="50" value="${getReview.content}"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">평점</th>
			<td><input type="text" name="gradepoint" class="box" size="50" value="${getReview.gradepoint}"></td>
		</tr>
		
		<tr bgcolor="yellow">
			<td colspan="2" align="center">
				<input type="submit" value="글수정">
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" onclick="window.location='review_list'">
			</td>	
		</tr>
	</table>
	</form>
</div>
</body>
</html>












