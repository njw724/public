<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>${getRest.rname}</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/review.css?ver=2"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=2"/>"/>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jD9qGVpvZh7Zobclojwp&submodules=geocoder"></script>
	<script src="//code.jquery.com/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<script src="http://malsup.github.com/jquery.cycle2.js"></script>
	<script src="http://malsup.github.io/jquery.cycle2.carousel.js"></script>
</head>
<%@include file="../top.jsp" %>
<div class="main" style="background: white;">
	<div class="top-shelf">
		<div class="content-container js-biz-details">
			<div class="biz-page-header clearfix" >
					<div class="biz-page-header-left claim-status" >
						<div class="u-space-t1">
						<h1>${getRest.rname}</h1>
					</div>
						<div class="biz-main-info embossed-text-white">
							<div class="rating-info clearfix">
								<div class="biz-rating biz-rating-very-large clearfix">
									<div class="restContent-star-rating-${starAvg}">
										<img class="offscreen" height="303"	src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png" width="84">
									</div>
									<span class="review-count rating-qualifier">${reviewCount} 리뷰</span>
								</div>
							</div>
							<div class="price-category">
								<span class="bullet-after">
       								 <span class="business-attribute price-range">
       								 	<c:forEach begin="1" end="${getRest.price}">￦</c:forEach>
       								 </span>
        						</span>
        						<span class="category-str-list" style="margin-right: 6px;">
			                  	 	${getRest.foodstyle}
					    		</span>
							</div>
						</div>
					</div>
					
					 
				
					<div class="biz-page-header-right u-relative">
						<div class="biz-page-actions nowrap">
							<c:if test="${empty myReview}">
							<a href="review_write?rnum=${getRest.rnum}&mode=write&where=rest" style="text-decoration: none;" class="ybtn review_write">
								<span aria-hidden="true" style="fill: white; width: 24px; height: 24px;" class="icon">
							    	<svg id="24x24_star" height="100%" viewBox="0 0 24 24" width="100%">
							    		<path d="M12 1.5l2.61 6.727 6.89.53-5.278 4.688 1.65 7.055L12 16.67 6.13 20.5l1.648-7.055L2.5 8.757l6.89-.53L12 1.5z"></path>
							   		</svg>
								</span>
								Write a Review 
							</a>
							</c:if>
							<c:if test="${!empty myReview}">
							<a href="review_write?rnum=${getRest.rnum}&mode=update&where=rest&rvnum=${myReview.rvnum}&star=${myReview.gradepoint}" style="text-decoration: none;" class="ybtn review_write">
								<span aria-hidden="true" style="fill: white; width: 24px; height: 24px;" class="icon">
							    	<svg id="24x24_star" height="100%" viewBox="0 0 24 24" width="100%">
							    		<path d="M12 1.5l2.61 6.727 6.89.53-5.278 4.688 1.65 7.055L12 16.67 6.13 20.5l1.648-7.055L2.5 8.757l6.89-.53L12 1.5z"></path>
							    	</svg>
								</span>
								Edit a Review 
							</a> 
							</c:if>
							<span class="ybtn-group clearfix" style="float: right;margin-top: 4px;"> 
						   	<a class="ybtn ybtn--small add-photo-button" href="restaurant_update_photo?rnum=${getRest.rnum}">
							  	<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon">
							     	<svg id="18x18_add_photo" height="100%" viewBox="0 0 18 18" width="100%">
						   		    	<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 4.75a4.25 4.25 0 1 0 0 8.5 4.25 4.25 0 0 0 0-8.5zM11 10h-1v1a1 1 0 0 1-2 0v-1H7a1 1 0 0 1 0-2h1V7a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2z"></path>
						         	</svg>
							  	</span> 
							  	Add Photo
						   	</a>
							</span>
				     	</div>
				  	</div>
			   </div>
		
				<div class="biz-page-subheader" style="display: table;">
					<div class="mapbox-container">
						<div class="mapbox" style="padding: 5px; background: #fff; border: 1px solid #ccc;">
							<div class="mapbox-map" id="map2" style="height: 180px; border: 1px solid #ccc;">
							</div>
							<div class="mapbox-text" style="min-height: 105px;">
								<ul style="margin: 5px; display: block;">
										<li class="u-relative">
											<span aria-hidden="true" style="vertical-align: top;width: 18px; height: 18px;" class="icon">
											    <svg id="18x18_marker" height="100%" viewBox="0 0 18 18" width="100%">
											    	<path d="M14 7A5 5 0 0 0 4 7c0 1.97 1.15 3.658 2.806 4.472h-.17L9 16l2.363-4.528h-.17C12.85 10.658 14 8.97 14 7zM9 5a2 2 0 1 1 0 4 2 2 0 0 1 0-4z"></path>
										    	</svg>
											</span>
											<div class="map-box-address u-space-l4" style="line-height: 18px; display:inline-block;">
												<strong class="street-address" style="font-weight: bold;">
													<address style="display: block;font-style: normal;">
														${getRest.roadAddrPart1}<br> ${getRest.addrDetail}<br>
														${getRest.roadAddrPart2}
													</address>
												</strong>
											</div>
										</li>
									<li class="clearfix" style="margin-bottom: 3px; display: list-item; text-align: -webkit-match-parent;">
										<div>
											<span class="icon" style="width: 18px; height: 18px;"> 
												<svg class="icon_svg">
													<path d="M16.444 7.556l-5.957-5.958a2.145 2.145 0 0 0-3.034 0L1.598 7.453a2.145 2.145 0 0 0 0 3.034l5.958 5.957a2 2 0 0 0 2.828 0l6.06-6.06a2 2 0 0 0 0-2.828zM9.97 11.47v-2.5h-3v3h-1v-4h4v-2.5l3 3-3 3z"></path>
												</svg>
											</span> 
											<a class="btn" data-popup-open="popup-1" href="#">길찾기</a>
											<div class="popup" data-popup="popup-1">
											    <div class="popup-inner">
											        <a class="popup-close" data-popup-close="popup-1" href="#">x</a>
											    </div>
											</div>
										</div>
									</li>
									<li class="hp" style="margin-bottom: 3px; display: list-item; text-align: -webkit-match-parent;">
										<div style="display: block;">
											<span class="icon" style="width: 18px; height: 18px;">
												<svg class="icon_svg">
													<path d="M15.862 12.526l-2.91-1.68a.442.442 0 0 0-.486.087l-1.58 1.687a.857.857 0 0 1-.52.232s-1.083.03-3.13-1.985c-2.046-2.015-2.054-3.12-2.054-3.12 0-.17.094-.41.21-.533L6.85 5.656a.49.49 0 0 0 .08-.504L5.295 2.14c-.073-.155-.228-.18-.345-.058L2.26 4.924a1.07 1.07 0 0 0-.248.53s-.34 2.927 3.75 6.955c4.093 4.025 6.96 3.59 6.96 3.59.167-.027.4-.148.516-.27l2.684-2.845c.117-.123.09-.285-.062-.36z"></path>
												</svg>
											</span> 
											<span class="phone">${getRest.raddress}-${getRest.hp2}-${getRest.hp3}</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="restContent-showcase-container">
						<div class="restContent-showcase-container-inner">
							<div class="top-shelf-grey"></div>
							<div class="showcase-footer-links">
								<a class="see-more u-pull-right" href="restaurant_photoList?rnum=${getRest.rnum}&view=all" style="float: right !important; color: #0073bb; cursor: pointer;">
									<span aria-hidden="true" style="width: 18px; height: 18px;"class="icon">
										<svg class="icon_svg">
								        	<svg id="18x18_grid" height="100%" viewBox="0 0 18 18" width="100%">
								        		<path d="M10 15v-5h5v5h-5zm0-12h5v5h-5V3zm-7 7h5v5H3v-5zm0-7h5v5H3V3z"></path>
							        		</svg>
								    	</svg>
								    </span>
								    See all ${getImageCount}
								</a>
							</div>
							
							<c:if test="${!empty uploadFileList}">
							<div class="showcase-photos">
								<div class="cycle-slideshow responsive" id="showcase-photo-box" data-cycle-prev="#prev" data-cycle-next="#next" style="background: none; z-index: 1000; display:inline-block; width: 100%; height: 220px; box-shadow: none;" data-cycle-fx="carousel" data-cycle-timeout="2000" data-cycle-carousel-visible="3" data-cycle-carousel-fluid="true">
									<span class="ms-arrow msa-previous" id="prev"></span>
    								<span class="ms-arrow msa-next" id="next"></span>
								</div>
							</div>
							</c:if>
						</div>
					 </div>
				  </div>
		        </div>
	        </div>
        
		<div class="restContent-super-container">
			<div class="restContent-container">
				<div class="restContent-layout-block">
					<div class="restContent-alpha">
						<div class="restContent-review-highlights" style="position: relative;">
							<div class="restContent-review-hightlights-content">
								<div style="border-bottom: 1px solid #e6e6e6;">
									<h2 style="word-wrap: break-word !important; word-break: break-word !important; overflow-wrap: break-word !important; font-weight: bold; margin-bottom: 6px; font-size: 21px; line-height: 1.28571em; color: #d32323; margin: 0 0 6px;">
										Review Highlights
									</h2>
								</div>
								<ul class="restContent-review-highlights-list" style="list-style: none; margin: 24px 0;">
									<c:forEach var="reviewDTO" items="${highlightReview}">
									<li class="restContent-review-highlights-media-block">
										<div class="restContent-review-highlights-media-avatar" style="border-right: 12px solid transparent; border-left: none;">
											<div class="restcontent-review-highlights-photo-box">
												<a href="member_details?mnum=${reviewDTO.memberDTO.mnum}" style="color: #0073bb; text-decoration: none; cursor: pointer;">
													<img width="60px" height="60px" style="outline: none; border-radius: 4px; vertical-align: middle;" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${reviewDTO.memberDTO.memberPhotoDTO.member_filename}">
												</a>
											</div>
										</div>
										<div class="restContent-review-highlights-media-story">
											<p class="restContent-quote" style="margin-bottom: 4px;">
           										${reviewDTO.content} 
											</p>
											<p class="restContent-highlight-sub-info" style="color: #666;margin-bottom: 4px;">
												<a href="restaurant_content?rnum=${reviewDTO.restaurantDTO.rnum}" style="color: #0073bb;">${reviewDTO.restaurantDTO.rname}</a>
											</p>
										</div>
									</li>
									</c:forEach>
								</ul>
							</div>
						</div>
							<div>
								<div class="restContent-feed">
									<div class="restContent-feed-header">
										<div class="restContent-feed-section-header">
											<h2>
												Recommended Reviews 
												<b style="font-weight: normal;color: #333;">for ${getRest.rname}</b>
											</h2>
											<div class="restContent-feed_filters" >
												<div class="section-header_block" style="margin: 0px !important;">
													<div class="arrange arrange--middle u-space-b1"> <!-- 추가한 것 -->
														<div class="restContent-arrange-middle">
															<div class="restContent-feed-search" style="margin-right: 30px !important;">
																<form class="restContent-form" name="restContent" method="post">
																	<div class="restContent-arrange-unit">
																		<input type="text" placeholder="Search within the reviews" name="SearchKeyword" id="SearchKeyword" autocomplete="on">
																		<input type="hidden" name="rnum" value="${getRest.rnum}">
																	</div>
																	<div class="rsetContent-arrange-unit-button" style="box-sizing: border-box;display: table-cell;vertical-align: top;">
																		<button type="button" value="submit" onclick="check()" class="restInsert-button">
																			<span>
																				<span class="restContent-icon">
																					<span aria-hidden="true" style="width: 18px; height: 18px;" class="restContent-icon18">
																					    <svg class="icon_svg">
																					        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_search_small"></use>
																					    </svg>
																					</span>
																			    </span>
																			</span>
																		</button>
																	</div>
																</form>
															</div>
														</div>
													<div class="restContent-arrange-unit-nowrap">
														<div class="feed_sort js-review-feed-sort" style="margin-left: -12px;">
															<div class="dropdown js-dropdown dropdown--tab dropdown--arrow dropdown--hover dropdown--restricted" >
																<div class="dropdown_toggle js-dropdown-toggle">
																	<a href="javascript:void(0);" class="dropdown_toggle-action" style="text-decoration:none;">
																		<span class="dropdown_prefix">
																			Sort by
																		</span>
																		<span class="dropdown_toggle-text js-dropdown-toggle-text" data-dropdown-initial-text="Yeps Sort" style="font-weight: bold;">
																			Yeps Sort
																		</span>
																		<span aria-hidden="true" style="width: 14px; height: 14px;" class="icon icon--14-triangle-down icon--size-14 icon--currentColor u-triangle-direction-down dropdown_arrow">
                                                       						<svg class="icon_svg">
                                                           						<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#14x14_triangle_down">
                                                              						<svg id="18x18_search_small" height="100%" viewBox="0 0 18 18" width="100%"><path d="M15.913 14.224a1.324 1.324 0 0 0-.3-.466h.01l-3.378-3.376a5.49 5.49 0 0 0 .802-2.857 5.523 5.523 0 1 0-5.522 5.52 5.49 5.49 0 0 0 2.856-.8l3.37 3.368.006.003a1.364 1.364 0 0 0 .93.384C15.41 16 16 15.41 16 14.684c0-.163-.032-.317-.086-.46zM7.525 10.94a3.422 3.422 0 0 1-3.418-3.416 3.422 3.422 0 0 1 3.418-3.417 3.422 3.422 0 0 1 3.416 3.417 3.42 3.42 0 0 1-3.413 3.416z"></path></svg>
                                                           						</use>
                                                       						</svg>
                                                   						</span>
																	</a>
																</div>
																<div class="dropdown_menu-container">
																	<div class="dropdown_menu-inner">
																		<div class="dropdown_menu js-dropdown-menu">
																			<ul class="dropdown_menu-group" style="list-style: none;">
																				<li class="dropdown_item">
																					<a class="tab-link js-dropdown-link tab-link--dropdown js-tab-link--dropdown is-selected" href="javascript:;" style="text-decoration:none;">
																						<span class="tab-link_label" title="Yeps Sort">Yeps Sort</span>
																					</a>
																				</li>
																				<li class="dropdown_item">
																					<a class="tab-link js-dropdown-link tab-link--dropdown js-tab-link--dropdown" href="#" onclick="sort_check()" style="text-decoration:none;">
																						<span class="tab-link_label" title="최근">최근</span>
																					</a>
																				</li>
																				<li class="dropdown_item">
																					<a class="tab-link js-dropdown-link tab-link--dropdown js-tab-link--dropdown" href="javascript:;" style="text-decoration:none;">
																						<span class="tab-link_label" title="오래된">오래된</span>
																					</a>
																				</li>
																				<li class="dropdown_item">
																					<a class="tab-link js-dropdown-link tab-link--dropdown js-tab-link--dropdown" href="javascript:;" style="text-decoration:none;">
																						<span class="tab-link_label" title="높은 평점">높은 평점</span>
																					</a>
																				</li>
																				<li class="dropdown_item">
																					<a class="tab-link js-dropdown-link tab-link--dropdown js-tab-link--dropdown" href="javascript:;" style="text-decoration:none;">
																						<span class="tab-link_label" title="낮은 평점">낮은 평점</span>
																					</a>
																				</li>
																			</ul>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div> <!-- 여기 추가한것 -->
											</div>
										</div>
									</div>
								</div>
								
								<div class="restContent-review-list" style="position: relative;">
									<ul class="restContent-reviews">
									<c:if test="${empty myReview}">
										<li>
											<div class="restContent-review-widget" style="margin: 0 -15px;">
												<div class="restContent-user">
													<div class="restContent-user-content" style="margin-top: -3px;">
														<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/empty_profile.png" height="68">
													</div>
												</div>
												<div class="restContent-review-wrapper">
													<div class="restContent-clearfix">
														<div class="restcontent-star" style="margin-bottom: 12px !important;">
															<div class="restContent-u-space" style="margin-bottom: 12px !important;border-bottom: 1px solid #ccc;">
															<fieldset class="star-selector js-star-selector">
													 			<form name="starpointF" method="post" action="review_write?mode=write&where=rest">
																	<div>
																		<ul id="star_rating">
																			<li class="selector star-selector-li-1_4 check_li_1" data-label="Eek! Methinks not.">
							                            				     	<input id="rating-1" type="radio" value="1" name="rating" class="star-selector-input" style="cursor: pointer; border: none; margin: 0; padding: 0; width: 30px; height: 30px; opacity: 0;">
							                                					 	<label class="star-selector_label" for="rating-1">1 (Eek! Methinks not.)</label>
							                                					 	<span class="tooltip-wrapper">
							                                					 		<span class="tooltip">
							                                					 			Eek! Methinks not.
							                                					 		</span>
							                                					 	</span>
							                             					</li>
							                              					<li class="selector star-selector-li-1_4 check_li_2" data-label="Meh. I've experienced better.">
							                                 					<input id="rating-2" type="radio" value="2" name="rating" class="star-selector-input">
							                                 						<label class="star-selector_label" for="rating-2">2 (Meh. I've experienced better.)</label>
							                              							<span class="tooltip-wrapper">
							                                					 		<span class="tooltip">
							                                					 		</span>
							                                						</span>
							                              					</li>
																			<li class="selector star-selector-li-1_4 check_li_3" data-label="3 (A-OK.)">
																				<input id="rating-3" type="radio" value="3" name="rating" class="star-selector-input">
							                                 						<label class="star-selector_label" for="rating-3">3 (A-OK.)</label>
							                              							<span class="tooltip-wrapper">
							                                					 		<span class="tooltip">
							                                					 		</span>
							                                					 	</span>
							                              					</li>
							                              					<li class="selector star-selector-li-1_4 check_li_4" data-label="4 (Yay! I'm a fan.)">
							                                 					<input id="rating-4" type="radio" value="4"  name="rating" class="star-selector-input">
							                                 						<label class="star-selector_label" for="rating-4">4 (Yay! I'm a fan.)</label>
							                              							<span class="tooltip-wrapper">
							                                					 		<span class="tooltip">
							                                					 		</span>
							                                					 	</span>
							                              					</li>
							                              					<li class="selector star-selector-li-5 check_li_5" data-label="5 (Woohoo! As good as it gets!)">
							                                 					<input id="rating-5" type="radio" value="5"  name="rating" class="star-selector-input">
							                                 						<label class="star-selector_label" for="rating-5">5 (Woohoo! As good as it gets!)</label>
							                              							<span class="tooltip-wrapper">
							                                					 		<span class="tooltip">
							                                					 		</span>
							                                					 	</span>
							                              					</li>
							                           					</ul> 
							                                 			<input type="hidden" name="rnum" value="${getRest.rnum}">   
							                                 			<input type="hidden" name="star" id="star">
							                                 			<input type="hidden" name="mode" value="write">
							                                 			<input type="hidden" name="where" value="rest">
							                          				</div>
							                           			</form>
															</fieldset>
														</div>
													</div>
													<a class="restContent-text-link" href="review_write?rnum=${getRest.rnum}&mode=write&where=rest">
														Start your review of <strong style="font-weight: bold;">${getRest.rname}</strong>.
										            </a>
												</div>
											</div>
										</div>
									</li>
								</c:if>	
								<c:if test="${!empty myReview}">
									<li>
										<div class="restContent-review-with" style="margin: 0 -15px; display: flex;">
											<div class="restContent-user">
												<div class="restContent-user-content" style="margin-top: -3px;">
													<div class="restContent-meida-block">
														<div class="restContent-media-avatar">
															<div class="restContent-photo-box">
																<a href="member_details?mnum=${myReview.memberDTO.mnum}" style="color: #0073bb;">
																	<img class="restContent-photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${myReview.memberDTO.memberPhotoDTO.member_filename}" width="60">
																</a>
															</div>
														</div>
														<div class="restContent-media-story">
															<ul class="restContent-user-info">
																<li class="restContent-user-name">
																	<a href="member_details?mnum=${myReview.memberDTO.mnum}" class="restContent-user-display-name">
																		<c:if test="${empty myReview.memberDTO.nickname}">
																			${myReview.memberDTO.email}
																		</c:if>
																		<c:if test="${!empty myReview.memberDTO.nickname}">
																			${myReview.memberDTO.nickname}
																		</c:if>
																	</a>
																</li>
																<li class="restContnet-user-location">
																	<b style="font-weight: bold;">
																	<c:forTokens items="${myReview.memberDTO.address}" delims=" " begin="1" end="2" var="addr">
                                                                    	${addr}
                                                                  	</c:forTokens>	
																	</b>
																</li>
															</ul>
															<ul class="restContent-user-stats">
																<li class="restContent-review-count">
																	<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon">
																	    <svg class="icon_svg" id="18x18_review" height="100%" viewBox="0 0 18 18" width="100%">
																	        <path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
																	    </svg>
																	</span>
																	<b style="font-weight: bold;">${myReview.memberDTO.reviewcount}</b> reviews
																</li>
																<li class="restContent-photo-count">
																	<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon">
																	    <svg class="icon_svg" id="18x18_camera" height="100%" viewBox="0 0 18 18" width="100%">
																	        <path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
																	    </svg> 
																	</span>
																	<b style="font-weight: bold;">${myReview.memberDTO.imagecount}</b> photos
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="restContent-review-wrapper add_margin_top_div">
												<p class="myreview_p_1">
													Finish your review of 
													<strong class="myreview_strong_1">${getRest.rname}</strong>
												</p>
												<div class="myreview_div_1">
													<div class="myreview_div_2">
														<div class="myreview_div_3">
														<!--myreview 별점부분 -->
															<div class="restList-star-rating-${myReview.gradepoint}" >
																<img class="offscreen" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png"
																	width="84" height="303" style="clip: rect(0, 0, 0, 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px; vertical-align: middle;">
															</div>									
														</div>
														<div class="myreview_div_5">
															<p class="myreview_p_2"> 
																Started on ${myReview.reg_date}
															</p> 
														</div>
													</div>
													<p class="myreview_p_3">
														${myReview.content} 
													</p>
													
													<ul class="review_photo_box">
													<c:forEach var="photos" items="${uploadFileList}" varStatus="status">
														<c:if test="${photos.mnum eq myReview.memberDTO.mnum}">
															<c:if test="${status.index % 3 == 0}">
																<li style="width: 348px; height: 348px;">
																	<div class="review_photo_box_overlay">
																		<img height="348" width="348" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${photos.filename}">
																	</div>
																</li>
															</c:if>
															<c:if test="${status.index % 3 != 0}">
																<li style="width: 168px; height: 168px;">
																	<div class="review_photo_box_overlay">
																		<img height="168" width="168" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${photos.filename}">
																	</div>
																</li>
															</c:if>
														</c:if>
													</c:forEach>
													</ul>
													<div class="myreview_div_6">

														<a class="myreview_a_1" href="review_write?star=${myReview.gradepoint}&contentUpdate=${myReview.content}&rnum=${getRest.rnum}&mode=update&rvnum=${myReview.rvnum}">
															리뷰수정
														</a>
														<form class="myreview_formF" action="review_delete" method="post">
															<input class="myreview_input_1" type="hidden" name="rvnum" value="${myReview.rvnum}">
															<input class="myreview_input_1" type="hidden" name="mnum" value="${myReview.memberDTO.mnum}">
															<input class="myreview_input_1" type="hidden" name="rnum" value="${getRest.rnum}">
															<input class="myreview_input_1" type="hidden" name="mode" value="${restaurantReviewDelete}">		
															<button class="myreview_button_1"> 
																<span class="myreview_span_1">
																	<svg class="myreview_svg_1">
																		<path class="myreview_path_1" d="M3 5V3h4V2h4v1h4v2H3zm11 9c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6h10v8zM8 8.5a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5zm3 0a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5z"></path>
																	</svg>
																</span>
																<span class="myreview_span_2">
																	<span class="myreview_span_3">
																		Delete draft
																	</span>
																</span>
															</button>
														</form>
													</div>
												</div>
											</div>
										</div>
									</li><!-- 리뷰 -->
								</c:if>		
									
									
										
									<c:forEach var="getReview" items="${selectedDataRV}">	
									
									<!-- 상우 작업부분 li -->
									<c:if test="${myReview.memberDTO.email != getReview.memberDTO.email}">
									<li>
										<div class="restContent-review-with">
											<div class="restContent-user">
												<div class="restContent-user-content" style="margin-top: -3px;">
													<div class="restContent-meida-block">
														<div class="restContent-media-avatar">
															<div class="restContent-photo-box">
																<a href="member_details?mnum=${getReview.memberDTO.mnum}" style="color: #0073bb;">
																	<img class="restContent-photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${getReview.memberDTO.memberPhotoDTO.member_filename}" width="60">
																</a>
															</div>
														</div>
														<div class="restContent-media-story">
															<ul class="restContent-user-info">
																<li class="restContent-user-name">
																	<a href="member_details?mnum=${getReview.memberDTO.mnum}" class="restContent-user-display-name">
																		<c:if test="${empty getReview.memberDTO.nickname}">
																			${getReview.memberDTO.email}
																		</c:if>
																		<c:if test="${!empty getReview.memberDTO.nickname}">
																			${getReview.memberDTO.nickname}
																		</c:if>
																	</a>
																</li>
																<li class="restContnet-user-location">
																	<b style="font-weight: bold;">
																	<c:forTokens items="${getReview.memberDTO.address}" delims=" " begin="1" end="2" var="addr">
                                                                    	${addr}
                                                                  	</c:forTokens>	
																	</b>
																</li>
															</ul>
															<ul class="restContent-user-stats">
																<li class="restContent-review-count">
																	<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon">
																	    <svg class="icon_svg" id="18x18_review" height="100%" viewBox="0 0 18 18" width="100%">
																	        <path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>
																	    </svg>
																	</span>
																	<b style="font-weight: bold;">${getReview.memberDTO.reviewcount}</b> reviews
																</li>
																<li class="restContent-photo-count">
																	<span aria-hidden="true" style="fill: #f15c00; width: 18px; height: 18px;" class="icon">
																	    <svg class="icon_svg" id="18x18_camera" height="100%" viewBox="0 0 18 18" width="100%">
																	        <path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
																	    </svg>
																	</span>
																	<b style="font-weight: bold;">${getReview.memberDTO.imagecount}</b> photos
																</li>
															</ul>
														</div>
													</div>
													<ul class="restContent-list-link">									
														<li>
															<a class="restContent-share-review" href="#" data-popup-open="writeMessage" alt="${getReview.memberDTO.email}">
																<div class="action-link_icon arrange_unit">
																	<span aria-hidden="true" style="fill: currentColor; width: 18px; height: 18px;" class="icon">
																    	<svg class="icon_svg" id="18x18_speech" height="100%" viewBox="0 0 18 18" width="100%">
																        	<path d="M2 4v6a2 2 0 0 0 2 2h1v3l4-3h5a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"></path>
																    	</svg>
																	</span>
																</div>
																<div class="action-link_label arrange_unit arrange_unit--fill">
            														Send message
																</div>
															</a>
														</li>
													</ul>
												</div>
											</div>
											<div class="restContent-review-wrapper">
												<div class="restContent-review-content">
													<div class="restContent-review-rating">
														<div>
															<div class="restList-star-rating-${getReview.gradepoint}" >
																<img class="offscreen" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" width="84" height="303">
															</div>
														</div>
														<span class="restContent-rating-qualifier">
															${getReview.reg_date}
														</span><!-- 날짜 -->
													</div>
													<p lang="ko" style="margin-bottom: 12px;display:block;">
														${getReview.content}
													</p>
													
													
												<ul class="review_photo_box">
													<c:forEach var="photos" items="${uploadFileList}" varStatus="status">
														<c:if test="${photos.mnum eq getReview.mnum}">
															<c:if test="${status.index % 3 == 0}">
																<li style="width: 348px; height: 348px;">
																	<div class="review_photo_box_overlay">
																		<img height="348" width="348" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${photos.filename}">
																	</div>
																</li>
															</c:if>
															<c:if test="${status.index % 3 != 0}">
																<li style="width: 168px; height: 168px;">
																	<div class="review_photo_box_overlay">
																		<img height="168" width="168" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${photos.filename}">
																	</div>
																</li>
															</c:if>
														</c:if>
													</c:forEach>
												</ul>										
													
													
												</div><!--리뷰 내용 -->
													
												<div class="review-footer clearfix">
													<div class="review-footer-actions pull-right clearfix" style="margin-top: 23px; float: right;">
														<a class="myreview_a_2 chiclet-link show-tooltip js-analytics-click chiclet-link--flag" data-popup-open="popup-2">
															<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon">
															    <svg id="18x18_flag" height="100%" viewBox="0 0 18 18" width="100%">
															    	<path class="myreview_path_2" d="M6 10V3c4.976 1.098 4.024-1 8 0v7c-4.024-.976-3.024 1.024-8 0zM4 2h1v14H4V2z"></path>
														    	</svg>
															</span>
															<span class="tooltip-wrapper">
													            <span class="tooltip">
													            	Report review
													            </span>
													        </span>
														</a>
													</div>
												</div>
											</div>
										</div>
									</li><!-- 리뷰 -->
									</c:if>
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
							</div>
						</div>
					</div>
				</div>
				<div class="restContent-beta">
					<div class="restContent-open-rail clearfix">
						<div class="restContent-summary">
							<ul class="restContent-iconed-list" style="list-style: none;">
								<li class="restContent-iconed-hours-iconed-list-item" style="display: table;width: 100%;margin-bottom: 0;">
									<div class="restContent-iconed-list-avatar">
										<span aria-hidden="true" style="width: 24px; height: 24px; fill: #d32323;" class="icon">
										    <svg class="icon_svg" id="24x24_clock" height="100%" viewBox="0 0 24 24" width="100%">
										        <path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-18c-4.41 0-8 3.59-8 8s3.59 8 8 8 8-3.59 8-8-3.59-8-8-8zm3 11c-.19 0-.384-.055-.555-.168L11 12.535V7a1 1 0 0 1 2 0v4.465l2.555 1.703A1 1 0 0 1 15 15z"></path>
										    </svg>
										</span>
									</div>
									<div class="restContent-iconed-list-story">
										<dl class="restContent-short-def-list" style="display: block;">
											<dt class="restContent-attribute-key" style="margin-right: 0.25em;display: inline;">
												오늘
											</dt>
											<dd style="font-weight: bold;display: inline;"> 
												<strong class="u-space-r-half" style="margin-right: 3px !important;font-weight: bold;">
													<span class="today"></span><br>
												</strong>
												<span class="open">
													영업 중
												</span>
											</dd>
										</dl>
									</div>
								</li>
								<li class="restContent-iconed-menu-iconed-list-item">
							        <div class="restContent-iconed-list-avatar">
										<span style="width: 24px; height: 24px; display: inline-block; vertical-align: middle;position: relative;overflow: hidden;top: -.1em;fill: #666;" class="icon">
											<svg class="icon_svg" id="24x24_food" height="100%" viewBox="0 0 24 24" width="100%">
							   					<path d="M17.22 22a1.78 1.78 0 0 1-1.74-2.167l1.298-4.98L14 13l1.756-9.657A1.635 1.635 0 0 1 19 3.635V20.22A1.78 1.78 0 0 1 17.22 22zm-7.138-9.156l.697 7.168a1.79 1.79 0 1 1-3.56 0l.7-7.178A3.985 3.985 0 0 1 5 9V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.83c0 1.85-1.2 3.518-2.918 4.014z"></path>
							   				</svg>
										</span>
									</div>
									<div class="restContent-iconed-list-story">
							            <b style="font-weight: bold;">
							            	<a class="menu-explore js-menu-explore" href="restaurant_listMenu?rnum=${getRest.rnum}">
							            		모든 메뉴
							            	</a>
							            </b>
							        </div>
							    </li>
							    <li class="restContent-iconed-list-item" style="display: table;width: 100%;margin-bottom: 0;">
						            <div class="restContent-iconed-list-avatar">
						       		 	<span class="restContent-business-attribute price-range" data-remainder="">
						       		 		<c:forEach begin="1" end="${getRest.price}">￦</c:forEach>
						       		 	</span>
						            </div>
						            <div class="restContent-iconed-list-story" style="    border-bottom: none;">
						                <dl class="restContent-short-def-list" style="display: block;">
						                    <dt class="restContent-attribute-key" style="margin-right: 0.25em;display: inline;">가격 범위</dt>
						                    <dd class="restContent-nowrap price-description">
						                        <c:choose>
													<c:when test="${getRest.price==1}">
														10,000원 이하
													</c:when>
													<c:when test="${getRest.price==2}">
														10,000원~30,000원
													</c:when>
													<c:when test="${getRest.price==3}">
														30,000원~50,000원
													</c:when>
													<c:otherwise>
														50,000원 이상
													</c:otherwise>
												</c:choose>
						                    </dd>
						                </dl>
						            </div>
						        </li>
							</ul>
						</div>
					</div>
					<div class="restContent-bordered-rail" style="padding-left: 30px;height:100%;">
						<div class="restContent-widget-hours" style="margin-top: -3px; margin-bottom: 24px;">
							<h3>
								영업 시간
							</h3>
							<table class="restContent-table-hours">
								<tbody style="display: table-row-group;">
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											월요일
										</th>
										<td style="border-top: 0; padding-right: 6px;  border: none; vertical-align: baseline; display: table-cell;">
											<span class="mon" style="white-space: nowrap;">${getRest.mon}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											화요일
										</th>
										<td style="border-top: 0; padding-right: 6px; border: none; vertical-align: baseline; display: table-cell;">
											<span class="tue" style="white-space: nowrap;">${getRest.tue}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											수요일
										</th>
										<td style="border-top: 0; padding-right: 6px; border: none; vertical-align: baseline; display: table-cell;">
											<span class="wed" style="white-space: nowrap;">${getRest.wed}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											목요일
										</th>
										<td style="border-top: 0; padding-right: 6px; border: none; vertical-align: baseline; display: table-cell;">
											<span class="thu" style="white-space: nowrap;">${getRest.thu}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											금요일
										</th>
										<td style="border-top: 0; padding-right: 6px; border: none; vertical-align: baseline; display: table-cell;">
											<span class="fri" style="white-space: nowrap;">${getRest.fri}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											토요일
										</th>
										<td style="border-top: 0; padding-right: 6px; border: none; vertical-align: baseline; display: table-cell;">
											<span class="sat" style="white-space: nowrap;">${getRest.sat}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
									<tr style="display: table-row;">
										<th scope="row" style="border-top: 0; min-width: 36px; padding-right: 18px; border: none; vertical-align: baseline; font-weight: bold; text-align: left; display: table-cell;">
											일요일
										</th>
										<td style="border-top: 0; padding-right: 6px;  border: none; vertical-align: baseline; display: table-cell;">
											<span class="sun" style="white-space: nowrap;">${getRest.sun}</span>
										</td>
										<td class="extra" style="border-top: 0; max-width: 70px; padding-right: 6px; font-size: 12px; font-weight: bold; color: #41a700; border: none; vertical-align: baseline; text-align: left; display: table-cell;"></td>
									</tr>
								</tbody>
							</table>
						</div>
<!-- 						<div class="restContent-menu-preview" style="margin-bottom: 24px;height:204px;"> -->
<!-- 							<h3 class="restContent-menu-preview-heading"> -->
<!-- 								<a href="#" style="color: #d32323; cursor: pointer;">메뉴</a> -->
<!-- 							</h3> -->
<!-- 						</div> -->
						<div class="restContent-business-info" style="height:1000px;margin-bottom: 24px;">
							<h3>
								가게 정보
							</h3>
							<ul class="restContent-list" style="display: block; height:1000px;">
								<li style="margin-bottom: 12px; display: list-item;height:auto;">
									<div class="short-def-list" style="height:1000px;">
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">좌석</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.reststyle}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">예약</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.reserv}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">배달</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.delivery}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">포장</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.takeout}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">주차장</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.parking}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">키드존</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.kidszone}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">단체예약</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.groupreserv}
											</dd>
										</dl> 
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">소음</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.noise}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">주류</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.alcohol}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">대기실</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.waiting}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">WIFI</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.wifi}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">화장실</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.toilet}
											</dd>
										</dl>
										
										<dl style="padding-bottom: 6px;display: block;">
											<dt class="restContent-attribute-key">테이블 수</dt>
											<dd style="font-weight: bold;display: inline;">
												${getRest.tablecount} (${getRest.standard}인 기준)
											</dd>
										</dl>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
	
	<div class="flag_content_popup" data-popup="popup-2">
    	<div class="popup-inner" style="width: 465px; z-index: 1; height: auto !important; max-height: none;">
    	    <div id="flag_content_popup_title">
    	    	<div id="flag_content_popup_close" data-popup-close="popup-2">
    				<h4 style="display: table-cell; padding: 0px 7px; font-size: 100%; font: inherit;">×</h4>
    			</div>
    	    	<h2>
    	    		부적절한 댓글 신고
    	    	</h2>
    	    </div>
    	    <div id="reply_flag_content_popup_error_message">
    	    	<span id="popup_error_message">
    	    		<span id="popup_error_message_icon" style="color: #d32323">
    	    			<svg>
    	    				<path d="M9 1a8 8 0 1 0 0 16A8 8 0 0 0 9 1zM8 5a1 1 0 0 1 2 0v4a1 1 0 0 1-2 0V5zm1 9a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"></path>
    	    			</svg>
    	    		</span>
    	    		신고사유를 선택하고 내용을 상세하게 작성해주세요.
    	    	</span>
    	    </div>
    	    
    	    <div id="flag_popup_description" style="padding: 0 12px;">
    	    	<div>
    	    		<p style="margin: 12px 0;">이 댓글을 신고하는 이유를 선택하고 상세하게 설명해주세요.</p>
    	    		<form name="reply_flag_popup_form" id="reply_flag_popup_form" action="message_send?report=reply&rnum=${getRest.rnum}&where=rest" method="post" onsubmit="return reply_report_check()" style="margin-bottoom: 0;">
    	    			<div>
    	    				<label id="reply_flag_popup_form_label" for="reason_field" style="display: inline-block; font-weight: bold; margin: 0 0 6px;">
    	    					이유
    	    				</label>
    	    				<select id="reason_field" name="reason_field">
    	    					<option value="default" selected>신고 사유를 선택하세요.</option>
    	    					<option value="inappropriate_post">부적절한 홍보 게시물</option>
    	    					<option value="Eroticism">음란성, 선정성 또는 부적합한 내용</option>
    	    					<option value="swear_word">특정인 대상의 비방/욕설</option>
    	    					<option value="Privacy_infringement">명예훼손/사생활 침해 및 저작권침해 등</option>
    	    					<option value="personal_information">개인정보 공개</option>
    	    					<option value="plaster">같은 내용의 반복 게시 (도배)</option>
    	    					<option value="other">기타</option>
    	    				</select>
    	    			</div>
    	    			<div id="flag_popup_descripte_container">
    	    				<div id="flag_popup_descripte">
    	    					<label id="reply_flag_popup_descripte_alert">신고내용을 상세하게 작성해주세요.</label>
    	    					<textarea id="reply_flag_popup_descripte_field" name="flag_popup_descripte_field"></textarea>
    	    				</div>
    	    			</div>
    	    		</form>
    	    	</div>
    	    </div>
     	  	<div id="flag_popup_footer">
     	  		<div id="flag_popup_buttons">
     	  			<button id="reply_flag_popup_submit_button" type="submit" value="submit">
     	  				<span>제출하기</span>
     	  			</button>
     	  			<a href="#" data-popup-close="popup-2">
    					Close
    				</a>
     	  		</div>
     	  	</div>
    	</div>
	</div>
	
	<!-- Message sendform -->
