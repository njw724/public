<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<html>
<head>
	<title>Write a Review - Yeps</title>
	<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=4"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=4"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/review.css?ver=6"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=4"/>"/>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jD9qGVpvZh7Zobclojwp&submodules=geocoder"></script>
	
	<script type="text/javascript">
   		function list(page){
      		  location.href="review_restaurantFind?curPage=" + page;
   	    }
    </script>


<style>
.wrap {
   width: 330px;
   height: 300px;
   position: relative;
}
.wrap.fixed {
   position: fixed;
   padding-top:10px;
    top: 0;
   z-index: 999; 
}
</style>
</head>

<body>
<%@ include file="../top.jsp" %>
  <div class="resFind_div1">
	<div class="resIMG_div_1">
	  <div class="resIMG_div_2">
		<div class="resIMG_div_3">
			<div class="resIMG_div_4">
				<div class="resIMG_div_5">
					<div class="resIMG_div_6">
						<h1 class="resIMG_h1_1">Your First Review Awaits</h1>
						<h2 class="resIMG_h2_1">
							<b class="resFind_b_2">
								Review everything from your favorite burger to your dentist.	
							</b>
						</h2>
						<form class="" name="review_restaurantFind_F" method="get" action="review_restaurantFind">
							<div class="resIMG_div_7">
								<div class="resIMG_div_8">
									<ul class="resIMG_ul_1">
										<li class="resIMG_li_1">
											<div class="resIMG_div_9">
												<div class="resIMG_div_10">
													<div class="resIMG_div_11">
														<div class="resIMG_div_12">
															Find
														</div>
														<div class="resIMG_div_13">
															<input class="resIMG_input_1" type="text" name="SearchFind" value="${SearchFind}" autocomplete="off">
														</div>
													</div>	
												</div>
												<div class="resIMG_div_14">
													<div class="resIMG_div_15">
													</div>
												</div>	
											</div>
										</li>
										<li class="resIMG_li_2">
											<div class="resIMG_div_16">
												<div class="resIMG_div_17">
													<div class="resIMG_div_18">
														<div class="resIMG_div_20">Near</div>
														<div class="resIMG_div_21">
															<input class="resIMG_input_2" type="text" name="SearchNear" value="${SearchNear}" autocomplete="off" >
														</div>
													</div>
												</div>
												<div class="resIMG_div_22">
													<div class="resIMG_div_23">
													</div>
												</div>
											</div>
										</li>	
									</ul>
								</div>
								<div class="resIMG_div_24">
									<button class="resIMG_button_1" type="submit" value="submit">
										<span class="resIMG_span_1">
											<span class="resIMG_span_2" aria-hidden="true">
												<svg class="resIMG_svg_1">
													<path d="M15.913 14.224a1.324 1.324 0 0 0-.3-.466h.01l-3.378-3.376a5.49 5.49 0 0 0 .802-2.857 5.523 5.523 0 1 0-5.522 5.52 5.49 5.49 0 0 0 2.856-.8l3.37 3.368.006.003a1.364 1.364 0 0 0 .93.384C15.41 16 16 15.41 16 14.684c0-.163-.032-.317-.086-.46zM7.525 10.94a3.422 3.422 0 0 1-3.418-3.416 3.422 3.422 0 0 1 3.418-3.417 3.422 3.422 0 0 1 3.416 3.417 3.42 3.42 0 0 1-3.413 3.416z"></path>
												</svg>
											</span>
										</span>
									</button>
								</div>
							</div>
						</form>
					</div>
					<div class="resIMG_div_25">
						<div class="resIMG_div_26">
							<img src="https://s3-media3.fl.yelpcdn.com/assets/2/www/img/6010a06f69a3/writeareview/rating_building.png">
						</div>
					</div>
				 </div>
			   </div>
		    </div>
	     </div>
      </div>
   </div>
   <!-- 여기부터 내용부분임 -->
   <div class="resFind_div2">
   		<div class="resFind_div3">
   			<h2 class="resFind_h2_1">
   				See the business you’d like to review?
   			</h2>
   			<div class="resFind_div4">
   				<div class="resFind_div5">
   					<ul class="resFind_ul_1">
						<c:choose>
							<c:when test="${empty map.Find_Restaurant_Review_Get_rdto}">
								<br>
								검색하신 단어에대한 레스토랑 정보가 없습니다.	
								<br>
							</c:when>
							<c:otherwise>						
   								<c:forEach var="rdto" items="${map.Find_Restaurant_Review_Get_rdto}" varStatus="status">
   									<li class="resFind_li_1">
   										<div class="resFind_div6">
   											<div class="resFind_div7">
   												<div class="resFind_div8">
   													<div class="resFind_div9">
   														<div class="resFind_div10">
   															<img class="resFind_img_1" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/${rdto.fileDTO.filename}">
   														</div>
   													</div>
   													<div class="resFind_div11">
   															<h3 class="resFind_h3_1">
   															<b class="resFind_b_1">
   																	${status.count}.
   																<span class="resFind_span_1">
   																	${rdto.rname}
   																</span>
   																	
   															</b>
   														</h3>
   														<div class="resFind_div12">
   															<div class="resFind_div13 resFind_starimg-${StarAvg.get(status.index)}">
																<img class="offscreen" src="https://s3-media2.fl.yelpcdn.com/assets/srv0/yelp_design_web/9b34e39ccbeb/assets/img/stars/stars.png"width="84" height="303"style="clip: rect(0, 0, 0, 0); position: absolute; left: -9999px; top: auto; overflow: hidden; width: 1px; height: 1px; vertical-align: middle;">
															</div>
   															<span class="resFind_span_2">
   																${reviewCount.get(status.index)} reviews
   															</span>
   														</div>
   														<div class="resFind_div14">
   															<span class="resFind_span_3">
   																$$ － ${rdto.foodstyle}
   															</span>
   														</div>
   															<c:choose>
	   															<c:when test="${!empty sessionScope.memberinfo}">
				   													<c:if test="${isExistReviewList.get(status.index) == 'n'}">
				   														<a class="resFind_a_2 resFind_a_1" href="review_write?rnum=${rdto.rnum}">
				   															<span class="resFind_span_5 resFind_span_4">
				   																<svg class="resFind_svg_2 resFind_svg_1">
				   																	<path d="M8.94 1l2.373 5.387 5.187.758-3.75 3.67.928 5.077-4.737-2.907L4.367 16l.885-5.186-3.75-3.67 5.187-.757L8.94 1z"></path>
				   																</svg>
				   															</span>
				   															Write a Review
				   														</a>
				   													</c:if>
	   															</c:when>
	   															<c:otherwise>
			   														<a class="resFind_a_2 resFind_a_1" href="review_write?rnum=${rdto.rnum}">
			   															<span class="resFind_span_5 resFind_span_4">
			   																<svg class="resFind_svg_2 resFind_svg_1">
			   																	<path d="M8.94 1l2.373 5.387 5.187.758-3.75 3.67.928 5.077-4.737-2.907L4.367 16l.885-5.186-3.75-3.67 5.187-.757L8.94 1z"></path>
			   																</svg>
			   															</span>
			   															Write a Review
			   														</a>
	   															</c:otherwise>
   															</c:choose>									
   													</div>
   												</div>
   											</div>
   											<div class="resFind_div15">
   												<address class="resFind_address_1">
   													${rdto.roadAddrPart1}
   													<br>
   													${rdto.roadAddrPart2}
   													<br>
   													${rdto.addrDetail}
   												</address>
   												<!-- 
   												<span class="resFind_span_6">
   													
   												</span>
   												 -->
   												<span class="resFind_span_7">
   													${rdto.raddress}-${rdto.hp2}-${rdto.hp3}
   												</span>
   											</div>
   										</div>
   									</li>
   								</c:forEach>	
   							</c:otherwise>
						</c:choose>
   					</ul>
   					<!-- 페이징처리 -->
   					<div class="resFind_div16">
   						<div class="resFind_div17">
   							<div class="resFind_div18">
   							
   								<!-- 페이징 처리의 시작부 -->
   								<div class="yeps_message_pagination_wrap">
   								<div class="yeps_message_page_of_pages" >
	                                  <c:if test="${map.yepsPager.blockEnd == 0}">
	                                      Page ${map.yepsPager.curPage} of 1
	                                  </c:if>
	                                  <c:if test="${map.yepsPager.blockEnd != 0}">
	                                      Page ${map.yepsPager.curPage} of ${map.yepsPager.blockEnd}
	                                  </c:if>
	                             </div>
   							
	   							 <!--  페이징 처리!! 현재페이지는 span이 되고 나머지는 a로    -->
		                         <c:if test="${map.yepsPager.blockEnd != 1}">
		                             <div class="yeps_message_page_link_wrapper" style="text-align: right;">
		                                 <div class="yeps_message_page_link_wrap">
		                                     <c:if test="${map.yepsPager.curBlock > 1}">
		                                         <div class="yeps_message_next_block">
		                                             <a class="yeps_message_next_block_action" href="javascript:list('1')">
		                                                 <span>Start</span>
		                                             </a>
		                                         </div>
		                                     </c:if>
		                                 <c:if test="${map.yepsPager.curBlock > 1}">
		                                     <div class="yeps_message_next_block">
		                                         <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.prevPage}'">
		                                             <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
		                                                  <svg class="icon_svg">
		                                                      <path d="M14.475 18.364l1.414-1.414L10.94 12l4.95-4.95-1.415-1.414L8.11 12l6.365 6.364z"></path>
		                                                  </svg>
		                                              </span>
		                                             <span>Previous</span>
		                                          </a>
		                                      </div>
		                                  </c:if>
		                                     <c:forEach var="num" begin="${map.yepsPager.blockBegin}" end="${map.yepsPager.blockEnd}">
		                                         <div class="yeps_message_page_link_option">
			                                         <c:choose>
			                                             <c:when test="${num == map.yepsPager.curPage}">
			                                                 <span class="yeps_message_page_option_action">
			                                                     ${num}
			                                                 </span>
			                                             </c:when>
			                                             <c:otherwise>
			                                                 <a href="javascript:list('${num}')" class="yeps_message_page_option_link_action">
			                                                     ${num}
			                                                 </a>
			                                             </c:otherwise>
			                                         </c:choose>
			                                     </div>
		                                     </c:forEach>
		                                  <c:if test="${map.yepsPager.curBlock <= map.yepsPager.totBlock}">
		                                     <div class="yeps_message_next_block">
		                                        <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.nextPage}')">
		                                            <span>Next</span>
		                                            <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
		                                                <svg class="icon_svg">
		                                                    <path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
		                                                </svg>
		                                            </span>
		                                        </a>
		                                     </div>
		                                  </c:if>
		                                  <c:if test="${map.yepsPager.curPage <= map.yepsPager.totPage}">
		                                     <div class="yeps_message_next_block" style="display: inline-block;">
		                                        <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.totPage}')">
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
   				<!-- 위치사진 -->
   				<div class="resFind_div19">
   					<div class="resFind_div24">
						<div class="wrap">
               		  	 <div id="map" style="width: 330px; height: 300px;"></div>
               		  	   
                 				 <script>
									  var map = new naver.maps.Map('map',{
								  	  zoom:8
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
									   var filename=new Array();
									   var hp=new Array();
									   
									  	<c:forEach items="${map.Find_Restaurant_Review_Get_rdto}" var="item" >
											rname.push("${item.rname}");
											rnum.push("${item.rnum}");
											foodstyle.push("${item.foodstyle}");
											roadAddrPart1.push("${item.roadAddrPart1}");
											addrDetail.push("${item.addrDetail}");
											roadAddrPart2.push("${item.roadAddrPart2}");
											hp.push("${item.raddress}" + "-" + "${item.hp2}" + "-" + "${item.hp3}");
											filename.push("${item.rest_filename}");
										</c:forEach>
													
										for (var i = 0; i < roadAddrPart1.length; i++) {
											naver.maps.Service.geocode({address : roadAddrPart1[i]},function(status, response) {
												var result = response.result;
												var myaddr = new naver.maps.Point(result.items[0].point.x,result.items[0].point.y);
												map.setCenter(myaddr); // 검색된 좌표로 지도 이동
												// 마커 표시
												var marker = new naver.maps.Marker({
													position : myaddr,
													map : map,
													icon : {
														//src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/images/
														url : 'https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/pin_s_'+ (j + 1)+'.png',
														size : new naver.maps.Size(22, 30),
														anchor : new naver.maps.Point(11, 30)
													}
												});        
												iwContent = [
													'<div class="scrollFix" style="width:300px;height:140px;padding:12px;">',
														'<div class="left" style="width:200px;height:140px;display:inline-block;float:left">',
															'<div class="rname" style="width:210px;height:20px">',
																'<span><a href="restaurant_content?rnum='+rnum[j]+'">'+rname[j]+'</a></span>',
															'</div>',
															'<div class="rating" style="width:">',
																'<span class="fa fa-star checked"></span>',
																'<span class="fa fa-star checked"></span>',
																'<span class="fa fa-star"></span>',
																'<span class="fa fa-star"></span>',
																'<span class="fa fa-star"></span>',
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
														'<img width="90px" height="90px"src="getImage/'+filename[j]+'">',
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
										  
							
					
							
                		</div>
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
  	</div>

</body>
</html>
<%@ include file="../bottom.jsp" %>