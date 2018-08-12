<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>The Best 10 Restaurants in ${map.location}</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jD9qGVpvZh7Zobclojwp&submodules=geocoder"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
</head>
<%@include file="../top.jsp" %>
	<div class="main">
		<div class="restList-header" style="background: #f5f5f5; border-bottom: 1px solid #e6e6e6;width: 100%;position: relative;padding-top: 15px;height:164px">
			<div class="content-container" style="width: 960px;margin: 0 auto;padding: 0 15px;height:auto;overflow:hidden;">
				<div class="clearfix layout-block layout-full search-page-top" style="margin: 0 -15px;height:auto;overflow:hidden;">
					
					<div class="column column-alpha" style="float: left;padding: 0 15px;min-height: 1px;box-sizing: border-box;width: 100%; height: 60%;">
						<div class="search-header clearfix" style="width:1100px;height:80px;padding-top: 12px;padding-bottom: 7px;">
							<div class="search-header-title-container" style="width:100%;height:40px;">
								<h1 style="font-size:21px;padding-top: 6px;">베스트 10 레스토랑<span>   ${map.location}</span></h1>
							</div>
						<div class="breadcrumbs-hierarchy" style="width:100%;height:18px;margin-bottom:6px;">
							<span style="width:100px;height:30px">
							<c:if test="${empty map.category}">
								<a href="#" class="location">서울</a>
							</c:if>
							<c:if test="${!empty map.category}">
								<a href="yeps_main_saerch?location=${map.location}">${map.location}</a>
									<span aria-hidden="true" style="width: 14px; height: 14px;" class="icon icon--14-chevron-right icon--size-14 u-space-r-half">
										<svg id="14x14_chevron_right" height="100%" viewBox="0 0 14 14" width="100%">
									    	<path d="M4.793 12a1 1 0 0 1-.707-1.707L7.38 7 4.085 3.707A1 1 0 1 1 5.5 2.293L10.207 7 5.5 11.707a.997.997 0 0 1-.707.293z"></path>
									    </svg>
									</span>
									<a href="yeps_main_saerch?category=${map.category}&location=${map.location}">${map.category}</a>
								</c:if>
							</span>
						</div>
						</div>
						
						<div class="filter-panel" style="font-size: 12px; line-height: 1.5em;position: relative;height:65px">
							<div class="filter-bar suggested-filters" style="">
								<ul class="suggested-filters_filter-list" style="padding-bottom: 18px;display: flex;flex-wrap: wrap;list-style: none;height:48px;">
									<li class="suggested-filters_filter" style="height:38px;padding-right: 6px;margin-bottom: 12px; -webkit-box-flex: 0;flex-grow: 0;flex-shrink: 0;user-select: none;display: list-item;text-align: -webkit-match-parent;">
										<ul class="suggested-filters_price-filters" style="height:38px;font-size: 0;list-style: none;display: block;-webkit-margin-start: 0px;-webkit-margin-end: 0px;">
										<li style="display: inline-block; text-align: -webkit-match-parent;">
											<label class="radio-check" style="display: inline; float: none; padding: 0; cursor: default;">
												<input class="filters-price" name="price" type="checkbox" value="1" style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align:start ; -webkit-writing-mode: horizontal-tb;">
												<span class="filter-label show-tooltip" >
													￦
													<span class="tooltip-wrapper">
														<span class="tooltip">
															저가
														</span>
													</span>
												</span>
										</label>
										</li>
										
										<li style="display: inline-block; text-align: -webkit-match-parent;">
											<label class="radio-check" style="display: inline; float: none; padding: 0; cursor: default;">
												<input class="filters-price" name="price" type="checkbox"
												value="2"
												style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start; -webkit-writing-mode: horizontal-tb;">
												<span class="filter-label show-tooltip">
													￦￦
													<span class="tooltip-wrapper">
														<span class="tooltip">
															중저가
														</span>
													</span>
												</span>
										</label>
										</li>
										<li style="display: inline-block; text-align: -webkit-match-parent;">
											<label class="radio-check"
											style="display: inline; float: none; padding: 0; cursor: default;">
												<input class="filters-price" name="price" type="checkbox"
												value="3"
												style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start; -webkit-writing-mode: horizontal-tb;">
												<span class="filter-label show-tooltip">
													￦￦￦
													<span class="tooltip-wrapper">
														<span class="tooltip">
															중고가
														</span>
													</span>
											</span>
										</label>
										</li>
										<li style="display: inline-block; text-align: -webkit-match-parent;">
											<label class="radio-check"
											style="display: inline; float: none; padding: 0; cursor: default;">
												<input class="filters-price" name="price" type="checkbox"
												value="4"
												style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start; -webkit-writing-mode: horizontal-tb;">
												<span class="filter-label show-tooltip">
													￦￦￦￦ 
													<span class="tooltip-wrapper">
														<span class="tooltip">
															고가
														</span>
													</span>
											</span>
										</label>
										</li>
									</ul>
									</li>
									
									<li class="suggested-filters_filter" style="flex-grow: 0;    flex-shrink: 0;padding-right: 6px;margin-bottom: 12px;-webkit-box-flex: 0;display: list-item;text-align: -webkit-match-parent;">
										<label class="feature open-now radio-check" style="    display: inline;float: none; padding: 0;    cursor: default;">
								            <input class="filters" autocomplete="off" name="feature" type="checkbox" value="open_now" style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start;">
										<span class="filter-label show-tooltip" >
											<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon icon--18-clock icon--size-18 icon--neutral-gray">
												<svg id="18x18_clock" height="100%" viewBox="0 0 18 18" width="100%">
													<path d="M9 17A8 8 0 1 1 9 1a8 8 0 0 1 0 16zM9 2C5.14 2 2 5.14 2 9s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm3.223 10.098a.998.998 0 0 1-.588-.192L8 9.256V5a1 1 0 0 1 2 0v3.24l2.812 2.05a1 1 0 0 1-.59 1.808z"></path>
												</svg>
											</span> 영업중 <span class="current-time"></span>
												<span class="tooltip-wrapper">
														<span class="tooltip">
															현재 영업중인 가게를 보여줍니다
														</span>
													</span>
										</span>
								</label>
									</li>

								<li class="suggested-filters_filter" style="padding-right: 6px; margin-bottom: 12px; -webkit-box-flex: 0; flex-grow: 0; flex-shrink: 0; user-select: none; display: list-item; text-align: -webkit-match-parent;">
									<label class="feature radio-check" style="display: inline;float: none;padding: 0;cursor: default;user-select: none;text-align: -webkit-match-parent;"> 
									<input class="filters" autocomplete="off" name="feature" type="checkbox" value="delivery" style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start; -webkit-writing-mode: horizontal-tb;">
										<span class="filter-label show-tooltip">
											<span aria-hidden="true" style="fill: #ca6d00; width: 18px; height: 18px;" class="icon icon--18-order icon--size-18"> 
												<svg id="18x18_order" height="100%" viewBox="0 0 18 18" width="100%">
													<g>
														<path d="M4 4V3h3v1H4m4-2H3v2H2a1 1 0 0 0-1 1v7h9V5a1 1 0 0 0-1-1H8V2" opacity=".502"></path>
														<path d="M17 10.93L15 9.5V4h-5v8H7.49a2.49 2.49 0 0 0-1.99-1 2.49 2.49 0 0 0-1.99 1H1v2h2.05a2.502 2.502 0 0 0 4.9 0h3.1a2.5 2.5 0 0 0 4.9 0H17v-3.07zM5.5 14.75a1.25 1.25 0 1 1 0-2.5 1.25 1.25 0 0 1 0 2.5zM12 6h1v3h-1V6zm1.5 8.75a1.25 1.25 0 1 1 0-2.5 1.25 1.25 0 0 1 0 2.5z"></path>
													</g>
												</svg>
											</span>
												배달 주문
												<span class="tooltip-wrapper">
														<span class="tooltip">
															배달 가능한 가게를 찾습니다
														</span>
													</span>
										</span>
								</label>
								</li>

								<li class="suggested-filters_filter" style="padding-right: 6px; margin-bottom: 12px; -webkit-box-flex: 0; flex-grow: 0; flex-shrink: 0; user-select: none; display: list-item; text-align: -webkit-match-parent;">                
							    <label class="feature radio-check" style="display: inline;float: none;padding: 0;cursor: default;user-select: none;text-align: -webkit-match-parent;">
							            <input class="filters" autocomplete="off" name="feature" type="checkbox" value="takeout" style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start; -webkit-writing-mode: horizontal-tb;">
							            <span class="filter-label show-tooltip">
							               	<span aria-hidden="true" style="fill: #ca6d00; width: 18px; height: 18px;" class="icon icon--18-shopping icon--size-18">
												    <svg id="18x18_shopping" height="100%" viewBox="0 0 18 18" width="100%">
												    	<path d="M12 5V1H6v4H3v10a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V5h-3zM7 2h4v3H7V2z"></path>
												    </svg>
											</span>
							    				Takeout
							    				<span class="tooltip-wrapper">
														<span class="tooltip">
															Takeout 가능한 가게를 찾습니다
														</span>
													</span>
							            </span>
							    </label>
							</li>
								
								
								<li class="suggested-filters_filter" style="padding-right: 6px; margin-bottom: 12px; -webkit-box-flex: 0; flex-grow: 0; flex-shrink: 0; user-select: none; display: list-item; text-align: -webkit-match-parent;">
									<div class="coachmark-tooltip js-OnlineReservations-search-coachmark coachmark-tooltip--bottom" style="display: inline-block; position: relative;    user-select: none;    text-align: -webkit-match-parent;">
										<div class="js-coachmark-tooltip coachmark-tooltip-content" style="z-index: 1002; width: 150px; padding-right: 24px; background: #0097ec; color: #fff; position: absolute; margin-right: 8px; border-radius: 5px; display: none; font-weight: normal; padding: 9px;">
											<span aria-hidden="true" style="width: 14px; height: 14px;" class="icon icon--14-close icon--size-14 icon--inverse icon--fallback-inverted coachmark-close js-coachmark-close">
											</span> 
										</div>
										<div class="js-coachmark-target">
											<label class="feature radio-check">
												<input class="filters" autocomplete="off" name="feature" type="checkbox" value="reserv" style="display: none; color: inherit; font: inherit; margin: 0; font-weight: normal; -webkit-appearance: checkbox; box-sizing: border-box; background-color: initial; cursor: default; padding: initial; border: initial; -webkit-rtl-ordering: logical; text-rendering: auto; letter-spacing: normal; word-spacing: normal; text-transform: none; text-indent: 0px; text-shadow: none; text-align: start;">
												<span class="filter-label show-tooltip" href="#">
													<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon icon--18-reservation icon--size-18 icon--black">
														<svg id="18x18_reservation" height="100%"viewBox="0 0 18 18" width="100%">
															<path d="M13.6 16H4.4C3.077 16 2 14.88 2 13.5v-9C2 3.12 3.077 2 4.4 2H5a1 1 0 0 1 2 0h4a1 1 0 0 1 2 0h.6C14.923 2 16 3.12 16 4.5v9c0 1.38-1.077 2.5-2.4 2.5zM15 7H3v6.5c0 .828.627 1.5 1.4 1.5h9.2c.773 0 1.4-.672 1.4-1.5V7zm-5 3h3v3h-3v-3z"></path>
														</svg>
												</span> 예약 
													<span class="tooltip-wrapper">
														<span class="tooltip">
															예약 가능한 가게를 찾습니다
														</span>
													</span>
											</span>
											</label>
										</div>
									</div>
								</li>
							</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="super-container" style="width:1100px;margin: 0 auto;padding:15px 15px 36px 15px;display: table;vertical-align: middle;">
			<div class="middle-container" style="width:1100px;display:inline-block;">
			<div class="scroll-map" style="width:1100px;margin-left:15px;margin-right:15px;display:inline-block;">
