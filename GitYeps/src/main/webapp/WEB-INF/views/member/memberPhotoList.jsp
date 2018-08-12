<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html>
<head>
   <title>Member Photo List - Yeps</title>
   <link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css"/>"/>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member_update_photo.css?ver=1"/>"/>
   <script src="//code.jquery.com/jquery.min.js"></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
   <script src="http://malsup.github.com/jquery.cycle2.js"></script>
</head>
<body ondragstart="return false">
<%@ include file="../top.jsp"%>
<div id="insert_photo_super_wrap">
	<div id="insert_photo_middle_wrap">
		<div id="photo-alert-container">
			<span class="photo-offscreen">Success message:</span>
			<div class="photo-alert photo-alert-update-success">
				<p class="photo-alert-message">
					메인 사진을 성공적으로 변경했습니다.
				</p>
			</div>
			<div class="photo-alert photo-alert-update-failed">
				<p class="photo-alert-message">
					메인 사진 변경에 실패하였습니다.
				</p>
			</div>
			<div class="photo-alert photo-alert-delete-success">
				<p class="photo-alert-message">
					사진을 성공적으로 삭제했습니다.
				</p>
			</div>
			<div class="photo-alert photo-alert-delete-failed">
				<p class="photo-alert-message">
					사진 삭제에 실패하였습니다.
				</p>
			</div>
	    </div>
		<div id="insert_photo_main_wrap">
			<div id="main_header">
				<div id="main_section_list_header">
					<div id="main_section_arrange">
						<div id="main_section_arrange_unit">
	               			<ul id="breadcrumbs">
	               				<li>
	               					<a href="member_details?mnum=${memberDTO.mnum}">
										<c:set value="${memberDTO.name}" var="memberName"/>
		                   				<c:choose>
		                   					<c:when test="${fn:length(memberName) > 7}">
		                   						<c:out value="${fn:substring(memberName,0,6)}"/>..
		                   					</c:when>
		                   					<c:otherwise>
		                   						<c:out value="${memberName}"/>
		                   					</c:otherwise> 
		                   				</c:choose>
	               					</a>
	               				</li>
	               				<li>
	               					<span aria-hidden="true" style="width: 24px; height: 24px;" class="icon icon--neutral-gray u-space-r-half">
	               						<svg class="icon_svg">
	               							<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
	               						</svg>
	               					</span>Profile photos
	               				</li>
	               			</ul>
	               			<c:if test="${memberDTO.mnum == sessionScope.memberinfo.mnum}">
	               				<h1 class="main_section_header_title h2">Add photos</h1>
	               			</c:if>
	               			<c:if test="${memberDTO.mnum != sessionScope.memberinfo.mnum}">
	               				<h1 class="main_section_header_title h2">${fn:length(memberPhotoList)} photos of ${memberDTO.name}</h1>
	               			</c:if>
               			</div>
               			<c:if test="${memberDTO.mnum == sessionScope.memberinfo.mnum}">
	               			<div id="main_section_arrange_unit_btn" class="nowrap">
		               			<a class="ybtn ybtn-primary" href="member_photos">
		               				<span aria-hidden="true" style="width: 24px; height: 24px;" class="member_icon icon--currentColor">
		               					<svg class="icon_svg">
		               						<path d="M19 20H5a3 3 0 0 1-3-3V9a3 3 0 0 1 3-3h2.184A2.99 2.99 0 0 1 10 4h4a2.99 2.99 0 0 1 2.816 2H19a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3zM12.005 8.5a4.5 4.5 0 1 0 0 9 4.5 4.5 0 0 0 0-9zM13 14v1a1 1 0 0 1-2 0v-1h-1a1 1 0 0 1 0-2h1v-1a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2h-1z"></path>
		               					</svg>
		               				</span>Add photos
		               			</a>
		               		</div>
		               	</c:if>
               		</div>
               </div>
            </div>
			<div class="media-landing">
				<div class="media-landing_gallery_photos">
					<ul class="photo-box-grid photo-box-grid--small">
						<c:forEach var="memberPhotoDTO" items="${memberPhotoList}">
							<li>
								<div class="photo-box" data-popup-open="photo_popup">
									<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${memberPhotoDTO.member_filename}" alt="member_photo" id="photo_box_img" width="150px" height="150px">
									<c:if test="${memberPhotoDTO.ismainphoto =='y'}">
										<div class="photo-box-overlay">
											<div class="photo-box-overlay_caption">메인사진</div>
										</div>
									</c:if>
									<a class="biz-shim js-lightbox-media-link js-analytics-click" href="#"></a>
								</div>
								<c:if test="${memberDTO.mnum == sessionScope.memberinfo.mnum || sessionScope.memberinfo.ismanager=='y'}">
									<ul class="photo-action-link-list">
										<c:if test="${memberPhotoDTO.ismainphoto =='n'}">
											<li>
												<form name="photoupdate" class="photo_update" action="member_photo_update" method="POST">
													<input type="hidden" name="filenum" value="${memberPhotoDTO.filenum}">
													<input type="hidden" name="mnum" value="${memberPhotoDTO.mnum}">
													<a class="photo-arrange_main">
														<div class="photo-action-link_icon">
															<span aria-hidden="true" style="width: 18px; height: 18px;" class="photo_icon member_icon--currentColor">
																<svg class="icon_svg">
																	<path d="M2.002 16h13.996a9.87 9.87 0 0 0-5.66-2.786V12.08c.898-.655 1.733-1.75 1.79-2.46 1.016-.495 1.228-1.723.506-1.994l-.017.024c.326-.458.527-1.04.527-1.706 0-.863-.156-1.66-.79-2.182C11.914 2.72 10.998 2 9.934 2c-.625 0-1.198.25-1.656.664a.955.955 0 0 0-.612-.23c-.4 0-.747.268-.934.662-1.005.37-1.738 1.505-1.738 2.848 0 .615.154 1.186.417 1.66-.78.307-.52 1.477.463 2.015.057.71.89 1.804 1.79 2.46v1.133A9.87 9.87 0 0 0 2.003 16z"></path>
																</svg>
															</span>
														</div>
														<div class="photo-action-link_label">
															메인 사진으로 지정
														</div>
													</a>
												</form>
											</li>
										</c:if>
										<li>
											<form name="photoupdate" class="photo_delete" action="member_photo_delete" method="POST">
												<input type="hidden" name="filenum" value="${memberPhotoDTO.filenum}">
												<input type="hidden" name="mnum" value="${memberPhotoDTO.mnum}">
												<input type="hidden" name="filename" value="${memberPhotoDTO.member_filename}">
												<input type="hidden" name="ismainphoto" value="${memberPhotoDTO.ismainphoto}">
												<a class="photo-arrange_delete">
													<div class="photo-action-link_icon">
														<span aria-hidden="true" style="width: 18px; height: 18px;" class="photo_icon member_icon--currentColor">
															<svg class="icon_svg">
																<path d="M3 5V3h4V2h4v1h4v2H3zm11 9c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6h10v8zM8 8.5a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5zm3 0a.5.5 0 0 0-.5-.5.5.5 0 0 0-.5.5v5a.5.5 0 0 0 .5.5.5.5 0 0 0 .5-.5v-5z"></path>
															</svg>
														</span>
													</div>
													<div class="photo-action-link_label">
														사진 삭제
													</div>
												</a>
											</form>
										</li>
									</ul>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="photo-media-landing_footer">
					<div class="photo-media-pager" data-component-bound="true">    
						<div class="photo-pagination-block">
							<div class="photo-arrange photo-arrange--stack photo-arrange--baseline photo-arrange--6">
								<div class="photo-page-of-pages photo-arrange_unit photo-arrange_unit--fill">
								Page 1 of 1
								</div>
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

