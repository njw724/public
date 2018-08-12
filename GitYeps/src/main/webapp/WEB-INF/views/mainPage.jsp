<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>
<head>
	<title>Yeps!</title>
	<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/mainPage.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/review.css"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
</head>
<body>
	<div class="mainpage_header_container" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${randomPhoto.filename});">
		<div class="mainpage_header_content_container">
			<div class="mainpage_header_top" style="height: 40px;">
				<div class="mainpage_header_top_wrap">
					<div class="mainpage_header_top_left_wrap">
						<div style="white-space: nowrap;">
							<ul class="mainpage_header_top_left">
								<li class="mainpage_header_write_review mainpage_header_top_items">
									<a href="review_restaurantIMG" class="mainpage_header_link">
										Write a Review
									</a>
								</li>
								<li class="mainpage_header_events mainpage_header_top_items">
									<a href="event_list" class="mainpage_header_link">
										Events
									</a>
								</li>
								<li class="mainpage_header_message mainpage_header_top_items">
									<a href="yeps_message" class="mainpage_header_link">
										Message 
									</a>
								</li>
							</ul>
						</div>
					</div>
					
					
					
					<c:choose>
							<c:when test="${empty sessionScope.memberinfo}">
								<div class="mainpage_header_top_right_wrap">
									<ul class="mainpage_header_top_right" style="float: right">
										<li class="mainpage_header_login mainpage_header_top_items">
											<a href="member_login" class="mainpage_header_link">
												Log In
											</a>
										</li>
										<li class="mainpage_header_signup">
											<a href="member_login?mode=signup" class="mainpage_header_signup_button">
												Sign Up
											</a>
										</li>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
							<div class="mainpage_header_top_right_wrap_login">
								<div id="page_header_notifications_wrap">
									<div id="page_header_notifications">
										<a href="yeps_message" class="header-nav_link" id="messages-icon" data-analytics-label="messages_icon">
											<span aria-label="Messages" style="width: 24px; height: 24px;" class="icon icon--24-speech icon--size-24 icon--white icon--fallback-inverted">
												<svg class="icon_svg">
													<path d="M18 3H6C4.34 3 3 4.34 3 6v7c0 1.66 1.34 3 3 3h2v5l5-5h5c1.66 0 3-1.34 3-3V6c0-1.66-1.34-3-3-3z"></path>
												</svg>
											</span>
