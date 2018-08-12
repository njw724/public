<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<script src="//code.jquery.com/jquery.min.js?ver=1"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=1"></script>
<script type="text/javascript">
	function numCheck(authNum,email1,email2){
		if(!authenform.authnum.value){
			alert("인증번호를 입력하세요");
			return false;
		}
		if(authenform.authnum.value!=authNum){
			alert("틀린 인증번호입니다. 인증번호를 다시 입력해주세요");
			authenform.authnum.value="";
			return false;
		}
		if(authenform.authnum.value==authNum){
			setEmail(email1,email2);
		}
	}
	
	function setEmail(email1,email2){
		opener.opener.document.joinf.email1.value=email1;
		opener.opener.document.joinf.email2.value=email2;
		opener.opener.document.joinf.idDuplication.value="idCheck";
		opener.opener.document.joinf.mailCheck.value="이메일 인증완료";
		opener.close();
		self.close();
	}
</script>

<body>
	<div id="email_auth">
		<div id="email_auth_top">
			<p class="auth_top">인증번호 7자리를 입력하세요.</p>
		</div>
		<form id="email_auth_middle" method="post" name="authenform">
			<ul class="inline-layout">
				<li style="width: 70%;">
					<input type="text" name="authnum" placeholder="인증번호 입력" autocomplete=off onkeypress="if(event.keyCode==13){return false;}">
				</li>
			</ul>
		</form>
		<div id="email_auth_bottom">
			<input type="button" value="인증번호 확인" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" onclick="numCheck('${authNum}','${email1}','${email2}');"> 
			<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="취소" onclick='self.close()' style="margin-top: -10px;">
		</div>
	</div>
</body>