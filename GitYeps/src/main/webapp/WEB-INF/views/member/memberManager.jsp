<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Yeps - Managed Page</title>
<script src="//code.jquery.com/jquery.min.js?ver=1"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=1"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css?ver=7"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/qna.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/magic-check.css"/>"/>

</head>
<%@ include file="../top.jsp"%>
	<div class="main-content-wrap--full">
		<div class="top-shelf top-shelf-grey sat-top-shelf">
			<div class="content-container">
				<div class="container">
					<div class="clearfix layout-block layout-n column--responsive">
						<div class="column column-alpha column--responsive">
							<img alt="Yelp Support Center" class="sc-top-shelf-illustration responsive-visible-large-block" src="https://s3-media3.fl.yelpcdn.com/assets/2/www/img/3d4cc7502e4d/support/support-darwin.png">
						</div>
						<div class="column column-beta column--responsive">
							<div class="sc-top-shelf-search-block">
								<div class="sc-search-form-container">
									<form name="member_manger_f" action="manager_managerPage" class="member_manager_form arrange arrange--6 arrange--stack-small sc-search-form" method="post">
										<div class="arrange_unit arrange_unit--fill sc-search-field">
											<select name="search" class="search">
												<option value="email">이메일</option>
												<option value="name">이름</option>
												
											</select>
											<input name="searchString" class="searchString" placeholder="What can we help you with?" type="text" value="" autocomplete=off>
											<button class="member_managerbtn member_managerbtn-primary" type="submit" value="submit">
												<span>
													<span class="i-wrap ig-wrap-common_sprite i-search-common_sprite-wrap">
														<i class="i ig-common_sprite search-common_sprite"></i> Search
													</span>
												</span>
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="memberManager">
		<div class="memberManagerContainer_wrap">
			<div class="memberManagerContainer">
				<div class="memberManagerContainer_section_header">
					<h2>
						YEPS's Members
					</h2>
				</div>
				<div class="memberManagerContainer_section">
					<c:choose>
						<c:when test="${empty memberProfile}">
							<h3 class="subscribe-list_title">Who's in?</h3>
							<div class="memberManagerContainer_section_member_wrap">
								<c:choose>
									<c:when test="${empty map.listMember}">
										<div class="not_found_member">
											<h3 class="subscribe-list_title">Not found Member</h3>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach var="dto" items="${map.listMember}" varStatus="status">
											<div class="memberManagerContainer_section_member">
												<div class="member_passport">
													<div class="member_avater">
														<div class="member_photo_box">
															<a href="member_manager?mnum=${dto.mnum}" class="js-analytics-click" data-analytics-label="user-photo">
																<c:choose>
																	<c:when test="${empty map.listMemberPhoto[status.index].member_filename}">
																		<img class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png" width="60" style="border-radius: 4px;">
																	</c:when>
																	<c:otherwise>
																		<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${map.listMemberPhoto[status.index].member_filename}" style="border-radius: 4px;" alt="member_main_photo" id="photo_box_img" width="60px" height="60px">
																	</c:otherwise>
																</c:choose>
															
																
															</a>
														</div>
													</div>
													<div class="member_story">
														<ul class="user-passport-info">
															<li class="user-name">
																<a class="user-display-name js-analytics-click" href="member_manager?mnum=${dto.mnum}" data-hovercard-id="mNnbq24hI6DxMOQ0JLFrnQ" data-analytics-label="about_me" id="dropdown_user-name">
																	<strong class="unit_hover">
																		<c:set value="${dto.name}" var="memberName"/>
					            										<c:choose>
				            												<c:when test="${fn:length(memberName) > 7}">
								                    							<c:out value="${fn:substring(memberName,0,6)}"/>..
				            												</c:when>
				            												<c:otherwise>
				            													<c:out value="${memberName}"/>
				            												</c:otherwise> 
				            											</c:choose>
																	</strong>
																</a>
															</li>
															<li class="user-location responsive-hidden-small">
																<c:if test="${empty dto.address}">
																	<b>Korea, seoul</b>
																</c:if>
																<b>
																	<c:forTokens items="${dto.address}" delims=" " begin="1" end="2" var="addr">
																		${addr}
																	</c:forTokens>
																</b>
															</li>
														</ul>
														<ul class="user-passport-stats">
