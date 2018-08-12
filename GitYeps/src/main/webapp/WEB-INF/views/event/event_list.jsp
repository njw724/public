<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<title>Yeps 이벤트 리스트</title>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css"/>"/>
</head>
<%@ include file="../top.jsp"%>
<div class="event_list_main_content_wrap event_list_main_content_wrap_full">
	<div class="event_list_main_super_container">
		<div class="event_list_main_section_header">
			<div class="event_list_main_section_location_bar">
				<div class="event_list_section_header_location_bar_inner">
					<div class="event_list_section_header_location_left">
						<c:if test="${empty sessionScope.memberinfo || empty sessionScope.memberinfo.address}">
							<h1>${search}</h1>
						</c:if>
						<c:if test="${!empty sessionScope.memberinfo}">
							<h1>
								<c:forTokens items="${sessionScope.memberinfo.address}" delims=" " begin="1" end="1" var="addr">
									${addr}
								</c:forTokens>
                            </h1>
						</c:if>
					</div>
					<!-- 반복문 돌면서 최대 5개 까지 출력 -->
					<div class="event_list_section_header_location_nowrap">
<!-- 						<a href="#">인근 추천 지역</a> -->
					</div>
					<div class="event_list_section_header_location_nowrap">
						<a href="javascript:;" class="location_city_list_toggle">
							<span class="icon icon_14x14_triangle_right" style="width: 14px; height: 14px; fill: currentColor;">
								<svg class="icon_svg" id="14x14_triangle_right" weight="100%" height="100%" viewbox="0 0 14 14">
									<path d="M9 7l-4 3.5v-7L9 7z"></path>
								</svg>
							</span>
							<span class="icon icon_14x14_triangle_down" style="display: none; width: 14px; height: 14px; fill: currentColor;">
								<svg class="icon_svg" id="14x14_triangle_down" weight="100%" height="100%" viewbox="0 0 14 14">
									<path d="M7 9L3.5 5h7L7 9z"></path>
								</svg>
							</span>
							More Cities
						</a>
					</div>
				</div>
				
				<div class="location_more_cities_island" style="display: none;">
					<div class="more_cities_island_wrap">
					<c:if test="${!empty sessionScope.memberinfo}">
						<div class="more_cities_island_section">
							<h4>저장된 위치</h4>
							<ul>
								<li style="margin-bottom: 6px !important;">
									<a href="#">
										<strong style="font-weight: bold;">Home</strong>
									</a>
									<br>
									<!-- 이 지역으로 검색되어야 함 -->
									<a href="#">${memberinfo.address}</a>
								</li>
							</ul>
							<a href="member_profile">저장된 집 주소 바꾸기 »</a>
						</div>
						
						<div class="more_cities_island_section">
							<h4>최근 검색한 위치</h4>
							<ul>
								<!-- 반복문으로 최대 10개까지 -->
								<c:choose>
									<c:when test="${empty locationList}">
										<li style="margin-bottom: 12px;">
											<a href="#">최근 검색한 기록이 없습니다.</a>
										</li>
									</c:when>
									<c:otherwise>
										<c:forEach var="recentLocation" items="${locationList}">
											<li style="margin-bottom: 12px;">
												<a href="event_list?mode=${mode}&search=${recentLocation}">${recentLocation}</a>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</ul>
							<a href="#" class="clear-location-toggle">최근 검색위치 초기화 »</a>
						</div>
						</c:if>
						<div class="more_cities_island_section">
							<h4>인기 지역</h4>
							<div class="popular_cities">
								<div class="popular_cities_left" style="vertical-align: top;">
									<a href="event_list?mode=${mode}&search=종로" style="margin-bottom: 10px !important; display: block !important;">종로</a>
									<a href="event_list?mode=${mode}&search=양화로" style="margin-bottom: 10px !important; display: block !important;">홍대</a>
									<a href="event_list?mode=${mode}&search=서초" style="margin-bottom: 10px !important; display: block !important;">강남</a>
									<a href="event_list?mode=${mode}&search=이태원" style="margin-bottom: 10px !important; display: block !important;">이태원</a>
									<a href="event_list?mode=${mode}&search=충무로" style="margin-bottom: 10px !important; display: block !important;">명동</a>
									<a href="event_list?mode=${mode}&search=신촌" style="margin-bottom: 10px !important; display: block !important;">신촌</a>
									<a href="event_list?mode=${mode}&search=혜화" style="margin-bottom: 10px !important; display: block !important;">혜화</a>
									<a href="event_list?mode=${mode}&search=압구정" style="margin-bottom: 10px !important; display: block !important;">압구정</a>
									<a href="event_list?mode=${mode}&search=광진구" style="margin-bottom: 10px !important; display: block !important;">건대</a>
								</div>								
								<div class="popular_cities_right" style="vertical-align: top;">
									<a href="event_list?mode=${mode}&search=부산" style="margin-bottom: 10px !important; display: block !important;">부산시</a>
									<a href="event_list?mode=${mode}&search=대구" style="margin-bottom: 10px !important; display: block !important;">대구시</a>
									<a href="event_list?mode=${mode}&search=울산" style="margin-bottom: 10px !important; display: block !important;">울산시</a>
									<a href="event_list?mode=${mode}&search=포항" style="margin-bottom: 10px !important; display: block !important;">포항시</a>
									<a href="event_list?mode=${mode}&search=대전" style="margin-bottom: 10px !important; display: block !important;">대전시</a>
									<a href="event_list?mode=${mode}&search=광주" style="margin-bottom: 10px !important; display: block !important;">광주시</a>
									<a href="event_list?mode=${mode}&search=전주" style="margin-bottom: 10px !important; display: block !important;">전주시</a>
									<a href="event_list?mode=${mode}&search=강릉" style="margin-bottom: 10px !important; display: block !important;">강릉시</a>
									<a href="event_list?mode=${mode}&search=천안" style="margin-bottom: 10px !important; display: block !important;">천안시</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="more_cities_island_bottom">
						<div class="more_cities_island_bottom_left">
							<p style="margin-bottom: 6px !important; margin-top: 0;">
								원하는 지역을 검색하세요: 
							</p>
							
							<div class="search_different_city">
								<form name="search_different_city" action="#" method="post" id="search_different_location" style="margin-bottom: 18px;">
									<div class="search_different_city_input_wrap" style="width: 100%;">
										<input type="text" placeholder name="search" value="${search}">
										<input type="hidden" placeholder name="mode" value="${mode}">
									</div>
									
									<div class="search_different_city_input_wrap">
										<button type="submit" value="submit" class="search_different_city_button" >
											<span>
												<span class="icon" style="width: 18px; height: 18px; margin: -9px 0; fill: #fff;">
													<svg class="icon_svg" viewBox="0 0 18 18" height="100%" width="100%">
														<path d="M15.913 14.224a1.324 1.324 0 0 0-.3-.466h.01l-3.378-3.376a5.49 5.49 0 0 0 .802-2.857 5.523 5.523 0 1 0-5.522 5.52 5.49 5.49 0 0 0 2.856-.8l3.37 3.368.006.003a1.364 1.364 0 0 0 .93.384C15.41 16 16 15.41 16 14.684c0-.163-.032-.317-.086-.46zM7.525 10.94a3.422 3.422 0 0 1-3.418-3.416 3.422 3.422 0 0 1 3.418-3.417 3.422 3.422 0 0 1 3.416 3.417 3.42 3.42 0 0 1-3.413 3.416z"></path>
													</svg>
												</span>
											</span>
										</button> 
									</div>
								</form>
							</div>
						</div>
						
						<div class="more_cities_island_bottom_right">
							<a id="hide_location_box" href="#" style="text-align: right !important; display: block !important;">
								Hide
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="event_list_browse_events_title">
			<div class="event_list_browse_title_button">
				<div class="event_list_browse_event_title">
					<h2 style="margin: 0 !important;">Browse Events</h2>
				</div>
								
				<div class="event_list_create_event_button">
					<a href="event_write" class="create_event_button">Create an Event</a>
				</div>
			</div>
			
			<div class="event_browse_filter">
				<div class="event_browse_filter_tap_wrapper">
					<ul class="event_browse_filter_tap"> 
						<li class="event_browse_filter_tap_items">
							<div class="event_browse_filter_tap_items_dropdown">
								<div class="event_browse_filter_itmes_dropdown_toggle">
									<a class="dropdown_toggle_action" href="#" role="button" data-dropdown-prefix="Sort by:">
										<span class="data-dropdown-prefix" style="font-size: 14px;">Sort by: </span>
										<span class="dropdow_toggle_text">
											<c:choose>
												<c:when test="${empty mode}">
													전체 목록
												</c:when>
												<c:when test="${mode == 'music_concert'}">
													음악 & 콘서트
												</c:when>
												<c:when test="${mode == 'visualart'}">
													전시회
												</c:when>
												<c:when test="${mode == 'film'}">
													영화 & 시사회
												</c:when>
												<c:when test="${mode == 'book'}">
													도서 & 출판
												</c:when>
												<c:when test="${mode == 'fashion'}">
													패션
												</c:when>
												<c:when test="${mode == 'food'}">
													음식
												</c:when>
												<c:when test="${mode == 'festival'}">
													축제 & 행사
												</c:when>
												<c:when test="${mode == 'sports_activity'}">
													스포츠 & 야외활동
												</c:when>
												<c:when test="${mode == 'nightlife'}">
													야간 문화활동
												</c:when>
												<c:when test="${mode == 'family_kids'}">
													가족 & 어린이
												</c:when>
												<c:when test="${mode == 'other'}">
													기타
												</c:when>
												
												<c:when test="${mode == 'free'}">
													무료 이벤트
												</c:when>
												
											</c:choose>
										</span>
										<span class="icon" style="left: -3px; width: 14px; height: 14px; fill: currentColor;">
											<svg class="icon_svg" id="14x14_triangle_down" weight="100%" height="100%" viewbox="0 0 14 14">
												<path d="M7 9L3.5 5h7L7 9z"></path>
											</svg>
										</span>
									</a>
								</div>
								
								<div class="event_browse_filter_itmes_dropdown_menu_container">
									<div class="event_browse_filter_itmes_dropdown_menu">
										<div class="event_browse_dropdown_menu_inner">
											<ul class="event_browse_dropdown_menu_group">
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															전체 목록
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=music_concert&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															음악 & 콘서트
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=visualart&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															전시회
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=film&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															영화 & 시사회
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=book&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															도서 & 출판
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=fashion&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															패션
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=food&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															음식
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=festival&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															축제 & 행사
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=sports_activity&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															스포츠 & 야외활동
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=nightlife&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															야간 문화활동
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=family_kids&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															가족 & 어린이
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=other&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															기타
														</span>
													</a>
												</li>
												<li class="event_browse_dropdown_menu_item">
													<a href="event_list?mode=free&search=${search}" class="dropdown_menu_item_link">
														<span style="display: inline-block;">
															무료 이벤트
														</span>
													</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		<c:if test="${empty eventList}">
			<div class="event_list_not_found" style="margin-bottom: 30px !important;">
				<h2>
					<b style="font-weight: normal; color: #333; font-size: 18px; font-weight: bold;">
						해당하는 이벤트를 발견하지 못했습니다.
					</b>
				</h2>
				<p style="margin-bottom: 12px; margin-top: 0; font-size: 13px;">
					찾으시는 이벤트가 없습니까?
					<a href="event_write">
						새로운 이벤트를 등록하세요!
					</a>
				</p>
			</div>
		</c:if>
		
		
		<div class="event_list_lines_wrapper">
			<c:forEach var="eventDTO" items="${eventList}" varStatus="status">
				<c:if test="${status.index % 3 == 0}">
					<div class="event_list_line">
				</c:if>
						
				<c:if test="${status.count % 3 < 3}">
					<div class="event_list_line_unit_wrapper">
						<div class="event_list_card_photo">
							<c:forEach var="fileDTO" items="${fileList}">
								<c:if test="${eventDTO.evnum == fileDTO.evnum}">
									<c:if test="${fileDTO.filename == 'nothing'}">
										<div class="event_list_photo_box" style="background-color: #f5f5f5; background-size: contain; background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png);">
											<a href="event_content?evnum=${eventDTO.evnum}">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png" height="300" width="300" class="event_list_photo_box_img">
											</a>									
										</div>
									</c:if>
									<c:if test="${fileDTO.filename != 'nothing' && fileDTO.ismainphoto == 'y'}">
										<div class="event_list_photo_box" style="background-image: url(https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${fileDTO.filename});">
											<a href="event_content?evnum=${eventDTO.evnum}">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${fileDTO.filename}" height="300" width="300" class="event_list_photo_box_img">
											</a>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					
						<div class="event_list_card_body">
							<div class="event_list_card_content">
								<h3 class="event_list_card_content_title">
									<a href="event_content?evnum=${eventDTO.evnum}">
										<span>
											${eventDTO.eventname}
										</span>
									</a>
								</h3>
								
								<div class="event_list_card_content_periode">
									<span style="width: 24px; height: 24px;" class="icon">
									<svg class="icon_svg" height="100%" width="100%" viewBox="0 0 24 24">
											<path d="M18 21H6a3 3 0 0 1-3-3V6a3 3 0 0 1 3-3 1 1 0 0 1 2 0h8a1 1 0 0 1 2 0 3 3 0 0 1 3 3v12a3 3 0 0 1-3 3zm1-13H5v10c0 .55.45 1 1 1h12c.55 0 1-.45 1-1V8zm-6 5h4v4h-4v-4z"></path>
										</svg>
									</span>
									<c:if test="${empty eventDTO.end_date}">
										${eventDTO.start_date}, ${eventDTO.start_time}
									</c:if>
									<c:if test="${!empty eventDTO.end_date}">
										${eventDTO.start_date}, ${eventDTO.start_time} – ${eventDTO.end_date}, ${eventDTO.end_time}
									</c:if>
								</div>
							
								<div class="event_list_card_content_location">
									<span style="width: 24px; height: 24px;" class="icon">
										<svg class="icon_svg" height="100%" width="100%" viewBox="0 0 24 24">
											<path d="M12 2C8.13 2 5 5.13 5 9c0 2.61 1.43 4.88 3.54 6.08L12 22l3.46-6.92A6.987 6.987 0 0 0 19 9c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 0 1 0-5 2.5 2.5 0 0 1 0 5z"></path>
										</svg>
									</span>
									${eventDTO.roadAddrPart1} — ${eventDTO.roadAddrPart2}
								</div>
								
								<p class="event_list_card_content_text">
									${fn:replace(eventDTO.event_content,crcn,br)}
								</p>
							</div>
							
							<div class="event_list_card_footer">
								<a href="event_list?mode=${eventDTO.event_category}">
									<c:choose>
										<c:when test="${eventDTO.event_category eq 'music_concert'}">
											음악 & 콘서트
										</c:when>
										<c:when test="${eventDTO.event_category eq 'visualart'}">
											전시회
										</c:when>
										<c:when test="${eventDTO.event_category eq 'film'}">
											영화 & 시사회	
										</c:when>
										<c:when test="${eventDTO.event_category eq 'book'}">
											도서 & 출판
										</c:when>
										<c:when test="${eventDTO.event_category eq 'fashion'}">
											패션
										</c:when>
										<c:when test="${eventDTO.event_category eq 'food'}">
											음식
										</c:when>
										<c:when test="${eventDTO.event_category eq 'festival'}">
											축제 & 행사
										</c:when>
										<c:when test="${eventDTO.event_category eq 'sports_activity'}">
											스포츠 & 야외활동
										</c:when>
										<c:when test="${eventDTO.event_category eq 'nightlife'}">
											야간 문화활동
										</c:when>
										<c:when test="${eventDTO.event_category eq 'family_kids'}">
											가족 & 어린이
										</c:when>
										<c:when test="${eventDTO.event_category eq 'other'}">
											기타
										</c:when>
									</c:choose>
								</a>
								
								<c:if test="${sessionScope.memberinfo.ismaster eq 'y' || sessionScope.memberinfo.ismanager eq 'y' || eventDTO.mnum == sessionScope.memberinfo.mnum}">
									<span id="event_del_edit" style="float: right !important; color: #999; font-weight: normal;">
										<a id="event_delete" href="javascript:deleteEvent('${eventDTO.evnum}')">
											삭제
										</a>
										/
										<a href="event_edit?evnum=${eventDTO.evnum}">
											수정
										</a>
									</span>
								</c:if>
							</div>
						</div>
					</div>
				</c:if>
				
				<c:set var="eventList_size" value="${fn:length(eventList)}"/>
				<c:choose>
					<c:when test="${status.count % 3 == 0}">
						</div>
					</c:when>
					<c:when test="${eventList_size == status.count}">
						<c:if test="${3 - (status.count % 3) != 0}">
							<c:forEach var="i" begin="1" end="${3 - (status.count % 3)}">
								<div class="event_list_line_unit_empty_wrap"></div>
							</c:forEach>	
						</c:if>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
				
				
				
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
		
		
		<div class="event_list_footer_section">
			<div class="event_list_footer_section_unit">
				<div class="event_list_footer_section_other_events">
					<h3>이번주 다른 이벤트</h3>
					
					
					<ul class="footer_section_other_events_list">
						<c:if test="${empty thisWeek_random_eventList}">
							<li>
								진행중인 이벤트가 없습니다.
							</li>
						</c:if>
						<c:if test="${!empty thisWeek_random_eventList}">
						<c:forEach var="thisWeek_random_eventDTO" items="${thisWeek_random_eventList}">
						<li>
							<div class="footer_section_other_events_list_item">
								<div class="list_item_photo_box_wrapper">
									<div class="list_item_photo_box">
										<a href="event_content?evnum=${thisWeek_random_eventDTO.evnum}">
											<c:if test="${thisWeek_random_eventDTO.fileDTO.filename == 'nothing'}">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/event_square.png" width="60px" height="60px">
											</c:if>
											<c:if test="${thisWeek_random_eventDTO.fileDTO.filename != 'nothing'}">
												<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${thisWeek_random_eventDTO.fileDTO.filename}" width="60px" height="60px">
											</c:if>
										</a>
									</div>
								</div>
								
								<div class="list_item_info_wrap">
									<strong style="font-weight: bold;">
										<a href="event_content?evnum=${thisWeek_random_eventDTO.evnum}">
											${thisWeek_random_eventDTO.eventname}
										</a>
									</strong>
									
									<small style="font-size: 12px; line-height: 1.5em">
										<c:if test="${empty thisWeek_random_eventDTO.end_date}">
											${thisWeek_random_eventDTO.start_date}, ${thisWeek_random_eventDTO.start_time}
										</c:if>
										<c:if test="${!empty thisWeek_random_eventDTO.end_date}">
											${thisWeek_random_eventDTO.start_date}, ${thisWeek_random_eventDTO.start_time} – ${thisWeek_random_eventDTO.end_date}, ${thisWeek_random_eventDTO.end_time}
										</c:if>
									</small>
								</div>
							</div>
						</li>
					</c:forEach>
					</c:if>
					</ul>
									
					<a class="link_more" href="event_list">
						더 보기
					</a>
				</div>
			</div>
		
			<div class="event_list_footer_browse_small" style="margin-left: 150px;">
				<h3>Browse Events</h3>
				
				<a href="event_list?mode=festival" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M15.14 14.96L17 18h-2v5h-1v-5h-2l1.86-3.04C10.85 14.586 8.5 11.616 8.5 8c0-3.87 2.69-7 6-7s6 3.13 6 7c0 3.617-2.35 6.587-5.36 6.96zM12.39 3.55c-.54-.14-1.14.39-1.36 1.19-.21.8.05 1.57.58 1.71.54.14 1.14-.39 1.36-1.19.21-.8-.05-1.57-.58-1.71zm-.45 11.89a4.737 4.737 0 0 1-2.82 1.49L10.5 19H9v4H8v-4H6.5l1.367-2.05c-2.53-.365-4.487-2.88-4.487-5.93 0-3.1 2.02-5.66 4.61-5.95-.32.91-.49 1.9-.49 2.93 0 3.38 1.84 6.27 4.44 7.44z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						축제 & 행사
					</div>
				</a>
				
				<a href="event_list?mode=food" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M17.22 22a1.78 1.78 0 0 1-1.74-2.167l1.298-4.98L14 13l1.756-9.657A1.635 1.635 0 0 1 19 3.635V20.22A1.78 1.78 0 0 1 17.22 22zm-7.138-9.156l.697 7.168a1.79 1.79 0 1 1-3.56 0l.7-7.178A3.985 3.985 0 0 1 5 9V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.5c0 .28.22.5.5.5s.5-.22.5-.5V3a1 1 0 0 1 2 0v5.83c0 1.85-1.2 3.518-2.918 4.014z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						음식
					</div>
				</a>
				
				<a href="event_list?mode=nightlife" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M19.215 3H4.785C3.095 3 2.29 5.08 3.54 6.22L11 13v6H8a1 1 0 0 0 0 2h8a1 1 0 0 0 0-2h-3v-6l7.46-6.78C21.71 5.08 20.905 3 19.214 3zM15 4.5a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						야간 문화활동
					</div>
				</a>
				
				<a href="event_list?mode=music_concert" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M8 6v11.01a4.68 4.68 0 0 0-1.707.235c-1.61.53-2.598 1.744-2.208 2.713.39.97 2.013 1.326 3.622.797 1.38-.453 2.3-1.408 2.293-2.282V11.5l8-2v5.51a4.68 4.68 0 0 0-1.707.235c-1.61.53-2.598 1.744-2.208 2.713.39.97 2.013 1.326 3.622.797 1.346-.442 2.258-1.363 2.293-2.22V3L8 6z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						음악 & 콘서트
					</div>
				</a>
				
				<a href="event_list?mode=visualart" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M11.85 3c-4.73.08-8.7 3.99-8.85 8.72-.02.62.03 1.23.13 1.82A3.003 3.003 0 0 0 6.09 16H11c.55 0 1 .45 1 1v.19c0 2.3 2.49 3.76 4.49 2.61A9.002 9.002 0 0 0 11.85 3zM8 11.5c-.83 0-1.5-.67-1.5-1.5S7.17 8.5 8 8.5s1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm3 8c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm1-5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						전시회
					</div>
				</a>
				
				<a href="event_list?mode=film" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M8.427 11l11.957-3.21L18.83 2 1.444 6.662 3 12.456V18c0 1.66 1.34 3 3 3h12c1.66 0 3-1.34 3-3v-7H8.427zm8.99-6.555l.517 1.93-1.93.52-.52-1.93 1.932-.52zM13.55 5.482l.52 1.932-1.933.518-.52-1.93 1.932-.52zM9.69 6.52l.518 1.93-1.932.52-.518-1.932 1.93-.52zM5.825 7.555l.52 1.932-1.933.52-.52-1.933 1.933-.52zM7 15H5v-2h2v2zm4 0H9v-2h2v2zm4 0h-2v-2h2v2zm4 0h-2v-2h2v2z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						영화 & 시사회
					</div>
				</a>
				
				<a href="event_list?mode=book" class="category_browse_label">
					<div class="category_browse_small_icon_wrap">
						<span class="category_browse_small_icon">
							<span class="icon" style="width: 24px; height: 24px;">
								<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
									<path d="M9.994 18H19v1H9.993v-1zm7.004-1H8.493c-.827 0-1.5.673-1.5 1.5s.673 1.5 1.5 1.5h9.505a1 1 0 0 1 0 2h-9.28c-1.812 0-3.467-1.277-3.7-3.075-.09-.7-.027-1.925-.027-1.925V4a2 2 0 0 1 2.004-2H17a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2z"></path>
								</svg>
							</span>
						</span>
					</div>
					<div class="category_browse_small_icon_desc">
						도서 & 출판
					</div>
				</a>
			</div>
			
			<div class="event_list_footer_browse_small" style="margin-left: 0px;">
				<div style="margin-top: 27px;">
					<a href="event_list?mode=fashion" class="category_browse_label">
						<div class="category_browse_small_icon_wrap">
							<span class="category_browse_small_icon">
								<span class="icon" style="width: 24px; height: 24px;">
									<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
										<path d="M19 8l-2-.845V5l-2.558 5H9.558L7 5v2.155L5 8 3 6l4.753-2.99v-.005L7.75 3h1.434C9.597 4 10.696 4.998 12 4.998c1.303 0 2.4-.998 2.815-1.998h1.433L21 5.998 19 8zm-3.99 3l4.96 8.1c-.12.144-.285.454-.5.535-.5.19-.998.054-1.103-.275-.11-.33-.582-.467-1.058-.336-.48.133-.81.493-.737.832.08.337-.273.71-.794.803-.52.09-.98-.13-1.025-.478-.05-.343-.486-.565-.975-.52-.49.043-.874.34-.86.685.016.346-.396.65-.924.65s-.94-.305-.922-.65c.013-.347-.374-.643-.863-.687-.49-.043-.922.177-.972.52-.044.343-.505.565-1.025.47-.52-.095-.874-.473-.793-.81.074-.34-.256-.71-.73-.842-.478-.13-.95-.014-1.06.315-.105.33-.6.42-1.1.23-.07-.025-.127-.156-.188-.19L9.01 11h6z"></path>
									</svg>
								</span>
							</span>
						</div>
						<div class="category_browse_small_icon_desc">
							패션
						</div>
					</a>
					
					<a href="event_list?mode=sports_activity" class="category_browse_label">
						<div class="category_browse_small_icon_wrap">
							<span class="category_browse_small_icon">
								<span class="icon" style="width: 24px; height: 24px;">
									<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
										<path d="M19.7 12.785c-1.398 1.398-3.157 2.16-4.856 2.26a59.9 59.9 0 0 0-5.068 1.957l.025.025-4.95 4.95-2.82-2.827 4.95-4.95.026.02A59.555 59.555 0 0 0 8.96 9.15c.102-1.7.863-3.458 2.26-4.857 2.735-2.734 6.85-3.05 9.194-.708 2.34 2.343 2.024 6.46-.71 9.192zm-9.878-.152c-.34.883-.697 1.76-1.082 2.627a59.14 59.14 0 0 1 2.626-1.082 5.165 5.165 0 0 1-.858-.686 5.132 5.132 0 0 1-.686-.86zm9.17-7.626c-1.558-1.56-4.413-1.243-6.362.707-1.95 1.95-2.267 4.804-.708 6.364 1.56 1.56 4.415 1.242 6.364-.708 1.95-1.95 2.267-4.804.707-6.363zM18 17a2 2 0 1 1 0 4 2 2 0 0 1 0-4z"></path>
									</svg>
								</span>
							</span>
						</div>
						<div class="category_browse_small_icon_desc">
							스포츠 & 야외활동
						</div>
					</a>
					
					<a href="event_list?mode=family_kids" class="category_browse_label">
						<div class="category_browse_small_icon_wrap">
							<span class="category_browse_small_icon">
								<span class="icon" style="width: 24px; height: 24px;">
									<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
										<path d="M17.5 7.27l-.305-.176A5.198 5.198 0 0 0 12 2a5.198 5.198 0 0 0-5.195 5.094L6.5 7.27a3.466 3.466 0 0 0-1.268 4.735 3.43 3.43 0 0 0 2.688 1.7l3.155 7.675c.34.827 1.51.827 1.85 0l3.155-7.674a3.43 3.43 0 0 0 2.688-1.7 3.466 3.466 0 0 0-1.27-4.736zm-.464 3.735c-.26.45-.732.72-1.263.72a1.46 1.46 0 0 1-.28-.026l-1.065-.204-.75.78a2.308 2.308 0 0 1-3.355 0l-.75-.78-1.066.202a1.46 1.46 0 0 1-.28.025 1.44 1.44 0 0 1-1.263-.72c-.404-.7-.163-1.6.537-2.003l.306-.176.977-.564.023-1.128A3.214 3.214 0 0 1 12 4a3.214 3.214 0 0 1 3.195 3.134l.023 1.128.977.564.304.176c.7.404.94 1.303.535 2.003z"></path>
									</svg>
								</span>
							</span>
						</div>
						<div class="category_browse_small_icon_desc">
							가족 & 어린이
						</div>
					</a>
					
					<a href="event_list" class="category_browse_label">
						<div class="category_browse_small_icon_wrap">
							<span class="category_browse_small_icon">
								<span class="icon" style="width: 24px; height: 24px;">
									<svg class="icon_svg" style="overflow: hidden; fill: #0073bb;">
										<path d="M20 14a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm-8 0a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm-8 0a2 2 0 1 1 0-4 2 2 0 0 1 0 4z"></path>
									</svg>
								</span>
							</span>
						</div>
						<div class="category_browse_small_icon_desc">
							전체 보기
						</div>
					</a>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>



