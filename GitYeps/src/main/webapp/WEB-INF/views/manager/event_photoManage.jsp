<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Add a Event Photo - Yeps</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css?ver=7"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/qna.css?ver=1"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_update_photo.css?ver=1"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
</head>
<%@ include file="../top.jsp"%>
	    <div class="main-content-wrap--full">
    	<div class="top-shelf top-shelf-grey sat-top-shelf">
			<div class="content-container">
				<div class="container">
					<div class="clearfix layout-block layout-n column--responsive">
						<div class="column column-alpha column--responsive">
							<img alt="Yelp Support Center" class="sc-top-shelf-illustration responsive-visible-large-block" src="https://s3-media3.fl.yelpcdn.com/assets/2/www/img/3d4cc7502e4d/support/support-darwin.png">
						</div>
						<div class="column column-beta column--responsive">
							<div class="sc-top-shelf-search-block">
								<div class="sc-search-form-container">
									<form name="member_manger_f" action="member_manager" class="member_manager_form arrange arrange--6 arrange--stack-small sc-search-form" method="post">
										<div class="arrange_unit arrange_unit--fill sc-search-field">
											<select name="search" class="search" style="width:80px; align:center;" >
												<option value="email">이메일</option>
												<option value="name">이름</option>
												<option value="eventname">이벤트</option>
											</select>
											<input name="searchString" class="searchString" placeholder="What can we help you with?" type="text" value="" autocomplete=off style="width: 60%;">
											<button class="member_managerbtn member_managerbtn-primary" type="submit" value="submit">
												<span>
													<span class="i-wrap ig-wrap-common_sprite i-search-common_sprite-wrap">
														<i class="i ig-common_sprite search-common_sprite"></i> Search
													</span>
												</span>
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
   </div>
   
   <div id="event_manager_list_header" style="margin:0 100px;">
	<h2 style="height: 40px; margin-top: 20px;">Event List</h2>
	    <table style="width:100%;">
			<tr>
				<th align="center" width="15%">번호</th>
				<th align="center" style=" width: 50%;">이벤트 이름</th>
				<th align="center" width="21%">작성일자</th>
				<th align="center" width="7%">삭제</th>
				<th align="center" width="7%">수정</th>
			</tr>
		<c:if test="${empty eventList}">
			<tr>
				<td colspan="6" align="center">등록된 이벤트가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="dto" items="${eventList}">
			<tr>
				<td id="event" align="center">${dto.evnum}</td>
				<td id="event" align="center"><a id="event_photo_manage" href="event_update_photo?evnum=${dto.evnum}&mode=manager" style="color: navy;">${dto.eventname}</a> </td>
				<td id="event" align="center">${dto.event_register_date}</td>
				<td id="event" align="center"><a style="color: red; " href="event_delete?evnum=${dto.evnum}">삭제</a></td>
				<td id="event" align="center"><a style="color: red; " href="event_edit?evnum=${dto.evnum}">수정</a></td>
				<input type="hidden" id="evnum_manager" name="evnum_manager" value="${dto.evnum}">
			</tr>
		</c:forEach>
	</table>
	
		<div class="event_list_paging_section" style="font-size: 14px; padding-top: 15px;">
			<div class="event_list_pagination_block" style="width: 1060px;">
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
   
		<%-- 	<div id="photo_drop_super_container" style="margin: 0 15px;">
				<div id="photo_drop_container">
					<div id="sucess_file_upload_header">
								<h2>Photos</h2>
							</div>
						<c:if test="${!empty uploadFileList}">
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

															<c:forEach var="memberDTO" items="${registMemberList}">
																<c:if test="${memberDTO.mnum == fileDTO.mnum && empty memberDTO.nickname}">
																	${memberDTO.email}
																</c:if>
																<c:if test="${memberDTO.mnum == fileDTO.mnum && !empty memberDTO.nickname}">
																	${memberDTO.nickname}
																</c:if>
															</c:forEach>
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
									
<!-- 									<form id="photo_description" method="post" style="margin-bottom: 18px; display: block;" enctype="multipart/form-data"> -->
										<input type="hidden" name="evnum" id="evnum" value="${eventDTO.evnum}">
										<input type="hidden" name="mnum" id="mnum" value="${sessionScope.mnum}">
										<input type="hidden" name="filenum" id="filenum" value="${fileDTO.filenum}">
<!-- 										<label>Description</label> -->
<!-- 										<div id="description_container"> -->
											<textarea rows="4" name="file_content">${fileDTO.file_content}</textarea>
<!-- 										</div> -->
<!-- 										<button type="submit" id="Save_button"> -->
<!-- 											<span>Save</span> -->
<!-- 										</button> -->
<!-- 									</form> -->
								</div>
							</c:forEach>	
							</div>
						</c:if>
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
	</div> --%>
	
	
	<div class="loading_wapper">
		<div class="loading_img" style="top: 40%; left: 45%;">
		</div>
	</div>
	
	<script type="text/javascript">
	
	 function list(page){
	        location.href="event_photo_manage?curPage=" + page;
	    }
 	
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
