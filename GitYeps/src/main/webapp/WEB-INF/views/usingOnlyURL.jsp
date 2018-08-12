<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form name="f" action="${url}" method="post">
	<input type="hidden" name="evnum" value="${param.evnum}">
</form>
<script type="text/javascript">
document.f.submit()
</script>