<!-- 											<a href="yeps_message" class="header-nav_link" id="messages-icon" data-analytics-label="messages_icon"> -->
<!-- 												<span aria-label="Messages" style="width: 24px; height: 24px;" class="icon icon--24-speech icon--size-24 icon--white icon--fallback-inverted"> -->
<!-- 													<svg class="icon_svg"> -->
<!-- 														<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#24x24_speech"> -->
<!-- 															<svg id="24x24_speech" height="100%" viewBox="0 0 24 24" width="100%"> -->
<!-- 																<path d="M18 3H6C4.34 3 3 4.34 3 6v7c0 1.66 1.34 3 3 3h2v5l5-5h5c1.66 0 3-1.34 3-3V6c0-1.66-1.34-3-3-3z"></path> -->
<!-- 															</svg> -->
<!-- 														</use> -->
<!-- 													</svg> -->
<!-- 												</span> -->
												<c:if test="${ not empty sessionScope.noneCount && sessionScope.noneCount > 0}">
													<span class="ybadge ybadge--notification ">${sessionScope.noneCount}</span>
												</c:if>
											</a>
										
										<a href="member_details?mnum=${memberinfo.mnum}" class="header-nav_link show-tooltip js-analytics-click" id="notifications-icon" data-analytics-label="notifications_icon">
											<span aria-label="Notifications" style="width: 24px; height: 24px;" class="icon icon--24-notification icon--size-24 icon--white icon--fallback-inverted">
												<svg class="icon_svg">
													<path d="M20.984 17.177A1 1 0 0 1 20 18H4a1 1 0 0 1-.348-1.938c2.43-.9 3.74-4.605 3.74-7.634 0-1.75 1.07-3.253 2.608-3.97V4a2 2 0 0 1 4 0v.457c1.538.718 2.61 2.22 2.61 3.97 0 3.03 1.31 6.734 3.738 7.635a1 1 0 0 1 .636 1.115zM12 22a3 3 0 0 1-3-3h6a3 3 0 0 1-3 3z"></path>
												</svg>
											</span>
										</a>
									</div>
								</div>
								
								<div id="page_header_notifications_wrap">
		                           <div id="page_header_acount_notifications">
		                              <div id="page_header_account">
		                                 <div id="topbar-account-item" class="drop-menu-origin" data-component-bound="true">
		                                    <a class="drop-menu-link user-account_button drop-menu-highlighted" href="javascript:;" id="topbar-account-link" data-component-bound="true">
		                                       <span class="user-account_avatar responsive-visible-large-block">
                                          			<c:choose>
                                             			<c:when test="${empty sessionScope.mainPhoto}">
                                                			<img class="photo-box-img" height="90" width="90" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png">
                                             			</c:when>
                                             			<c:otherwise>
                                                			<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${mainPhoto.member_filename}" alt="member_main_photo" id="photo_box_img" width="90px" height="90px">
                                             			</c:otherwise>
                                          			</c:choose>
                                       			</span>
		                                       <span aria-hidden="true" style="width: 14px; height: 14px;" class="icon icon-triangle-down">
		                                          <svg class="icon_svg">
		                                             <path d="M7 9L3.5 5h7L7 9z"></path>
		                                          </svg>
		                                       </span>
		                                    </a>
		                                    <div id="topbar-account-wrap" class="drop-menu drop-menu-has-arrow" data-component-bound="true">
		                                       <div class="drop-menu-arrow responsive-hidden-small"></div>
		                                          <div class="drop-menu-group responsive-visible-large-block">
		                                             <div class="ypassport ypassport-notext media-block">
		                                                <div class="media-avatar responsive-photo-box js-analytics-click" data-analytics-label="about_me">
		                                                   <div class="photo-box pb-60s" data-hovercard-id="mNnbq24hI6DxMOQ0JLFrnQ">
		                                                      <a href="member_details" class="js-analytics-click" data-analytics-label="user-photo">
                                                         		<c:choose>
                                                        		    <c:when test="${empty sessionScope.mainPhoto}">
                                                            		   <img class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png" width="60">
                                                           			</c:when>
                                                            		<c:otherwise>
                                                               			<img class="photo-box-img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${mainPhoto.member_filename}" alt="member_main_photo" id="photo_box_img" width="60px" height="60px">
                                                            		</c:otherwise>
                                                         		</c:choose>
		                                                      </a>
		                                                   </div>
		                                                </div>
		                                                <div class="media-story">
		                                                   <ul class="user-passport-info">
		                                                      <li class="user-name">
		                                                         <a class="user-display-name js-analytics-click" href="member_details" data-hovercard-id="mNnbq24hI6DxMOQ0JLFrnQ" data-analytics-label="about_me" id="dropdown_user-name">
		                                                            <strong class="unit_hover">
		                                                            	<c:if test="${!empty sessionScope.memberinfo.nickname}">
		                                                            		<c:out value="${sessionScope.memberinfo.nickname}"/>
		                                                            	</c:if>
		                                                            	<c:if test="${empty sessionScope.memberinfo.nickname}">
																			<c:set value="${sessionScope.memberinfo.name}" var="memberName"/>
																			<c:choose>
																				<c:when test="${fn:length(memberName) > 7}">
		                                                                        	<c:out value="${fn:substring(memberName,0,6)}"/>..
																				</c:when>
																				<c:otherwise>
																					<c:out value="${memberName}"/>
																				</c:otherwise> 
		                                                              	  </c:choose>
		                                                              	</c:if>
		                                                            </strong>
		                                                         </a>
		                                                      </li>
		                                                      <li class="user-location responsive-hidden-small">
																<b>
                                                            	<c:if test="${!empty sessionScope.memberinfo.address}">
                                                         			<c:forTokens items="${sessionScope.memberinfo.address}" delims=" " begin="1" end="2" var="addr">
                                                                   		${addr}
                                                                 	</c:forTokens>
                                                         		</c:if>
                                                         		<c:if test="${empty sessionScope.memberinfo.address}">
                                                         			주소를 등록해주세요.
                                                         		</c:if>
                                                         		</b>
                                                      		 </li>
		                                                   </ul>
		                                                   <ul class="user-passport-stats">
		                                                      <li class="review-count">
		                                                         <span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-review icon--size-18">
		                                                            <svg class="icon_svg">
		                                                               <path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
		                                                            </svg>
		                                                         </span>
		                                                         <b>${sessionScope.memberinfo.reviewcount}</b> <!-- 리뷰 수 -->
		                                                      </li>
		                                                      
		                                                      <li class="photo-count">
																<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon icon--18-review icon--size-18">
                                                            		<svg class="icon_svg" id="18x18_camera" height="100%" viewBox="0 0 18 18" width="100%">
																		<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
																	</svg>
                                                         		</span>
                                                         		<b>${sessionScope.memberinfo.imagecount}</b> <!-- 리뷰 수 -->
                                                      		 </li>
		                                                   </ul>
		                                                </div>
		                                             </div>
		                                                      </div>
		                                          <ul class="drop-menu-group--nav drop-menu-group">
		                                             <li class="drop-down-menu-link">
		                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_details" data-analytics-label="dropdown_about-me">
		                                                   <strong class="arrange_unit">
		                                                      <span aria-hidden="true" style="width: 24px; height: 24px;" class="icon icon--24-profile icon--size-24 u-space-r1">
		                                                         <svg class="icon_svg">
		                                                            <path d="M4.37 22c.278-4.762 3.587-8 7.63-8 4.043 0 7.352 3.238 7.63 8H4.37zM12 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10z"></path>
		                                                         </svg>
		                                                      </span><strong class="unit_hover">About Me</strong>
		                                                   </strong>
		                                                </a>
		                                             </li>
		                                             <li class="drop-down-menu-link hidden-non-responsive-block responsive-visible-medium-block">
		                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="yeps_message" data-analytics-label="">
		                                                   <strong class="arrange_unit">
		                                                      <span aria-hidden="true" style="width: 24px; height: 24px;" class="icon icon--24-talk icon--size-24 u-space-r1">
		                                                         <svg class="icon_svg">
		                                                            <path d="M20 17.326V21l-3-3c-2.715 0-5.006-1.504-5.746-3.566C14.047 13.42 16 11.144 16 8.5c0-.142-.015-.282-.026-.422A7.19 7.19 0 0 1 17 8c3.314 0 6 2.24 6 5 0 1.85-1.208 3.46-3 4.326zM8 14c-.08 0-.158-.007-.238-.01L4 17v-3.99c-1.812-.994-3-2.642-3-4.51C1 5.462 4.134 3 8 3s7 2.462 7 5.5S11.866 14 8 14z"></path>
		                                                         </svg>
		                                                      </span><strong class="unit_hover">Message</strong>
		                                                   </strong>
		                                                </a>
		                                             </li>
		                                             <c:if test="${memberinfo.ismaster eq 'y' || memberinfo.ismanager eq 'y'}">
		                                             <li class="drop-down-menu-link">
		                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="manager_managerPage" data-analytics-label="dropdown_rewards-inactive">
		                                                   <strong class="arrange_unit">
		                                                      <span aria-hidden="true" style="width: 24px; height: 24px;" class="icon icon--24-cash-back icon--size-24 u-space-r1">
		                                                         <svg class="icon_svg">
		                                                            <path d="M18.803 12.49l-4.162 1.194c-.8.23-1.45-.666-.98-1.357l2.42-3.59a.893.893 0 0 1 1.33-.172 7.66 7.66 0 0 1 1.97 2.71.894.894 0 0 1-.572 1.215zm-4.187 2.627l4.117 1.338a.893.893 0 0 1 .53 1.233 7.762 7.762 0 0 1-2.058 2.64.894.894 0 0 1-1.326-.216l-2.3-3.674c-.44-.706.24-1.578 1.03-1.32zm-3.996-3.64l-4.07-7.05a.893.893 0 0 1 .388-1.25A12.475 12.475 0 0 1 11.324 2c.518-.04.96.37.96.89v8.138c0 .913-1.208 1.236-1.664.446zm-.714 3.475L5.704 16a.894.894 0 0 1-1.103-.767 7.68 7.68 0 0 1 .358-3.33.892.892 0 0 1 1.237-.516l3.89 1.898c.75.365.635 1.466-.173 1.667zm.738 1.23c.557-.62 1.584-.205 1.555.627l-.158 4.322c-.02.54-.51.94-1.04.85A7.76 7.76 0 0 1 7.9 20.73a.893.893 0 0 1-.156-1.333l2.897-3.22z"></path>
		                                                         </svg>
		                                                      </span><strong class="unit_hover">Managed Page</strong>
		                                                   </strong>
		                                                   <span class="arrange_unit">
		                                                      <span class="ybadge ybadge-notification drop-down-menu-link_new-label" style="position: static; padding: 0 3px;">MNG</span>
		                                                   </span>
		                                                </a>
		                                             </li>
		                                             </c:if>
		                                             <li class="drop-down-menu-link">
		                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_profile" data-analytics-label="Zprofile">
		                                                   <strong class="arrange_unit">
		                                                      <span aria-hidden="true" style="width: 24px; height: 24px;" class="icon icon--24-settings icon--size-24 u-space-r1">
		                                                         <svg class="icon_svg">
		                                                            <path d="M21.872 10.48c.076.497.128 1.002.128 1.52s-.05 1.022-.127 1.518l-3.165.475c-.14.47-.323.92-.552 1.343l1.9 2.57c-.3.408-.62.8-.976 1.156l-.018.018a10.05 10.05 0 0 1-1.154.975l-2.57-1.9a7 7 0 0 1-1.344.553l-.475 3.165a9.94 9.94 0 0 1-1.506.127h-.034c-.51 0-1.01-.052-1.5-.127l-.475-3.165a7 7 0 0 1-1.343-.553l-2.57 1.9c-.408-.3-.798-.62-1.155-.975l-.018-.018a10.068 10.068 0 0 1-.978-1.155l1.9-2.57a6.97 6.97 0 0 1-.552-1.344l-3.164-.475C2.052 13.022 2 12.518 2 12s.052-1.023.128-1.52l3.164-.475a7 7 0 0 1 .553-1.342l-1.9-2.57a10.035 10.035 0 0 1 2.148-2.15l2.57 1.9a7.015 7.015 0 0 1 1.343-.55l.475-3.166C10.98 2.052 11.486 2 12 2s1.023.052 1.52.127l.474 3.165c.47.14.92.323 1.342.552l2.57-1.9a10.044 10.044 0 0 1 2.15 2.148l-1.9 2.57c.23.424.412.874.552 1.343l3.164.475zM12 8.5a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7z"></path>
		                                                         </svg>
		                                                      </span><strong class="unit_hover">Account Settings</strong>
		                                                   </strong>
		                                                </a>
		                                             </li>
		                                          </ul>
		                                          <ul class="drop-menu-group">
		                                             <li class="drop-down-menu-link drop-down-menu-link--logout">
		                                                <form action="member_logout" id="logout-form" name="logout-form">
		                                                   <button type="submit" class="u-pseudo-link" id="header-log-out" data-analytics-label="logout">Log Out</button>
		                                                </form>
		                                             </li>
		                                          </ul>
		                                       </div>         
		                                    </div>
		                                 </div>
		                              </div>
		                           </div>
								</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
			
			
			<div class="mainpage_header_inner">
				<div class="mainpage_header_inner_mainlogo" style="text-align: center!important;">
					<h1 id="mainpage_header_mainlogo">
						<a href="main">Yeps</a>
					</h1>
				</div>
				<form action="yeps_main_saerch" method="post" action="#" class="mainpage_find_form" >
					<div class="mainpage_search_arrange">
						<div id="yeps_search_arrange">
							<label id="find_label" class="mainpage_search">
								<span id="label_span">Find</span>
								<span id="label_input_span">
									<input type="text" maxlength="64" name="category" id="page_header_inputs" class="page_header_inputs" autocomplete="off" placeholder="분야별 검색" aria-autocomplete="list" tabindex="1" data-component-bound="true">		
								</span>
							</label>
							
							<div id="main_search_suggestion_container">
								<ul id="suggestion_container_list">
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('fork_knife_icon')" onmouseout="javascript:outMouse('fork_knife_icon')" onclick="javascript:clickMouse('Restaurants')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="fork_knife">
												<span id="fork_knife_icon">
													<svg id="24x24_food" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M17.22 22a1.78 1.78 0 0 1-1.74-2.167l1.298-4.98L14 13l1.756-9.657A1.635 1.635 0 0 1 19 3.635V20.22A1.78 1.78 0 0 1 17.22 22zm-7.138-9.156l.697 7.168a1.79 1.79 0 1 1-3.56 0l.7-7.178A3.985 3.985 0 0 1 5 9V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.83c0 1.85-1.2 3.518-2.918 4.014z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Restaurants
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('Bars_icon')" onmouseout="javascript:outMouse('Bars_icon')" onclick="javascript:clickMouse('Bars')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="Bars">
												<span id="Bars_icon" >
													<svg id="24x24_nightlife" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M19.215 3H4.785C3.095 3 2.29 5.08 3.54 6.22L11 13v6H8a1 1 0 0 0 0 2h8a1 1 0 0 0 0-2h-3v-6l7.46-6.78C21.71 5.08 20.905 3 19.214 3zM15 4.5a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Bars
												</span>
											</div>
										</div>
									</li> 
									
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('food_icon')" onmouseout="javascript:outMouse('food_icon')" onclick="javascript:clickMouse('Food')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="food">
												<span id="food_icon">
													<svg id="24x24_ice_cream" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M17.5 7.27l-.305-.176A5.198 5.198 0 0 0 12 2a5.198 5.198 0 0 0-5.195 5.094L6.5 7.27a3.466 3.466 0 0 0-1.268 4.735 3.43 3.43 0 0 0 2.688 1.7l3.155 7.675c.34.827 1.51.827 1.85 0l3.155-7.674a3.43 3.43 0 0 0 2.688-1.7 3.466 3.466 0 0 0-1.27-4.736zm-.464 3.735c-.26.45-.732.72-1.263.72a1.46 1.46 0 0 1-.28-.026l-1.065-.204-.75.78a2.308 2.308 0 0 1-3.355 0l-.75-.78-1.066.202a1.46 1.46 0 0 1-.28.025 1.44 1.44 0 0 1-1.263-.72c-.404-.7-.163-1.6.537-2.003l.306-.176.977-.564.023-1.128A3.214 3.214 0 0 1 12 4a3.214 3.214 0 0 1 3.195 3.134l.023 1.128.977.564.304.176c.7.404.94 1.303.535 2.003z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Food
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('breakfast_brunch_icon')" onmouseout="javascript:outMouse('breakfast_brunch_icon')" onclick="javascript:clickMouse('Breakfast & Brunch')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="breakfast_brunch">
												<span id="breakfast_brunch_icon">
													<svg id="24x24_croissant" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M20.634 8.5H19.1c.09-.295.15-.602.15-.926v-2.12c.718.34 1.39.76 2.003 1.253.74.597.332 1.793-.62 1.793zm-4.86 1.055a5.58 5.58 0 0 0-.712-.05L13.748 3.58a10.957 10.957 0 0 1 3.425.138c.477.094.827.5.827 1.324v2.534c0 1.195-1.043 2.15-2.225 1.98zm-2.43 1.81a4.005 4.005 0 0 0-1.98 1.98c-.202.442-.664.702-1.138.597l-6.89-1.528a1.013 1.013 0 0 1-.737-1.3A13.018 13.018 0 0 1 11.112 2.6a1.013 1.013 0 0 1 1.3.735l1.527 6.89c.106.475-.154.937-.597 1.14zM9.506 15.06c.003.242.016.48.05.713C9.722 16.957 8.768 18 7.573 18H4.7c-.485 0-.89-.35-.984-.827a10.957 10.957 0 0 1-.138-3.425l5.928 1.314zM8.5 19.1v1.534c0 .95-1.196 1.36-1.792.62a9.997 9.997 0 0 1-1.253-2.004h2.12c.318 0 .626-.062.925-.15z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Breakfast & Brunch
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('coffee_tea_icon')" onmouseout="javascript:outMouse('coffee_tea_icon')" onclick="javascript:clickMouse('Coffee & Tea')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="coffee_tea">
												<span id="coffee_tea_icon">
													<svg id="24x24_coffee" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M19 13h-1a3 3 0 0 1-3 3H7a3 3 0 0 1-3-3V5h15a3 3 0 0 1 3 3v2a3 3 0 0 1-3 3zm1-5c0-.55-.45-1-1-1h-1v4h1c.55 0 1-.45 1-1V8zm2 10a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h18a1 1 0 0 1 1 1z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Coffee & Tea
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('delivery_icon')" onmouseout="javascript:outMouse('delivery_icon')" onclick="javascript:clickMouse('delivery')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="delivery">
												<span id="delivery_icon">
													<svg id="24x24_order" height="100%" viewBox="0 0 24 24" width="100%">
														<g>
															<path d="M19 10V4h-6v10H9.444a3.485 3.485 0 0 0-4.888 0H2v3h1.55A3.49 3.49 0 0 0 7 20a3.49 3.49 0 0 0 3.45-3h3.1c.24 1.69 1.69 3 3.45 3 1.76 0 3.21-1.31 3.45-3H22v-5l-3-2zM7 18a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm8-12h2v3h-2V6zm2 12c-.83 0-1.5-.67-1.5-1.5S16.17 15 17 15s1.5.67 1.5 1.5S17.83 18 17 18z"></path>
															<path d="M6 7V6c0-.55.45-1 1-1h1c.55 0 1 .45 1 1v1H6m2-4H7a3 3 0 0 0-3 3v1H2v7h11V7h-2V6a3 3 0 0 0-3-3" opacity=".502"></path>
														</g>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Delivery
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('takeout_icon')" onmouseout="javascript:outMouse('takeout_icon')" onclick="javascript:clickMouse('takeout')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="takeout">
												<span id="takeout_icon">
													<svg id="24x24_shopping" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M16 6V5a3 3 0 0 0-3-3h-2a3 3 0 0 0-3 3v1H5v13a3 3 0 0 0 3 3h8a3 3 0 0 0 3-3V6h-3zm-6-1c0-.55.45-1 1-1h2c.55 0 1 .45 1 1v1h-4V5z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													TakeOut
												</span>
											</div>
										</div>
									</li>
									<li id="suggestion_container_list_items" onmouseover="javascript:onMouse('reservations_icon')" onmouseout="javascript:outMouse('reservations_icon')" onclick="javascript:clickMouse('reservations')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="reservations">
												<span id="reservations_icon">
													<svg id="24x24_reservation" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M18 21H6a3 3 0 0 1-3-3V6a3 3 0 0 1 3-3 1 1 0 0 1 2 0h8a1 1 0 0 1 2 0 3 3 0 0 1 3 3v12a3 3 0 0 1-3 3zm1-13H5v10c0 .55.45 1 1 1h12c.55 0 1-.45 1-1V8zm-6 5h4v4h-4v-4z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Reservations
												</span>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div id="yeps_search_arrange" style="float: left;">
							<label id="near_label" class="mainpage_search">
								<span id="label_span">Near</span>
								<span id="label_input_span">
									<input type="text" maxlength="80" name="location" id="page_header_location_inputs" class="page_header_location_inputs" autocomplete="off" placeholder="지역별 검색" value="서울특별시">
									<input type="hidden" name="latitude" id="latitude" />
									<input type="hidden" name="longitude" id="longitude" />
								</span>
							</label>
							
							<!-- 이 구간 안에 새로운 div로 지역검색할 수 있도록 지정해야함 -->
							<div id="main_location_suggestion_container">
								<ul id="location_suggestion_container_list">
									<li id="suggestion_container_list_items_button" onmouseover="javascript:onMouse('location_icon')" onmouseout="javascript:outMouse('location_icon')" onclick="javascript:loc_clickMouse('Current Location')">
										<div id="list_items_unit" style="position: relative; display: flex;">
											<div id="location">
												<span id="location_icon" style="fill: #0073bb;">
													<svg id="24x24_location" height="100%" viewBox="0 0 24 24" width="100%">
														<path d="M3 12.73L20 4l-8.73 17-.696-7.574L3 12.73z"></path>
													</svg>
												</span>
											</div>
											<div id="suggestion_container_list_items_name">
												<span>
													Current Location
												</span>
											</div>
										</div>
									</li>
									
									<c:if test="${!empty sessionScope.memberinfo.address}">
										<li class="suggestions-location-list-item saved-location" onmouseout="javascript:outMouse('location_icon')" onclick="javascript:loc_clickMouse('Home')">
											<div class="location-media-block">
												<div class="location-media-avatar">
													<span id="location_icon" style="width: 24px; height: 24px;">
														<svg class="icon_svg">
															<path d="M12 2C8.13 2 5 5.13 5 9c0 2.61 1.43 4.88 3.54 6.08L12 22l3.46-6.92A6.987 6.987 0 0 0 19 9c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 0 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
														</svg>
													</span>
												</div>
												<div class="location-media-story">
													<span class="suggestion-location-detail">
														<span class="suggestion-location-detail suggestion-location-name">Home</span>
													</span>
													<small class="suggestion-location-detail suggestion-location-subtitle suggestion-location">
														<c:forTokens items="${sessionScope.memberinfo.address}" delims=" " begin="1" end="2" var="addr">
															${addr}
														</c:forTokens><br>
														<c:forTokens items="${sessionScope.memberinfo.address}" delims=" " begin="3" end="3" var="addr">
															${addr}
														</c:forTokens>
													</small>
												</div>
											</div>
										</li>
									</c:if>
								</ul>
							</div>
							
						</div>
						<div id="yeps_search_arrange" style="width: 32%; float: left;">
							<label id="yeps_search_arrange_label" class="mainpage_search">
								<span id="search_input_span">
									<input type="text" maxlength="80" id="page_header_searchDate_inputs" class="page_header_searchDate_inputs" name="searchword" autocomplete="off" placeholder="검색어를 입력하세요."">
									<input type="hidden" maxlength="80" name="search_loc" value>
								</span>
							</label>
							
							<div class="search_arrange_suggestions">
		                        <ul class="search_arrange_suggestions-list">
			                        
		                       </ul>
		                    </div>
						</div>
						
						<div id="header_searchbutton_container">
							<div id="header_searchbutton_contain_wrap">
								<div id="header_searchbutton_wrap">
									<button type="submit" value="submit" tabindex="3" style="background: #d32323; height: 45px; width: 70px; padding: 0 20px;" title="Search" id="header_searchbutton" class="mainpage_searchbutton">
										<span aria-hidden="true" style="fill: #fff; width: 24px; height: 24px;">
											<svg id="24x24_search" viewBox="0 0 24 24">
												<path d="M20.753 19.34l-4.295-4.297A7.46 7.46 0 0 0 18 10.5a7.5 7.5 0 1 0-7.5 7.5 7.46 7.46 0 0 0 4.543-1.542l4.296 4.295a1 1 0 1 0 1.412-1.414zM10.5 16A5.506 5.506 0 0 1 5 10.5C5 7.467 7.467 5 10.5 5S16 7.467 16 10.5 13.533 16 10.5 16z"></path>
											</svg>
										</span>
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
				<ul class="mainpage_header_inner_categories">
					<li class="mainpage_header_inner_category">
						<div>
							<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
								<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
									<path d="M13.61 17h-.007a1.39 1.39 0 0 1-1.376-1.587L13 10l-2-1c0-5.373 1.375-8 3.25-8 .497 0 .75.336.75.75v13.86A1.39 1.39 0 0 1 13.61 17zM6.557 9.912l.35 5.59a1.41 1.41 0 1 1-2.813 0l.35-5.59A1.994 1.994 0 0 1 3 8V1.5a.5.5 0 0 1 1 0v5a.5.5 0 0 0 1 0v-5a.5.5 0 0 1 1 0v5a.5.5 0 0 0 1 0v-5a.5.5 0 0 1 1 0V8c0 .91-.61 1.67-1.443 1.912z"></path>
								</svg>
							</span>
							<a href="restaurant_list" class="mainpage_header_inner_category_link">
								Restaurants
							</a>
						</div>
					</li>
					<li class="mainpage_header_inner_category">
						<div>
							<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
								<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
									<path d="M15.55 3.66c.565-.648.105-1.66-.754-1.66H3.204a1 1 0 0 0-.753 1.66L8 9v5H6a1 1 0 0 0 0 2h6a1 1 0 0 0 0-2h-2V9l5.55-5.34zM11 3a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"></path>
								</svg>
							</span>
							<a href="#" class="mainpage_header_inner_category_link">
								Nightlife
							</a>
						</div>
					</li>
					<li class="mainpage_header_inner_category">
						<div id="mainpage_header_inner_category_block">
							<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
								<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
									<path d="M12.772 8.594c-.337 0-.656-.067-.962-.164l-6.99 7.116a1.472 1.472 0 0 1-2.11 0 1.538 1.538 0 0 1 0-2.15L9.697 6.28a3.34 3.34 0 0 1-.16-.98c0-1.82 1.447-3.294 3.234-3.294.338 0 .657.068.963.165L11.93 4.01l2.11 2.15 1.806-1.837c.095.312.162.637.162.98 0 1.82-1.45 3.294-3.236 3.294zM4.955 6.198L3.54 5.21 1.998 3.64l1.565-1.59 1.54 1.57.905 1.508L7.71 6.86 6.658 7.932 4.955 6.198zm10.006 7.198a1.54 1.54 0 0 1 0 2.15 1.475 1.475 0 0 1-2.11 0l-3.314-3.374 2.11-2.15 3.316 3.374z"></path>
								</svg>
							</span>
							<a href="#" class="mainpage_header_inner_category_link" id="category_link_homeservice_active">
								Home service
							</a>
							<span style="width: 14px; height: 14px; fill: currentColor; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; left: -3px; fill: #fff;">
								<svg id="14x14_triangle_down" height="100%" viewBox="0 0 14 14" width="100%">
									<path d="M7 9L3.5 5h7L7 9z"></path>
								</svg>
							</span>
							<div id="header_page_footer_dropdown_wrap" style="display: block;">
								<div id="header_page_footer_dropdown">
									<div id="header_page_footer_dropdown_menu">
										<ul id="header_page_footer_dropdown_menu_group">
											<li id="header_page_footer_dropdown_menu_item">
												<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Air Conditioning & Heating</span>
												</a>
											</li>
											<li id="header_page_footer_dropdown_menu_item">
											<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Contractors</span>
												</a>
											</li>
											<li id="header_page_footer_dropdown_menu_item">
												<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Electricians</span>
												</a>
											</li>
											<li id="header_page_footer_dropdown_menu_item">
												<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Home Cleaners</span>
												</a>
											</li>
											<li id="header_page_footer_dropdown_menu_item">
												<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Landscapers</span>
												</a>
											</li>
											<li id="header_page_footer_dropdown_menu_item">
												<a href="#" id="footer_dropdown_menu_item_link">
													<span style="white-space: nowrap;">Locksmiths</span>
												</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li class="mainpage_header_inner_category">
						<div>
							<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
								<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
									<g>
										<path d="M4 4V3h3v1H4m4-2H3v2H2a1 1 0 0 0-1 1v7h9V5a1 1 0 0 0-1-1H8V2" opacity=".502"></path>
										<path d="M17 10.93L15 9.5V4h-5v8H7.49a2.49 2.49 0 0 0-1.99-1 2.49 2.49 0 0 0-1.99 1H1v2h2.05a2.502 2.502 0 0 0 4.9 0h3.1a2.5 2.5 0 0 0 4.9 0H17v-3.07zM5.5 14.75a1.25 1.25 0 1 1 0-2.5 1.25 1.25 0 0 1 0 2.5zM12 6h1v3h-1V6zm1.5 8.75a1.25 1.25 0 1 1 0-2.5 1.25 1.25 0 0 1 0 2.5z"></path>
									</g>
								</svg>
							</span>
							<a href="#" class="mainpage_header_inner_category_link">
								Delivery
							</a>
						</div>
					</li>
				</ul>
				<div class="mainpage_header_inner_bottom" style="text-align: center;">
					<div class="mainpage_header_bottom_text_name" style="display:inline-block;">
						<span>
							<a href="restaurant_content?rnum=${randomPhoto.rnum}" class="mainpage_header_recommend_name">
								<span>
									${randomPhoto.restaurantDTO.rname}
								</span>
							</a>
						</span>
					</div>
				</div>
				
				<div class="mainpage_header_bottom_photo_owner">
					<div>
						<p style="margin-bottom: 12px;">
							photo by
							<a href="member_details?mnum=${randomPhoto.mnum}" class="mainpage_header_bottom_photo_owner_link">
								<c:if test="${empty randomPhoto.memberDTO.nickname}">
									${randomPhoto.memberDTO.email}
								</c:if>
								<c:if test="${!empty randomPhoto.memberDTO.nickname}">
									${randomPhoto.memberDTO.nickname}
								</c:if>
							</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="mainpage_container">
		<div class="mainpage_content_container">
			<div class="mainpage_home_container">
				<div class="mainpage_home_container_section">
					<h2 class="mainpage_homecontainer_section_location">Yeps 선택 지역</h2>
					<div class="mainpage_homecontainer_location_bar">
						<div>
							<ul class="mainpage_homecontainer_location_bar_center">
							<!-- 아마 최신 검색 리스트 가져와서 반복문으로 6개 돌린 듯 -->
								<c:forEach var="location" items="${locationList}">
									<li class="mainpage_location_bar_item">
										<a href="yeps_main_saerch?location=${location}" class="mainpage_location_bar_item_link">
											<span class="mainpage_location_bar_item_label">${location}</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				
				
				<div class="mainpage_new_businesses_section">
					<h3 class="explore_city_title">
						Hot & New Businesses
					</h3>
					
					<div class="mainpage_new_businesses_list">
					<!-- 3개만 출력하는 반복문일 가능성 높음 -->
						<c:forEach var="RestaurantDTO" items="${hotAndNewSet}" varStatus="status">
						<div class="mainpage_new_businesses">
							<div class="mainpage_new_businesses_card">
								<div class="mainpage_new_businesses_card_photo">
								<c:if test="${empty RestaurantDTO.fileDTO.filename}">
									<div class="mainpage_new_businesses_photo_box" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png);">
										<a href="restaurant_content?rnum=${RestaurantDTO.rnum}" style="display: block;" class="new_businesses_photo_box_link">
											<img class="photo_box_img" height="400" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png" width="600">
										</a>
									</div>
								</c:if>
								<c:if test="${!empty RestaurantDTO.fileDTO.filename}">
									<div class="mainpage_new_businesses_photo_box" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${RestaurantDTO.fileDTO.filename});">
										<a href="restaurant_content?rnum=${RestaurantDTO.rnum}" style="display: block;" class="new_businesses_photo_box_link">
											<img class="photo_box_img" height="400" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${RestaurantDTO.fileDTO.filename}" width="600">
										</a>
									</div>
								</c:if>
								</div>
								
								<div class="mainpage_new_businesses_card_content">
									<h3 class="new_businesses_card_content_title">
										<div>
											<span>
												<a href="restaurant_content?rnum=${RestaurantDTO.rnum}">
													<span>${RestaurantDTO.rname}</span>
												</a>
											</span>
										</div>
									</h3>
									
									<div class="mainpage_new_business_rating">
										<div class="mainpage_review_rating pre_div_star${starAvg.get(status.index)}" title="4.0 star rating">
											<img class="pre_starimg1" height="303" width="84" alt="4.0 star rating" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" >
										</div>
										<span class="mainpage_new_business_review_count">
											${reviewCount.get(status.index)} reviews
										</span>
									</div>
									
									<div class="new_business_price_foodstyle">
										<!-- 가격표시 없으면 표시 안함 -->
										<span class="bullet-after">
											<span style="letter-spacing: 1px; white-space: nowrap;">
												<c:forEach begin="1" end="${RestaurantDTO.price}">￦</c:forEach>
											</span>
										</span>
										<span>
											${RestaurantDTO.foodstyle}
										</span>
									</div>
									
									<div class="new_business_store_location">
										<span>${RestaurantDTO.roadAddrPart1}</span>
									</div>
									
									<p class="new_business_open_date">
										<span class="icon 18x18_frame" style="width: 18px; height: 18px; fill: currentColor; overflow: hidden;">
											<svg class="icon_svg" id="18x18_frame">
												<path d="M11.508 3.743c1.173 2.43-.465 2.27-.696 3.88C10.082 2.758 5.947 1.5 5.947 1.5c2.045 2.697-1.9 4.784-3.63 8.33-1.47 3.016 2.533 5.44 4.67 6.67-2.15-2.993-.563-5.02 1.612-6.793-.81 2.448.5 2.934 1.043 3.944.71-.31 1.028-1.3 1.1-1.79.954 1.31 1.465 2.97-.248 4.64 8.302-3.77 5.977-9.743 1.007-12.752z"></path>
											</svg>
										</span>
										${RestaurantDTO.rest_regdate} opened
									</p>
								</div>
							</div>
						</div>
						</c:forEach>					
					</div>
				