<div class="popup" align="left" id="writeMessage" data-popup="writeMessage"  style="z-index: 1;">
	<div class="popup-inner" style="width: 465px; z-index: 1; height: auto !important; max-height: 400px;">
    	<div id="flag_content_popup_title">
    	    <div id="flag_content_popup_close" data-popup-close="writeMessage">
    			<h4 style="display: table-cell; padding: 0px 7px;">×</h4>
    		</div>
    		<h2>
    	    	메세지 보내기
    	    </h2>
    	</div>
    	
    	<div id="flag_popup_description" style="padding: 12px 8px 0;">
    		<div>
    			<form name="sendform"  action = "message_send" method="post">
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
     			<button id="reply_message_popup_submit_button" type="submit" value="submit" data-popup-send="SendMessage" >
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
			
			$('body').css('overflow','hidden');
        	$('#reply_flag_content_popup_error_message').css('display', 'none');
        	$('#reply_flag_popup_descripte_alert').css('color', 'black');
        	$('#reply_flag_popup_form_label').css('color', 'black');
        	$("#reason_field").val("default").prop("selected", true);
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
	 
   
   $(document).on('mouseenter', '.selector', function(e) {
	   var star = $(e.target).val();
       $(this).parent().removeClass('i-selector-stars--extra-large-0');
       $(this).parent().removeClass('i-selector-stars--extra-large-1');
       $(this).parent().removeClass('i-selector-stars--extra-large-2');
       $(this).parent().removeClass('i-selector-stars--extra-large-3');
       $(this).parent().removeClass('i-selector-stars--extra-large-4');
       $(this).parent().removeClass('i-selector-stars--extra-large-5');
       
       if(star == 0){
          $(this).parent().addClass('i-selector-stars--extra-large-0');
          $('#check_li_1').dis
       }else if(star == 1){
          $(this).parent().addClass('i-selector-stars--extra-large-1');
       }else if(star == 2){
          $(this).parent().addClass('i-selector-stars--extra-large-2');
       }else if(star == 3){
          $(this).parent().addClass('i-selector-stars--extra-large-3');
       }else if(star == 4){
          $(this).parent().addClass('i-selector-stars--extra-large-4');
       }else if(star == 5){
          $(this).parent().addClass('i-selector-stars--extra-large-5');
       } 
   });
   
   $(document).on("mouseleave",".selector",function(){
	   $(this).parent().removeClass('i-selector-stars--extra-large-0');
       $(this).parent().removeClass('i-selector-stars--extra-large-1');
       $(this).parent().removeClass('i-selector-stars--extra-large-2');
       $(this).parent().removeClass('i-selector-stars--extra-large-3');
       $(this).parent().removeClass('i-selector-stars--extra-large-4');
       $(this).parent().removeClass('i-selector-stars--extra-large-5');
    });
   
   $(document).on("click",".selector",function(e){
	   var star = $(e.target).val();
       $('#star').val(star);
       $(this).parent().parent().parent().submit();
    });
   
   $(document).on("click", "#reply_flag_popup_submit_button", function(){
	   $("#reply_flag_popup_form").submit();
    });

   
   //리뷰 Sort
   $(document).on("click", ".dropdown_toggle-action", function (e) {
	   if($(this).parent().hasClass('is-active')) {
		   $(this).parent().removeClass(' is-active')
	       $(this).parent().parent().removeClass('is-active')
	   } else {
		   $(this).parent().addClass(' is-active')
	       $(this).parent().parent().addClass('is-active')
	       $('.js-dropdown-menu').addClass('is-visible')   
	       e.stopPropagation();
		   e.preventDefault();
	   }
   });
   
   $(document).on("click", function (e) {
	   if(!$(e.target).hasClass('dropdown') || !$(e.target).hasClass('dropdown_toggle-action')) {
		   $('.dropdown').removeClass('is-active');
		   $('.dropdown_toggle').removeClass('is-active');
		   $('.js-dropdown-menu').removeClass('is-visible')
	   }
   });
   var week = new Array("sun","mon","tue","wed","thu","fri","sat")
   var d = new Date();
   var day = d.getDay();
   
   
   $(".today").text($('.'+week[day]+'').text());
   
   var today=$('.today').text()
   var today_res = today.split("-");
   var hours =  d.getHours(), minutes = d.getMinutes();
   var current_time = (hours > 12) ? ("오후 "+hours-12 + ':' + minutes) : ("오전 "+hours + ':' + minutes);
   var current=current_time.substring(3,current_time.length);
   var current_split=current.split(":");
  
   var start=today_res[0].substring(3,today_res[0].length);//hh:dd 시작
   var start_split=start.split(":");
   
   var end=today_res[1].substring(3,today_res[1].length);//hh:dd 끝
   var end_split=end.split(":");
   
   