<script>
	$(document).on('click', '.location_city_list_toggle', function(e) {
		if($('.icon_14x14_triangle_down').css('display') == 'none') {
// 			$('.icon_14x14_triangle_right').text('Hide');
			$('.icon_14x14_triangle_right').hide();
			$('.icon_14x14_triangle_down').show();
 			$('.location_more_cities_island').show();
		} else {
// 			$('.icon_14x14_triangle_right').text('More Cities');
			$('.icon_14x14_triangle_right').show();
			$('.icon_14x14_triangle_down').hide();
			$('.location_more_cities_island').hide();
		}		
	});
	
	$(document).on('click', '#hide_location_box', function() {
		$('.icon_14x14_triangle_right').show();
		$('.icon_14x14_triangle_down').hide();
		$('.location_more_cities_island').hide();
	})
	
	
	$(document).on('click', '.dropdown_toggle_action', function(e) {
		var parent = $(this).parents('.event_browse_filter_itmes_dropdown_toggle');
		
 		if(!$(parent).hasClass('is_active')) {
 			$('.event_browse_filter_itmes_dropdown_toggle').removeClass('is_active');
			$('.event_browse_filter_itmes_dropdown_menu').removeClass('is_visible');
			$(parent).addClass('is_active');
			$(parent).next().children('.event_browse_filter_itmes_dropdown_menu').addClass('is_visible');
		} else {
			$(parent).removeClass('is_active');
			$(parent).next().children('.event_browse_filter_itmes_dropdown_menu').removeClass('is_visible');
		}
 		e.stopPropagation();
 		e.preventDefault();
	})
	
	$(document).on('click', function(e) {
		if(!$(e.target).hasClass('dropdown_toggle_action') && !$(e.target).hasClass('event_browse_filter_itmes_dropdown_menu')) {
			$('.event_browse_filter_itmes_dropdown_toggle').removeClass('is_active');
			$('.event_browse_filter_itmes_dropdown_menu').removeClass('is_visible');
		}
	})
	
</script>

<script type="text/javascript">	
	function list(page){
		location.href="event_list?curPage=" + page;
	}
	
	function deleteEvent(evnum) {
		if(confirm("이벤트에 등록된 모든 자료를 삭제합니다. 계속 하시겠습니까?")) {
			location.href="event_delete?evnum=" + evnum;
		} else {
			return;
		}
	}
</script>


<%@ include file="../bottom.jsp"%>