<!-- 					<div style="margin-top: 12px!important; text-align: center!important;"> -->
<!-- 						<a href="#">더 많은 최신 식당 보기</a> -->
<!-- 					</div> -->
				</div>
			</div>
		</div>
	
		<div class="mainpage_browse_categories">
			<div class="mainpage_browse_categories_content_container">
				<div class="browse_categories_inner_container">
					<div class="browse_categories_section">
						<h2 class="browes_categories_section_header">Browse Businesses by Category</h2>
			
						<div class="mainpage_browes_categories_content">
							<div class="mainpage_browes_categories_content_partial_wrap">
								<div class="mainpage_browes_categories_content_unit">
									<a href="restaurant_list" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media1.fl.yelpcdn.com/assets/srv0/homepage/80b92cd513f0/assets/img/categories/72x72_restaurants.png">
										<h3 class="mainpage_browes_categories_content_title">Restaurants</h3>
									</a>
								</div>
							
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/homepage/ad1f85392c04/assets/img/categories/72x72_shopping.png">
										<h3 class="mainpage_browes_categories_content_title">Shopping</h3>
									</a>
								</div>
							
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media1.fl.yelpcdn.com/assets/srv0/homepage/4ee31d03d5b2/assets/img/categories/72x72_nightlife.png">
										<h3 class="mainpage_browes_categories_content_title">Nightlife</h3>
									</a>
								</div>
							
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media4.fl.yelpcdn.com/assets/srv0/homepage/7b915f332ffe/assets/img/categories/72x72_active_life.png">
										<h3 class="mainpage_browes_categories_content_title">Active Life</h3>
									</a>
								</div>
							</div>
						
							<div class="mainpage_browes_categories_content_partial_wrap">
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media1.fl.yelpcdn.com/assets/srv0/homepage/dda5bcbe7e6c/assets/img/categories/72x72_beauty.png">
										<h3 class="mainpage_browes_categories_content_title">Beauty & Spas</h3>
									</a>
								</div>
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/homepage/59b42d70fa94/assets/img/categories/72x72_automotive.png">
										<h3 class="mainpage_browes_categories_content_title">Automotive</h3>
									</a>
								</div>
								<div class="mainpage_browes_categories_content_unit">
									<a href="#" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/homepage/52d0e24aea08/assets/img/categories/72x72_home_services.png">
										<h3 class="mainpage_browes_categories_content_title">Home Services</h3>
									</a>
								</div>
								<div class="mainpage_browes_categories_content_unit">
									<a href="javascript:;" class="mainpage_browes_categories_content_link">
										<img class="mainpage_browes_categories_content_img"  width="72" src="https://s3-media4.fl.yelpcdn.com/assets/srv0/homepage/3110ec19fa2b/assets/img/categories/72x72_more_categories.png">
										<h3 class="mainpage_browes_categories_content_title change_title">More Categories</h3>
									</a>
								</div>
							</div>
						</div>
						
						
						
						<div class="mainpage_browes_more_categories is_disabled" id="mainpage_more_categories" style="max-height: 0px; position: static; visibility: visible;">
							<div class="more_categories_divider hr_line"></div>
						
							<div class="mainpage_browes_more_categories_lines">
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_coffee">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M19 13h-1a3 3 0 0 1-3 3H7a3 3 0 0 1-3-3V5h15a3 3 0 0 1 3 3v2a3 3 0 0 1-3 3zm1-5c0-.55-.45-1-1-1h-1v4h1c.55 0 1-.45 1-1V8zm2 10a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h18a1 1 0 0 1 1 1z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Coffee & Tea</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Food">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M17.22 22a1.78 1.78 0 0 1-1.74-2.167l1.298-4.98L14 13l1.756-9.657A1.635 1.635 0 0 1 19 3.635V20.22A1.78 1.78 0 0 1 17.22 22zm-7.138-9.156l.697 7.168a1.79 1.79 0 1 1-3.56 0l.7-7.178A3.985 3.985 0 0 1 5 9V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.83c0 1.85-1.2 3.518-2.918 4.014z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Food</strong>
									</a>
								</div>
								
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Arts_Entertainment">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M11.85 3c-4.73.08-8.7 3.99-8.85 8.72-.02.62.03 1.23.13 1.82A3.003 3.003 0 0 0 6.09 16H11c.55 0 1 .45 1 1v.19c0 2.3 2.49 3.76 4.49 2.61A9.002 9.002 0 0 0 11.85 3zM8 11.5c-.83 0-1.5-.67-1.5-1.5S7.17 8.5 8 8.5s1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm3 8c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm1-5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Arts & Entertainment</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Health_Medical">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M15 9V4H9v5H4v6h5v5h6v-5h5V9h-5z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Health & Medical</strong>
									</a>
								</div>
							</div>
							<div class="mainpage_browes_more_categories_lines">
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Professional_Service">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M19 20H5a3 3 0 0 1-3-3v-4h8v3h4v-3h8v4a3 3 0 0 1-3 3zM2 7h6V4h8v3h6v5H2V7zm8 0h4V6h-4v1z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Professional Services</strong>
									</a>
								</div>
							
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Pets">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M16.956 14.106l-7.07-7.07A2.5 2.5 0 0 0 6.35 3.498a2.49 2.49 0 0 0-.698 2.13 2.493 2.493 0 0 0-2.13.697A2.5 2.5 0 0 0 7.057 9.86l7.07 7.07a2.5 2.5 0 0 0 3.536 3.538 2.49 2.49 0 0 0 .698-2.13 2.49 2.49 0 0 0 2.134-.7 2.5 2.5 0 1 0-3.536-3.534z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Pets</strong>
									</a>
								</div>
							
							
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_RealEstate">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M12 3l-8.48 9.327C2.938 12.97 3.393 14 4.26 14H5v7h5v-5h4v5h5v-7h.74c.868 0 1.323-1.03.74-1.673L12 3z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Real Estate</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Hotels_Travel">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M20.4 13.61a1.924 1.924 0 0 0-1.825-.505l-2.203.55-3.228-3.227 5.973-4.887-.438-.436a1.92 1.92 0 0 0-2.117-.407L10.157 7.44 6.732 4.018c-.75-.75-2.644-1.43-3.394-.68-.75.75-.07 2.646.68 3.395l3.423 3.425-2.743 6.408a1.92 1.92 0 0 0 .407 2.114l.44.437 4.886-5.973 3.227 3.228-.55 2.203a1.92 1.92 0 0 0 .504 1.824l.59.586 2.717-4.073 4.073-2.716-.59-.59z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Hotels & Travel</strong>
									</a>
								</div>
							</div>
						
						
							<div class="mainpage_browes_more_categories_lines">
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Local_Service">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M21 10h-8.35A5.996 5.996 0 0 0 1 12a5.996 5.996 0 0 0 11.65 2H14v1a1 1 0 0 0 1 1h1a1 1 0 0 0 1-1v-1h1v1a1 1 0 0 0 1 1h1a1 1 0 0 0 1-1v-1a2 2 0 0 0 0-4zM7 14a2 2 0 1 1 0-4 2 2 0 0 1 0 4z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Local Services</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_EventPlanning_Services">
									<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M15.14 14.96L17 18h-2v5h-1v-5h-2l1.86-3.04C10.85 14.586 8.5 11.616 8.5 8c0-3.87 2.69-7 6-7s6 3.13 6 7c0 3.617-2.35 6.587-5.36 6.96zM12.39 3.55c-.54-.14-1.14.39-1.36 1.19-.21.8.05 1.57.58 1.71.54.14 1.14-.39 1.36-1.19.21-.8-.05-1.57-.58-1.71zm-.45 11.89a4.737 4.737 0 0 1-2.82 1.49L10.5 19H9v4H8v-4H6.5l1.367-2.05c-2.53-.365-4.487-2.88-4.487-5.93 0-3.1 2.02-5.66 4.61-5.95-.32.91-.49 1.9-.49 2.93 0 3.38 1.84 6.27 4.44 7.44z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Event Planning & Services</strong>
									</a>
								</div>
								
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_PublicServices_Government">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M21 11V9h-1l-8-6-8 6H3v2h2v7H4v1H3v2h18v-2h-1v-1h-1v-7h2zm-8 7h-2v-7h2v7zm-6-7h2v7H7v-7zm10 7h-2v-7h2v7z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Public Services & Government</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Financial_Services">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M6 19v-2h14V9h2v10H6zM2 5h16v10H2V5zm8 7.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Financial Services</strong>
									</a>
								</div>
							</div>
							
							
							<div class="mainpage_browes_more_categories_lines">
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Education">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M9.994 18H19v1H9.993v-1zm7.004-1H8.493c-.827 0-1.5.673-1.5 1.5s.673 1.5 1.5 1.5h9.505a1 1 0 0 1 0 2h-9.28c-1.812 0-3.467-1.277-3.7-3.075-.09-.7-.027-1.925-.027-1.925V4a2 2 0 0 1 2.004-2H17a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Education</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Religious_Organizations">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M18.5 11L16 14.5v-6L12 3 8 8.5v6L5.5 11 3 14.5V21h7v-4h4v4h7v-6.5L18.5 11z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Religious Organizations</strong>
									</a>
								</div>
								
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Local_Flavor">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M12 1.5l2.61 6.727 6.89.53-5.278 4.688 1.65 7.055L12 16.67 6.13 20.5l1.648-7.055L2.5 8.757l6.89-.53L12 1.5z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;"> Local Flavor</strong>
									</a>
								</div>
								
								<div class="mainpage_browes_more_categories_units">
									<span style="width: 24px; height: 24px;" class="icon mainpage_24x24_Mass_Media">
										<svg class="icon_svg" viewBox="0 0 24 24" height="100%" width="100%">
											<path d="M19 6h-6.586l2.293-2.293a1 1 0 1 0-1.414-1.414L10 5.586 6.707 2.293a1 1 0 1 0-1.414 1.414L7.586 6H5a3 3 0 0 0-3 3v8a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V9a3 3 0 0 0-3-3zm-3 11c0 .55-.45 1-1 1H5c-.55 0-1-.45-1-1V9c0-.55.45-1 1-1h10c.55 0 1 .45 1 1v8zm3-4c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm0-3c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"></path>
										</svg>
									</span>
									<a href="#">
										<strong style="font-weight: 700;">Mass Media</strong>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div class="under_review_container">
		<div class="under_review_content_container">
			<div class="un_named">
				<div class="mainpage_home_container_section">
					<div style="width: 100%; height:auto; overflow: hidden;">
						<div class="mainpage_review_of_the_day">
							<div class="review_of_the_day_container">
								<h2 class="review_of_the_day_title">Review of the Day</h2>
								<c:if test="${empty review_of_the_day_reviewDTO}">
									등록된 리뷰가 없습니다.
								</c:if>
								<c:if test="${!empty review_of_the_day_reviewDTO}">
								<div class="review_of_the_day_content">
									<div class="review_of_the_day_writer_container">
										<div class="review_of_the_day_writer_photo_box">
											<div>
												<a href="member_details?mnum=${review_of_the_day_reviewDTO.memberDTO.mnum}">
												<!-- 만약 아이디에 사진 없다면 이거 띄우도록 이프 문! -->
													<c:if test="${review_of_the_day_reviewDTO.memberDTO.memberPhotoDTO.member_filename == null}">
														<img class="review_of_the_day_writer_img" height="60" widgh="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png" style="border-radius: 4px;">
													</c:if>
													<c:if test="${review_of_the_day_reviewDTO.memberDTO.memberPhotoDTO.member_filename != null}">
														<img class="review_of_the_day_writer_img" height="60" widgh="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${review_of_the_day_reviewDTO.memberDTO.memberPhotoDTO.member_filename}" style="border-radius: 4px;">
													</c:if>
												</a>
											</div>
										</div>
										
										<div class="review_of_the_day_writer_info">
											<strong style="font-weight: 700;">
												<a href="member_details?mnum=${review_of_the_day_reviewDTO.mnum}" class="review_of_the_day_writer">
													${review_of_the_day_reviewDTO.memberDTO.email}
												</a>
											</strong>
											<ul class="review_of_the_day_writer_status">												
												<li class="review_of_the_day_writer_review_count">
													<span class="icon 18x18_review_icon">
														<svg style="fill: #f15c00; width: 18px; height: 18px;">
															<path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
														</svg>
													</span>
													<b>${review_of_the_day_reviewDTO.memberDTO.reviewcount}</b>
												</li>
												
												<li class="review_of_the_day_writer_image_count">
													<span class="icon 18x18_review_icon">
														<svg style="fill: #f15c00; width: 18px; height: 18px;">
															<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
														</svg>
													</span>
													<b>${review_of_the_day_reviewDTO.memberDTO.imagecount}</b>
												</li>
											</ul>
											<div class="where_write_review">
												Wrote a review for
												<div style="display: inline;">
													<span>
														<a href="restaurant_content?rnum=${review_of_the_day_restaurantDTO.rnum}&rname=${review_of_the_day_restaurantDTO.rname}" style="font-weight: 700;">
															${review_of_the_day_restaurantDTO.rname}
														</a>
													</span>
												</div>   
											</div>
										</div>
									</div>
									
									<div class="bedge_benner_blue">
										Review of the Day
										<img class="bedge_benner_blue_img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/40x40_rotd.png" width="40">
									</div>
									
									<div class="mainpage_review_rating_regdate">
										<div>											
											<div class="mainpage_review_rating pre_div_star${review_of_the_day_reviewDTO.gradepoint}" title="4.0 star rating">
												<img class="pre_starimg1" height="303" width="84" alt="4.0 star rating" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" >
											</div>
										</div>
										<span>
											${review_of_the_day_reviewDTO.reg_date} 작성
										</span>
									</div>
									
									<p style="margin-bottom: 12px;">
										${fn:replace(review_of_the_day_reviewDTO.content,crcn,br)}
									</p>
								</div>
								</c:if>
								
								<p style="text-align: center!important; margin-bottom: 12px;">
									<a href="previous_reviews">
										Read previous reviews
									</a>
								</p>
								
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="mainpage_home_container_section">
					<h2 class="browes_categories_section_header" style="margin-bottom: 6px;">
						Recent Activity
					</h2>
					
					<div class="recent_activity_wrapper">
						<div class="recent_activity_container">
							<div class="recent_activity_line">	
							<!-- 여기 이거 반복문!!!!! -->
								<c:forEach var="reviewDTO" items="${recentReviewInfoList}" varStatus="status">
								<div class="recent_activity_unit">
									<div class="recent_activity_unit_header">
										<div class="recent_activity_unit_header_content">
											<div class="recent_activity_unit_header_user_profile">
												<div class="photo_box">
													<a href="member_details?mnum=${reviewDTO.memberDTO.mnum}">
														<c:if test="${empty reviewDTO.memberDTO.memberPhotoDTO.member_filename}">
															<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png" height="30" width="30" style="border-radius: 4px;">
														</c:if>
														<c:if test="${!empty reviewDTO.memberDTO.memberPhotoDTO.member_filename}">
															<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${reviewDTO.memberDTO.memberPhotoDTO.member_filename}" height="30" width="30" style="border-radius: 4px;">
														</c:if>
														
													</a>
												</div>
											</div>
											
											<div class="recent_activity_unit_header_user_profile" style="width: 100%;">
												<a href="member_details?mnum=${reviewDTO.memberDTO.mnum}">
													<c:if test="${empty reviewDTO.memberDTO.nickname}">
														<strong>${reviewDTO.memberDTO.email}</strong>
													</c:if>
													<c:if test="${!empty reviewDTO.memberDTO.nickname}">
														<strong>${reviewDTO.memberDTO.nickname}</strong>
													</c:if>
												</a>
												<br>
												<span style="float: left; margin-right: 12px; margin-bottom: -2px;">
													Wrote a review
												</span>
											</div>
										</div>
									</div>
									
									
									<!-- 만약 사진이 있으면 보이고 없으면 안보이고 -->
									<div class="recent_activity_unit_content">
										<div class="recent_activity_unit_content_photo">
											<c:if test="${empty reviewDTO.restaurantDTO.fileDTO.filename}">
											<div class="photo_box_background" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png)">
												<a href="restaurant_content?rnum=${reviewDTO.restaurantDTO.rnum}" style="display: block;">
													<img class="recent_activity_photo_box" height="400" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png" width="600">
												</a>
											</div>
											</c:if>
											<c:if test="${!empty reviewDTO.restaurantDTO.fileDTO.filename}">
											<div class="photo_box_background" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${reviewDTO.restaurantDTO.fileDTO.filename})">
												<a href="restaurant_content?rnum=${reviewDTO.restaurantDTO.rnum}" style="display: block;">
													<img class="recent_activity_photo_box" height="400" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${reviewDTO.restaurantDTO.fileDTO.filename}" width="600">
												</a>
											</div>
											</c:if>
										</div>
										
										<div class="recent_activity_unit_content_text_body">
											<div class="recent_activity_unit_content_text_body_title">
												<div class="recent_activity_unit_content_text_body_title_link">
													<span>
														<a href="restaurant_content?rnum=${reviewDTO.rnum}" style="font-weight: 700;">
															<span>
																${reviewDTO.restaurantDTO.rname}
															</span>
														</a>
													</span>
												</div>
											</div>
											
											<div class="recent_activity_unit_content_text_body_star">
												<div class="pre_div_star${reviewDTO.gradepoint} star_wrapper" title="4.0 star rating">
                                           			<img class="pre_starimg1" height="303" width="84" alt="4.0 star rating" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png" >
                                        		</div>
											</div>
											
											<p class="recent_activity_unit_content_text">
												<span>
													${reviewDTO.content}
												</span>
											</p>
										</div>
									</div>
									
									<div class="recent_activity_unit_footer">
										<a href="#" style="white-space: nowrap!important;">
											전체 보기
										</a>
									</div>
								
								</div>
								</c:forEach>
								
							</div>
						
						
						<p class="recent_activity_readmore">
							<a id="show_more_activity">
								<span class="icon" style="width: 24px; height: 24px; margin-right: 3px!important; fill: currentColor; ">
									<svg class="svg_icon" height="100%" viewBox="0 0 24 24" width="100%">
										<path d="M18.364 9.525L16.95 8.11 12 13.06 7.05 8.11 5.636 9.526 12 15.89l6.364-6.365z"></path>
									</svg>
								</span>
								
								<span>
									Show more activity in 해당 지역
								</span>
							</a>
						</p>
					</div>
				</div>				
			</div>
		</div>
	</div>
