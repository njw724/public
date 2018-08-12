<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="qna_top.jsp" %>

<div class="qna-content-container">
      <div class="container">
         <div class="YblockContentMain">
            <div class="qna_view not_list faq"  style="display:none;">
               <h1>자주 묻는 질문</h1>
               <div class="qna_location">
                  <div class="location_list">
                     <span><a href="qna_list"><small>Q&A홈</small></a></span>
                     <span class="end"><a href="qna_list?mode=faq"><strong><small>자주 묻는 질문</small></strong></a></span>
                  </div>
               </div>
            </div>
            
            <div class="qna_view not_list qna" style="display:none;">
               <h1>Q&A</h1>
               <div class="qna_location">
                  <div class="location_list">
                     <span><a href="qna_list"><small>Q&A홈</small></a></span>
                     <span class="end"><a href="qna_list?mode=qna"><strong><small>Q&A</small></strong></a></span>
                  </div>
               </div>
            </div>
            
            <div class="YblockPageMenu">
               <ul style="display:  flex;">
                  <li class="Yfirst Ycurrent" style="width: 50%;"><a href="qna_list?mode=faq">자주 묻는 질문</a></li>
                  <li class="Ylast" style="width: 50%;"><a href="qna_list?mode=qna">Q&A</a></li>
               </ul>
            </div>
            
            <div class="faq"  style="display:none;">
               <h2 class="Yhide">자주 묻는 질문</h2>
               <div class="Yinformation">
                  <p>원하시는 답변을 찾을 수 없다면 <a href="qna_list?mode=qna" id="lik1to1Inquery">Q&A</a>를 활용해 주세요!</p>
               </div>
               <div class="YblockTab greenTab">
                  <ul>
                     <li class="F00 Yfirst Ycurrent"><a onclick="fTabFaqList();">전체</a></li>
                     <li class="F01"><a onclick="fTabFaqList('F01');">리뷰 작성</a></li>
                     <li class="F02"><a onclick="fTabFaqList('F02');">프로필 수정</a></li>
                     <li class="F03 Ylast"><a onclick="fTabFaqList('F03');">기타</a></li>
                  </ul>
               </div>
               <div id="faqList">
                  <div class="YblockTabContent">
                     <div class="YaccordionList">
                        <dl class="F01">
                           <dt>
                              <a title="내용 펼치기">
                              <strong><span class="Yhide"></span>리뷰 작성</strong>
                              <span>리뷰는 어떻게 작성해야하나요? </span>
                              </a>
                           </dt>
                           <dd style="display: none;">
                           <span class="Yhide"></span>
                           잘 작성하시면 됩니다!
                           </dd>
                        </dl>
                              
                        <dl class="F01">
                           <dt>
                              <a title="내용 펼치기">
                              <strong><span class="Yhide"></span>리뷰 작성</strong>
                              <span>별점을 낮게 주면 어떻게 되나요?</span>
                              </a>
                           </dt>
                           <dd style="display: none;">
                           <span class="Yhide"></span>
                              해당 가게의 사장님이 슬퍼합니다.
                           </dd>
                        </dl>
                        
                        <dl class="F02">
                           <dt>
                              <a title="내용 펼치기">
                              <strong><span class="Yhide"></span>프로필 수정</strong>
                              <span>프로필은 어떻게 수정하나요?</span>
                              </a>
                           </dt>
                           <dd style="display: none;">
                           <span class="Yhide"></span>
                              로그인 뒤 우측 상단의 캐릭터아이콘을 눌러서 Account Settings 를 클릭해주시면 됩니다.
                           </dd>
                        </dl>
                        
                        <dl class="F03">
                           <dt>
                              <a title="내용 펼치기">
                              <strong><span class="Yhide"></span>기타</strong>
                              <span>다른 궁금한 점들은?</span>
                              </a>
                           </dt>
                           <dd style="display: none;">
                           <span class="Yhide"></span>
                              Q&A를 이용해주시기 바랍니다.
                           </dd>
                        </dl>
                     </div>
                  </div>
               </div>
            </div>
            
            <div class="qna" style="display:none;">
               <div class="Yinformation">
                  <p>자주 묻는 질문이 궁금하다면 <a href="qna_list?mode=faq" id="lik1to1Inquery">자주묻는질문</a>을 활용해 주세요!</p>
                  <input id="qnabtn" type="button" class="qnabtn qnabtn-primary qnabtn-full" value="질문하기" onclick="window.location='qna_write'">
               </div>
               <div id="faqList">
                  <table class="blueone">
                  <thead>
                     <tr>
                        <th width="10%">번호</th>
                        <th width="50%">제목</th>
                        <th>답변</th>
                        <th align="center">작성자</th>
                        <th align="center">작성일</th>
                        <th align="center">조회수</th>
                     </tr>
                  </thead>
                  <tbody>
                  <c:if test="${empty map.listQnA}">
                     <tr>
                        <td colspan="6">등록된 Q&A가 없습니다.</td>
                     </tr>   
                  </c:if>    
                  <c:forEach var="dto" items="${map.listQnA}">
                     <tr>
                        <td>
							${article_count}
							<c:set var="article_count" value="${article_count-1}"/>
                        </td>
                        <td>
                        <c:choose>
                           <c:when test="${dto.secret=='n'}">
                                 <a href="qna_content?qnum=${dto.qnum}">
                                       <c:set value="${dto.title}" var="title"/>
                                          <c:choose>
                                             <c:when test="${fn:length(title) > 50}">
                                                <b><c:out value="${fn:substring(title,0,49)}"/>..</b>
                                             </c:when>
                                             <c:otherwise>
                                                <b><c:out value="${title}"/></b>
                                             </c:otherwise>
                                          </c:choose>
                                    </a>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                              <c:when test="${sessionScope.memberinfo.mnum == dto.mnum || sessionScope.memberinfo.ismanager =='y'}">
                                    <a href="qna_content?qnum=${dto.qnum}">
                                       <c:set value="${dto.title}" var="title"/>
                                          <c:choose>
                                             <c:when test="${fn:length(title) > 20}">
                                                <b><c:out value="${fn:substring(title,0,19)}"/>..</b>
                                             </c:when>
                                             <c:otherwise>
                                                <b><c:out value="${title}"/></b>
                                             </c:otherwise>
                                          </c:choose>
                                    </a>
                              </c:when>
                              <c:otherwise>
                                 <center>
                                    비밀글입니다.
                                 </center>
                              </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                        </td>
                        <td>
                           <c:choose>
                              <c:when test="${empty dto.reply}">
                                 미답변
                              </c:when>
                              <c:otherwise>
                                 <b>답변완료</b>
                              </c:otherwise>
                           </c:choose>
                        </td>
                        <td>
                           <c:set value="${dto.writer}" var="writer"/>
                           <c:choose>
                              <c:when test="${fn:length(writer) > 12}">
                                 <c:out value="${fn:substring(writer,0,11)}"/>..
                              </c:when>
                              <c:otherwise>
                                 <c:out value="${writer}"/>
                              </c:otherwise>
                           </c:choose>
                        </td>
                        <td>${dto.regdate}</td>
                        <td align="center">${dto.readcount}</td>
                     </tr>      
                  </c:forEach>
                  </tbody>
                  </table>
   
                  		<div class="event_list_paging_section" style="font-size: 14px;">
			<div class="event_list_pagination_block">
				<div class="event_list_pagination_wrap">
					<div class="event_list_page_of_pages">
						<c:if test="${map.yepsPager.blockEnd == 0}">
							Page ${map.curPage} of 1
						</c:if>
						<c:if test="${map.yepsPager.blockEnd != 0}">
							Page ${map.curPage} of ${map.yepsPager.blockEnd}
						</c:if>
					</div>