<!-- 															<li class="friend-count"> -->
<!-- 																<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-friends icon--size-18"> -->
<!-- 																	<svg class="icon_svg"> -->
<!-- 																		<path d="M7.904 9.43l-2.098 4.697a.9.9 0 0 1-1.612 0L2.096 9.43a.902.902 0 0 1 .806-1.305h4.196c.67 0 1.105.705.806 1.305zM5 7.375a2 2 0 1 1 0-4 2 2 0 0 1 0 4z"></path> -->
<!-- 																		<path d="M15.904 9.43l-2.098 4.697a.89.89 0 0 1-.806.498.89.89 0 0 1-.806-.498L10.096 9.43a.902.902 0 0 1 .806-1.305h4.195c.67 0 1.106.705.807 1.305zM13 7.375a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" opacity=".502"></path> -->
<!-- 																	</svg> -->
<!-- 																</span> -->
<!-- 																<b>0</b> friends	친구 수 -->
<!-- 															</li> -->
															<li class="review-count">
																<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-review icon--size-18">
																	<svg class="icon_svg">
																		<path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
																	</svg>
																</span>
																<b>${dto.reviewcount}</b> reviews <!-- 리뷰 수 -->
															</li>
														</ul>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
							
							
							
							
							<div class="event_list_paging_section" style="font-size: 14px;margin: 0 auto; padding: 15px 15px; width: 960px;">
			<div class="event_list_pagination_block">
				<div class="event_list_pagination_wrap">
					<div class="event_list_page_of_pages">
						<c:if test="${yepsPager.blockEnd == 0}">
							Page ${curPage} of 1
						</c:if>
						<c:if test="${yepsPager.blockEnd != 0}">
							Page ${curPage} of ${yepsPager.blockEnd}
						</c:if>
					</div>
<!-- 					페이징 처리!! 현재페이지는 span이 되고 나머지는 a로 -->
					<c:if test="${yepsPager.blockEnd != 1}">
					<div class="event_list_page_link_wrapper">
						<div class="event_list_page_link_wrap">
						
						<c:if test="${yepsPager.curBlock > 1}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('1')">
									<span>Start</span>
								</a>
							</div>
						</c:if>

						<c:if test="${yepsPager.curBlock > 1}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${yepsPager.prevPage}')">
									<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
										<svg class="icon_svg">
											<path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>
										</svg>
									</span>
									<span>Previous</span>
								</a>
							</div>
						</c:if>
						
						
						<c:forEach var="num" begin="${yepsPager.blockBegin}" end="${yepsPager.blockEnd}">
							<div class="event_list_page_link_option">
							<c:choose>
								<c:when test="${num == yepsPager.curPage}">
									<span class="event_list_page_option_action">
										${num}
									</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:list('${num}')" class="event_list_page_option_link_action">
										${num}
									</a>
								</c:otherwise>
							</c:choose>
							</div>
						</c:forEach>
						
						<c:if test="${yepsPager.curBlock <= yepsPager.totBlock}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${yepsPager.nextPage}')">
									<span>Next</span>
									<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
										<svg class="icon_svg">
											<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
										</svg>
									</span>
								</a>
							</div>
						</c:if>
						
						<c:if test="${yepsPager.curPage <= yepsPager.totPage}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${yepsPager.totPage}')">
									<span>End</span>
								</a>
							</div>
						</c:if>
						</div>
					</div>
					</c:if>
				</div>
			</div>
		</div>
							
							
							
							
							
							
							
							
						</c:when>
						<c:otherwise>
							<h3 class="subscribe-list_title">Member Profile</h3>
							<div class="memberProfileContainer_section_member_wrap">
			    				<form action="member_profile" class="member_profilef" method="post" name="memberProfile">
			    					<div class="member_profilef_alpha">
										<div class="psection">
											<h4>Photo</h4>
											<div class="photo-box pb-m">
												<a class="js-analytics-click" data-analytics-label="user-photo" href="member_photolist?mnum=${memberProfile.mnum}">
													<c:choose>
														<c:when test="${empty memberMainPhoto}">
															<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png">
														</c:when>
														<c:otherwise>
															<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${memberMainPhoto.member_filename}" alt="member_main_photo" id="photo_box_img" width="100px" height="100px">
														</c:otherwise>
													</c:choose>	
													
												</a>
											</div>
											<ul class="user-passport-stats">
												<li class="review-count">
													<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-review icon--size-18">
														<svg class="icon_svg">
															<path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
														</svg>
													</span>
													<b>${memberProfile.reviewcount}</b> reviews <!-- 리뷰 수 -->
												</li>
												<li class="image-count">
													<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-review icon--size-18">
														<svg class="icon_svg">
															<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
														</svg>
													</span>
													<b>${memberProfile.imagecount}</b> photos <!-- 리뷰 수 -->
												</li>
											</ul>
										</div>
										<button type="button" value="delete" class="deletebtn ybtn ybtn-primary" onclick="deleteMember()"><span>Delete Member</span></button>
									</div>
									<div class="member_profilef_beta">
										<label for="mnum">회원번호</label>
										<input id="mnum" maxlength="30" name="mnum" type="text" value="${memberProfile.mnum}" readOnly style="background-color: #f5f5f5;">
										<label for="email">이메일</label>
										<input id="email" maxlength="50" name="email" type="text" value="${memberProfile.email}" readOnly style="background-color: #f5f5f5;">
										<label for="joindate">가입일</label>
										<input id="joindate" maxlength="50" name="joindate" type="text" value="${memberProfile.joindate}" readOnly style="background-color: #f5f5f5;">
										<label for="name">이름</label>
										<span class="help-block">This field is required.</span>
										<input id="name" maxlength="20" name="name" required type="text" autocomplete=off value="${memberProfile.name}">
										<label for="nickname">닉네임</label>
										<span class="help-block">The Boss, Calamity Jane, The Prolific Reviewer</span>
										<input id="nickname" maxlength="50" name="nickname"  type="text" placeholder=" " autocomplete=off value="${memberProfile.nickname}">
										
												<label for="manager">관리권한</label><br>
												<div class="checkbox">
													<input class="magic-checkbox" type="checkbox" id="controlcate" name="controlckbox" value="controlcate">
													<label for="controlcate" class="manage-label" style="width:13%;font-size:14px;">카테고리</label>
													
													<input class="magic-checkbox" type="checkbox" id="controlevent" name="controlckbox" value="controlevent">
													<label for="controlevent" class="manage-label" style="width:13%;font-size:14px;">이벤트</label>
													
													<input class="magic-checkbox" type="checkbox" id="controlmember" name="controlckbox" value="controlmember">
													<label for="controlmember" class="manage-label" style="width:13%;font-size:14px;">유저</label>
													
													<input class="magic-checkbox" type="checkbox" id="controlstore" name="controlckbox" value="controlstore">
													<label for="controlstore" class="manage-label" style="width:13%;font-size:14px;">가게</label>
													
													<input class="magic-checkbox" type="checkbox" id="controlreview" name="controlckbox" value="controlreview">
													<label for="controlreview" class="manage-label" style="width:13%;font-size:14px;">리뷰</label>
												</div><Br/><Br/>
										<button type="submit" value="submit" class="ybtn ybtn-primary"><span>Save Changes</span></button>
										<a href="member_manager">Cancel</a>
									</div>
								</form>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>	
		</div>			
		
		
	</div>
	
	
		