</div>
	
<div class="hover_card" style="top: 383px; display: none;">
	<div class="hovercard-inner">
		<div class="business-hovercard">
			<div class="media-block">
				<div class="media-avatar">
					<div>
						<a href="restaurant_content?rnum=${randomPhoto.rnum}">
							<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${randomPhoto.filename}" height="90" width="90">
						</a>
					</div>
				</div>
				
				<div class="media-story">
					<div class="media-title">
						<a href="restaurant_content?rnum=${randomPhoto.rnum}">
							${randomPhoto.restaurantDTO.rname}
						</a>
					</div>
					<div class="biz-rating-large">
						<div class="mainpage_review_rating pre_div_star${randomPhoto_starAvg}" title="4.0 star rating">
							<img class="pre_starimg1" height="303" width="84" alt="4.0 star rating" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" >
						</div>
						<span class="mainpage_new_business_review_count">
							${randomPhoto_reivewCount} reviews
						</span>
					</div>
					<div class="price-category">
						<span>
							${randomPhoto.restaurantDTO.category}
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<span class="arrow-icon"></span>
</div>
	
	
	
	<script>
	$(document).ready(function() {
		$('#page_header_inputs').click(function() {
			$('#main_search_suggestion_container').show();
			$('#find_label').css('border-radius', '4px 0 0 0');
		})
		$('#page_header_location_inputs').click(function() {
			$.ajax({
				type : 'post',
					url : 'recent_location_list',
					dataType : 'json',
					success : function(responseData){
						if(responseData != null){
							$(".recent_location").remove();
							for(var i=0; i < responseData.length ; i++){
								var recentLocation = responseData[i];
								$("#location_suggestion_container_list").append("<li class='suggestions-location-list-item recent_location' onmouseout=\"javascript:outMouse('location_icon')\" onclick=\"javascript:loc_clickMouse('"+recentLocation+"')\"><div class='location-media-block'><div class='location-media-avatar'><span id='location_icon' style='width: 24px; height: 24px;'><svg class='icon_svg'><path d='M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-18c-4.41 0-8 3.59-8 8s3.59 8 8 8 8-3.59 8-8-3.59-8-8-8zm3 11c-.19 0-.384-.055-.555-.168L11 12.535V7a1 1 0 0 1 2 0v4.465l2.555 1.703A1 1 0 0 1 15 15z'></path></svg></span></div><div class='location-media-story'><span class='suggestion-location-detail'><span class='suggestion-location-detail suggestion-location-name'>"+recentLocation+"</span></span></div></div></li>");
							}
						}
					},
	             	error : function(request, status, error) {
	                	alert("error : locationList")
	             	},
	        });
			$('#main_location_suggestion_container').show();
		})
		
		$(document).on('mouseenter', '.mainpage_header_recommend_name', function(e) {
			$('.hover_card').css('left', Math.max(0, (($(window).width() - $(this).outerWidth()) / 2 - 125)) + "px");
			$('.hover_card').css('display', 'block');
			e.stopPropagation();
		    e.preventDefault();
		})
		
		$(document).on('mouseleave', '.mainpage_header_recommend_name', function(e) {
			$(document).on('mouseenter', '.hover_card', function() {
				$('.hover_card').css('display', 'block');
			})
			$('.hover_card').css('display', 'none');
		})
		
		$(document).on('mouseleave', '.hover_card', function() {
				$('.hover_card').css('display', 'none');
		})
		
		$(document).on('mouseover', '.suggestions-location-list-item', function() {
			$(this).find('#location_icon').css('fill', 'white');
		})
		$(document).on('mouseleave', '.suggestions-location-list-item', function() {
			$(this).find('#location_icon').css('fill', '#666');
		})
		
		$('#mainpage_header_inner_category_block').hover(function() {
			$('#header_page_footer_dropdown').attr('id', 'header_page_footer_dropdown_view');
			$('#mainpage_header_inner_category_block').attr('id', 'mainpage_header_inner_category_block_active');
			$('#header_page_footer_dropdown_wrap').css('pointer-events', 'auto');
		})
		$('#mainpage_header_inner_category_block').mouseleave(function() {
			$('#header_page_footer_dropdown_view').attr('id', 'header_page_footer_dropdown');
			$('#mainpage_header_inner_category_block_active').attr('id', 'mainpage_header_inner_category_block');
			$('#header_page_footer_dropdown_wrap').css('pointer-events', 'none');
		})
		
		$('.mainpage_searchbutton').hover(function() {
			$('.mainpage_searchbutton').css('background', '#c91400');
		})
		$('.mainpage_searchbutton').mouseleave(function() {
			$('.mainpage_searchbutton').css('background', '#bd1f1f');
		})
			
		$('.drop-menu-link').click(function(e) {
			$('#topbar-account-wrap').toggle();
		    e.stopPropagation();
		    e.preventDefault();
		});
		
		$(document).on('click', '.mainpage_browes_categories_content_link', function(e) { 			
 			if($('#mainpage_more_categories').hasClass('is_disabled')) {
  				$('.change_title').text('Fewer Categories');
 	 			$('#mainpage_more_categories').removeClass('is_disabled');
  	 			$('.mainpage_browes_more_categories').css('max-height', '212px');
  	 			$('.mainpage_browes_more_categories').css('position', 'static');
 			} else {
 				$('.change_title').text('More Categories');
	 			$('#mainpage_more_categories').addClass('is_disabled');
 	 			$('.mainpage_browes_more_categories').css('max-height', '0px');
 			}
		});
		   
		$(document).on('click', function(e) {
			if(!$(e.target).hasClass("drop-menu-has-arrow") && !$(e.target).hasClass('drop-menu-group')) {
				$('#topbar-account-wrap').hide();
			}
			if(!$(e.target).hasClass("page_header_searchDate_inputs")){
	        	$(".search_arrange_suggestions").hide();
	        }
	        if($(e.target).hasClass("page_header_searchDate_inputs")){
	        	var searchData = document.getElementById("page_header_searchDate_inputs").value;
	     		if(searchData == null || searchData == ""){
	     			$(".search_arrange_suggestions-list-item").remove();
	     			$(".search_arrange_suggestions").hide();		
	     		}else{
	     	        $.ajax({
	     	            type : 'post',
	     	             url : 'search_auto_complete',
	     	             data : {searchData:searchData},
	     	             dataType : 'json',
	     	             success : function(responseData){
	     	            	 if(responseData.length == 0){
	     	            		 $(".search_arrange_suggestions").hide();
	     	            	 }else{
	     		            	 $(".search_arrange_suggestions-list-item").remove();
	     		            	 for(var i=0; i < responseData.length ; i++){
	     		            		var autoComple = responseData[i];
	     		            		$(".search_arrange_suggestions-list").append('<li class="search_arrange_suggestions-list-item"><input type="hidden" id="search_word" value="'+ autoComple +'"><div class="search_arrange_suggestions_media-block"><div class="search_arrange_suggestions_media-story"><span class="search_arrange_suggestion-detail"><span class="search_arrange_suggestion-detail search_arrange_suggestion-title"><b>'+ autoComple +'</b></span></span><small class="search_arrange_suggestion-detail search_arrange_suggestion-subtitle"></small></div></div></li>');
	     		            	 }
	     		            	 $(".search_arrange_suggestions").show();
	     	            	 }
	     	             },
	     	             error : function(request, status, error) {
	     	                alert("실패")
	     	             },
	     	             
	     	        });
	     		}
	         }
		});
	});
	
	$('html').click(function(e) {
		if(!$(e.target).hasClass("page_header_inputs"))	{
			$('#main_search_suggestion_container').hide();
			$('#find_label').css('border-radius', '4px 0 0 4px');
		}
		if(!$(e.target).hasClass("page_header_location_inputs")) {
			$('#main_location_suggestion_container').hide();
		}
	});
	
	$(document).on('click', '#show_more_activity', function() {
		var height = parseInt($('.recent_activity_line').css('max-height'));
 		$('.recent_activity_line').css("max-height", height+700);
	})
	
	
	</script>
	
	<script type="text/javascript">
		function onMouse(obj) {
			document.getElementById(obj).style.fill = "white";
		}
	
		function outMouse(obj) {
			if(obj == 'location_icon') {
				document.getElementById(obj).style.fill = "#0073bb";
			} else {
				document.getElementById(obj).style.fill = "#666";
			}
		}
	
		function clickMouse(obj) {
			document.getElementById("page_header_inputs").value = obj;
// 			document.page_header_form.action = "#";
// 			document.page_header_form.submit();
		}
		function loc_clickMouse(obj) {
			document.getElementById("page_header_location_inputs").value = obj;
// 			document.page_header_form.action = "#";
// 			document.page_header_form.submit();
		}
	</script>
	
	<script type="text/javascript">
	$("#page_header_searchDate_inputs").keyup(function() {
		var searchData = document.getElementById("page_header_searchDate_inputs").value;
		
		if(searchData == null || searchData == ""){
			$(".search_arrange_suggestions-list-item").remove();
			$(".search_arrange_suggestions").hide();		
		}else{
	        $.ajax({
	            type : 'post',
	             url : 'search_auto_complete',
	             data : {searchData:searchData},
	             dataType : 'json',
	             success : function(responseData){
	            	 if(responseData.length == 0){
	            		 $(".search_arrange_suggestions").hide();
	            	 }else{
		            	 $(".search_arrange_suggestions-list-item").remove();
		            	 for(var i=0; i < responseData.length ; i++){
		            		var autoComple = responseData[i];
		            		$(".search_arrange_suggestions-list").append('<li class="search_arrange_suggestions-list-item"><input type="hidden" id="search_word" value="'+ autoComple +'"><div class="search_arrange_suggestions_media-block"><div class="search_arrange_suggestions_media-story"><span class="search_arrange_suggestion-detail"><span class="search_arrange_suggestion-detail search_arrange_suggestion-title"><b>'+ autoComple +'</b></span></span><small class="search_arrange_suggestion-detail search_arrange_suggestion-subtitle"></small></div></div></li>');
		            	 }
		            	 $(".search_arrange_suggestions").show();
	            	 }
	             },
	             error : function(request, status, error) {
	                alert("실패")
	             },
	             
	        });
		}
	});
	
	$(document).on('click', '.search_arrange_suggestions-list-item', function() {
		var searchword = $(this).children('#search_word').val();
		$("#page_header_searchDate_inputs").val(searchword);
		$(".search_arrange_suggestions").hide();
		$("#page_header_searchDate_inputs").focus();
	});
	
	$(document).on('click', '#suggestion_container_list_items_button', function() {
		var nav = null;
		
		 if (nav == null) {
		      nav = window.navigator;
		  }
		  if (nav != null) {
		      var geoloc = nav.geolocation;
		      if (geoloc != null) {
		          geoloc.getCurrentPosition(successCallback);
		      }
		      else {
		          alert("geolocation not supported");
		      }
		  }
		  else {
		      alert("Navigator not found");
		  }
	});
	
	function successCallback(position){
		document.getElementById("latitude").value = position.coords.latitude;
		document.getElementById("longitude").value = position.coords.longitude;
	}
</script>

<%@include file="bottom.jsp"%>

