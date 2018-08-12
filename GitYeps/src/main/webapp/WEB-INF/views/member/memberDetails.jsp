<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>Details</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css?ver=2"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=2"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=2"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css?ver=2"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css?ver=2"/>"/>
<script src="//code.jquery.com/jquery.min.js?ver=1"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js?ver=2"></script>
<script src="http://malsup.github.com/jquery.cycle2.js"></script>
</head>
<%@ include file="../top.jsp"%>
	<div class="member_details_wrap">
		<div class="member_details_top_shelf">
			<div class="member_details_content_container">
				<div class="member_details_user_profile_container">
					<div class="member_details_user_profile_avatar">
						<div class="member_details_photo_slideshow_wrap">
							<div class="member_details_photo_slideshow">
								<c:choose>
									<c:when test="${empty getPhotoList}">
										<div class="member_details_photo_slideshow_image">
											<a href="member_details">
												<img class="photo-box-img" height="250" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/user_large_square.png" width="250" style="width: 217px; height: auto;">
											</a>
										</div>
										<div class="member_photo_box_actions">
											<a class="member_photo-box_action-link" href="member_photos">
												<span aria-hidden="true" style="width: 18px; height: 18px;" class="member_icon">
													<svg class="member_icon_svg">
														<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 4.75a4.25 4.25 0 1 0 0 8.5 4.25 4.25 0 0 0 0-8.5zM11 10h-1v1a1 1 0 0 1-2 0v-1H7a1 1 0 0 1 0-2h1V7a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2z"></path>
													</svg>
												</span>
												<c:if test="${memberDTO.mnum == sessionScope.memberinfo.mnum}">
													<span class="member_photo-box_action-text">Add a photo</span>
												</c:if>
											</a>
										</div>
									</c:when>
									<c:otherwise>
										<div class="member_details_photo_slideshow_image cycle-slideshow" data-cycle-speed="1000" id="slideshow_img">
											<a class="member_photo-box_action-link" href="#"></a>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="member_details_user_profile_content_wrap">
						<div class="member_profile_avatar-dummy" aria-hidden="true"></div>
						<div class="member_profile_info">
							<h1>
								<c:set value="${memberDTO.name}" var="memberName"/>
                   				<c:choose>
                   					<c:when test="${fn:length(memberName) > 7}">
                   						<c:out value="${fn:substring(memberName,0,6)}"/>..
                   					</c:when>
                   					<c:otherwise>
                   						<c:out value="${memberName}"/>
                   					</c:otherwise> 
                   				</c:choose>
							</h1>
							<h3 class="member_location">
								<c:choose>
									<c:when test="${!empty memberDTO.address}">
										<c:forTokens items="${memberDTO.address}" delims=" " begin="1" end="2" var="addr">
											${addr}
										</c:forTokens>
									</c:when>
									<c:otherwise>
										서울특별시
									</c:otherwise>
								</c:choose>
							</h3>
							<ul class="user-passport-stats">
								<li class="review-count">
									<span aria-hidden="true" style="fill: #f15c00; width: 24px; height: 24px;" class="icon icon--24-review icon--size-24">
										<svg class="icon_svg">
											<path d="M21 6a3 3 0 0 0-3-3H6a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V6zm-5.88 10.428l-3.16-1.938-3.05 2.01.59-3.457L7 10.596l3.457-.505L11.96 6.5l1.582 3.59 3.458.506-2.5 2.447.62 3.385z"></path>
										</svg>
									</span>
									<strong>${memberDTO.reviewcount}</strong> Reviews
								</li>
								<li class="photo-count">
									<span aria-hidden="true" style="fill: #f15c00; width: 24px; height: 24px;" class="icon icon--24-camera icon--size-24">
										<svg class="icon_svg">
											<path d="M19 20H5a3 3 0 0 1-3-3V9a3 3 0 0 1 3-3h2.184A2.99 2.99 0 0 1 10 4h4a2.99 2.99 0 0 1 2.816 2H19a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3zM12.005 8.5a4.5 4.5 0 1 0 0 9 4.5 4.5 0 0 0 0-9zm0 7a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
										</svg>
									</span>
									<strong>${memberDTO.imagecount}</strong> Photos
								</li>
							</ul>
						</div>
						<div class="member_profile_actions">
							<ul class="member_action-link-list">
								<c:if test="${memberDTO.mnum == sessionScope.memberinfo.mnum}">
									<li>
										<a class="member_detail_arrange" href="member_photos" rel="">
											<div class="member_action-link_icon">
												<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon member_icon--currentColor">
													<svg class="icon_svg">
														<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 4.75a4.25 4.25 0 1 0 0 8.5 4.25 4.25 0 0 0 0-8.5zM11 10h-1v1a1 1 0 0 1-2 0v-1H7a1 1 0 0 1 0-2h1V7a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2z"></path>
													</svg>
												</span>
											</div>
											<div class="member_action-link_label">Add Profile Photos</div>
										</a>
									</li>
									<li>
										<a class="member_detail_arrange" href="member_profile" rel="">
											<div class="member_action-link_icon">
												<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon member_icon--currentColor">
													<svg class="icon_svg">
														<path d="M14 3H4a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zM4 6.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-3zM14 12H4v-1h10v1zm0-5h-4V6h4v1zm0 2h-4V8h4v1z"></path>
													</svg>
												</span>
											</div>
											<div class="member_action-link_label">Update Your Profile</div>
										</a>
									</li>
								</c:if>
								<c:if test="${memberDTO.mnum != sessionScope.memberinfo.mnum}">
									<li>
										<a class="member_detail_arrange" href="#" rel="" data-popup-open="writeMessage" alt="${memberDTO.email}">
											<div class="member_action-link_icon">
												<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon member_icon--currentColor">
													<svg class="icon_svg">
														<path d="M2 4v6a2 2 0 0 0 2 2h1v3l4-3h5a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"></path>
													</svg>
												</span>
											</div>
											<div class="member_action-link_label">Send message</div>
										</a>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="member_details_content_container">
			<div class="member_details_content_layout_block">
				<div class="details-column-alpha">
					<div class="details_section">
						<div class="details-title-menus">
							<div class="details_title-header">
								<div class="details_arrange">
									<div class="details_arrange_unit">
										<div class="details-titled-header_content">
			                    			<h3>
			                    				<c:set value="${memberDTO.name}" var="memberName"/>
			                    				<c:choose>
			                    					<c:when test="${fn:length(memberName) > 7}">
			                    						<c:out value="${fn:substring(memberName,0,6)}"/>..
			                    					</c:when>
			                    					<c:otherwise>
			                    						<c:out value="${memberName}"/>
			                    					</c:otherwise> 
			                    				</c:choose>’s Profile
			                    			</h3>
			                			</div>
			                		</div>
								</div>
							</div>
							<ul class="profile-nav_items">
								<li class="titled-nav_item">
									<a id="profile_overview" class="profile-nav_link">
										<div class="details_nav_link-content details_arrange">
											<div class="arrange_unit">
												<span aria-hidden="true" style="width: 24px; height: 24px;" class="icon details-nav_icon">
													<svg class="icon_svg">
														<path d="M4.37 22c.278-4.762 3.587-8 7.63-8 4.043 0 7.352 3.238 7.63 8H4.37zM12 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10z"></path>
													</svg>
												</span>
											</div>
											<div class="arrange_unit arrange_unit-fill">
												<span class="titled-nav_link-label">Profile Overview</span>
											</div>
										</div>
									</a>
								</li>
								<li class="titled-nav_item">
									<a id="profile_reviews" class="profile-nav_link">
										<div class="details_nav_link-content details_arrange">
											<div class="arrange_unit">
												<span aria-hidden="true" style="width: 24px; height: 24px;" class="icon details-nav_icon">
													<svg class="icon_svg">
														<path d="M21 6a3 3 0 0 0-3-3H6a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3V6zm-5.88 10.428l-3.16-1.938-3.05 2.01.59-3.457L7 10.596l3.457-.505L11.96 6.5l1.582 3.59 3.458.506-2.5 2.447.62 3.385z"></path>
													</svg>
												</span>
											</div>
											<div class="arrange_unit arrange_unit-fill">
												<span class="titled-nav_link-label">Reviews</span>
											</div>
										</div>
									</a>
								</li>
								<li class="titled-nav_item">
									<a id="profile_events" class="profile-nav_link">
										<div class="details_nav_link-content details_arrange">
											<div class="arrange_unit">
												<span aria-hidden="true" style="width: 24px; height: 24px;" class="icon details-nav_icon">
													<svg class="icon_svg">
														<path d="M18 21H6a3 3 0 0 1-3-3V6a3 3 0 0 1 3-3 1 1 0 0 1 2 0h8a1 1 0 0 1 2 0 3 3 0 0 1 3 3v12a3 3 0 0 1-3 3zm1-13H5v10c0 .55.45 1 1 1h12c.55 0 1-.45 1-1V8zm-5.634 7.723L12 18l-1.366-2.277a3.5 3.5 0 1 1 2.732 0zM12 11.25a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5z"></path>
													</svg>
												</span>
											</div>
											<div class="arrange_unit arrange_unit-fill">
												<span class="titled-nav_link-label">Events</span>
											</div>
										</div>
									</a>
								</li>
								<li class="titled-nav_item">
									<a id="profile_tips" class="profile-nav_link">
										<div class="details_nav_link-content details_arrange">
											<div class="arrange_unit">
												<span aria-hidden="true" style="width: 24px; height: 24px;" class="icon details-nav_icon">
													<svg class="icon_svg">
														<path d="M15 15.32V18H9v-2.68C6.64 14.19 5 11.79 5 9c0-3.87 3.13-7 7-7s7 3.13 7 7c0 2.79-1.64 5.19-4 6.32zM10.5 6C9.67 6 9 6.67 9 7.5S9.67 9 10.5 9 12 8.33 12 7.5 11.33 6 10.5 6zM13 22h-2a2 2 0 0 1-2-2h6a2 2 0 0 1-2 2z"></path>
													</svg>
												</span>
											</div>
											<div class="arrange_unit arrange_unit-fill">
												<span class="titled-nav_link-label">Tips</span>
											</div>
										</div>
									</a>
								</li>
							</ul>
							<div class="titled-nav-header" role="presentation"></div>
						</div>
					</div>
				</div>
				<div class="details-column-beta_overview">
					<div class="member_details_overview">
						<div class="member_details_overview_activity">
							<h2>Notifications</h2>
							<c:if test="${noneCount <= 0 || empty noneCount}" >
                    			<p class="member_details-no_notifications">No new friend requests or compliments at this time.</p>
                     		</c:if>
                     		<c:if test="${noneCount > 0 }" >
                     			<p class="member_details-no_notifications"> 읽지 않은 메시지가<span style="color: red; font-weight: bold;"> ${noneCount }</span>개 있습니다.</p>
                     		</c:if>
							
							
							<div class="member_details-overview_reviews">
							<!-- 작성한 리뷰가 있을 경우 -->
							</div>
							<div class="member_details_overview_self_feed">
								<!-- 작성한 리뷰가 없을 경우 -->
								<div class="member_section">
									<div class="member_section-header">
										<h2>Recent Activity</h2>
									</div>
									<div class="member_feeds">
										<ul class="content-list">
											<li data-section-id="self">
											 <!-- 작성한 리뷰가 있을 경우 -->
							                  <c:if test="${ not empty reviewcount}" >
							                      <h3 class="member_no-recent-activity" align="left"> 지금까지  <span style="color: red; font-weight: bold;"> ${reviewcount}</span> 개의 리뷰가 작성되었습니다.</h3>
  							                  </c:if>
  							                  <!-- 작성한 리뷰가 없을 경우 -->
                                              <c:if test="${ empty reviewcount}" >
												  <p class="member_no-recent-activity" align="left">
													  We don't have any recent activity for you right now.
												  </p>
											  </c:if>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="member_details_overview_sidebar">
							<h3>
								About
								<c:set value="${memberDTO.name}" var="memberName"/>
                   				<c:choose>
                   					<c:when test="${fn:length(memberName) > 7}">
                   						<c:out value="${fn:substring(memberName,0,6)}"/>..
                   					</c:when>
                   					<c:otherwise>
                   						<c:out value="${memberName}"/>
                   					</c:otherwise> 
                   				</c:choose>
							</h3>
							<div class="member_section">
								<ul class="memberlist">
									<li>
										<h4>Location</h4>
										<p>
											<c:choose>
												<c:when test="${!empty memberDTO.address}">
													<c:forTokens items="${memberDTO.address}" delims=" " begin="1" end="2" var="addr">
														${addr}
													</c:forTokens>
												</c:when>
												<c:otherwise>
													서울특별시
												</c:otherwise>
											</c:choose>
										</p>
									</li>
									<li>
										<h4>YEPSing Since</h4>
										<p>${memberDTO.joindate}</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="details-column-beta_reviews">
				   <div>
					  <div class="memberDetails-review-list" style="position: relative;">
					     <ul class="review-drafts">
					    <!----------------------------------------------- 아작스 통해 붙여넣는 부분 -------------------------------------------------- -->
				    
					     </ul>
					  </div>
					  <!-- -----페이징 처리 시작 ------ -->					
			   			<div class="event_list_paging_section" style="font-size: 14px;">
	                       <div class="event_list_pagination_block">
	                          <div class="event_list_pagination_wrap"  >
	                              <div class="event_list_page_of_pages" >
	                                  <c:if test="${map.yepsPager.blockEnd == 0}">
	                                      Page ${map.yepsPager.curPage} of 1
	                                  </c:if>
	                                  <c:if test="${map.yepsPager.blockEnd != 0}">
	                                      Page ${map.yepsPager.curPage} of ${map.yepsPager.blockEnd}
	                                  </c:if>
	                             </div>
	              <!--         페이징 처리!! 현재페이지는 span이 되고 나머지는 a로   --> 
	                         <c:if test="${map.yepsPager.blockEnd != 1}">
	                             <div class="yeps_message_page_link_wrapper" >
	                                 <div class="yeps_message_page_link_wrap" >
	                                     <c:if test="${map.yepsPager.curBlock > 1}">
	                                         <div class="yeps_message_next_block">
	                                             <a class="yeps_message_next_block_action" href="javascript:list('1')">
	                                                 <span>Start</span>
	                                             </a>
	                                         </div>
	                                     </c:if>
	                                 <c:if test="${map.yepsPager.curBlock > 1}">
	                                     <div class="yeps_message_next_block">
	                                         <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.prevPage}')">
	                                             <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
	                                                  <svg class="icon_svg">
	                                                      <path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>
	                                                  </svg>
	                                            </span>
	                                            <span>Previous</span>
	                                         </a>
	                                    </div>
	                                </c:if>
	                                    <c:forEach var="num" begin="${map.yepsPager.blockBegin}" end="${map.yepsPager.blockEnd}">
	                                        <div class="yeps_message_page_link_option">
		                                        <c:choose>
		                                            <c:when test="${num == map.yepsPager.curPage}">
		                                                <span class="yeps_message_page_option_action">
		                                                    ${num}
		                                                </span>
		                                            </c:when>
		                                            <c:otherwise>
		                                                <a href="javascript:list('${num}')" class="yeps_message_page_option_link_action">
		                                                    ${num}
		                                                </a>
		                                            </c:otherwise>
		                                        </c:choose>
		                                    </div>
	                                    </c:forEach>
	                                <c:if test="${map.yepsPager.curBlock <= map.yepsPager.totBlock}">
	                                    <div class="yeps_message_next_block">
	                                        <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.nextPage}')">
	                                            <span>Next</span>
	                                            <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
	                                                <svg class="icon_svg">
	                                                    <path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
	                                                </svg>
	                                            </span>
	                                        </a>
	                                    </div>
	                                </c:if>
	                            <c:if test="${map.yepsPager.curPage <= map.yepsPager.totPage}">
	                                <div class="yeps_message_next_block" style="display: inline-block;">
	                                    <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.totPage})">
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
			       </div>
			    
			       
				   <div class="member_reviews-hero">
					   <div class="member_u-relative">
						   <h2 style="margin: 0; padding: 0; color: #d32323;" class="section-header_title">Reviews</h2>
					   <p>It’s your turn ? review everything from your favorite burger to your favorite root canal. Write reviews to contribute to the Yelp community and help your friends find all the local gems that you love.</p>
						   <a href="review_restaurantIMG" class="ybtn ybtn-primary">Write a Review</a>
									<img class="reviews-hero-img" src="https://s3-media3.fl.yelpcdn.com/assets/2/www/img/1f978654eb34/user_details/reviews-hero.png">
									<div class="member_reviews-widget member_u-bg-color">
										<div class="member_reviews-widget_action-bar">
											<div class="member_reviews-widget_action-bar-buttons">
												<a class="ybtn ybtn-primary war-button" href="javascript:;">
													<span aria-hidden="true" style="width: 24px; height: 24px;" class="member_icon member_icon-currentColor">
														<svg class="icon_svg">
															<path d="M12 1.5l2.61 6.727 6.89.53-5.278 4.688 1.65 7.055L12 16.67 6.13 20.5l1.648-7.055L2.5 8.757l6.89-.53L12 1.5z"></path>
														</svg>
													</span>Write a Review
												</a>
												<span class="member_ybtn-group">
													<a class="ybtn ybtn--small add-photo-button" href="javascript:;">
														<span aria-hidden="true" style="width: 18px; height: 18px;" class="member_icon member_icon-currentColor">
															<svg class="icon_svg">
																<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 4.75a4.25 4.25 0 1 0 0 8.5 4.25 4.25 0 0 0 0-8.5zM11 10h-1v1a1 1 0 0 1-2 0v-1H7a1 1 0 0 1 0-2h1V7a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2z"></path>
															</svg>
														</span> Add Photo
													</a>
													<a class="ybtn ybtn--small share-icon" href="javascript:;">
														<span aria-hidden="true" style="width: 18px; height: 18px;" class="member_icon member_icon-currentColor">
															<svg class="icon_svg">
																<path d="M17.714 6.43L13 10.356v-3.03c-1 0-5.097 1.47-6.286 3.62.274-3.08 4.286-5.5 6.286-5.5V2.5l4.714 3.93zM3 4v10h11v-2.5l1-1V15H2V3h8.5l-1 1H3z"></path>
															</svg>
														</span> Share
													</a>
													<a class="ybtn ybtn--small not-bookmarked" href="javascript:;">
														<span aria-hidden="true" style="width: 18px; height: 18px;" class="member_icon member_icon-currentColor">
															<svg class="icon_svg">
																<path d="M14 2H4v14l5-4 5 4V2zm-3.13 7.957L8.978 8.794 7.148 10 7.5 7.926 6 6.458l2.074-.303L8.977 4l.948 2.155L12 6.458l-1.5 1.468.37 2.03z"></path>
															</svg>
														</span>
														<span class="bookmark-icon_label">Bookmark</span>
													</a>
												</span>
											</div>
										</div>
										<div class="reviews-widget--no-hover u-sticky u-absolute"></div>
									</div>
								</div>
							</div>
		                </div> 
						  
				
				
					      


             
				<div class="details-column-beta_events">
					<div class="member_detals_section_header">
						<h2>Events</h2>
					</div>
					<p>There’s always lots going on in your city. Use Yelp to explore local activities, save cool events, and even create your own! When you come back here, it’s like your very own social calendar.</p>
					<a href="event_list" class="ybtn ybtn-primary war-button">Discover Things To Do</a>
					<div class="member_events-hero">
						<div class="member_u-relative">
							<img class="events-hero-img" src="https://s3-media3.fl.yelpcdn.com/assets/2/www/img/dbef3f175427/user_details/events-hero.png">
							<div class="member_events-widget member_u-bg-color">
								<div class="member_events-widget_action-bar">
									<h3>Are You Interested?</h3>
									<div class="member_events_arrange">
										<div class="member_events_arrange_unit">
											<button type="submit" value="submit" class="ybtn ybtn-primary ybtn-full"><span>I'm In!</span></button>
										</div>
										<div class="member_events_arrange_unit">
											<button type="submit" value="submit" class="member_events_arrange_ybtn ybtn-full"><span>Sounds Cool</span></button>
										</div>
									</div>
								</div>
								<div class="events-widget--no-hover u-sticky u-absolute"></div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="details-column-beta_tips">
					<div class="quicktips-container js-quicktips-container">
						<div class="member_detals_section_header">
							<h2>Tips</h2>
						</div>
						<p>Sorry, no tips yet.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="popup" align="left" id="writeMessage" data-popup="writeMessage">
	<div class="popup-inner" style="width: 465px; height: auto !important; max-height: 400px;">
    	<div id="flag_content_popup_title">
    	    <div id="flag_content_popup_close" data-popup-close="writeMessage">
    			<h4 style="display: table-cell; padding: 0px 7px; font-size: 100%; font: inherit;">×</h4>
    		</div>
    		<h2>
    	    	메세지 보내기
    	    </h2>
    	</div>
    	
    	<div id="flag_popup_description" style="padding: 12px 8px 0;">
    		<div>
    			<form name="sendform" method="post">
    				<div>
						<h4 align="left" style="color: #d32323;">Send Message To</h4>
    	    			<input type="text" id="sendformTo" name="receiver">
    	    			<h4 align="left" style="color: #d32323;">Subject is</h4>
	            		<input type="text" name="title" id="sendformSubject">
	        			<h4 align="left" style="color: #d32323;">Content is</h4>
	            		<textarea rows="4" name="content" id="sendformMessage"  style="width: 95%;" placeholder="여기에 메시지를 입력하세요."></textarea>
    	    		</div>
    			</form>
    		</div>
    	</div>
    	
		<div id="flag_popup_footer">
     		<div id="flag_popup_buttons">
     			<button id="reply_flag_popup_submit_button" type="submit" value="submit" data-popup-send="SendMessage" onclick="sendMessage()">
     				<span>메세지 보내기</span>
     			</button>
     			<a href="#" data-popup-close="writeMessage">
    				Close
    			</a>
     		</div>
     	</div>
	</div>		
