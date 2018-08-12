<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<html>
<head>
<title>Email 중복확인</title>
<link rel="stylesheet" type="text/css"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css?ver=1" />
<script src="//code.jquery.com/jquery.min.js?ver=1"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=1"></script>

<script type="text/javascript">
	function change_email(email3){
		if(email3 == '0'){
			checkForm.email2.readOnly = false;
			checkForm.email2.value = "";
			checkForm.email2.focus();
		}else{
			checkForm.email2.readOnly = true;
			checkForm.email2.value = email3;
		}	
	
		$('#confirmemail #emailpicker-div').hide();
		inputEmailChk();
	}
	
	function confirmEmail(){
		if(checkForm.email1.value=="" || checkForm.email2.value==""){
			alert("이메일주소를 입력해주세요")
			checkForm.email1.focus()
			return false;
		}
		var email = checkForm.email1.value+"@"+checkForm.email2.value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(exptext.test(email)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			alert("이메일형식이 올바르지 않습니다.");
			document.checkForm.email2.focus();
			return false;
		}
		return true;
	}
	
	function resetEmail(){
		opener.inputEmailChk()
		opener.document.join.email1.value="";
		opener.document.join.email2.value="";
		self.close();
	}
	
	function openEmailAuthCheck(){
		var popupX = (window.screen.width/2)-(300/2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height/2)-(300/2);
		// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		window.open("", "emailAuth", 'status=no, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=300,left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
		frm = document.emailauthf;
		frm.action = "member_emailAuth";
		frm.target = "emailAuth";
		frm.method = "POST";
		frm.submit;
	}
	
	$(document).ready(function() {
		$('#confirmemail #member_email2').click(function(){
			$('#confirmemail #emailpicker-div').toggle();
		})
        
		$(document).mouseup(function (e){
			var container=$("#confirmemail #emailpicker-div");
			if(container.has(e.target).length===0){
				container.hide(); 
			}
		})
	});
</script>
</head>
<body>
	<c:choose>
		<c:when test="${isMember==1}">
			<form id="confirmemail" name="checkForm" action="member_confirmEmail" onsubmit="confirmEmail()">
				<div id="confirmemail_yes_head">
					<p class="subemail">${email}</p>
					<p class="subused">은 이미 사용중인 이메일입니다.</p>
					<p class="subused">다른 이메일을 입력해주세요.</p>
					<ul class="inline-layout">
						<li style="width: 45%">
							<input name="email1" maxlength="20" placeholder="이메일" required="required" onkeydown="inputEmailChk()" autocomplete=off type="text" value=""></li>
						<li style="width: 55%">
							<div id="member_email2">
								<div class="member_email2_input" style="position: relative; float: left; vertical-align: middle;">
									<span class="member_at" aria-hidden="true" style="position: relative; vertical-align: middle;"> 
										<label style="margin: 7px 0 0 10px; diplay: block; height: 18px; position: absolute;">@</label>
									</span> 
									<span> 
										<input type="text" id="member_email2_input" name="email2" maxlength="30" required="required" onkeydown="inputEmailChk()" autocomplete=off style="padding-left: 30px;">
									</span>
								</div>
							</div>
						</li>
					</ul>
				</div>
				<div id="confirmemail_yes_body">
					<input type="submit" name="confirm_email" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="중복확인"> 
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="취소" onclick='self.close()'>
				</div>

				<div id="emailpicker-div">
					<ul>
						<li id="email3" onclick="change_email('0')">직접 입력</li>
						<li id="email3" onclick="change_email('gmail.com')">gmail.com</li>
						<li id="email3" onclick="change_email('hanmail.net')">hanmail.net</li>
						<li id="email3" onclick="change_email('naver.com')">naver.com</li>
						<li id="email3" onclick="change_email('nate.com')">nate.com</li>
						<li id="email3" onclick="change_email('korea.com')">korea.com</li>
						<li id="email3" onclick="change_email('yahoo.com')">yahoo.com</li>
						<li id="email3" onclick="change_email('hotmail.com')">hotmail.com</li>
						<li id="email3" onclick="change_email('chol.com')">chol.com</li>
						<li id="email3" onclick="change_email('netian.com')">netian.com</li>
						<li id="email3" onclick="change_email('dreamwiz.com')">dreamwiz.co</li>
						<li id="email3" onclick="change_email('live.com')">live.com</li>
					</ul>
				</div>
			</form>
		</c:when>
		<c:otherwise>
			<form id="confirmemail" name="emailauthf" method="POST" onsubmit="return openEmailAuthCheck()">
				<div id="confirmemail_no_head">
					<p class="subemail">${email}</p>
					<p class="subused">은 사용 할 수 있는 Email입니다.</p>
					<p class="subused">인증메일 받기 버튼을 클릭해주세요.</p>
				</div>
				<div id="confirmemail_no_body">
					<input type="hidden" name="email" value="${email}"> 
					<input type="submit" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="인증메일 받기"> 
					<input type="button" class="confirmemailbtn confirmbtn-primary confirmbtn-big confirmbtn-full" value="취소" onclick='self.close()'>
				</div>
			</form>
		</c:otherwise>
	</c:choose>
</body>
</html>