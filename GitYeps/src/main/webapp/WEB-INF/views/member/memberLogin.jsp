<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css?ver=1" />
<script src="//code.jquery.com/jquery.min.js?ver=1"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=1"></script>
	
<script type="text/javascript">
	var mode = "${param.mode}";
	$(function() { 
		if(mode == 'signup'){
			$("#login").hide();
			$('#join').show();
		}else{
			$("#login").show();
			$('#join').hide();
		}
	});
		//------------------------------------회원가입
		function focusSsn2(mode){
			if(mode=='join'){
		 		if(document.joinf.ssn1.value.length==6){
			 		document.joinf.ssn2.focus();
		 		}
		 		document.joinf.ssn1.value=document.joinf.ssn1.value.replace(/[^0-9]/g,'')
			}else if(mode=='findpasswd'){
		 		if(document.findpasswdf.ssn1.value.length==6){
			 		document.findpasswdf.ssn2.focus();
		 		}
		 			document.findpasswdf.ssn1.value=document.findpasswdf.ssn1.value.replace(/[^0-9]/g,'')
			}else if(mode=='findemail'){
		 		if(document.findemailf.ssn1.value.length==6){
			 		document.findemailf.ssn2.focus();
		 		}
		 		document.findemailf.ssn1.value=document.findemailf.ssn1.value.replace(/[^0-9]/g,'')
			}
		}
			 
		function numberOnly(){
			if(event.keyCode < 47 || event.keyCode > 58 || event.keyCode>=96 && event.keyCode<=105){
				return false; 
			}
		}
		
		function checkPw(){
			if(document.joinf.passwd.value == '' || document.joinf.passwd2.value == ''){
				document.joinf.passCheck.value=""
			}else{
				if(document.joinf.passwd.value == document.joinf.passwd2.value){
					document.joinf.passCheck.value="패스워드가 일치합니다";
					document.joinf.passCheck.style.color = "blue";
				}else{
					document.joinf.passCheck.value="패스워드가 일치하지않습니다";
					document.joinf.passCheck.style.color = "red";
				}
			}
		}
	
		function change_email(email3){
			if(email3 == '0'){
				document.joinf.email2.readOnly = false;
				document.joinf.email2.value = "";
				document.joinf.email2.focus();
			} else{
				document.joinf.email2.readOnly = true;
				document.joinf.email2.value = email3;
			}
			$('#emailpicker-div').hide();
			inputEmailChk();
		}
		
		function openConfirmEmail(){
			if(document.joinf.email1.value=="" || document.joinf.email2.value==""){
				alert("이메일주소를 입력해주세요")
				document.joinf.email1.focus()
				return
			}
			var email = document.joinf.email1.value+"@"+document.joinf.email2.value;
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if(exptext.test(email)==false){
				//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
				alert("이메일형식이 올바르지 않습니다.");
				document.joinf.email2.focus();
				return
			}
			var popupX = (window.screen.width/2)-(400/2);
			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
			var popupY= (window.screen.height/2)-(450/2);
			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
			url = "member_confirmEmail?email=" + email;
			open(url, "confirm", 'status=no, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=400, height=450,left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
		}
			 
		function inputEmailChk(){
			document.joinf.idDuplication.value="idUncheck"
				document.joinf.mailCheck.value="*이메일 중복 확인";
		}
		
		function check(){
			if(document.joinf.name.value==""){
				alert("이름을 입력해주세요")
				document.joinf.name.focus()
				return
			}
					
			var ck=0; 
			// 처음 7자 검사
			if (document.joinf.ssn1.value.length != 6 || document.joinf.ssn2.value.length != 7 || document.joinf.ssn1.value.substring(0,2) < 20 || document.joinf.ssn1.value.substring(2,4) < 1 || document.joinf.ssn1.value.substring(2,4) > 12 || document.joinf.ssn1.value.substring(4,6) < 0 || document.joinf.ssn1.value.substring(4,6) > 31 || document.joinf.ssn2.value.substring(0,1) > 2 || document.joinf.ssn2.value.substring(0,1) < 1) {
				alert("주민등록번호를 정확히 입력해주세요.");
				document.joinf.ssn1.value = document.joinf.ssn2.value="";
				document.joinf.ssn1.focus();
				return;
			}
			//끝자리 검증번호 유효성 검사
			var total = document.joinf.ssn1.value + document.joinf.ssn2.value;
			for (i=0; i < 12; i++) {
				ck  += (i%8+2)*total.substring(i, i+1);
			}
			ck = (11-(ck%11))%10;
			if (parseInt(ck) != parseInt(total.substring(12, 13))) {
				alert("잘못된 주민등록번호입니다. 다시 확인해주세요.");
				document.joinf.ssn1.value = document.joinf.ssn2.value="";
				document.joinf.ssn1.focus();
				return;
			}
			 		
			if(document.joinf.email1.value==""){
				alert("이메일주소를 입력해주세요")
				document.joinf.email1.focus()
				return
			}
			if(document.joinf.email2.value==""){
				alert("이메일주소를 입력해주세요")
				document.joinf.email2.focus()
				return
			}
			var email = document.joinf.email1.value+"@"+document.joinf.email2.value;
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if(exptext.test(email)==false){
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
				alert("이메일형식이 올바르지 않습니다.");
				document.joinf.email2.focus();
				return
			}
			if(document.joinf.idDuplication.value!="idCheck"){
				alert("이메일 중복체크를 해주세요")
				document.joinf.email1.focus()
				return
			}
			if(document.joinf.passwd.value==""){
				alert("패스워드를 입력해주세요")
				document.joinf.passwd.focus()
				return
			}
			if(document.joinf.passwd.value != document.joinf.passwd2.value){
				alert("입력하신 패스워드와 패스워드 확인이 일치하지 않습니다")
				return
			}
			if(document.joinf.passwd.value.length<6) {
				alert("비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를 사용하여 6~16자까지 입력해주세요")
				return
			}
			if(!document.joinf.passwd.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
				alert("비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를 사용하여 6~16자까지 입력해주세요")
				return
			}
			document.joinf.submit()
		}
		
		//------------------------------------로그인
		function loginCheck(){
			if(loginf.email.value==""){
				alert("아이디를 입력해주세요");
				loginf.email.focus();
				return false;
			}
			if(loginf.passwd.value==""){
				alert("비밀번호를 입력해주세요");
				loginf.passwd.focus();
				return false;
			}
			document.loginf.submit();
		}
		   	 
		$(document).ready(function() {
			$('.signup-link').click(function() {
				if($("#login").css("display") == "none"){
					$("#login").show();
					$('#join').hide();
				}else{
					$("#login").hide();
					$('#join').show();
				}
			});
		         
			$('.login-link').click(function() {
				$("#login").show();
				$("#find_passwd").hide();
				$('#find_email').hide();
			});
		         
			$('.forgot-email-link').click(function() {
				$("#login").hide();
				$("#find_passwd").hide();
				$('#find_email').show();
			});
		
			$('.forgot-passwd-link').click(function() {
				$("#login").hide();
				$('#find_email').hide();
				$('#find_passwd').show();
			});
		         
			$('#member_email2').click(function(){
				$('#emailpicker-div').toggle();
			})
		         
			$(document).mouseup(function (e){
				var container=$("#emailpicker-div");
				if(container.has(e.target).length===0){
				container.hide(); 
				}
			})
		});
		   	 
		//------------------------------------이메일 찾기
		function findEmailCheck(){
			if(findemailf.name.value==""){
				alert("이름을 입력해주세요.");
				findemailf.name.focus();
				return false;
			}
			if (findemailf.ssn1.value.length != 6 || findemailf.ssn2.value.length != 7 || findemailf.ssn1.value.substring(0,2) < 20 || findemailf.ssn1.value.substring(2,4) < 1 || findemailf.ssn1.value.substring(2,4) > 12 || findemailf.ssn1.value.substring(4,6) < 0 || findemailf.ssn1.value.substring(4,6) > 31 || findemailf.ssn2.value.substring(0,1) > 2 || findemailf.ssn2.value.substring(0,1) < 1) {
				alert("주민등록번호를 정확히 입력해주세요.");
				findemailf.ssn1.value = findemailf.ssn2.value="";
				findemailf.ssn1.focus();
				return false;
			}
			var popupX = (window.screen.width/2)-(400/2);
			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
			var popupY= (window.screen.height/2)-(340/2);
			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
			window.open("", "findEmail", 'status=no, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=400, height=340, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
			frm = document.findemailf;
			frm.action = "member_findEmail";
			frm.target = "findEmail";
			frm.submit;
		}
		   	
		//------------------------------------비밀번호찾기
		function findPasswdCheck(){
			if(findpasswdf.name.value==""){
				alert("이름을 입력해주세요.");
				findpasswdf.name.focus();
				return false;
			}
			if (findpasswdf.ssn1.value.length != 6 || findpasswdf.ssn2.value.length != 7 || findpasswdf.ssn1.value.substring(0,2) < 20 || findpasswdf.ssn1.value.substring(2,4) < 1 || findpasswdf.ssn1.value.substring(2,4) > 12 || findpasswdf.ssn1.value.substring(4,6) < 0 || findpasswdf.ssn1.value.substring(4,6) > 31 || findpasswdf.ssn2.value.substring(0,1) > 2 || findpasswdf.ssn2.value.substring(0,1) < 1) {
				alert("주민등록번호를 정확히 입력해주세요.");
				findpasswdf.ssn1.value = findpasswdf.ssn2.value="";
				findpasswdf.ssn1.focus();
				return false;
			}
			if(findpasswdf.email.value==""){
				alert("아이디를 입력해주세요.");
				findpasswdf.email.focus();
				return false;
			}
			var popupX = (window.screen.width/2)-(400/2);
			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
			var popupY= (window.screen.height/2)-(340/2);
			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
			window.open("", "findPasswd", 'status=no, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=400, height=340, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
			frm = document.findpasswdf;
			frm.action = "member_findPasswd";
			frm.target = "findPasswd";
			frm.submit;
		}
	</script>
</head>
<%@ include file="../top.jsp"%>
	<div id="super_container">
		<div id="Membercontainer">
			<div id="Memberbody">
				<div id="member-wrapper">
					<div id="login" align="center"> <!-- 로그인 Div -->
						<div id="member_header">
							<h2>Log In to YEPS</h2>
							<p class="subheading">New to YEPS? 
							<a class="signup-link u-pseudo-link">Sign up</a>
							<p class="legal-copy">By logging in, you agree to YEPS 
							<a class="legal-link" href="#">Terms of Service</a>
								and <a class="legal-link" href="#">Privacy Policy</a>.
							</p>
						</div>

						<div id="member_body">
							<form name="loginf" class="memberf" action="member_login" method="POST" onsubmit="return loginCheck()">
								<input type="hidden" id="old_url" name="old_url" value="${old_url}">
								<input id="email" name="email" placeholder="Email" required="required" type="email" autocomplete=off value=""> 
								<input id="passwd" name="passwd" placeholder="Password" required="required" type="password" autocomplete=off value="">
								<div id="forgot-email">
									<small><a class="forgot-email-link">Forgot e-mail?</a></small>
								</div>
								<div id="forgot-passwd">
									<small><a class="forgot-passwd-link">Forgot password?</a></small>
								</div>
								<button type="submit" value="submit" class="ybtn ybtn-primary ybtn-big ybtn-full">
									<span>Log In</span>
								</button>
								<div class="sub-text-box">
									<small class="subtle-text">New to YEPS? 
									<a class="signup-link u-pseudo-link">Sign up</a></small>
								</div>
							</form>
						</div>
					</div>
					
					<div id="join" align="center"> <!-- 회원가입 Div -->
						<div id="member_header">
							<h2>Sign Up for YEPS</h2>
							<p class="subheading">Connect with great local businesses</p>
							<p class="legal-copy">By signing up, you agree to YEPS 
							<a class="legal-link" href="https://www.yelp.com/static?p=tos">Terms of Service</a> and 
							<a class="legal-link" href="/tos/privacy_en_us_20160131">Privacy Policy</a>.
							</p>
						</div>
						
						<div id="member_body">
							<form name="joinf" class="memberf" method="POST" action="member_join">
								<input name="name" placeholder="이름" required="required" type="text" autocomplete=off value="">
								<ul class="inline-layout">
									<li><input id="memberssn1"onkeypress="return numberOnly();" onkeyup="focusSsn2('join')" maxlength="6" placeholder="주민번호 앞자리" required="required" type="text" name="ssn1" autocomplete=off value="" /></li>
									<li><input id="memberssn2" onkeypress="return numberOnly();" maxlength="7" placeholder="주민번호 뒷자리" required="required" type="password" name="ssn2" value="" /></li>
								</ul>
								<ul class="inline-layout">
									<li style="width: 45%"><input name="email1" maxlength="20" placeholder="이메일" required="required" onkeydown="inputEmailChk()" type="text" autocomplete=off value=""></li>
									<li style="width: 55%">
										<div id="member_email2">
											<div class="member_email2_input" style="position: relative; float: left; vertical-align: middle;">
												<span class="member_at" aria-hidden="true" style="position: relative; vertical-align: middle;">
													<label style="margin: 7px 0 0 10px; diplay: block; height: 18px; position: absolute;">@</label> </span> 
												<span> 
													<input type="text" id="member_email2_input" name="email2" maxlength="30" required="required" onkeydown="inputEmailChk()" autocomplete=off style="padding-left: 30px;">
												</span>
											</div>
										</div>
									</li>
								</ul>
								<ul class="inline-layout">
									<li style="width: 70%; margin-top: -8px;"><input id="mailCheck" type="text" name="mailCheck" value="*이메일 중복 확인" readOnly></li>
									<li style="width: 30%;"><input id="confirmemailbtn" type="button" name="confirm_email" class="confirmbtn confirmbtn-primary confirmbtn-full" value="중복확인" onclick="openConfirmEmail()"></li>
								</ul>

								<input type="hidden" name="idDuplication" value="idUncheck">
								<input id="passwd" name="passwd" placeholder="패스워드" required="required" type="password" maxlength="20" onkeyup="checkPw()"> 
								<input id="passwd2" name="passwd2" placeholder="패스워드 확인" required="required" type="password" maxlength="20" onkeyup="checkPw()"> 
								<input id="passwdcheck" type="text" name="passCheck" readOnly>
								<button id="signup-button" type="button" value="Sign Up" onclick="check()" class="ybtn ybtn-primary ybtn-big ybtn-full">
									<span>Sign Up</span>
								</button>
							</form>
							<div class="sub-text-box">
								<small class="subtle-text">Already on Yelp? 
								<a class="signup-link u-pseudo-link">Log in</a></small>
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
						</div>
					</div>
					
					<div id="find_email" align="center"> <!-- 이메일찾기 Div -->
						<div id="member_header">
							<h2>Forgot Email</h2>
							<p>Please enter your profile and we will let you know your email address.</p>
						</div>
						<div id="member_body">
							<form name="findemailf" class="findemailf" method="POST" onsubmit="return findEmailCheck()">
								<input id="name" name="name" placeholder="이름" required="required" type="text" autocomplete=off value="">
								<ul class="inline-layout">
									<li><input id="memberssn1" onkeypress="return numberOnly();" onkeyup="focusSsn2('findemail')" maxlength="6" placeholder="주민번호 앞자리" required="required" type="text" name="ssn1" autocomplete=off value="" /></li>
									<li><input id="memberssn2" onkeypress="return numberOnly();" maxlength="7" placeholder="주민번호 뒷자리" required="required" type="password" name="ssn2" value="" /></li>
								</ul>
								<div id="forgot-email">
									<small><a class="forgot-passwd-link">Forgot password?</a></small>
								</div>
								<button type="submit" value="submit" class="ybtn ybtn-primary ybtn-big ybtn-full">
									<span>Find Email</span>
								</button>
								<div class="sub-text-box">
									<small class="subtle-text">
									<a class="login-link u-pseudo-link">Back to Login</a></small>
								</div>
							</form>
						</div>
					</div>
					
					<div id="find_passwd" align="center"> <!-- 비밀번호찾기 Div -->
						<div id="member_header">
							<h2>Forgot Password</h2>
							<p>Please enter your profile and we will send you an email about your changed password.</p>
						</div>
						<div id="member_body">
							<form name="findpasswdf" class="findpasswdf" method="POST" onsubmit="return findPasswdCheck()">
								<input id="name" name="name" placeholder="이름" required="required" type="text" value="">
								<ul class="inline-layout">
									<li><input id="memberssn1" onkeypress="return numberOnly();" onkeyup="focusSsn2('findpasswd')" maxlength="6" placeholder="주민번호 앞자리" required="required" type="text" name="ssn1" autocomplete=off value="" /></li>
									<li><input id="memberssn2" onkeypress="return numberOnly();" maxlength="7" placeholder="주민번호 뒷자리" required="required" type="password" name="ssn2" value="" /></li>
								</ul>
								<input id="email" name="email" placeholder="이메일" required="required" type="email" autocomplete=off value="">
								<div id="forgot-email">
									<small><a class="forgot-email-link">Forgot e-mail?</a></small>
								</div>
								<button type="submit" value="submit" class="ybtn ybtn-primary ybtn-big ybtn-full">
									<span>Reset Password</span>
								</button>
								<div class="sub-text-box">
									<small class="subtle-text">
										<a class="login-link u-pseudo-link">Back to Login</a>
									</small>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div id="login_img">
					<img src="https://s3-media4.fl.yelpcdn.com/assets/2/www/img/1e82406ff345/signup/signup_illustration.png">
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../bottom.jsp"%>