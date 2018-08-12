<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Add a Event Photo - Yeps</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_update_photo.css?ver=1"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
</head>
<%@ include file="../top.jsp"%>
	<div id="insert_photo_super_wrap">
		<div id="insert_photo_middle_wrap">
			<div id="result_photo_status_text">
				<p>사진을 성공적으로 삭제했습니다.</p>
			</div>
			<div id="insert_photo_main_wrap">
				<div id="main_header">
					<div id="main_header_baseline">
						<div id="main_header_baseline_text">
							<h2>Add A Photo To <a href="event_content?evnum=${eventDTO.evnum}">${eventDTO.eventname}</a></h2>
						</div>
						<div id="main_header_baseline_back">
							<a href="event_content?evnum=${eventDTO.evnum}">Back</a>
						</div>
					</div>
				</div>
				<div id="photo_drop_super_container">
					<div id="photo_drop_container">
						<div id="file_uploader_container" data-component-bound="true">
							<div id="file_uploader" data-component-bound="true" style="opacity: 1;">
								<div id="file_drop_area">
									<div id="file_drop_area_inner">
										<h1>업로드할 파일을 올려주세요.</h1>
										<fieldset id="or_line">
											<legend>OR</legend>
										</fieldset>
										<div id="file_browser" style="pointer-events: auto;">
											<input type="file" id="file_browser_input" onchange="javascript:fileCheck(this)" multiple accept="image/gif, image/jpeg, image/png">
											<button type="submit" id="file_browser_button">
												<span>Browse Files</span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<c:if test="${!empty uploadFileList}">
							<div id="sucess_file_upload_header">
								<h2>Photos</h2>
							</div>
							<div id="user_photo_edit_container">
							<c:forEach var="fileDTO" items="${uploadFileList}" varStatus="status">
								<div id="user_photo_edit">
									<div id="user_photo_edit_top">
										<div id="user_photo_area">
											<div id="user_photo_box" style="position: relative;">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${fileDTO.filename}" alt="event_photo" id="photo_box_img" width="168px" height="168px">
												<c:if test="${fileDTO.ismainphoto == 'y'}">
												<div class="photo-box-overlay">
													<div class="photo-box-overlay_caption">메인사진</div>
												</div>
												</c:if>
											</div>
										</div>
										<div id="user_photo_write_info">
											<p>
												From 
												<a href="member_details" style="font-weight: bold;">
												<!-- 이름 출력 다시 생각해봐 -->
													
													<c:choose>
														<c:when test="${sessionScope.memberinfo.ismanager eq 'y' ||  sessionScope.memberinfo.ismaster eq 'y' || eventDTO.mnum == memberinfo.mnum}">
															<c:if test="${empty registMemberList.get(status.index).nickname}">
																${registMemberList.get(status.index).email}
															</c:if>
															<c:if test="${!empty registMemberList.get(status.index).nickname}">
																${registMemberList.get(status.index).nickname}
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${memberinfo.mnum == fileDTO.mnum && empty memberinfo.nickname}">
																${memberinfo.email}
															</c:if>
															<c:if test="${memberinfo.mnum == fileDTO.mnum && !empty memberinfo.nickname}">
																${memberinfo.nickname}
															</c:if>
														</c:otherwise>
													</c:choose>	
												</a>
											</p> 
											
											<c:if test="${memberinfo.ismaster eq 'y' || memberinfo.ismanager eq 'y' || eventDTO.mnum == memberinfo.mnum || fileDTO.mnum == memberinfo.mnum}">
											<form name="event_photo_delete_form" id="info_photo" action="event_delete_photo" method="post">
												<input type="hidden" name="filename" value="${fileDTO.filename}">
												<input type="hidden" name="evnum" value="${eventDTO.evnum}">
												<input type="hidden" name="ismainphoto" value="${fileDTO.ismainphoto}">
												<button id="delete_button">삭제</button> 
											</form>
											</c:if>
											<c:if test="${(memberinfo.ismaster eq 'y' || memberinfo.ismanager eq 'y' || eventDTO.mnum == memberinfo.mnum) && fileDTO.ismainphoto eq 'n'}">
											<form name="event_mainphoto_form" id="info_photo" action="event_main_photo" method="post" style="margin-top: 10px;">
												<input type="hidden" name="filenum" value="${fileDTO.filenum}">
												<input type="hidden" name="evnum" value="${eventDTO.evnum}">
												<input type="hidden" name="mnum" value="${eventDTO.mnum}">
												<button id="mainphoto_button">대표사진 변경</button> 
											</form>
											</c:if>
										</div>
									</div>
								</div>
							</c:forEach>	
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="loading_wapper">
		<div class="loading_img" style="top: 40%; left: 45%;">
		</div>
	</div>
	
	<script type="text/javascript">
 		function fileCheck() {
 			var fileObject = document.getElementById('file_browser_input');
 			var files = fileObject.files;
 			
			var data = new FormData();
 			for(var i = 0; i < files.length; i++) {
 				var pathpoint = files[i].name.lastIndexOf('.');
				var filepoint = files[i].name.substring(pathpoint+1, files[i].length);
				var filetype = filepoint.toLowerCase();

				if(filetype == 'jpg' || filetype == 'gif' || filetype == 'png' || filetype == 'jpeg') {
					if(files[i].size > 10485760) {
						alert("이미지의 크기가 10MB를 초과할 수 없습니다.");
						return false;
					} else {
						data.append('file'+i, files[i]);
					}
				} else if(filetype == 'bmp') {
 					alert('.bmp형식의 이미지는 적절한 형식이 아닙니다. 다른 형식의 이미지 파일을 선택해주세요.');
 					return false;
 				} else {
					alert('이미지 파일만 선택할 수 있습니다.');
					return false;
				}
 			}
 			
 			$(document).ajaxStart(function() {
 				$('body').css('overflow', 'hidden');
				$('.loading_wapper').fadeIn(500);
			})
			
			$(document).ajaxStop(function() {
				$('body').css('overflow', 'auto');
				$('.loading_wapper').fadeOut(500);
			})
	
 			var url = "event_fileUpLoad?evnum=${eventDTO.evnum}";
 			$.ajax({
 				url: url,
 				method: 'post',
 				data: data,
 				dataType: 'json',
 				processData: false,
 				contentType: false,
 				success: function(responseData) {
 					if(responseData.failed) {
 						alert("업로드할 수 없는 파일이 존재합니다.");
 						return false;
 					} else if (responseData.created_fail) {
 						alert(responseData.created_fail);
 						return false;
 					} else if (responseData.upload_failed) {
 						alert(responseData.upload_failed)
 						return false;
 					} else if(responseData.url) {
						window.location.href = responseData.url; 
					} else if (responseData.update) {
 						alert(responseData.update);
 						$('#result_photo_status_text').text('사진을 등록했습니다.');
						$('#result_photo_status_text').show();
 					}
 	 				$('#sucess_file_upload_header').show();
 	 				$('#user_photo_edit_container').show();
 					var uploadFiles = responseData.fileList;
 					location.reload();
 				}
 			});		
 		}
	</script>
	
	
	<script>
		$(function() {
			var objDragAndDrop = $('#file_uploader_container');
			objDragAndDrop.on('dragenter', function (e) {
				e.stopPropagation();
				e.preventDefault();
				$(this).css('opacity', '0.33');
			});	

			objDragAndDrop.on('dragleave', function (e) {
				e.stopPropagation();
				e.preventDefault();
				$(this).css('opacity', '1');
			});
	
			objDragAndDrop.on('dragover', function (e) {
				e.stopPropagation();
				e.preventDefault();
				$(this).css('opacity', '0.33');
			});
	
			objDragAndDrop.on('drop', function (e) {
				e.preventDefault();
				$(this).css('opacity', '1');
	
				var files = e.originalEvent.dataTransfer.files;
				if(files.length < 1) {
					return;
				}
				
				for(var i = 0; i < files.length; i++) {
					var pathpoint = files[i].name.lastIndexOf('.');
					var filepoint = files[i].name.substring(pathpoint+1, files[i].name.length);
					var filetype = filepoint.toLowerCase();
					
					if(filetype != 'jpg' && filetype != 'gif' && filetype != 'png' && filetype != 'jpeg') {
						alert('이미지 파일만 선택할 수 있습니다.');
						return;
					}
					if(filetype == 'bmp') {
						alert('.bmp형식의 이미지는 적절한 형식이 아닙니다. 다른 형식의 이미지 파일을 선택해주세요.');
						return;	
					}
					if(files[0].size > 10485760) {
						alert("이미지의 크기가 10MB를 초과할 수 없습니다.");
						return;
					}
				}
	
				(F_FileMultiUpload = function(files, objDragAndDrop) {
					var data = new FormData();
					for(var i = 0; i < files.length; i++) {
						data.append('files'+i, files[i]);
					}
					
					$(document).ajaxStart(function() {
						$('body').css('overflow', 'hidden');
						$('.loading_wapper').fadeIn(500);
					})
					
					$(document).ajaxStop(function() {
						$('body').css('overflow', 'auto');
						$('.loading_wapper').fadeOut(500);
					})
					
					var url = "event_fileUpLoad?evnum=${eventDTO.evnum}";
					$.ajax({
						url: url,
						method: 'post',
						data: data,
						dataType: 'json',
						processData: false,
						contentType: false,
						success: function(responseData) {
							if(responseData.failed) {
								alert("업로드할 수 없는 파일이 존재합니다.");
								return false;
							} else if (responseData.created_fail) {
								alert(responseData.created_fail);
							return false;
							} else if (responseData.upload_failed) {
								alert(responseData.upload_failed)
								return false;
							} else if(responseData.url) {
								window.location.href = responseData.url; 
							} else if (responseData.update) {
		 						alert(responseData.update);
		 						$('#result_photo_status_text').text('사진을 등록했습니다.');
								$('#result_photo_status_text').show();
		 					}
							$('#sucess_file_upload_header').show();
		 	 				$('#user_photo_edit_container').show();
		 					var uploadFiles = responseData.fileList;
		 					location.reload();
						}
					});
				});
				F_FileMultiUpload(files, objDragAndDrop);
			});
		});
		
		$(document).ready(function() {
			var mode = '${mode}';
			if(mode == 'delete') {
				$('#result_photo_status_text').show();
			} else if(mode == 'update'){
				$('#result_photo_status_text').text('메인 사진을 성공적으로 변경했습니다.');
				$('#result_photo_status_text').show();
			} else {
				$('#result_photo_status_text').hide();
			}
			$('#file_browser_button').hover(function() {
				$(this).css('background-color', 'red');
			})
			$('#file_browser_button').mouseleave(function() {
				$(this).css('background-color', '#d90007');
			})
			$('#file_browser_button').click(function() {
				$('#file_browser_input').click();				
			})
		});
		
// 		$(document).on('click', '#Save_button', function(e) {
// 			$('#photo_description').attr('action', 'event_updatePro_photo');
// 		});
	</script>
<%@ include file="../bottom.jsp"%>