//    if(parseInt(current_split[0])>parseInt(start_split[0]) && parseInt(current_split[0])<parseInt(end_split[0])){
// 	   $('.closed').removeClass('closed').addClass('open')
	   $('#24x24_clock').parent().css("fill","#41a700")
// 	   $('.open').text("영업중")
	   
//    }else{
	   
//    }
	   
</script>


<script type="text/javascript">
//**원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
var rnum = '${getRest.rnum}';

var list = new Array();
<c:forEach var="fileDTO" items="${uploadFileList}">
	list.push("${fileDTO.filename}");
</c:forEach>

    var myaddress = '${getRest.roadAddrPart1}';
    naver.maps.Service.geocode({address : myaddress}, function(status, response) {
		var result = response.result;
		var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		map.setCenter(myaddr);
			
		var marker = new naver.maps.Marker({
			position: myaddr,
			map: map
		});
	});
	var map = new naver.maps.Map('map2', {
		zoom: 12, //지도의 초기 줌 레벨
	    minZoom: 10, //지도의 최소 줌 레벨
	    disableKineticPan: true,
	    tileTransition: true,
	    draggable: true,
        pinchZoom: true,
        scrollWheel: true,
        keyboardShortcuts: true,
        disableDoubleTapZoom: false,
        disableDoubleClickZoom: true,
        disableTwoFingerTapZoom: true
	});


