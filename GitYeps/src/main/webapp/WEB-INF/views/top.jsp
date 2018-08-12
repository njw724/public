<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/mainPage.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=2"/>"/>  
<link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<body ondragstart="return false">
<input type="hidden" id="set" value="${set}">
<div id="wrap" style="background: white;">
<div id="page_header">
	<div id="header_main_content_wrap">
		<div id="main_content_wrap">
			<div id="content_container">
				<div id="content_container_arrange">
					<div id="yeps_img">
						<a href="main">Yeps</a>
					</div>
					<div id="yeps_search_arrange_wrap">
						<form action="yeps_main_saerch" name="page_header_form" method="post" style="margin: 0; padding: 0; width: 100%;">
							<div id="yeps_search_arrange">
								<label id="find_label">
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
								<label id="near_label">
									<span id="label_span">Near</span>
									<span id="label_input_span">
										<input type="text" maxlength="80" name="location" id="page_header_location_inputs" class="page_header_location_inputs" autocomplete="off" placeholder="지역별 검색">
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
								<label id="yeps_search_arrange_label">
									<span id="search_input_span">
										<input type="text" maxlength="80" id="page_header_searchDate_inputs" class="page_header_searchDate_inputs" name="searchword" autocomplete="off" placeholder="검색어를 입력하세요.">
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
										<button type="submit" value="submit" tabindex="3" title="Search" id="header_searchbutton">
											<span aria-hidden="true" style="fill: #fff;">
												<svg id="24x24_search" viewBox="0 0 24 24">
													<path d="M20.753 19.34l-4.295-4.297A7.46 7.46 0 0 0 18 10.5a7.5 7.5 0 1 0-7.5 7.5 7.46 7.46 0 0 0 4.543-1.542l4.296 4.295a1 1 0 1 0 1.412-1.414zM10.5 16A5.506 5.506 0 0 1 5 10.5C5 7.467 7.467 5 10.5 5S16 7.467 16 10.5 13.533 16 10.5 16z"></path>
												</svg>
											</span>
										</button>
									</div>
								</div>
							</div>
						</form>
					</div>
						
						<c:choose>
							<c:when test="${empty sessionScope.memberinfo}">
								<div id="page_header_signup_wrap">
									<ul style="display: inline-block;">
										<li style="display: list-item; text-align: -webkit-match-parent;">
											<a href="member_login?mode=signup" id="page_header_signup">
												Sign Up
											</a>
										</li>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<div id="page_header_notifications_wrap">
									<div id="page_header_notifications">
										<a href="yeps_message" class="header-nav_link" id="messages-icon" data-analytics-label="messages_icon">
                                 			<span aria-label="Messages" style="width: 24px; height: 24px;" class="icon icon--24-speech icon--size-24 icon--white icon--fallback-inverted">
                                     			<svg class="icon_svg">
                                         			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#24x24_speech">
                                             			<svg id="24x24_speech" height="100%" viewBox="0 0 24 24" width="100%">
                                                 			<path d="M18 3H6C4.34 3 3 4.34 3 6v7c0 1.66 1.34 3 3 3h2v5l5-5h5c1.66 0 3-1.34 3-3V6c0-1.66-1.34-3-3-3z"></path>
                                             			</svg>
                                         			</use>
                                    			</svg>
                                 			</span>
                               				<c:if test="${ not empty sessionScope.noneCount && sessionScope.noneCount > 0}">
                                 				<span class="ybadge ybadge--notification ">${sessionScope.noneCount}</span>
                              				</c:if>
										</a>
										<a href="member_details" class="header-nav_link show-tooltip js-analytics-click" id="notifications-icon" data-analytics-label="notifications_icon">
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
                                    <a class="drop-menu-link user-account_button drop-menu-highlighted" href="#" id="topbar-account-link" data-component-bound="true">
                                       <span class="user-account_avatar responsive-visible-large-block">
                                          <c:choose>
                                             <c:when test="${empty sessionScope.mainPhoto}">
                                                <img class="photo-box-img" height="90" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_medium_square.png" width="90">
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
                                    <div id="topbar-account-wrap" class="drop-menu drop-menu-has-arrow">
                                       <div class="drop-menu-arrow responsive-hidden-small"></div>
                                          <div class="drop-menu-group responsive-visible-large-block">
                                             <div class="ypassport ypassport-notext media-block">
                                                <div class="media-avatar responsive-photo-box js-analytics-click">
                                                   <div class="photo-box pb-60s">
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
                                                         <a class="user-display-name js-analytics-click" href="member_details" id="dropdown_user-name">
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
                                                         <b>${sessionScope.memberinfo.imagecount}</b>
                                                      </li>
                                                   </ul>
                                                </div>
                                             </div>
                                           </div>
                                          <ul class="drop-menu-group--nav drop-menu-group">
                                             <li class="drop-down-menu-link">
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_details?mnum=${sessionScope.memberinfo.mnum}" style="display: block; word-wrap: break-word;">
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
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="yeps_message">
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
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="manager_managerPage">
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
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_profile">
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
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div id="header_main_content_footer_wrap">
			<div id="footer_content_container">
				<div id="footer_container_arrange">
					<div id="footer_container_list">
						<div id="footer_list" style="display: table-cell;">
							<ul style="display: inline-block;">
								<li id="footer_list_li">
									<div>
										<a href="restaurant_list" id="footer_list_li_unit">
											<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
												<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
													<path d="M13.61 17h-.007a1.39 1.39 0 0 1-1.376-1.587L13 10l-2-1c0-5.373 1.375-8 3.25-8 .497 0 .75.336.75.75v13.86A1.39 1.39 0 0 1 13.61 17zM6.557 9.912l.35 5.59a1.41 1.41 0 1 1-2.813 0l.35-5.59A1.994 1.994 0 0 1 3 8V1.5a.5.5 0 0 1 1 0v5a.5.5 0 0 0 1 0v-5a.5.5 0 0 1 1 0v5a.5.5 0 0 0 1 0v-5a.5.5 0 0 1 1 0V8c0 .91-.61 1.67-1.443 1.912z"></path>
												</svg>
											</span>
											Restaurants
										</a>
									</div>
								</li>
								<li id="footer_list_li">
									<div>
										<a href="#" id="footer_list_li_unit">
											<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
												<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
													<path d="M15.55 3.66c.565-.648.105-1.66-.754-1.66H3.204a1 1 0 0 0-.753 1.66L8 9v5H6a1 1 0 0 0 0 2h6a1 1 0 0 0 0-2h-2V9l5.55-5.34zM11 3a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"></path>
												</svg>
											</span>
											Nightlife
										</a>
									</div>
								</li>
								<li id="footer_list_li">
									<div id="footer_list_block">
										<a href="#" id="footer_list_li_unit_after">
											<span style="width: 18px; height: 18px; margin-right: 3px !important; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; fill: #fff;">
												<svg id="18x18_food" height="100%" viewBox="0 0 18 18" width="100%">
													<path d="M12.772 8.594c-.337 0-.656-.067-.962-.164l-6.99 7.116a1.472 1.472 0 0 1-2.11 0 1.538 1.538 0 0 1 0-2.15L9.697 6.28a3.34 3.34 0 0 1-.16-.98c0-1.82 1.447-3.294 3.234-3.294.338 0 .657.068.963.165L11.93 4.01l2.11 2.15 1.806-1.837c.095.312.162.637.162.98 0 1.82-1.45 3.294-3.236 3.294zM4.955 6.198L3.54 5.21 1.998 3.64l1.565-1.59 1.54 1.57.905 1.508L7.71 6.86 6.658 7.932 4.955 6.198zm10.006 7.198a1.54 1.54 0 0 1 0 2.15 1.475 1.475 0 0 1-2.11 0l-3.314-3.374 2.11-2.15 3.316 3.374z"></path>
												</svg>
											</span>
											Home service
											<span style="width: 14px; height: 14px; fill: currentColor; display: inline-block; vertical-align: middle; position: relative; overflow: hidden; top: -.1em; left: -3px;">
												<svg id="14x14_triangle_down" height="100%" viewBox="0 0 14 14" width="100%">
													<path d="M7 9L3.5 5h7L7 9z"></path>
												</svg>
											</span>
										</a>
										<div id="header_page_footer_dropdown_wrap">
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
							</ul>
							<ul style="display: inline-block;">
								<li id="footer_list_dot">
									<div class="before">
										·
									</div>
								</li>
								<li id="footer_list_li_review">
									<div>
										<a href="review_restaurantIMG" id="footer_list_li_unit"> 
											Write a Review
										</a>
									</div>
								</li>
								<li id="footer_list_li_event">
									<div>
										<a href="event_list" id="footer_list_li_unit">
											Events
										</a>
									</div>
								</li>
								<li id="footer_list_li_message">
									<div>
										<a href="yeps_message" id="footer_list_li_unit">
											Message
										</a>
									</div>
								</li>
							</ul>
						</div>
						<c:if test="${empty sessionScope.memberinfo}">
								<div id="footer_list_login_box">
									<a href="member_login?mode=login" id="footer_list_li_unit" style="color: white; font-weight: bold; min-width: 80px; padding: 3px 10px;">Log In</a>
								</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	$(document).ready(function() {
		var set = $('#set');
		if(set.val() == 'events') {
			$('#footer_list_li_event').css('background', '#9b1a1a');
		} else if(set.val() == 'review') {
			$('#footer_list_li_review').css('background', '#9b1a1a');
		} else if(set.val() == 'message') {
			$('#footer_list_li_message').css('background', '#9b1a1a');
		}
		
		var category = '${map.category}';
		var location = '${map.location}';
		var searchword = '${map.searchword}';
		$('#page_header_inputs').val(category);
		$('#page_header_location_inputs').val(location);
		$('#page_header_searchDate_inputs').val(searchword);
		
	});
		$(document).on("mouseenter","#footer_list_block",function(){
        $('#header_page_footer_dropdown').attr('id', 'header_page_footer_dropdown_view');
        $('#footer_list_li_unit_after').attr('id', 'footer_list_li_unit_after_active');
        $('#header_page_footer_dropdown_wrap').css('pointer-events', 'auto');
     });
     
     $(document).on("mouseleave","#footer_list_block",function(){
        $('#header_page_footer_dropdown_view').attr('id', 'header_page_footer_dropdown');
        $('#footer_list_li_unit_after_active').attr('id', 'footer_list_li_unit_after');
        $('#header_page_footer_dropdown_wrap').css('pointer-events', 'none');
     });
     
     $(document).on("click","#page_header_inputs",function(){
        $('#main_search_suggestion_container').show();
        $('#find_label').css('border-radius', '4px 0 0 0');
     });
     
     $(document).on("click","#page_header_location_inputs",function(){
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
     });
     
	$(document).on('mouseover', '.suggestions-location-list-item', function() {
		$(this).find('#location_icon').css('fill', 'white');
	})
	$(document).on('mouseleave', '.suggestions-location-list-item', function() {
		$(this).find('#location_icon').css('fill', '#666');
	})

     $(document).on("click",".drop-menu-link",function(e){
        $('#topbar-account-wrap').toggle();
        e.stopPropagation();
        e.preventDefault();
     });
     
     $(document).on('click', function(e) {
    	 if($(e.target).hasClass('drop-menu')) {
    		 e.stopPropagation();
    	     e.preventDefault();
    	 }
    	 
  		if(!$(e.target).hasClass('drop-menu')) {
  			$('#topbar-account-wrap').hide();
  		}
  	});
     
     $(document).on('click',"html", function(e) {
    	 if($(e.target).hasClass('drop-menu-link')) {
         	e.stopPropagation();
            e.preventDefault();
         }
         if(!$(e.target).hasClass("page_header_inputs"))   {
            $('#main_search_suggestion_container').hide();
            $('#find_label').css('border-radius', '4px 0 0 4px');
         }
         if(!$(e.target).hasClass("page_header_location_inputs")) {
            $('#main_location_suggestion_container').hide();
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
// 		document.page_header_form.action = "#";
// 		document.page_header_form.submit();
	}
	function loc_clickMouse(obj) {
		document.getElementById("page_header_location_inputs").value = obj;
// 		document.page_header_form.action = "#";
// 		document.page_header_form.submit();
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