<!-- 		<div id="loading" > -->
<!-- 		</div> -->
<!-- 			<img id="loading-image" src="resources/img/loading.gif" alt="Loading..." /> -->

			<div class="column-alpha2" style="width:700px; height:100%;display:inline-block;float:left;padding:0px 15px 0px 15px">

				<ul style="list-style: none;display: block;">
					<c:forEach var="dto" items="${map.list}" varStatus="status">
						<li style="margin: 0;padding: 18px 0;border-top: 1px solid #e6e6e6; padding-top: 17px; display: list-item; text-align: -webkit-match-parent;">
							<div class="search-result natural-search-result">
								<div class="biz-listing-large" style="margin: 0 -15px;height:auto;overflow:hidden;">
									<div class="main-attribute"style=" float: left;padding: 0 15px; min-height: 1px; box-sizing: border-box;width: 62.5%;">
										<div class="midea-block"style="position: relative;display: flex;">
											<div class="midea-avata"style="border-right: 12px solid transparent; border-left: none;">
												<div class="photo-box" >
													<a href="restaurant_content?rnum=${dto.rnum}" class="js-analytics-click" style="color: #0073bb; cursor: pointer;">
														<img width="90px" height="90px" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${dto.fileDTO.filename}" style="outline: none;border-radius: 4px;vertical-align: middle;">	
        											</a>
												</div>
											</div>
											<div class="midea-story" style="-webkit-box-flex: 1; flex: 1;min-width: 0;min-height: 0;">
													<h3 style="font-weight: normal;margin-bottom: 6px; word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;    font-size: 16px;line-height: 1.3125em;color: #d32323; display: block;">
														<span class="indexed-biz-name" style="color: #333; display: block;">
															${status.count}.
															<a href="restaurant_content?rnum=${dto.rnum}" style="font-size: 16px; line-height: 1.3125em; display: inline; padding: 3px 0; color: #0073bb; cursor: pointer;">
																<span> ${dto.rname}</span>
															</a>
														</span>
													</h3>
														<div class="biz-rating biz-rating-large clearfix" style="margin: 6px 0;overflow:hidden;height:auto;">
															<div class="restList-star-rating-${map.StarAvg.get(status.index)}">
																<img class="offscreen" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png" width="84" height="303"style="clip: rect(0, 0, 0, 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px; vertical-align: middle;">
															</div>
															<span class="review-count rating-qualifier" style="display: block;float: left;color: #666;font-weight: normal;">${map.reviewCount.get(status.index)} 리뷰</span>
														</div>
													<div class="price-category"style="clear: both;">
														<span class="bullet-after">
																<span class="business-attribute price-range" style="letter-spacing: 1px; white-space: nowrap;">
																	<c:forEach begin="1" end="${dto.price}">￦</c:forEach>
																</span>
														</span>
														<span class="category-str-list">
															<a href="#" style="color: #0073bb; cursor: pointer;">${dto.foodstyle}</a>
														</span>
													</div>
											</div>
										</div>
									</div>
									<div class="secondary-attributes" style="float: left; padding: 0 15px; min-height: 1px; box-sizing: border-box; width: 37.5%; margin-top: 3px;">
										<address style="display: block; font-style: normal;">
											${dto.roadAddrPart1}<br>
											${dto.addrDetail}<br>
											${dto.roadAddrPart2}<br>
										</address>
										<span class="offscreen" style="clip: rect(0 0 0 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px;">Phone number</span>
										<span class="hp">${dto.raddress}-${dto.hp2}-${dto.hp3}</span>
									</div>
								</div>
										
										<c:if test="${map.LastReview.get(status.index).content!=null}">
										<div class="snippet-block media-block" style="margin-top: 12px; margin-bottom: 0; font-size: 13px; line-height: 1.38462em; position: relative; display: flex;">
										<div class="media-avatar" style="border-right: 6px solid transparent; border-left: none;">
											<div class="photo-box pb-30s">
												<a href="restaurant_content?rnum=${dto.rnum}" style="color: #0073bb; cursor: pointer;">
													<img width="30px" height="30px" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${map.LastReview.get(status.index).memberDTO.memberPhotoDTO.member_filename}" style="outline: none; margin-top: 3px; border-radius: 4px; vertical-align: middle;">
												</a>
											</div>
										</div>
										<div class="media-story" style="-webkit-box-flex: 1; flex: 1; min-width: 0; min-height: 0;">
											<p style="margin-bottom: 0;display: -webkit-box; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; -webkit-box-orient: vertical; word-wrap: break-word; margin: 0;">
													${map.LastReview.get(status.index).content}	
												<c:if test="${LastReview.review.content.length()>60 }">
													<a href="#" style="white-space: nowrap;color: #0073bb; cursor: pointer;">read more</a>
												<a href="#" style="white-space: nowrap; color: #0073bb; cursor: pointer;">read more</a>
												</c:if>
											</p>
										</div>
									</div>
									</c:if>
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="event_list_paging_section" style="font-size: 14px;">
				         <div class="event_list_pagination_block">
				            <div class="event_list_pagination_wrap">
				               <div class="event_list_page_of_pages">
				                  <c:if test="${map.YepsPager.blockEnd == 0}">
				                     Page ${map.YepsPager.curPage} of 1
				                  </c:if>
				                  <c:if test="${map.YepsPager.blockEnd != 0}">
				                     Page ${map.YepsPager.curPage} of ${map.YepsPager.blockEnd}
				                  </c:if>
				               </div>
		<!--                페이징 처리!! 현재페이지는 span이 되고 나머지는 a로 -->
		               <c:if test="${map.YepsPager.blockEnd != 1}">
		               <div class="event_list_page_link_wrapper">
		                  <div class="event_list_page_link_wrap">
		                  
		                  <c:if test="${map.YepsPager.curBlock > 1}">
		                     <div class="event_list_next_block">
		                        <a class="event_list_next_block_action" href="javascript:list('1')">
		                           <span>Start</span>
		                        </a>
		                     </div>
		                  </c:if>
		
		                  <c:if test="${map.YepsPager.curBlock > 1}">
		                     <div class="event_list_next_block">
		                        <a class="event_list_next_block_action" href="javascript:list('${map.YepsPager.prevPage}')">
		                           <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
		                              <svg class="icon_svg">
		                                 <path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>
		                              </svg>
		                           </span>
		                           <span>Previous</span>
		                        </a>
		                     </div>
		                  </c:if>
		                  
		                  <c:forEach var="num" begin="${map.YepsPager.blockBegin}" end="${map.YepsPager.blockEnd}">
		                     <div class="event_list_page_link_option">
		                     <c:choose>
		                        <c:when test="${num == map.YepsPager.curPage}">
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
		                  
		                  <c:if test="${map.YepsPager.curBlock <= map.YepsPager.totBlock}">
		                     <div class="event_list_next_block">
		                        <a class="event_list_next_block_action" href="javascript:list('${map.YepsPager.nextPage}')">
		                           <span>Next</span>
		                           <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
		                              <svg class="icon_svg">
		                                 <path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
		                              </svg>
		                           </span>
		                        </a>
		                     </div>
		                  </c:if>
		                  
		                  <c:if test="${map.YepsPager.curPage <= map.YepsPager.totPage}">
		                     <div class="event_list_next_block">
		                        <a class="event_list_next_block_action" href="javascript:list('${map.YepsPager.totPage}')">
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
		      
		</div><!-- 리스트 -->

				<div class="column-beta" style="width:330px;height:323px;float:left;padding:0px 15px;">
				<div class="wrap">
					<div id="map" style="width: 330px; height:300px;"></div>
				<script>
				var infoWindows2=[];
				function refreshMap(){
					rname=[];
					rnum=[];
					foodstyle=[];
					roadAddrPart1=[];
					addrDetail=[];
					roadAddrPart2=[];
					hp=[];
					rest_filename=[];
					infoWindows2=[];
					for(var i=0;i<markers.length;i++){
						markers[i].setMap(null);
					}
				}
				function refreshMarker(item,i){
					rname.push(item.rname);
					rnum.push(item.rnum);
					foodstyle.push(item.foodstyle);
					roadAddrPart1.push(item.roadAddrPart1);
					addrDetail.push(item.addrDetail);
					roadAddrPart2.push(item.roadAddrPart2);
					hp.push(item.raddress+ "-" + item.hp2 + "-" + item.hp3);
					rest_filename.push(item.fileDTO.filename);
					
					
						naver.maps.Service.geocode({address : roadAddrPart1[i]},function(status, response) {
							var result = response.result;
							var myaddr = new naver.maps.Point(result.items[0].point.x,result.items[0].point.y);
							map.setCenter(myaddr); // 검색된 좌표로 지도 이동
							// 마커 표시
							var marker = new naver.maps.Marker({
								position : myaddr,
								map : map,
								icon : {
									url : 'https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/pin_s_'+ (i + 1)+'.png',
									size : new naver.maps.Size(22, 30),
									anchor : new naver.maps.Point(11, 30)
								}
							}); 

							iwContent = [
								'<div class="scrollFix" style="width:300px;height:140px;padding:12px;">',
									'<div class="left" style="width:200px;height:140px;display:inline-block;float:left">',
										'<div class="rname" style="width:210px;height:20px">',
											'<span><a href="restaurant_content?rnum='+rnum[i]+'">'+rname[i]+'</a></span>',
										'</div>',
										'<div class="rating" style="width:">',
											'<span class="review">리뷰</span>',
										'</div>',
										'<div class="price-range">',
											'<span>￦￦￦</span><span>●</span><span class="foodstyle">'+foodstyle[i]+'</span>',
										'</div>',
										'<div class="address">',
										'<span>'+roadAddrPart1[i]+'</span><br>',
										'<span>'+addrDetail[i]+'</span><br>',
										'<span>'+roadAddrPart2[i]+'</span>',
										'</div>',
								'</div>',
								'<div class="right"style="width:100px;height:140px;float:left">',
									'<img width="90px" height="90px"src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+rest_filename[i]+'">',
								'</div>'
								].join('')
							var infowindow = new naver.maps.InfoWindow({
								content : iwContent,
							});
							markers.push(marker)
							infoWindows2.push(infowindow);
							function getClickHandler2(seq) {
								return function(e) {
									var marker = markers[seq], infoWindow = infoWindows2[seq];
									if (infoWindow.getMap()) {
										infoWindow.close();
									} else {
										infoWindow.open(map, marker);
									}
								}
							}
							naver.maps.Event.addListener(markers[i],'click', getClickHandler2(i));
						});
				};
					
					
	  var map = new naver.maps.Map('map',{
  	  zoom:6
    });
	  
	  var markers = [],infoWindows = [];
	   var j=0;
	   var k=1;
	   var rname=new Array();
	   var rnum=new Array();
	   var foodstyle=new Array();
	   var roadAddrPart1=new Array();
	   var addrDetail=new Array();
	   var roadAddrPart2=new Array();
	   var rest_filename=new Array();
	   var hp=new Array();
	   
	  	<c:forEach items="${map.list}" var="item" >
			rname.push("${item.rname}");
			rnum.push("${item.rnum}");
			foodstyle.push("${item.foodstyle}");
			roadAddrPart1.push("${item.roadAddrPart1}");
			addrDetail.push("${item.addrDetail}");
			roadAddrPart2.push("${item.roadAddrPart2}");
			hp.push("${item.raddress}" + "-" + "${item.hp2}" + "-" + "${item.hp3}");
			rest_filename.push("${item.fileDTO.filename}");
		</c:forEach>


		for (var i = 0; i < roadAddrPart1.length; i++) {
			naver.maps.Service.geocode({address : roadAddrPart1[i]},function(status, response) {
		          if (status !== naver.maps.Service.Status.OK) {
		              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
		          }
				var result = response.result;
				var myaddr = new naver.maps.Point(result.items[0].point.x,result.items[0].point.y);
				map.setCenter(myaddr); // 검색된 좌표로 지도 이동
				// 마커 표시
				var marker = new naver.maps.Marker({
					position : myaddr,
					map : map,
					icon : {
						url : 'https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/pin_s_'+ (j + 1)+'.png',
						size : new naver.maps.Size(22, 30),
						anchor : new naver.maps.Point(11, 30)
					}
				}); 
				iwContent = [
// 					<div class="hovercard biz-hovercard biz top-aligned right-aligned" style="display: none;">
						
// 					</div>
					'<div class="scrollFix" style="width:300px;height:140px;padding:12px;">',
						'<div class="left" style="width:200px;height:140px;display:inline-block;float:left">',
							'<div class="rname" style="width:210px;height:20px">',
								'<span><a href="restaurant_content?rnum='+rnum[j]+'">'+rname[j]+'</a></span>',
							'</div>',
							'<div class="rating" style="width:">',
								'<span class="review">리뷰</span>',
							'</div>',
							'<div class="price-range">',
								'<span>￦￦￦</span><span>●</span><span class="foodstyle">'+foodstyle[j]+'</span>',
							'</div>',
							'<div class="address">',
							'<span>'+roadAddrPart1[j]+'</span><br>',
							'<span>'+addrDetail[j]+'</span><br>',
							'<span>'+roadAddrPart2[j]+'</span>',
							'</div>',
					'</div>',
					'<div class="right"style="width:100px;height:140px;float:left">',
						'<img width="90px" height="90px"src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+rest_filename[j]+'">',
					'</div>'
					].join('')
				var infowindow = new naver.maps.InfoWindow({
					content : iwContent,
				});
				markers.push(marker)
				infoWindows.push(infowindow);
	
				function getClickHandler(seq) {
					return function(e) {
						var marker = markers[seq], infoWindow = infoWindows[seq];
						if (infoWindow.getMap()) {
							infoWindow.close();
						} else {
							infoWindow.open(map, marker);
						}
					}
				}
				naver.maps.Event.addListener(markers[j],'click', getClickHandler(j));
				j++
			});
		};
			</script>
					<div class="column column-beta js-search-feedback-container">
						<div class="search-feedback-box island island--light">
							<div class="feedback-biz-suggest">
								<div class="text-container">
									<h3 style="display: block;word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;font-weight: bold;margin-bottom: 6px;font-size: 16px;line-height: 1.3125em;color: #d32323;margin: 0 0 6px;">찾으려는 매장이 없습니까?</h3>
									<p style="margin-bottom: 12px; display: block;">만약 찾으시는 가게가 없다면 등록해주세요!</p>
								</div>
								<a href="restaurant_insert" class="ybtn ybtn--primary ybtn--small js-show-add-biz-modal">레스토랑 등록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
			<div class="footer-block" style="width:990px;height:214px;margin:0px -15px;">
				<div class="feedback-container" style="width:300px;height:214px; float: left;padding: 0 15px;">
				
				</div>
			</div>
		</div>
	</div>
	 <div class="loading_wapper" >
      	<div class="loading_img" style="left: 500px;top: 400px;"></div>
   	</div>


<script>
    // **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
    function list(page){
        window.location.href="yeps_main_saerch?category=${map.category}&location=${map.location}&searchword=${map.searchword}&curPage="+page;
    }
</script>
<script>
  $(window).scroll(function(){
      if ($(this).scrollTop() > 290) {
    	 $('.wrap').addClass('fixed');
      }else {
    	  $('.wrap').removeClass('fixed');
      }
  });
</script>

<script>
$(document).ready(function(){
	var mode;
	var price=[];
	
	$(document).on('change','.filters,.filters-price', function() {
		
		$('.filters').not(this).prop('checked', false);  
		
	    if($("input:checkbox[name='feature']").is(":checked") == true){
            mode = $(this).val();
          }else{
             mode = "mode";
          }
		price=[];
		$("input:checkbox[name='price']:checked").each(function() {
				price.push($(this).val());
			});
		if(price==null||price==""){
			price.push("0");
		}
			var allData = { "mode": mode,"price":price};
			$(document).ajaxStart(function() {
				$('body').css('overflow', 'hidden');
	            $('.loading_wapper').fadeIn(500);
	         })
	         
	         $(document).ajaxStop(function() {
	        	 $('body').css('overflow', 'auto');
	            $('.loading_wapper').fadeOut(500);
	         })
	         
				 $.ajax({
					 url : "restaurant_ajax",
					 type : "post",
					 dataType : "json",
					 data : allData,
					 success : function(data){
						 $('.column-alpha2 ul li').remove();
						 $('.event_list_paging_section').empty();
						 refreshMap();
						 $.each(data.list,function(i,item){
							 refreshMarker(item,i);
							 var price;
							 if(item.price == 1) {
								 price = '￦';
							 } else if (item.price == 2) {
								 price = '￦￦';
							 } else if (item.price == 3) {
								 price = '￦￦￦';
							 } else if (item.price == 4) {
								 price = '￦￦￦￦';
							 }
							 
							 
							 $(".column-alpha2 ul").append(
										'<li style="margin: 0;padding: 18px 0;border-top: 1px solid #e6e6e6;padding-top: 17px;display: list-item;text-align: -webkit-match-parent;">'+
											'<div class="search-result natural-search-result">'+
												'<div class="biz-listing-large" style="margin: 0 -15px;height:auto;overflow:hidden;">'+
													'<div class="main-attribute" style=" float: left;padding: 0 15px;min-height: 1px;    box-sizing: border-box;width: 62.5%;">'+
														'<div class="midea-block" style="position: relative;display: flex;">'+
															'<div class="midea-avata" style="border-right: 12px solid transparent; border-left: none;">'+
																'<div class="photo-box">'+
																	'<a href="restaurant_content?rnum='+item.rnum+'" class="js-analytics-click" style="color: #0073bb; cursor: pointer;">'+
																		'<img width="90px" height="90px" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+item.fileDTO.filename+'" style="outline: none;border-radius: 4px;vertical-align: middle;">'+
																	'</a>'+
																'</div>'+
															'</div>'+
															'<div class="midea-story" style="-webkit-box-flex: 1; flex: 1;min-width: 0;min-height: 0;">'+
																'<h3 style="font-weight: normal;margin-bottom: 6px;    word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;    font-size: 16px;line-height: 1.3125em;color: #d32323; display: block;">'+
																	'<span class="indexed-biz-name" style="color: #333;    display: block;">'+
																		'<a href="restaurant_content?rnum='+item.rnum+'" style="font-size: 16px;line-height: 1.3125em; display: inline; padding: 3px 0; color: #0073bb; cursor: pointer;">'+
																			'<span>'+item.rname+'</span>'+
																		'</a>'+
																	'<span>'+
																'</h3>'+
																'<div class="biz-rating biz-rating-large clearfix" style="margin: 6px 0;overflow:hidden;height:auto;">'+
																	'<div class="restList-star-rating-'+data.StarAvg[i]+'">'+
																		'<img class="offscreen" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png"width="84" height="303"style="clip: rect(0, 0, 0, 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px; vertical-align: middle;">'+
																	'</div>'+
																	'<span class="review-count rating-qualifier" style="display: block;float: left;color: #666;font-weight: normal;">'+data.reviewCount[i]+' 리뷰</span>'+
																'</div>'+
																'<div class="price-category"style="clear: both;">'+
																	'<span class="bullet-after">'+
																		'<span class="business-attribute price-range" style="letter-spacing: 1px; white-space: nowrap;">'+price+'</span>'+
																	'</span>'+
																	'<span class="category-str-list">'+
																		'<a href="#" style="color: #0073bb; cursor: pointer;">'+item.foodstyle+'</a>'+
																	'</span>'+
																'</div>'+
															'</div>'+
														'</div>'+
													'</div>'+
													'<div class="secondary-attributes" style="float: left;padding: 0 15px;min-height: 1px;box-sizing: border-box;width: 37.5%;margin-top: 3px;">'+
														'<address style="display: block;font-style: normal;">'+
															''+item.roadAddrPart1+'<br>'+
															''+item.addrDetail+'<br>'+
															''+item.roadAddrPart2+'<br>'+
														'</address>'+
														'<span class="offscreen" style="clip: rect(0 0 0 0);position: absolute;left: -9999px;top: auto;overflow: hidden;width: 1px;height: 1px;">Phone number</span>'+
															'<span class="hp">'+item.raddress+'-'+item.hp2+'-'+item.hp3+'</span>'+
														'</span>'+
													'</div>'+
												'</div>'+
													'<div class="snippet-block media-block" style="margin-top: 12px;margin-bottom: 0; font-size: 13px;line-height: 1.38462em;    position: relative;    display: flex;">'+
														'<div class="media-avatar" style="border-right: 6px solid transparent;border-left: none;">'+
															'<div class="photo-box pb-30s">'+
																'<a href="restaurant_content?rnum='+item.rnum+'" style="color: #0073bb; cursor: pointer;">'+
																	'<img width="30px" height="30px" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/'+data.LastReview[i].memberDTO.memberPhotoDTO.member_filename+'" style="outline: none;margin-top: 3px;border-radius: 4px;    vertical-align: middle;">'+
																'</a>'+
															'</div>'+
														'</div>'+
														'<div class="media-story" style="-webkit-box-flex: 1;flex: 1;min-width: 0;min-height: 0;">'+
															'<p style="margin-bottom: 0;display: block;">'+
																''+data.LastReview[i].content+''+
																'<c:if test="${LastReview.review.content.length()>60 }">' +
																	'<a href="#" style="white-space: nowrap; color: #0073bb; cursor: pointer;">read more</a>'+
																'</c:if>' +
															'</p>'+
														'</div>'+
													'</div>'+
											'</div>'+
										'</li>'
										 );
								 });
						 var pagingHtml = "";
				           pagingHtml = '<div class="event_list_pagination_block">' + 
				           				'<div class="event_list_pagination_wrap">' + 
				           				'<div class="event_list_page_of_pages">';
				           if(data.YepsPager.blockEnd == 0) {
				        	   pagingHtml += 'Page ' + data.YepsPager.curPage + ' of 1';
				           } else {
				        	   pagingHtml += 'Page ' + data.YepsPager.curPage + ' of ' + data.YepsPager.blockEnd;
				           }
				           pagingHtml += '</div>';
				           if(data.YepsPager.blockEnd != 1) {
				        	   pagingHtml += '<div class="event_list_page_link_wrapper">';
				        	   pagingHtml += '<div class="event_list_page_link_wrap">';
				        	   if(data.YepsPager.curBlock > 1) {
				        		   pagingHtml += '<div class="event_list_next_block">';
				        		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+ 1 +')">';
				        		   pagingHtml += '<span>Start</span>';
				        		   pagingHtml += '</a>';
				        		   pagingHtml += '</div>';
				        	   }
				        	   
				        	   if(data.YepsPager.curBlock > 1) {
				        		   pagingHtml += '<div class="event_list_next_block">';
				        		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+data.YepsPager.prevPage+')">';
				        		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
				        		   pagingHtml += '<svg class="icon_svg">';
				        		   pagingHtml += '<path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>';
				        		   pagingHtml += '</svg>';
				        		   pagingHtml += '</span>';
				        		   pagingHtml += '<span>Previous</span>';
				        		   pagingHtml += '</a>';
				        		   pagingHtml += '</div>';
				        	   }
				        	   
				        	   for(var num = data.YepsPager.blockBegin; num <= data.YepsPager.blockEnd; num++) {
				        		   pagingHtml += '<div class="event_list_page_link_option">';
				        		   if(num == data.YepsPager.curPage) {
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
				        	   
				        	   if(data.YepsPager.curBlock <= data.YepsPager.totBlock) {
				        		   pagingHtml += '<div class="event_list_next_block">';
				        		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+data.YepsPager.nextPage+')">';
				        		   pagingHtml += '<span>Next</span>';
				        		   pagingHtml += '<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">';
				        		   pagingHtml += '<svg class="icon_svg">';
				        		   pagingHtml += '<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>';
				        		   pagingHtml += '</svg>';
				        		   pagingHtml += '</span>';
				        		   pagingHtml += '</a>';
				        		   pagingHtml += '</div>';
				        	   }
				        	   if(data.YepsPager.curBlock <= data.YepsPager.totBlock) {
				        		   pagingHtml += '<div class="event_list_next_block">';
				        		   pagingHtml += '<a class="event_list_next_block_action" href="javascript:list('+data.YepsPager.totPage+')">';
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
				error:function(request,status,error){
				alert("code:"+request.status+"\n"+"error:"+error);
			}
		});
	});
});

</script>
<%@include file="../bottom.jsp" %>



