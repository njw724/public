<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
   <title>Add a Member Photo - Yeps</title>
   <link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member_update_photo.css?ver=1"/>"/>
   <script src="//code.jquery.com/jquery.min.js"></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
</head>
<body ondragstart="return false">
   <%@ include file="../top.jsp"%>
   <div id="insert_photo_super_wrap">
      <div id="insert_photo_middle_wrap">
         <div id="insert_photo_main_wrap">
            <div id="main_header">
               <div id="main_section_header">
               	<div id="main_section_arrange">
               		<div id="main_section_arrange_unit">
               			<ul id="breadcrumbs">
               				<li>
               					<a href="member_details">
               						<c:set value="${sessionScope.memberinfo.name}" var="memberName"/>
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
               			<h1 class="main_section_header_title h2">Add photos</h1>
               		</div>
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
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <div class="loading_wapper">
		<div class="loading_img" style="margin: -20px -55px;">
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
				$('.loading_wapper').fadeIn(500);
			})
			
			$(document).ajaxStop(function() {
				$('.loading_wapper').fadeOut(500);
			})
   
          var url = "member_fileUpLoad";
          $.ajax({
             url: url,
             method: 'post',
             data: data,
             dataType: 'json',
             processData: false,
             contentType: false,
             success: function(responseData) {
            	 	if(responseData.success){
            	 		location.href="member_photolist?mnum=" + responseData.mnum ;
             		}else if(responseData.failed) {
                       alert("업로드할 수 없는 파일이 존재합니다.");
                       return false;
                    }else if (responseData.created_fail) {
                       alert(responseData.created_fail);
                       return false;
                    }else if (responseData.upload_failed) {
                       alert(responseData.upload_failed)
                       return false;
                    }
             },
             error: function() {
                alert("아작스 에러");
                return false;
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
   				$('.loading_wapper').fadeIn(500);
   			}) 
   			
   			$(document).ajaxStop(function() {
   				$('.loading_wapper').fadeOut(500);
   			})
               
               var url = "member_fileUpLoad";
               $.ajax({
                  url: url,
                  method: 'post',
                  data: data,
                  dataType: 'json',
                  processData: false,
                  contentType: false,
                  success: function(responseData) {
                	  if(responseData.success){
                		  location.href="member_photolist?mnum=" + responseData.mnum ;
               		  }else if(responseData.failed) {
                           alert("업로드할 수 없는 파일이 존재합니다.");
                           return false;
                      } else if (responseData.created_fail) {
                           alert(responseData.created_fail);
                           return false;
                      } else if (responseData.upload_failed) {
                           alert(responseData.upload_failed)
                           return false;
                      }
                  },
                  error: function() {
                     alert("아작스 에러");
                     return false;
                  }
               });
            });
            F_FileMultiUpload(files, objDragAndDrop);
         });
      });
      
      $(document).ready(function() {
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
   </script>
<%@ include file="../bottom.jsp"%>