for(var i = 0; i < list.length; i++) {
	var img = document.createElement('img');
	img.src = 'https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/' + list[i];
	img.style.cursor = 'pointer';
	img.style.width = '100%';
	img.style.height = '100%';
	img.onclick = function() {location.href="#"};
	document.getElementById('showcase-photo-box').appendChild(img);
}

$('#reply_message_popup_submit_button').click(function(){
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
 
    document.sendform.submit(); 

});

function reply_report_check() {
	var selected = document.getElementById('reason_field');
	if(selected.options[selected.selectedIndex].value == "default") {
		document.getElementById('reply_flag_content_popup_error_message').style.display = 'block';
		document.getElementById('reply_flag_popup_form_label').style.color = '#d32323';
		return false;
	} else if(reply_flag_popup_form.reply_flag_popup_descripte_field.value == "") {
		document.getElementById('reply_flag_content_popup_error_message').style.display = 'block';
		document.getElementById('reply_flag_popup_form_label').style.color = '#d32323';
		return false;
	}
	return true;
}

function list(page){
	var searchKeyword = $('#SearchKeyword').val();
	
	$(document).ajaxStart(function() {
		$('body').css('overflow', 'hidden');
		$('html').scrollTop(0);
		$('.loading_wapper').fadeIn(500);
	})
					
	$(document).ajaxStop(function() {
		$('body').css('overflow', 'auto');
		$('.loading_wapper').fadeOut(500);
	})
	
    $.ajax({
        type : 'post',
        url : 'restaurant_content_ajax?curPage=' + page + '&rnum=' + rnum + '&SearchKeyword=' + searchKeyword,
        dataType : 'json',
        success : function(responseData){
        	if(responseData.error) {
        		alert(responseData.error);
        		return false;
        	}
            $('.restContent-reviews > li:not(:first)').detach();
            $.each(responseData.selectedDataRV,function(i,item){
        	    var userId;
        	    if(item.memberDTO.nickname == null) {
        	 	    userId = item.memberDTO.email;
        	    } else {
        		    userId = item.memberDTO.nickname;
        	    }
        	    var address = item.memberDTO.address;
        	    var addr = [];
        	    if(address != null) {
        		    addr = address.split(' ');
        	    } else {
        		    addr[0] = '';
        		    addr[1] = '';
        	    }
        	   
          	$('.restContent-reviews').append(
   	     			   '<li>' +
   		     			   '<div class="restContent-review-with" style="margin: 0 -15px; display: flex;">' +
   	    		 		   		'<div class="restContent-user">' +
   		     			   			'<div class="restContent-user-content" style="margin-top: -3px;">' +
										'<div class="restContent-meida-block">' +
											'<div class="restContent-media-avatar">' +
												'<div class="restContent-photo-box">' +
													'<a href="member_details?mnum='+ item.memberDTO.mnum +'" style="color: #0073bb;">' +
														'<img class="restContent-photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/' + item.memberDTO.memberPhotoDTO.member_filename + '" width="60">' +
													'</a>' +
												'</div>' +
											'</div>' +
											'<div class="restContent-media-story">' +
												'<ul class="restContent-user-info">' +
													'<li class="restContent-user-name">' +
														'<a href=member_details?mnum="'+ item.memberDTO.mnum +'" class="restContent-user-display-name">' +
															userId +
														'</a>' +
													'</li>' +
													'<li class="restContnet-user-location">' +
														'<b style="font-weight: bold;">' +
															addr[0] + addr[1] +
														'</b>' +
													'</li>' +
												'</ul>' +
												'<ul class="restContent-user-stats">' +
													'<li class="restContent-review-count">'+
														'<span style="fill: #f15c00; width: 18px; height: 18px;" class="icon">'+
														   '<svg class="icon_svg">'+
														        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_review">'+
														        	'<svg id="18x18_review" height="100%" viewBox="0 0 18 18" width="100%">'+
												    		    		'<path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>'+
													        	'</svg>'+
													        '</use>'+
													    '</svg>'+
													'</span>'+
													'<b style="font-weight: bold;"> ' + item.memberDTO.reviewcount + '</b> reviews'+
												'</li>'+
												'<li class="restContent-photo-count">'+
													'<span style="fill: #f15c00; width: 18px; height: 18px;" class="icon">'+
													    '<svg class="icon_svg">'+
													        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_camera">'+
														        '<svg id="18x18_camera" height="100%" viewBox="0 0 18 18" width="100%">'+
													        		'<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>'+
													        	'</svg>'+
													       ' </use>'+
													    '</svg>'+
													'</span>'+
													'<b style="font-weight: bold;"> '+ item.memberDTO.imagecount +'</b> photos'+
												'</li>'+
											'</ul>'+
										'</div>'+
									'</div>'+
									'<ul class="restContent-list-link">'+									
										'<li>'+
											'<a class="restContent-share-review" data-popup-open="writeMessage" href="#" alt="'+ item.memberDTO.email +'">'+
												'<div class="action-link_icon arrange_unit">'+
													'<span style="fill: currentColor; width: 18px; height: 18px;" class="icon">'+
													    '<svg class="icon_svg">'+
													        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_speech">'+
													        	'<svg id="18x18_speech" height="100%" viewBox="0 0 18 18" width="100%">'+
										        					'<path d="M2 4v6a2 2 0 0 0 2 2h1v3l4-3h5a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"></path>'+
													        	'</svg>'+
													        '</use>'+
													   ' </svg>'+
													'</span>'+
												'</div>'+
												'<div class="action-link_label arrange_unit arrange_unit--fill">'+
													'Send message'+
												'</div>'+
											'</a>'+
										'</li>'+
									'</ul>'+
								'</div>'+
							'</div>'+			
							'<div class="restContent-review-wrapper">'+
								'<div class="restContent-review-content">'+
									'<div class="restContent-review-rating">'+
										'<div>'+
											'<div class="restList-star-rating-'+item.gradepoint+'">'+
												'<img class="offscreen" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" width="84" height="303">'+
											'</div>'+
										'</div>'+
										'<span class="restContent-rating-qualifier">'+
											item.reg_date +
										'</span>'+
									'</div>'+
									'<p lang="ko" style="margin-bottom: 12px;display:block;">'+
										item.content +
									'</p>'+
								'</div>'+
							'<div class="review-footer clearfix">'+
								'<div class="review-footer-actions pull-right clearfix" style="margin-top: 23px; float: right;">'+
									'<a class="chiclet-link show-tooltip js-analytics-click chiclet-link--flag" data-popup-open="popup-2">'+
										'<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon">'+
						    				'<svg id="18x18_flag" height="100%" viewBox="0 0 18 18" width="100%">'+
						    					'<path d="M6 10V3c4.976 1.098 4.024-1 8 0v7c-4.024-.976-3.024 1.024-8 0zM4 2h1v14H4V2z"></path>'+
					    					'</svg>'+
										'</span>'+
										'<span class="tooltip-wrapper">'+
				            				'<span class="tooltip">'+
				            					'Report review'+
				            				'</span>'+
				        				'</span>'+
									'</a>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</li>'
           		);
           });
           
           
           $('.event_list_paging_section').empty();
           var pagingHtml = "";
           pagingHtml = '<div class="event_list_pagination_block">' + 
           				'<div class="event_list_pagination_wrap">' + 
           				'<div class="event_list_page_of_pages">';
           if(responseData.YepsPager.blockEnd == 0) {
        	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of 1';
           } else {
        	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of ' + responseData.YepsPager.blockEnd;
           }
           pagingHtml += '</div>';
           if(responseData.YepsPager.blockEnd != 1) {
        	   pagingHtml += '<div class="event_list_page_link_wrapper">';
        	   pagingHtml += '<div class="event_list_page_link_wrap">';
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
           alert("불러오기 실패");
        },
   });
}

function sort_check(){
	$(document).ajaxStart(function() {
		$('body').css('overflow', 'hidden');
		$('html').scrollTop(0);
		$('.loading_wapper').fadeIn(500);
	})
					
	$(document).ajaxStop(function() {
		$('body').css('overflow', 'auto');
		$('.loading_wapper').fadeOut(500);
	})
	
	    $.ajax({
	         type : 'post',
	         url : 'restaurant_content_sort_ajax',
	         data : queryString,
	         dataType : 'json',
         	success : function(responseData){
         	
         	}
         });
}

function check() {	
	var queryString = $("form[name=restContent]").serialize();
	$(document).ajaxStart(function() {
		$('body').css('overflow', 'hidden');
		$('html').scrollTop(0);
		$('.loading_wapper').fadeIn(500);
	})
					
	$(document).ajaxStop(function() {
		$('body').css('overflow', 'auto');
		$('.loading_wapper').fadeOut(500);
	})
	
    $.ajax({
         type : 'post',
         url : 'restaurant_content_ajax',
         data : queryString,
         dataType : 'json',
         success : function(responseData){
            $('#SearchKeyword').val(responseData.SearchKeyword);
            $('.restContent-reviews > li:not(:first)').detach();
            $.each(responseData.selectedDataRV,function(i,item){
         	   var userId;
         	   if(item.memberDTO.nickname == null) {
         		   userId = item.memberDTO.email;
         	   } else {
         		   userId = item.memberDTO.nickname;
         	   }
         	   var address = item.memberDTO.address;
         	   var addr = [];
         	   if(address != null) {
         		   addr = address.split(' ');
         	   } else {
         		   addr[0] = '';
         		   addr[1] = '';
         	   }
         	   
         	  $('.restContent-reviews').append(
  	     			   '<li>' +
  		     			   '<div class="restContent-review-with" style="margin: 0 -15px; display: flex;">' +
  	    		 		   		'<div class="restContent-user">' +
  		     			   			'<div class="restContent-user-content" style="margin-top: -3px;">' +
										'<div class="restContent-meida-block">' +
											'<div class="restContent-media-avatar">' +
												'<div class="restContent-photo-box">' +
													'<a href="member_details?mnum='+ item.memberDTO.mnum +'" style="color: #0073bb;">' +
														'<img class="restContent-photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/' + item.memberDTO.memberPhotoDTO.member_filename + '" width="60">' +
													'</a>' +
												'</div>' +
											'</div>' +
											'<div class="restContent-media-story">' +
												'<ul class="restContent-user-info">' +
													'<li class="restContent-user-name">' +
														'<a href=member_details?mnum="'+ item.memberDTO.mnum +'" class="restContent-user-display-name">' +
															userId +
														'</a>' +
													'</li>' +
													'<li class="restContnet-user-location">' +
														'<b style="font-weight: bold;">' +
															addr[0] + addr[1] +
														'</b>' +
													'</li>' +
												'</ul>' +
												'<ul class="restContent-user-stats">' +
													'<li class="restContent-review-count">'+
														'<span style="fill: #f15c00; width: 18px; height: 18px;" class="icon">'+
														   '<svg class="icon_svg">'+
														        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_review">'+
														        	'<svg id="18x18_review" height="100%" viewBox="0 0 18 18" width="100%">'+
												    		    		'<path d="M13 3H5c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1.505 9.643l-2.526-1.55L6.526 12.7 7 9.934 5 7.977l2.766-.404L8.97 4.7l1.264 2.873L13 7.977l-2 1.957.495 2.71z"></path>'+
													        	'</svg>'+
													        '</use>'+
													    '</svg>'+
													'</span>'+
													'<b style="font-weight: bold;"> ' + item.memberDTO.reviewcount + '</b> reviews'+
												'</li>'+
												'<li class="restContent-photo-count">'+
													'<span style="fill: #f15c00; width: 18px; height: 18px;" class="icon">'+
													    '<svg class="icon_svg">'+
													        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_camera">'+
														        '<svg id="18x18_camera" height="100%" viewBox="0 0 18 18" width="100%">'+
													        		'<path d="M15 15H3a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2h2a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2zM9 5a4 4 0 1 0 0 8 4 4 0 0 0 0-8zm0 6.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"></path>'+
													        	'</svg>'+
													       ' </use>'+
													    '</svg>'+
													'</span>'+
													'<b style="font-weight: bold;"> '+ item.memberDTO.imagecount +'</b> photos'+
												'</li>'+
											'</ul>'+
										'</div>'+
									'</div>'+
									'<ul class="restContent-list-link">'+									
										'<li>'+
											'<a class="restContent-share-review" data-popup-open="writeMessage" href="#" alt="'+item.member.email+'">'+
												'<div class="action-link_icon arrange_unit">'+
													'<span style="fill: currentColor; width: 18px; height: 18px;" class="icon">'+
													    '<svg class="icon_svg">'+
													        '<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#18x18_speech">'+
													        	'<svg id="18x18_speech" height="100%" viewBox="0 0 18 18" width="100%">'+
										        					'<path d="M2 4v6a2 2 0 0 0 2 2h1v3l4-3h5a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"></path>'+
													        	'</svg>'+
													        '</use>'+
													   ' </svg>'+
													'</span>'+
												'</div>'+
												'<div class="action-link_label arrange_unit arrange_unit--fill">'+
													'Send message'+
												'</div>'+
											'</a>'+
										'</li>'+
									'</ul>'+
								'</div>'+
							'</div>'+			
							'<div class="restContent-review-wrapper">'+
								'<div class="restContent-review-content">'+
									'<div class="restContent-review-rating">'+
										'<div>'+
											'<div class="restList-star-rating-'+item.gradepoint+'">'+
												'<img class="offscreen" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/stars.png" width="84" height="303">'+
											'</div>'+
										'</div>'+
										'<span class="restContent-rating-qualifier">'+
											item.reg_date +
										'</span>'+
									'</div>'+
									'<p lang="ko" style="margin-bottom: 12px;display:block;">'+
										item.content +
									'</p>'+
								'</div>'+
							'<div class="review-footer clearfix">'+
								'<div class="review-footer-actions pull-right clearfix" style="margin-top: 23px; float: right;">'+
									'<a class="chiclet-link show-tooltip js-analytics-click chiclet-link--flag" data-popup-open="popup-2">'+
										'<span aria-hidden="true" style="width: 18px; height: 18px;" class="icon">'+
						    				'<svg id="18x18_flag" height="100%" viewBox="0 0 18 18" width="100%">'+
						    					'<path d="M6 10V3c4.976 1.098 4.024-1 8 0v7c-4.024-.976-3.024 1.024-8 0zM4 2h1v14H4V2z"></path>'+
					    					'</svg>'+
										'</span>'+
										'<span class="tooltip-wrapper">'+
				            				'<span class="tooltip">'+
				            					'Report review'+
				            				'</span>'+
				        				'</span>'+
									'</a>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</li>'
          		);
         	   
         	 $('.event_list_paging_section').empty();
             var pagingHtml = "";
             pagingHtml = '<div class="event_list_pagination_block">' + 
             				'<div class="event_list_pagination_wrap">' + 
             				'<div class="event_list_page_of_pages">';
             if(responseData.YepsPager.blockEnd == 0) {
          	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of 1';
             } else {
          	   pagingHtml += 'Page ' + responseData.YepsPager.curPage + ' of ' + responseData.YepsPager.blockEnd;
             }
             pagingHtml += '</div>';
             if(responseData.YepsPager.blockEnd != 1) {
          	   pagingHtml += '<div class="event_list_page_link_wrapper">';
          	   pagingHtml += '<div class="event_list_page_link_wrap">';
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
            });
         	   
         },
         error : function(request, status, error) {
            alert("불러오기 실패");
         },
    });
	return true;
}
</script>

<%@ include file="../bottom.jsp" %>