<!-- 					페이징 처리!! 현재페이지는 span이 되고 나머지는 a로 -->
					<c:if test="${map.yepsPager.blockEnd != 1}">
					<div class="event_list_page_link_wrapper">
						<div class="event_list_page_link_wrap">
						
						<c:if test="${map.yepsPager.curBlock > 1}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('1')">
									<span>Start</span>
								</a>
							</div>
						</c:if>

						<c:if test="${map.yepsPager.curBlock > 1}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${map.yepsPager.prevPage}')">
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
							<div class="event_list_page_link_option">
							<c:choose>
								<c:when test="${num == map.yepsPager.curPage}">
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
						
						<c:if test="${map.yepsPager.curBlock <= map.yepsPager.totBlock}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${map.yepsPager.nextPage}')">
									<span>Next</span>
									<span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
										<svg class="icon_svg">
											<path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
										</svg>
									</span>
								</a>
							</div>
						</c:if>
						
						<c:if test="${map.yepsPager.curPage <= yepsPager.totPage}">
							<div class="event_list_next_block">
								<a class="event_list_next_block_action" href="javascript:list('${map.yepsPager.totPage}')">
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
</div>
<script type="text/javascript">
   var mode = "${param.mode}";
   $(function() { 
      if(mode == 'qna'){
         $('.faq').hide();
         $('.qna').show();
         $('.YblockPageMenu > ul > li').removeClass('Ycurrent');
           $('.YblockPageMenu > ul > .Ylast').addClass('Ycurrent');
      }else{
         $('.faq').show();
         $('.qna').hide();
         $('.YblockPageMenu > ul > li').removeClass('Ycurrent');
           $('.YblockPageMenu > ul > .Yfirst').addClass('Ycurrent');
      }
   });
   
    function list(page){
       var searchString = '${map.searchString}';
        location.href="qna_list?mode=qna&searchString=" + searchString + "&curPage="+page;
    }
   
   function fTabFaqList(faq) {
      $('.greenTab > ul > li').removeClass('Ycurrent')
       if(faq == null){
          $('.greenTab > ul > .F00').addClass('Ycurrent')
          $('.YaccordionList .F01').show();
          $('.YaccordionList .F02').show();
          $('.YaccordionList .F03').show();
       }else if(faq == 'F01'){
          $('.greenTab > ul > .F01').addClass('Ycurrent')
          $('.YaccordionList .F01').show();
          $('.YaccordionList .F02').hide();
          $('.YaccordionList .F03').hide();
       }else if(faq == 'F02'){
          $('.greenTab > ul > .F02').addClass('Ycurrent')
          $('.YaccordionList .F01').hide();
          $('.YaccordionList .F02').show();
          $('.YaccordionList .F03').hide();
       }else if(faq == 'F03'){
          $('.greenTab > ul > .F03').addClass('Ycurrent')
          $('.YaccordionList .F01').hide();
          $('.YaccordionList .F02').hide();
          $('.YaccordionList .F03').show();
       }
    }
   
   $(document).ready(function(){
        $('.YaccordionList > dl').click(function( e ){
           $(this).children('dd').toggle();
           if($(this).hasClass('Ycurrent')){
              $(this).removeClass('Ycurrent');
           }else{
              $(this).addClass('Ycurrent');
           }
        })
        
        $('#profile-link').click(function(e){
           $(".profile-column-beta_profile").show();
           $(".profile-column-beta_passwd").hide();
           $(".profile-column-beta_memberleave").hide();
        })

     });   
   </script>
<%@ include file="../bottom.jsp"%>

