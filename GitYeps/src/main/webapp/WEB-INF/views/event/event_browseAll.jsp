<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<title>${eventDTO.eventname}</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_browseAll.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css?ver=2"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css?ver=2"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
	<script src="http://malsup.github.com/jquery.cycle2.js"></script>
</head>

<%@ include file="../top.jsp" %>
	<div class="main_content_wrap">
		<div class="event_browseAll_super_container">
			<div class="event_browseAll_container">
				<div class="event_browseAll_wrap">
					<div class="event_browseAll_landing_header">
						<div class="event_browseAll_section_header">
							<div class="event_browseAll_header_wrap">
								<div class="event_browseAll_header_unit" style="width: 100%;">
									<ul class="event_browseAll_header_sector">
										<li>
											<a href="event_content?evnum=${eventDTO.evnum}">
												${eventDTO.eventname}
											</a>
										</li>
										
										<li>
											<span style="width: 24px; height: 24px; margin-right: 3px !important; fill: #999;" class="icon">
												<svg class="icon_svg" height="100%" viewBox="0 0 24 24" width="100%">
													<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
												</svg>
											</span>
											Photos
										</li>
									</ul>
									
									<h1>
										${fileCount} photos for ${eventDTO.eventname}
									</h1>
								</div>
								
								<div class="event_browseAll_header_unit">
									<a class="add_photos_button" href="event_update_photo?evnum=${eventDTO.evnum}">
										<span style="width: 24px; height: 24px; margin: -12px 0; margin-right: 6px !important; fill: currentColor;" class="icon">
											<svg class="icon_svg" height="100%" viewBox="0 0 24 24" width="100%">
												<path d="M19 20H5a3 3 0 0 1-3-3V9a3 3 0 0 1 3-3h2.184A2.99 2.99 0 0 1 10 4h4a2.99 2.99 0 0 1 2.816 2H19a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3zM12.005 8.5a4.5 4.5 0 1 0 0 9 4.5 4.5 0 0 0 0-9zM13 14v1a1 1 0 0 1-2 0v-1h-1a1 1 0 0 1 0-2h1v-1a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2h-1z"></path>
											</svg>
										</span>
										<c:if test="${find == true}">
											Manage Photos
										</c:if>
										<c:if test="${find == false}">
											Add Photos
										</c:if>
									</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="event_browseAll_landing_content">
						<div class="event_browseAll_gallery_photos">
							<ul class="event_browseAll_photo_box_grid">
								<!-- 여기 반복문!! -->
								<c:forEach var="fileDTO" items="${fileList}">
								<li>
									<div class="photo_box" data-popup-open="photo_popup">
										<img class="photo_box_img" height="226" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${fileDTO.filename}" width="226">
										<a class="photo_box_img_action" href="#"></a>
									</div>
								</li>
								</c:forEach>
							</ul>
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
   		//----- OPEN   		
    	$('[data-popup-open]').on('click', function(e)  {
        	var targeted_popup_class = jQuery(this).attr('data-popup-open');
        	$('#popup_slideshow_img').empty();
        	$('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
        	var src = jQuery(this).children().first().attr('src');
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

<%@ include file="../bottom.jsp" %>