</div>
	
	<div class="loading_wapper" >
      	<div class="loading_img" style="left: 40%; top: 40%;"></div>
   	</div>
	
<script>
$(function() {
	$(document).on('click', '[data-popup-open]', function(e)  {
		var memberinfo ='${sessionScope.memberinfo}';
    	if(!memberinfo.length) {
     		$(location).attr("href", "event_report");
     		return;
    	}
		var targeted_popup_class = jQuery(this).attr('data-popup-open');
		$('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
    	
    	if(targeted_popup_class == 'writeMessage') {
    		var email = $(this).attr('alt');
    		$('#sendformTo').val(email);
    	}
		e.stopPropagation();
    	e.preventDefault();
	});
    
	//----- CLOSE
	$(document).on('click', '[data-popup-close]', function(e)  {
		var targeted_popup_class = jQuery(this).attr('data-popup-close');
		$('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);
		$('body').css('overflow','auto');
		e.stopPropagation();

    	e.preventDefault();
		});
	});   

		$('#reply_flag_popup_submit_button').click(function(){
			if($('#sendformTo').val()==''){
			alert("받는 사람을 입력해주세요");
			$('#sendformTo').focus()
			return false;
			
			}else if($('#sendformSubject').val()==''){
			alert("제목를 입력해주세요");
			$('#sendformSubject').focus()
			return false;
			
			}else if($('#sendformMessage').val()==''){
			alert("내용을 입력해주세요");
			$('#sendformMessage').focus()
			return false;
			}
		    document.sendform.action = "message_send";
		    document.sendform.submit(); 
		
		});

	var list = new Array();
	<c:forEach var="memberPhotoDTO" items="${getPhotoList}">
		list.push("${memberPhotoDTO.member_filename}");
	</c:forEach>
	
	for(var i = 0; i < list.length; i++) {
		var img = document.createElement('img');
		img.src = 'https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/' + list[i];
		img.style.cursor = 'pointer';
		img.style.width = '100%';
		img.style.height = '100%';
		img.onclick = function() {location.href="member_photolist?mnum=${memberDTO.mnum}"};
		document.getElementById('slideshow_img').appendChild(img);
	}
	
	$(document).ready(function(){
		$(".details-column-beta_overview").show();
		$(".details-column-beta_reviews").hide();
	   	$(".details-column-beta_events").hide();
	    $(".details-column-beta_tips").hide();
	    $('.event_list_paging_section').hide();
		$('.profile-nav_items > li > a').removeClass('is-active');
		$('#profile_overview').addClass('is-active');
	    $('.profile-nav_items > li > a').click(function( e ){
	       $('.profile-nav_items > li > a').removeClass('is-active');
	       $(this).addClass('is-active');
	    })
	    
	    $('#profile_events').click(function(e){
	    	$(".details-column-beta_overview").hide();
 	    	$(".details-column-beta_reviews").hide();
 	    	$(".details-column-beta_events").show();
 	    	$(".details-column-beta_tips").hide();
 	    	$(".event_list_paging_section").hide();
	    })
	    
	    $('#profile_tips').click(function(e){
	    	$(".details-column-beta_overview").hide();
 	    	$(".details-column-beta_reviews").hide();
 	    	$(".details-column-beta_events").hide();
 	    	$(".details-column-beta_tips").show();
 	    	$(".event_list_paging_section").hide();
	    })
	    
	    $('#profile_overview').click(function(e){
	    	$(".details-column-beta_overview").show();
 	    	$(".details-column-beta_reviews").hide();
 	    	$(".details-column-beta_events").hide();
 	    	$(".details-column-beta_tips").hide();
 	    	$('.event_list_paging_section').hide();
 	    	
	    })
	    
	    $('#profile_reviews').click(function(e){
	    	$(".details-column-beta_overview").hide();
 	    	$(".details-column-beta_reviews").show();
 	    	$(".details-column-beta_events").hide();
 	    	$(".details-column-beta_tips").hide();
 	    	$('.event_list_paging_section').show();
 	    	
 	    	$(document).ajaxStart(function() {
	 			$('body').css('overflow', 'hidden');
	 			$('html').scrollTop(0);
	 			$('.loading_wapper').fadeIn(500);
	 		})
 							
	 		$(document).ajaxStop(function() {
	 			$('body').css('overflow', 'auto');
	 			$('.loading_wapper').fadeOut(500);
	 		})
 	    	
 	     	var mnum = '${memberDTO.mnum}';
 	     	var login_mnum = '${memberinfo.mnum}';
	        $.ajax({
             type : 'post',
             url : 'review_member_ajax?mnum='+ mnum, 
             data : mnum,
             dataType : 'json',
             success : function(responseData){
            	var num = responseData.num;
                var mnum = responseData.mnum;
              
       	 $('.memberDetails-review-list ul li').remove(); 
	 	$.each(responseData.memberReview,function(i,item){
	 		var num = responseData.num;
	        var mnum = responseData.mnum;
	 		var price;
	 		if(item.restaurantDTO.price == 1) {
	 			price = '￦';
	 		} else if(item.restaurantDTO.price == 2) {
	 			price = '￦￦';
	 		} else if(item.restaurantDTO.price == 3) {
	 			price = '￦￦￦';
	 		} else if(item.restaurantDTO.price == 4) { 
	 			price = '￦￦￦￦';
	 		}
		 $(".memberDetails-review-list ul").append(
				 '<li class="review-draft">'+
 					'<div class="arrange">'+
 						'<div class="arrange_unit arrange_unit--fill">'+
						    '<div class="media-block media-block--12 biz-listing-medium">'+
				                '<div class="media-avatar">'+
				                    '<div class="photo-box pb-60s">'+
				                        '<a href="restaurant_content?rnum='+ item.rnum +'" class="js-analytics-click" data-analytics-label="biz-photo">'+
				                            '<img alt="Liholiho Yacht Club" class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+item.restaurantDTO.fileDTO.filename+'" width="60">'+
				          			    '</a>'+
				    		        '</div>'+
				         	    '</div>'+
				            	'<div class="media-story">'+
				                	'<div class="media-title clearfix">'+
				                    	'<a class="biz-name js-analytics-click" data-analytics-label="biz-name" href="restaurant_content?rnum='+ item.rnum +'" data-hovercard-id="K8YqsGXicOLOUcQXTzRrnw"><span>'+ item.restaurantDTO.rname + '   </span></a>'+
				                	'</div>'+
				                	'<div class="price-category" style="float: none;">'+
				                		'<span class="bullet-after">' +
				                			'<span class="price-range">' +
				                				price + 
				                			'</span>' + 
				                		'</span>' + 
				                    	'<span class="category-str-list">'+
				                    		'<a href="#">' + item.restaurantDTO.foodstyle + '</a>'+
				    					'</span>'+
				    			 	'</div>'+
				                 	'<address>'+
				                		item.restaurantDTO.roadAddrPart1 + '<br>' + item.restaurantDTO.roadAddrPart2 + item.restaurantDTO.addrDetail +
				                 	'</address>'+
				             	'</div>'+
        		        	'</div>'+
				        	'<div class="review_arrange_unit">'+
			                	'<p class="time-stamp nowrap review-draft_date-created text-right">'+
			                    	'Started on  '+  item.reg_date + 
			                	'</p>'+
			                	'<div class="restList-star-rating-'+ item.gradepoint +'">'+
		             				'<img class="star_member_img" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png">'+
		            			'</div>'+
			             	'</div>'+
			             	'<p class="member_ptag1" lang="ko" style="margin-bottom: 12px; width: 100%; float: right; display: block;">'+
						 		item.content +
					    	'</p><br><br>'+
			            	'<div class="clearfix" id="buttom_group" style="margin-bottom: 50px;">'+
			            		'<c:if test="${memberDTO.mnum eq memberinfo.mnum}">' +
			            		'<a style="float: left;" href="review_write?rvnum=' + item.rvnum + '&mode=update&star='+item.gradepoint+'&rnum='+item.rnum+'" class="yepsbyn ybtn--small js-war-widget_finish-draft pull-left">리뷰수정</a>'+
					               '<form action="review_delete" class="pull-right js-delete-review-draft-form" method="post" name="delete_draft">'+
					                   '<input type="hidden" value="'+ item.rvnum + '" name="rvnum">'+
					                  '<input type="hidden" value="'+ mnum + '" name="mnum">'+
					                   '<input type="hidden" value="restaurantReviewDelete" name="mode">'+
					                   '<input type="hidden" value="'+ item.rnum +'" name="rnum">'+
					                   '<button type="submit" style="float: right;"class="chiclet-link u-cursor-pointer show-tooltip js-delete-review-draft">'+
					                      '<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon icon--18-trash icon--size-18 icon--currentColor">'+
					                          '<svg class="icon_svg">'+
										       '<path d="M3 5V3h4V2h4v1h4v2H3zm11 9c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6h10v8zM8 8.5a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5zm3 0a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5z"></path>'+
					                          '</svg>'+
					                      '</span>'+
					                      '<span class="tooltip-wrapper">'+
					                      	'<span class="tooltip">Delete draft</span>'+
					                     '</span>'+
					                   '</button>'+
					               '</form>' +
			               		'</c:if>' + 
			             	'</div>'+
		              	'</div>'+
				   	'</div>'+
					'</li>'
				);
		 
	             });
	 
				 $('.event_list_paging_section').empty();
			     var pagingHtml = "";
			     pagingHtml = '<div class="event_list_pagination_block">' + 
			     			  '<div class="event_list_pagination_wrap" >' + 
			     			  '<div class="event_list_page_of_pages">';
			     if(responseData.YepsPager.blockEnd == 0) {
			  	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of 1';
			     } else {
			  	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of ' + responseData.YepsPager.blockEnd;
			     }
			     pagingHtml += '</div>';
			     if(responseData.YepsPager.blockEnd != 1) {
			  	   pagingHtml += '<div class="event_list_page_link_wrapper" style="text-align: right;">';
			  	   pagingHtml += '<div class="event_list_page_link_wrap"  >';
			  	   if(responseData.YepsPager.curBlock > 1) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+ 1 +')">';
			  		   pagingHtml += '<span>Start</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   if(responseData.YepsPager.curBlock > 1) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.prevPage+')">';
			  		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
			  		   pagingHtml += '<svg class="icon_svg">';
			  		   pagingHtml += '<path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>';
			  		   pagingHtml += '</svg>';
			  		   pagingHtml += '</span>';
			  		   pagingHtml += '<span>Previous</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   for(var num = responseData.YepsPager.blockBegin; num <= responseData.YepsPager.blockEnd; num++) {
			  		   pagingHtml += '<div class="event_list_page_link_option">';
			  		   if(num == responseData.YepsPager.curPage) {
			  			   pagingHtml += '<span class="event_list_page_option_action">';
			  			   pagingHtml += num;
			  			   pagingHtml += '</span>';
			  		   } else {
			  			   pagingHtml += '<a href="javascript:list('+ num +')" class="event_list_page_option_link_action">';
			  			   pagingHtml += num;
			  			   pagingHtml += '</a>';
			  		   }
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   if(responseData.YepsPager.curBlock <= responseData.YepsPager.totBlock) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.nextPage+')">';
			  		   pagingHtml += '<span>Next</span>';
			  		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
			  		   pagingHtml += '<svg class="icon_svg">';
			  		   pagingHtml += '<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>';
			  		   pagingHtml += '</svg>';
			  		   pagingHtml += '</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   if(responseData.YepsPager.curBlock <= responseData.YepsPager.totBlock) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.totPage+')">';
			  		   pagingHtml += '<span>End</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   pagingHtml += '</div>';
			  	   pagingHtml += '</div>';
			     }
			     pagingHtml += '</div>';
			     pagingHtml += '</div>';
			     pagingHtml += '</div>';
			
			     $('.event_list_paging_section').append(pagingHtml);      
			   
				 },
	             error : function(request, status, error) {
	             alert("실패 :" + "code:"+request.status+"\n\n"+"message:"+request.responseText+"\n\n"+"error:"+error); 
	             },
	         }); 
	    });
	});
	</script>
	
	<script type="text/javascript">
	function list(page){
		$(document).ajaxStart(function() {
			$('body').css('overflow', 'hidden');
			$('html').scrollTop(0);
			$('.loading_wapper').fadeIn(500);
		})
						
		$(document).ajaxStop(function() {
			$('body').css('overflow', 'auto');
			$('.loading_wapper').fadeOut(500);
		})
		
		var mnum = '${memberDTO.mnum}';
		var login_mnum = '${memberinfo.mnum}';
	    $.ajax({
	        type : 'post',
	        url : 'review_member_ajax?curPage=' + page + '&mnum=' + mnum,
	        dataType : 'json',
	        success : function(responseData){
	        	if(responseData.msg) {
	        		alert(responseData.msg);
	        		window.location.href = responseData.url;
	        	}
		       	 $('.memberDetails-review-list ul').empty(); 
		       	$.each(responseData.memberReview,function(i,item){
			 		var num = responseData.num;
			        var mnum = responseData.mnum;
			 		var price;
			 		if(item.restaurantDTO.price == 1) {
			 			price = '￦';
			 		} else if(item.restaurantDTO.price == 2) {
			 			price = '￦￦';
			 		} else if(item.restaurantDTO.price == 3) {
			 			price = '￦￦￦';
			 		} else if(item.restaurantDTO.price == 4) { 
			 			price = '￦￦￦￦';
			 		}
				 $(".memberDetails-review-list ul").append(
					
						 '<li class="review-draft">'+
		 					'<div class="arrange">'+
		 						'<div class="arrange_unit arrange_unit--fill">'+
								    '<div class="media-block media-block--12 biz-listing-medium">'+
						                '<div class="media-avatar">'+
						                    '<div class="photo-box pb-60s">'+
						                        '<a href="restaurant_content?rnum='+ item.rnum +'" class="js-analytics-click" data-analytics-label="biz-photo">'+
						                            '<img alt="Liholiho Yacht Club" class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+item.restaurantDTO.fileDTO.filename+'" width="60">'+
						          			    '</a>'+
						    		        '</div>'+
						         	    '</div>'+
						            '<div class="media-story">'+
						                '<div class="media-title clearfix">'+
						                    '<a class="biz-name js-analytics-click" data-analytics-label="biz-name" href="restaurant_content?rnum='+ item.rnum +'" data-hovercard-id="K8YqsGXicOLOUcQXTzRrnw"><span>'+ item.restaurantDTO.rname + '   </span></a>'+
						                '</div>'+
						                '<div class="price-category" style="float: none;">'+
						                	'<span class="bullet-after">' +
						                		'<span class="price-range">' +
						                			price + 
						                		'</span>' + 
						                	'</span>' + 
						                    '<span class="category-str-list">'+
						                    	'<a href="#">' + item.restaurantDTO.foodstyle + '</a>'+
						    				'</span>'+
						    			 '</div>'+
						                 '<address>'+
						                	item.restaurantDTO.roadAddrPart1 + '<br>' + item.restaurantDTO.roadAddrPart2 + item.restaurantDTO.addrDetail +
						                 '</address>'+
						             '</div>'+
		        		        '</div>'+
						        '<div class="review_arrange_unit">'+
					                '<p class="time-stamp nowrap review-draft_date-created text-right">'+
					                    'Started on  '+  item.reg_date + 
					                '</p>'+
					                '<div class="restList-star-rating-'+ item.gradepoint +'">'+
				             		'<img class="star_member_img" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png">'+
				            	'</div>'+
					             '</div>'+
					             '<p class="member_ptag1" lang="ko" style="margin-bottom: 12px; width: 100%; float: right; display: block;">'+
								 item.content +
							    '</p><br><br>'+
					            '<div class="clearfix" id="buttom_group" style="margin-bottom: 50px;">'+
					            '<c:if test="${memberDTO.mnum eq memberinfo.mnum}">' +
			            		'<a style="float: left;" href="review_write?rvnum=' + item.rvnum + '&mode=update&star='+item.gradepoint+'&rnum='+item.rnum+'" class="yepsbyn ybtn--small js-war-widget_finish-draft pull-left">리뷰수정</a>'+
					               '<form action="review_delete" class="pull-right js-delete-review-draft-form" method="post" name="delete_draft">'+
					                   '<input type="hidden" value="'+ item.rvnum + '" name="rvnum">'+
					                   '<input type="hidden" value="'+ mnum + '" name="mnum">'+
					                   '<input type="hidden" value="restaurantReviewDelete" name="mode">'+
					                   '<input type="hidden" value="'+ item.rnum +'" name="rnum">'+
					                   '<button type="submit" style="float: right;"class="chiclet-link u-cursor-pointer show-tooltip js-delete-review-draft">'+
					                      '<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon icon--18-trash icon--size-18 icon--currentColor">'+
					                          '<svg class="icon_svg">'+
										       '<path d="M3 5V3h4V2h4v1h4v2H3zm11 9c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6h10v8zM8 8.5a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5zm3 0a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5z"></path>'+
					                          '</svg>'+
					                      '</span>'+
					                      '<span class="tooltip-wrapper">'+
					                      	'<span class="tooltip">Delete draft</span>'+
					                     '</span>'+
					                   '</button>'+
					               '</form>' +
			               		'</c:if>' + 
					             '</div>'+
				              '</div>'+
						   '</div>'+
						'</li>'
						      );
				 	 
			             });
				 
				 $('.event_list_paging_section').empty();
			     var pagingHtml = "";
			     pagingHtml = '<div class="event_list_pagination_block">' + 
			     			  '<div class="event_list_pagination_wrap" >' + 
			     			  '<div class="event_list_page_of_pages">';
			     if(responseData.YepsPager.blockEnd == 0) {
			  	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of 1';
			     } else {
			  	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of ' + responseData.YepsPager.blockEnd;
			     }
			     pagingHtml += '</div>';
			     if(responseData.YepsPager.blockEnd != 1) {
			  	   pagingHtml += '<div class="event_list_page_link_wrapper">';
			  	   pagingHtml += '<div class="event_list_page_link_wrap" >';
			  	   if(responseData.YepsPager.curBlock > 1) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+ 1 +')">';
			  		   pagingHtml += '<span>Start</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   if(responseData.YepsPager.curBlock > 1) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.prevPage+')">';
			  		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
			  		   pagingHtml += '<svg class="icon_svg">';
			  		   pagingHtml += '<path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>';
			  		   pagingHtml += '</svg>';
			  		   pagingHtml += '</span>';
			  		   pagingHtml += '<span>Previous</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   for(var num = responseData.YepsPager.blockBegin; num <= responseData.YepsPager.blockEnd; num++) {
			  		   pagingHtml += '<div class="event_list_page_link_option">';
			  		   if(num == responseData.YepsPager.curPage) {
			  			   pagingHtml += '<span class="event_list_page_option_action">';
			  			   pagingHtml += num;
			  			   pagingHtml += '</span>';
			  		   } else {
			  			   pagingHtml += '<a href="javascript:list('+ num +')" class="event_list_page_option_link_action">';
			  			   pagingHtml += num;
			  			   pagingHtml += '</a>';
			  		   }
			  		   pagingHtml += '</div>';
			  	   }
			  	   
			  	   if(responseData.YepsPager.curBlock <= responseData.YepsPager.totBlock) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.nextPage+')">';
			  		   pagingHtml += '<span>Next</span>';
			  		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
			  		   pagingHtml += '<svg class="icon_svg">';
			  		   pagingHtml += '<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>';
			  		   pagingHtml += '</svg>';
			  		   pagingHtml += '</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   if(responseData.YepsPager.curBlock <= responseData.YepsPager.totBlock) {
			  		   pagingHtml += '<div class="event_list_next_block">';
			  		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+responseData.YepsPager.totPage+')">';
			  		   pagingHtml += '<span>End</span>';
			  		   pagingHtml += '</a>';
			  		   pagingHtml += '</div>';
			  	   }
			  	   pagingHtml += '</div>';
			  	   pagingHtml += '</div>';
			     }
			     pagingHtml += '</div>';
			     pagingHtml += '</div>';
			     pagingHtml += '</div>';
			
			     $('.event_list_paging_section').append(pagingHtml);      
			   
	           
	         },
	         error : function(request, status, error) {
	             alert("실패 :" + "code:"+request.status+"\n\n"+"message:"+request.responseText+"\n\n"+"error:"+error); 
	         },
	     });
	 } 
	
	

</script>

<%@ include file="../bottom.jsp"%>