<script type="text/javascript">
	var list = new Array();
	<c:forEach var="memberPhotoDTO" items="${memberPhotoList}">
		list.push("${memberPhotoDTO.member_filename}");
	</c:forEach>
	for(var i = 0; i < list.length; i++) {
		var img = $("<img>").attr("src", "https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/" + list[i]).css('vertical-align', 'middle').css('display', 'inline-block').css('max-width', '100%').css('max-height', '100%');
		$('#popup_slideshow_img').append(img);
	}
	
	$(document).ready(function() {
		var mode = '${mode}';
		if(mode == 'successUpdate'){
			$('.photo-alert-update-success').show();
			$('.photo-alert-update-failed').hide();
			$('.photo-alert-delete-success').hide();
			$('.photo-alert-delete-failed').hide();
		}else if(mode == 'failedUpdate'){
			$('.photo-alert-update-failed').show();
			$('.photo-alert-update-success').hide();
			$('.photo-alert-delete-success').hide();
			$('.photo-alert-delete-failed').hide();
		}else if(mode == 'successDelete'){
			$('.photo-alert-delete-success').show();
			$('.photo-alert-delete-failed').hide();
			$('.photo-alert-update-failed').hide();
			$('.photo-alert-update-success').hide();
		}else if(mode == 'failedDelete'){
			$('.photo-alert-delete-success').hide();
			$('.photo-alert-delete-failed').show();
			$('.photo-alert-update-failed').hide();
			$('.photo-alert-update-success').hide();
		}
		
		
		$(document).on("click",".photo-arrange_main",function(){
			$(this).parents().submit();
		});
		
		$(document).on("click",".photo-arrange_delete",function(){
			$(this).parents().submit();
		});
		
		$('[data-popup-open]').on('click', function(e)  {
        	var targeted_popup_class = jQuery(this).attr('data-popup-open');
        	$('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
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

        	e.stopPropagation();
        	e.preventDefault();
    	});
	});
</script>

<%@include file="../bottom.jsp"%>
