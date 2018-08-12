<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<title>Photos for ${getRest.rname}</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restaurant_update_photo.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css"/>"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<%@include file="../top.jsp" %>
<div class="main-content-wrap main-content-wrap--full" style="background: white;">
	<div class="restPhotoList-super-container" style="width: 960px; margin: 0 auto;padding: 15px 15px 36px 15px;">
		<div class="restPhotoList-container">
			<div class="js-media-landing_container">
				<div class="js-media-landing_header media-landing_header" style="margin-top: 18px;">
					<h1 class="js-media-landing_header_title" style="word-wrap: break-word !important; word-break: break-word !important; overflow-wrap: break-word !important; font-weight: bold; margin-bottom: 6px; font-size: 30px; line-height: 1.2em; color: #333; padding-top: 6px; margin: 0 0 6px; display: block;">
						Photos for ${getRest.rname}
					</h1>
					<div class="section-header media-header--tabbed" style="margin-bottom: 11px;border-bottom: 1px solid #e6e6e6;">
						<div class="arrange arrange--12 arrange--bottom" style="margin-left: -12px;margin-right: -12px;border-collapse: separate;border-spacing: 12px 0;    display: table;min-width: 100%;table-layout: auto;">
							<div class="arrange_unit arrange_unit--fill media-header_biz-listing" style=" margin-left: 6px;margin-right: 6px;border-collapse: collapse;border-spacing: 0 0;    vertical-align: bottom;    width: 100%;    box-sizing: border-box;display: table-cell;">
								<div class="media-block media-block biz-passport--slim" style="    position: relative;    display: flex;">
									<div class="media-avatar">
										<div class="photo-box pb-30s">
											<a href="restaurant_content?rnum=${getRest.rnum}" class="js-analytics-click" style="color: #0073bb;text-decoration: none;cursor: pointer;">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${getRest.fileDTO.filename}" class="photo-box-img" width="30" height="30" style="outline: none;margin-top: 3px;border-radius: 4px;vertical-align: middle;">
											</a>
										</div>
									</div>
									<div class="media-story" style="-webkit-box-flex: 1;flex: 1;min-width: 0;min-height: 0;">
										<div class="media-title clearfix">
											<a href="restaurant_content?rnum=${getRest.rnum}" class="biz-name js-analytics-click" style="font-weight: bold; color: #0073bb; cursor: pointer;">
												<span>${getRest.rname}</span>
											</a>
										</div>
										<div class="biz-passport_rating" style="margin-top: -3px; display:flex;">
											<div class="biz-rating biz-rating-medium clearfix" style="margin-bottom: 0;margin: 3px 0;">
												<div class="restPhoto-star-rating-${starAvg}">
													<img class="offscreen" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png" width="84" height="303"style="clip: rect(0, 0, 0, 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px; vertical-align: middle;">
												</div>
												<span class="review-count rating-qualifier" style="font-size: 12px;line-height: 1.5em;    display: block;float: left;color: #666;font-weight: normal;">
													<span itemprop="reviewCount">${reviewCount}</span> reviews
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="arrange_unit nowrap media-header_actions" style="margin-left: 6px; margin-right: 6px; border-collapse: collapse; border-spacing: 0 0; vertical-align: bottom; box-sizing: border-box; display: table-cell; white-space: nowrap; ">
								<a class="ybtn ybtn--primary u-space-r1 restaurant_add_photo" href="restaurant_update_photo?rnum=${getRest.rnum}">
									<span aria-hidden="true" style="fill: currentColor; width: 24px; height: 24px;" class="icon">
									    <svg id="24x24_add_photo" height="100%" viewBox="0 0 24 24" width="100%">
									    	<path d="M19 20H5a3 3 0 0 1-3-3V9a3 3 0 0 1 3-3h2.184A2.99 2.99 0 0 1 10 4h4a2.99 2.99 0 0 1 2.816 2H19a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3zM12.005 8.5a4.5 4.5 0 1 0 0 9 4.5 4.5 0 0 0 0-9zM13 14v1a1 1 0 0 1-2 0v-1h-1a1 1 0 0 1 0-2h1v-1a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2h-1z"></path>
									    </svg>
									</span>
									Add Photos
								</a>
							</div>
						</div>
						<div class="section-header_tabs section-header_tabs-search" style="display: flex;flex-direction: row;align-items: flex-end;border-top: none;    margin-top: 18px;">
							<div class="tab-navbars js-tab-navbars" style="display: inline-block; width: 75%;">
								<div class="media-header_root-navbar media-header_root-navbar--paged">
									<div class="tab-nav-container">
										<ul class="js-tab-nav--paged" style="display: inline; margin: 0 0 -1px; padding: 0; white-space: nowrap;">
											<div class="paged-scroll-container js-paged-scroll-container inactive-left-arrow inactive-right-arrow has-single-page" style="    overflow: hidden;margin: 0 -15px;    user-select: none;position: relative;    display: flex;-webkit-box-direction: normal; -webkit-box-orient: horizontal; flex-direction: row;padding: 0px 18px; z-index: 2;">
												<div class="paged-scroll-container_container" style="-webkit-box-flex: 1;flex-grow: 1;align-self: center;overflow: hidden;position: relative;white-space: nowrap;">
													<div class="js-scroll-container scroll-container" style="transform: translateX(0px);    display: flex;-webkit-box-direction: normal;-webkit-box-orient: horizontal;    flex-direction: row;    transition: transform 400ms;width: 100%;">
														<li class="tab-nav_item" style="display: table-cell; vertical-align: middle;">
															<a href="restaurant_photoList?rnum=${getRest.rnum}&view=all" class="tab-link">
																<span style="font-weight: bold; vertical-align: middle; line-height: 30px; display: inline-block;">
																	All Photos
																</span>
																<span style="font-weight: bold; vertical-align: middle; line-height: 30px; display: inline-block;">
																	(${allPhotoCount})
																</span>
															</a>
														</li>
														<c:if test="${!empty memberinfo}">
														<li class="tab-nav_item" style="display: table-cell; vertical-align: middle;">
															<a href="restaurant_photoList?rnum=${getRest.rnum}&view=mylist" class="tab-link">
																<span style="font-weight: bold; vertical-align: middle; line-height: 30px; display: inline-block;">
																	<c:if test="${empty memberinfo.nickname}">
																		<c:set var="email" value="${fn:split(memberinfo.email, '@')}" />
																		${email[0]}'s Photos
																	</c:if>
																	<c:if test="${!empty memberinfo.nickname}">
																		${memberinfo.nickname}'s Photos
																	</c:if>
																</span>
																<span style="font-weight: bold; vertical-align: middle; line-height: 30px; display: inline-block;">
																	(${myPhotoCount})
																</span>
															</a>
														</li>
														</c:if>
													</div>
												</div>
											</div>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="media-landing js-media-landing" style="position: relative;">
					<div class="media-landing_gallery photos" style="height:auto;overflow:hidden;">
						<ul class="photo-box-grid photo-box-grid--highlight photo-box-grid--small clearfix lightbox-media-parent" style="margin-right: -12px; margin-top: 18px; transform-style: preserve-3d;">
							<c:forEach var="upload" items="${uploadFileList}">
							<li style="transition: opacity 0.1s ease-out; width: 150px; float: left; margin: 0 12px 12px 0; display: list-item;">
								<div class="photo-box photo-box--interactive" data-popup-open="photo_popup" style="height: 150px; position: relative;">
									<c:if test="${upload.ismainphoto == 'y'}">
										<div class="photo-box-overlay">
											<div class="photo-box-overlay_caption">메인사진</div>
										</div>
									</c:if>									
									<img class="photo-box-img" height="226" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${upload.filename}"  width="226" style="max-width: 100%; max-height: 100%; border-radius: 4px; vertical-align: middle;">
									
									<c:if test="${(getRest.mnum eq memberinfo.mnum || memberinfo.ismaster eq 'y' || memberinfo.ismanager eq 'y') && upload.ismainphoto == 'n'}">							
									<div id="photo_box_delete" style="top: unset; bottom: 6px; left: 6px;">
										<form name="photoupdate" class="photo_update" action="restaurant_photo_update" method="POST">
											<input type="hidden" name="filenum" value="${upload.filenum}">
											<input type="hidden" name="mnum" value="${getRest.mnum}">
											<input type="hidden" name="rnum" value="${getRest.rnum}">
											<input type="hidden" name="view" value="${view}">
  	 										<a id="photo_box_action_link" style="background: rgba(0,0,0,0.8);">
  	 											<span style="width: 24px; height: 24px; fill: #fff;" class="icon">
  	 												<svg class="icon_svg" height="100%" viewBox="0 0 18 18" width="100%"> 
  	 													<path d="M13 6c0-.55-.45-1-1-1s-1 .45-1 1 .45 1 1 1 1-.45 1-1zm-4.71 6.93L6.5 10.79 4 14h10l-3.21-4.29-2.5 3.22zM3 3h5V1H3c-1.1 0-2 .9-2 2v5h2V3zm12 12h-5v2h5c1.1 0 2-.9 2-2v-5h-2v5zM3 10H1v5c0 1.1.9 2 2 2h5v-2H3v-5zm12-9h-5v2h5v5h2V3c0-1.1-.9-2-2-2z"/>
  	 												</svg>
  	 											</span>
 	 											
  	 											<span id="tooltip_wrapper">
  													<span id="tooltip">
  														MainPhoto
  													</span>
  	 											</span>
  	 										</a>
  	 									</form>
  	 								</div>
									</c:if>
									<c:if test="${view == 'mylist' || getRest.mnum eq memberinfo.mnum || memberinfo.ismaster eq 'y' || memberinfo.ismanager eq 'y'}">
									<div id="photo_box_delete" style="top: unset; bottom: 6px;">
										<form name="photoupdate" class="photo_update" action="restaurant_photo_delete" method="POST">
											<input type="hidden" name="filenum" value="${upload.filenum}">
											<input type="hidden" name="rnum" value="${getRest.rnum}">
											<input type="hidden" name="filename" value="${upload.filename}">
											<input type="hidden" name="ismainphoto" value="${upload.ismainphoto}">
											<input type="hidden" name="view" value="${view}">
  	 										<a id="photo_box_action_link" style="background: rgba(0,0,0,0.8);">
  	 											<span style="width: 24px; height: 24px; fill: #fff;" class="icon">
  	 												<svg class="icon_svg" height="100%" viewBox="0 0 24 24" width="100%"> 
  	 													<path d="M5 7V5a1 1 0 0 1 1-1h4V3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v1h4a1 1 0 0 1 1 1v2H5zm13 12a3 3 0 0 1-3 3H9a3 3 0 0 1-3-3V8h12v11zm-8-8H9v8h1v-8zm5 0h-1v8h1v-8z"></path>
  	 												</svg>
  	 											</span>
 	 										
  	 											<span id="tooltip_wrapper">
  													<span id="tooltip">
  														Delete
  													</span>
  	 											</span>
  	 										</a>
  	 									</form>
  	 								</div>
  	 								</c:if>
									<a class="biz-shim js-lightbox-media-link js-analytics-click" id="dd" data-analytics-label="biz-photo" href="#" style="display: block; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: white; opacity: 0; color: #0073bb; text-decoration: none; cursor: pointer;"></a>
								</div>
							</li>
							</c:forEach>
						</ul><!-- 이미지 30장  -->
					</div>
					
					
					<div class="event_list_paging_section" style="font-size: 14px;">
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
											<a class="event_list_next_block_action" href="javascript:list('1', '${view}')">
												<span>Start</span>
											</a>
										</div>
									</c:if>

									<c:if test="${yepsPager.curBlock > 1}">
										<div class="event_list_next_block">
											<a class="event_list_next_block_action" href="javascript:list('${yepsPager.prevPage}', '${view}')">
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
												<a href="javascript:list('${num}', '${view}')" class="event_list_page_option_link_action">
												${num}
												</a>
											</c:otherwise>
										</c:choose>
										</div>
									</c:forEach>
						
									<c:if test="${yepsPager.curBlock <= yepsPager.totBlock}">
										<div class="event_list_next_block">
											<a class="event_list_next_block_action" href="javascript:list('${yepsPager.nextPage}', '${view}')">
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
											<a class="event_list_next_block_action" href="javascript:list('${yepsPager.totPage}', '${view}')">
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

</div>


	<div class="photo_content_popup" data-popup="photo_popup">
    	<div class="photo_popup-inner" style="z-index: 1;">
    	    <div id="photo_content_popup_close" data-popup-close="photo_popup">
    	    	Close
    	    	<span class="icon popup_close_icon" style="width: 24px; height: 24px; margin-left: 3px !important; fill: currentColor;">
    	    		<svg class="icon_svg" height="100%" viewBox="0 0 24 24" width="100%">
    	    			<path d="M17.657 19.07L12 13.415 6.343 19.07 4.93 17.658 10.585 12 4.93 6.343 6.342 4.93 12 10.585l5.657-5.657L19.07 6.34 13.416 12l5.657 5.657-1.413 1.414z"></path>
    	    		</svg>
    	    	</span>
    	    </div>
			<div class="photo_content_popup_wrapper">
				<div class="photo_content_popup_container">
					<div class="photo_content_popup_container">
						<div class="photo_popup_container">
							<div class="photo_popup_grid">
								<div class="photo_popup_grid_main">
									<div id="popup_slideshow_img">
									</div>
									
									<div class="photo_popup_grid_main_photo_area_footer">
										<ul class="photo_popup_footer_inner">
											<li>
												<a href="#" data-popup-close="photo_popup">
													<span class="icon" style="opacity: 0.7; filter: drop-shadow(0 0 4px rgba(0,0,0,0.3)); margin-right: 3px !important; fill: currentColor; width: 18px; height: 18px;">
														<svg class="icon_svg" height="100%" width="100%" viewBox="0 0 18 18">
															<path d="M10 15v-5h5v5h-5zm0-12h5v5h-5V3zm-7 7h5v5H3v-5zm0-7h5v5H3V3z"></path>
														</svg>
													</span>
													Browse all
												</a>
											</li>
											
											
											<li>
												<span class="photo_popup_footer_page_count">
													<span class="photo_popup_footer_current">
														1
													</span>
													of
													<span class="photo_popup_footer_total">
														1
													</span>
												</span>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
    	</div>
	</div>

<script>
	var view = '${view}';
	if(view == 'all') {
		$('.js-tab-nav--paged li').first().children('.tab-link').addClass('selected');
	} else if(view == 'mylist') {
		$('.js-tab-nav--paged li:not(:first) > a').addClass('selected');
	}
	
	$(document).on('mouseenter', '.tab-link', function() {
		if(!$(this).hasClass('selected')) {
			$(this).addClass('hovered');
			$('.tab-link').not(this).addClass('clear_bottom');
		}
	})
	$(document).on('click', '.tab-link', function() {
		not($(this)).removeClass('hovered');
		not($(this)).removeClass('selected');
		$(this).addClass('selected');
	})
	$(document).on('mouseleave', '.tab-link', function() {
		$('.tab-link').removeClass('clear_bottom');	
		$(this).removeClass('hovered');
	})
	
	
    // **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
    function list(page){
        location.href="restaurant_photoList?curPage="+page+"&rnum=${getRest.rnum}&view=${view}";
    }
    
  //----- OPEN   		
	$('[data-popup-open]').on('click', function(e)  {
		if($(e.target).prop('className') == 'icon') {
			$(e.target).parent().parent().submit();
			e.stopPropagation();
	    	e.preventDefault();
			return;
		}
		
    	var targeted_popup_class = jQuery(this).attr('data-popup-open');
    	$('#popup_slideshow_img').empty();
    	$('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
    	var src = jQuery(this).children('img').attr('src');
    	var img = $("<img>").attr("src", src).css('position', 'static').css('vertical-align', 'middle');
		$('#popup_slideshow_img').append(img);
  
    	$('body').css('overflow','hidden');
		e.stopPropagation();
    	e.preventDefault();
	});

	//----- CLOSE
	$('[data-popup-close]').on('click', function(e)  {
    	var targeted_popup_class = jQuery(this).attr('data-popup-close');
    	$('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);
    	$('body').css('overflow','auto');
    	
    	if(targeted_popup_class == 'photo_popup') {
    		$('#slideimg').removeClass('cycle-slideshow');
    	}
    	e.stopPropagation();
    	e.preventDefault();
	});
	
</script>
<%@include file="../bottom.jsp" %>