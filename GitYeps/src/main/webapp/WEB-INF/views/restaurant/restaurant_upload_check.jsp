<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>${restaurantDTO.rname}</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_update_photo.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restaurant_update_photo.css?ver=1"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
</head>
<%@ include file="../top.jsp"%>
	<div id="insert_photo_super_wrap" style="display: flex;">
		<div id="insert_photo_middle_wrap">
			<div id="insert_photo_main_wrap">
				<div style="margin: 0 -15px;">
					<div id="insert_photo_main">
						<div id="user_photo_intro">
							<h2>
								<a href="restaurant_content?rnum=${restaurantDTO.rnum}">
									${restaurantDTO.rname}:
								</a> 
								Your Photos
							</h2>
							<a href="restaurant_photoList?rnum=${restaurantDTO.rnum}">View all photos</a>
							<br>
							<br>
						</div>
											
						<div id="restaurant_photo_upload_container">
							<div id="finish_upload_header">
 								<div id="upload_title_wrap">
 									<div id="upload_title_success">
 										<span style="width: 18px; height: 18px; fill: #41a700;" class="icon">
 											<svg class="icon_svg" height="100%" viewBox="0 0 18 18" width="100%">
 												<path d="M7.232 14.273L1.93 8.97a1 1 0 1 1 1.413-1.414l3.89 3.89 7.424-7.426a1 1 0 0 1 1.414 1.414l-8.837 8.84z"></path>
 											</svg>
 										</span>
 										<h3 id="upload_title_text">
 											Perfect!
 											<b>Next, check your ${filesize} photos below</b>
 										</h3>
 									</div>
 								</div>
 								
 								<div id="finish_button_wrap">
 									<div id="finish_button_container">
 										<button type="submit" value="submit" id="finish_button">
 											<span>Finish</span>
 										</button>
 									</div>
 								</div>
 							</div>
 							<ul id="photo_box_grid_wide">
 								<c:forEach var="filename" items="${filenames}">
 									<li id="uploaded_photo">
  	 									<div id="photo_box">
  	 										<img id="photo_box_img" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${filename}">
  	 										<div id="photo_box_delete">
  	 											<a id="photo_box_action_link">
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
  	 										</div>
  	 									</div>
  									</li>
 								</c:forEach>
 							</ul>
						</div>
						
						<form id="finishForm" action="restaurant_update_photo" method="post">
							<input type="hidden" name="rnum" value="${restaurantDTO.rnum}">
							<input type="hidden" name="mode" value="update">
							<input type="hidden" name="view" value="all">
							<input type="hidden" name="filecount" value="${filesize}">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	var rnum ='${restaurantDTO.rnum}';
	var rname = '${restaurantDTO.rname}';
	$(document).on('click', '#photo_box_action_link', function() {
		var src = $(this).parent().parent().children('#photo_box_img').attr('src');
		var pathpoint = src.lastIndexOf('/');
		var filename = src.substring(pathpoint+1, src.length);
		$(this).parent().parent().parent().fadeOut(500);

		$.ajax({
			url : 'restaurant_delete_ajax?rnum=' + rnum + '&filename=' + filename,
			dataType : 'json',
			success : function(responseData){
				if(responseData.url) {
					window.location = responseData.url; 
				}
				if(responseData.success) {
		        	
		        }
			}
		});
	});
	
	$(document).on('click', '#finish_button', function() {
		var existFile = $('#photo_box_grid_wide').children();
		if(existFile) {
			$('#finishForm').attr('action', 'restaurant_photoList');
			$('#finishForm').submit();
		} else {
			$('#finishForm').submit();
		}
		
	})
	</script>
	
<%@ include file="../bottom.jsp"%>