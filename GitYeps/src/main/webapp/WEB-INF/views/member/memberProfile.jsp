<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<html>
<head>
   <title>profile</title>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css?ver=3"/>"/>
   <script src="//code.jquery.com/jquery.min.js?ver=1"></script>
   <script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=1"></script>
</head>
<%@ include file="../top.jsp"%>
	<div class="profile-content-wrap">
		<div class="profile-container">                    
			<div class="profile-settings-container">
				<div class="profile-column-alpha">
					<div class="profile-title-menus">
						<div class="profile-title-header">
							<div class="profile-titled-header_content">
                    			<h3>
                    				<c:set value="${sessionScope.memberinfo.name}" var="memberName"/>
                    				<c:choose>
                    					<c:when test="${fn:length(memberName) > 7}">
                    						<c:out value="${fn:substring(memberName,0,6)}"/>..
                    					</c:when>
                    					<c:otherwise>
                    						<c:out value="${memberName}"/>
                    					</c:otherwise> 
                    				</c:choose>
                    			’s Account Settings
                    			</h3>
                			</div>
						</div>
						
						<ul class="profile-nav_items">
							<li class="profile-nav_item">
								<a id="profile-link" class="profile-nav_link">
									<div class="profile-nav_link-content profile-arrange">
										<div class="profile-arrange_unit profile-arrange_unit--fill">
											<span class="profile-nav_link-label">프로필 수정</span>
										</div>
									</div>
								</a>
							</li>
							<li class="profile-nav_item">
								<a id="passwd-link" class="profile-nav_link">
									<div class="profile-nav_link-content profile-arrange">
										<div class="profile-arrange_unit profile-arrange_unit--fill">
											<span class="profile-nav_link-label">비밀번호 변경</span>
										</div>
									</div>
								</a>
							</li>
							<li class="profile-nav_item">
								<a id="memberleave-link" class="profile-nav_link">
									<div class="profile-nav_link-content profile-arrange">
										<div class="profile-arrange_unit profile-arrange_unit--fill">
											<span class="profile-nav_link-label">회원 탈퇴</span>
										</div>
									</div>
								</a>
							</li>
						</ul>
					</div>
					<div class="titled-nav-header" role="presentation"></div>
				</div>
				
				<div class="profile-column-beta_profile">
					<div class="profile-section-header">
        				<h2>Profile</h2>
    				</div>
    				
    				<form action="member_profile" class="profilef" method="post" name="memberProfile">
						<div class="psection">
							<c:choose>
								<c:when test="${empty mainPhoto}">
									<h4>Your Profile Photo
										<strong><a href="member_photos">(Add/Edit)</a></strong>
									</h4>
									<div class="photo-box pb-m">
										<a class="js-analytics-click" data-analytics-label="user-photo" href="member_photos">
											<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png">
										</a>
									</div>
								</c:when>
								<c:otherwise>
									<h4>Your Profile Photo
										<strong><a href="member_photolist?mnum=${sessionScope.memberinfo.mnum}">(Add/Edit)</a></strong>
									</h4>
									<div class="photo-box pb-m">
										<a class="js-analytics-click" data-analytics-label="user-photo" href="member_photolist?mnum=${sessionScope.memberinfo.mnum}">
											<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${mainPhoto.member_filename}" alt="member_main_photo" id="photo_box_img" width="100px" height="100px">
										</a>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<label for="name">Name</label>
						<span class="help-block">This field is required.</span>
						<input id="name" maxlength="20" name="name" required placeholder=" " type="text" value="${sessionScope.memberinfo.name}">
						<label for="nickname">Nickname</label>
						<span class="help-block">The Boss, Calamity Jane, The Prolific Reviewer</span>
						<input id="nickname" maxlength="20" name="nickname" placeholder=" " type="text" autocomplete=off value="${sessionScope.memberinfo.nickname}">
						<label for="address">Address</label>
						<span class="help-block">Where do you live?</span>
						<input id="address" maxlength="70" name="address" placeholder=" " type="text" autocomplete=off value="${sessionScope.memberinfo.address}" onclick="goPopup();" readonly>
						<button type="submit" value="submit" class="ybtn ybtn-primary"><span>Save Changes</span></button>
						<a href="member_index">Cancel</a>
					</form>
				</div>
				
				<div class="profile-column-beta_passwd">
					<div class="profile-section-header">
        				<h2>Password</h2>
    				</div>
    				
    				<form action="member_password" class="profilef" method="post" name="memberPasswd">
						<label for="passwd">현재 비밀번호</label>
						<span class="help-block">This field is required.</span>
						<input id="passwd" maxlength="20" name="passwd" required="required" placeholder="현재 비밀번호" size="30" type="password" value="">
						<label for="passwd-Change">변경할 비밀번호</label>
						<span class="help-block">This field is required.</span>
						<input id="passwd1" name="passwd1" placeholder="변경할 비밀번호" required="required" type="password" maxlength="20" onkeyup="checkPw()"> 
						<input id="passwd2" name="passwd2" placeholder="변경할 비밀번호 확인" required="required" type="password" maxlength="20" onkeyup="checkPw()">
						<input id="passwdcheck" type="text" name="passCheck" readOnly> 
						<button type="button" onclick="check()" class="ybtn ybtn-primary"><span>Save Changes</span></button>
						<a href="member_index">Cancel</a>
					</form>
				</div>
				
				<div class="profile-column-beta_memberleave">
					<div class="profile-section-header">
        				<h2>Member Leave</h2>
    				</div>
    				
    				<form action="member_leave" class="profilef" method="post" name="memberLeave">
						<label for="passwd">비밀번호를 입력해주세요.</label>
						<span class="help-block">This field is required.</span>
						<input id="passwd" maxlength="20" name="passwd" required="required" placeholder="비밀번호" size="30" type="password" value="">
						<button type="button" onclick="memberleave()" class="ybtn ybtn-primary"><span>Member leave</span></button>
						<a href="member_index">Cancel</a>
					</form>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	var mode = "${param.mode}";
	$(function() { 
		if(mode == 'passwd'){
			$(".profile-column-beta_passwd").show();
			$(".profile-column-beta_profile").hide();
			$(".profile-column-beta_memberleave").hide();
			$('.profile-nav_items > li > a').removeClass('is-active');
	        $('#passwd-link').addClass('is-active');
		}else if(mode == 'memberleave'){
			$(".profile-column-beta_memberleave").show();
			$(".profile-column-beta_passwd").hide();
			$(".profile-column-beta_profile").hide();
			$('.profile-nav_items > li > a').removeClass('is-active');
	        $('#memberleave-link').addClass('is-active');
		}else{
			$(".profile-column-beta_profile").show();
        	$(".profile-column-beta_passwd").hide();
        	$(".profile-column-beta_memberleave").hide();
        	$('.profile-nav_items > li > a').removeClass('is-active');
            $('#profile-link').addClass('is-active');
		}
	});

	function checkPw(){
		if(document.memberPasswd.passwd1.value == '' || document.memberPasswd.passwd2.value == ''){
			document.memberPasswd.passCheck.value=""
		}else{
			if(document.memberPasswd.passwd1.value == document.memberPasswd.passwd2.value){
				document.memberPasswd.passCheck.value="패스워드가 일치합니다";
				document.memberPasswd.passCheck.style.color = "blue";
			}else{
				document.memberPasswd.passCheck.value="패스워드가 일치하지않습니다";
				document.memberPasswd.passCheck.style.color = "red";
			}
		}
	}
	
	function check(){
		if(document.memberPasswd.passwd.value==""){
			alert("패스워드를 입력해주세요")
			document.memberPasswd.passwd.focus()
			return
		}
		if(document.memberPasswd.passwd1.value==""){
			alert("패스워드를 입력해주세요")
			document.memberPasswd.passwd1.focus()
			return
		}
		if(document.memberPasswd.passwd2.value==""){
			alert("패스워드를 입력해주세요")
			document.memberPasswd.passwd2.focus()
			return
		}
		if(document.memberPasswd.passwd1.value != document.memberPasswd.passwd2.value){
			alert("입력하신 패스워드와 패스워드 확인이 일치하지 않습니다")
			return
		}
		if(document.memberPasswd.passwd1.value.length<6) {
			alert("비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를 사용하여 6~16자까지 입력해주세요")
			return
		}
		if(!document.memberPasswd.passwd1.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
			alert("비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를 사용하여 6~16자까지 입력해주세요")
			return
		}
		document.memberPasswd.submit()
	}
	
	function memberleave() {
		if(document.memberLeave.passwd.value==""){
			alert("패스워드를 입력해주세요")
			document.memberLeave.passwd.focus()
			return
		}
		
		if(confirm("정말 YEPS를 탈퇴하시겠습니까?")){
			document.memberLeave.submit();
		}else{
			return
		}
		return
	}
	
	
	$(document).ready(function(){
        $('.profile-nav_items > li > a').click(function( e ){
           $('.profile-nav_items > li > a').removeClass('is-active');
           $(this).addClass('is-active');
        })
        
        $('#profile-link').click(function(e){
        	$(".profile-column-beta_profile").show();
        	$(".profile-column-beta_passwd").hide();
        	$(".profile-column-beta_memberleave").hide();
        })
        
        $('#passwd-link').click(function(e){
        	$(".profile-column-beta_passwd").show();
        	$(".profile-column-beta_profile").hide();
        	$(".profile-column-beta_memberleave").hide();
        })
        
        $('#memberleave-link').click(function(e){
        	$(".profile-column-beta_memberleave").show();
        	$(".profile-column-beta_passwd").hide();
        	$(".profile-column-beta_profile").hide();
        })
     });
	
	function goPopup() {
		var pop = window.open("jusoPopup", "도로명 주소","width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(roadAddrPart1, addrDetail, roadAddrPart2, zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다
		var address = "[" + zipNo + "]" + " " + roadAddrPart1 + " " + roadAddrPart2 + " " + addrDetail;
		document.memberProfile.address.value = address;
		
	}
</script>

<%@include file="../bottom.jsp"%>