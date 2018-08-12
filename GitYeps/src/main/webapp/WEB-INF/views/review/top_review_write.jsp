<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
   <title>Write a Review</title>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=4"/>"/>
   <script src="//code.jquery.com/jquery.min.js"></script>
</head>
<body>
    <div class="review_template_write_div1">
       <div class="review_template_write_div2">
          <div class="review_template_write_div3">
             <div class="review_template_write_div4">
                <div class="review_template_write_div5">
                   <div class="review_template_write_div6">
                      <a class="review_template_write_a_3" href="main">
                         Yelp
                      </a>   
                   </div>
                </div>
                <div class="review_template_write_div7">
                   <h2 class="review_template_write_h2_1">
                      <span class="review_template_write_span_1">
                         Write a Review
                      </span>
                   </h2>
                </div>
                <div class="review_template_write_div7-1">
                   
                </div>
                
                <c:if test="${empty sessionScope.memberinfo}">
                <div class="review_template_write_div8">
                   <ul class="review_template_write_ul_1">
                      <li class="review_template_write_li_1">
                         <a class="review_template_write_a_1" href="member_login">
                            Log In
                         </a>
                      </li>
                      <li class="review_template_write_li_2">
                         <a class="review_template_write_a_2" href="member_login?mode=signup">
                            Sign Up
                         </a>
                      </li>
                   </ul>
                </div>
                </c:if>
                
                <c:if test="${!empty sessionScope.memberinfo}">					
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
                                                            <c:choose>
                                                               <c:when test="${!empty sessionScope.memberinfo.address}">
                                                                  <c:forTokens items="${sessionScope.memberinfo.address}" delims=" " begin="1" end="2" var="addr">
                                                                     ${addr}
                                                                  </c:forTokens>
                                                               </c:when>
                                                               <c:otherwise>
                                                                  	서울특별시
                                                               </c:otherwise>
                                                            </c:choose>
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
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_details" style="display: block; word-wrap: break-word;">
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
                                                <a class="js-analytics-click arrange arrange--middle arrange--6" href="member_manager">
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
                </c:if>
             </div>
          </div>
       </div>   
    </div>

    <script>
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
    </script>
    