<script type="text/javascript">
	var search = '${map.search}'
	var searchString = '${map.searchString}'
	var memberProfile = '${memberProfile}'
	$(document).ready(function() {
		if(search && searchString){
			$(".search").val(search)
			$(".searchString").val(searchString)
		}
		
		if(memberProfile){
			var controlcate = '${memberProfile.controlcate}';
			var controlevent = '${memberProfile.controlevent}';
			var controlmember = '${memberProfile.controlmember}';
			var controlstore = '${memberProfile.controlstore}';
			var controlreview = '${memberProfile.controlreview}';
			
			if(controlcate == 'y'){
				$("input:checkbox[id='controlcate']").prop("checked", true);
			}
			if(controlevent == 'y'){
				$("input:checkbox[id='controlevent']").prop("checked", true);
			}
			if(controlmember == 'y'){
				$("input:checkbox[id='controlmember']").prop("checked", true);
			}
			if(controlstore == 'y'){
				$("input:checkbox[id='controlstore']").prop("checked", true);
			}
			if(controlreview == 'y'){
				$("input:checkbox[id='controlreview']").prop("checked", true);
			}
		}
	});
	
	$('#management').click(function(){
		var url = "member_managerPage";
		window.location = url;
	});
	
	function deleteMember(){
		if(confirm("정말 탈퇴시키실건가요?")){
			var mnum = '${memberProfile.mnum}'
			location.href="member_delete?mnum=" + mnum ;
		}else{
			return
		}
		return
	}
	
	function list(page){
        location.href="member_manager?search=" + search + "&searchString=" + searchString + "&curPage="+page;
    }
</script>
<%@ include file="../bottom.jsp"%>