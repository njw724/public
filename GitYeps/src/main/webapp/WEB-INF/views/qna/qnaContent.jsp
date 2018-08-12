<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<% 
   pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
   
<html>
<head>
   <title>QnA</title>
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
</head>
<%@ include file="qna_top.jsp" %>
<div class="qna-content-container">
      <div class="container">
         <div class="YblockContentMain">
            <div class="qna_view not_list faq" style="display:none;">
               <h1>자주 묻는 질문</h1>
               <div class="qna_location">
                  <div class="location_list">
                     <span><a href="qna_list"><small>Q&A홈</small></a></span>
                     <span class="end"><a href="qna_list?mode=faq"><strong><small>자주 묻는 질문</small></strong></a></span>
                  </div>
               </div>
            </div>
            
            <div class="qna_view not_list qna">
               <h1>Q&A</h1>
               <div class="qna_location">
                  <div class="location_list">
                     <span><a href="qna_list"><small>Q&A홈</small></a></span>
                     <span class="end"><a href="qna_list?mode=qna"><strong><small>Q&A</small></strong></a></span>
                  </div>
               </div>
            </div>
            
            <div class="YblockPageMenu">
               <ul>
                  <li class="Yfirst" style="width: 50%;"><a href="qna_list?mode=faq">자주 묻는 질문</a></li>
                  <li class="Ylast Ycurrent" style="width: 50%;"><a href="qna_list?mode=qna">Q&A</a></li>
               </ul>
            </div>
            
            <div class="faq" style="display:none;">
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
            
            <div class="qna" style="">
               <div class="Yinformation">
                  <p>자주 묻는 질문이 궁금하다면 <a href="qna_list?mode=faq" id="lik1to1Inquery">자주묻는질문</a>을 활용해 주세요!</p>
                  <input id="qnabtn" type="button" class="qnabtn qnabtn-primary qnabtn-full" value="돌아가기" onclick="window.location='qna_list?mode=qna'">
               </div>
            </div>
            
            <div id="faqList">
               <table class="blueone_content">
                  <tr>
                     <th width="15%">글번호</th>
                     <td align="center" width="35%">${getQnA.qnum}</td>
                     <th width="15%">조회수</th>
                     <td align="center" width="35%">${getQnA.readcount}</td>
                  </tr>
                  <tr>
                     <th width="15%">작성자</th>
                     <td align="center" width="35%">${getQnA.writer}</td>
                     <th width="15%">작성일</th>
                     <td align="center" width="35%">${getQnA.regdate}</td>
                  </tr>
                  <tr>
                     <th width="15%">글제목</th>
                     <td colspan="3"><input type="text" name="title" maxlength="50" value="${getQnA.title}" readonly>
                  </tr>
                  <tr>
                     <th width="15%">글내용</th>
                     <td colspan="3"><textarea name="content" rows="13" cols="50" class="box" readonly>${getQnA.content}</textarea></td>
                     
                  </tr>
               </table>
            </div>
            
            <c:if test="${!empty getQnA.reply}">
               <div class="qna_reply_content">
                  <form name="qnareplyf" class="qna_reply_form" action="qna_reply" method="post" onsubmit="return replyCheck()">
                     <input type="hidden" name="qnum" value="${getQnA.qnum}"/>
                     <table class="blueone_content">
                        <tr>
                           <th>답 변 내 용</th>
                        </tr>
                        <tr>
                           <td><textarea name="reply" rows="10" class="replybox" autocomplete="off"  required readonly>${getQnA.reply}</textarea></td>
                        </tr>
                     </table>
                     <div class="qna_content_btn_wrap qna_reply_update">
                        <c:if test="${sessionScope.memberinfo.ismanager == 'y'}">
                           <input type="button" class="qna_reply_update_btn qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="replyupdate()" value="답변 수정하기">
                           <input type="submit" class="qna_reply_update_okbtn qnacontentbtn qnawritebtn-primary qnawritebtn-full" value="답변 수정완료">
                           <input type="button" class="qna_reply_update_cancelbtn qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="replyupdate_cancel()" value="답변 수정취소">
                        </c:if>
                        <c:choose>         
                  <c:when test="${sessionScope.memberinfo.ismanager == 'y'}">   
                     <c:if test="${empty getQnA.reply}">
                        <input type="button" name="qna_reply" class="qna_replybtn qnacontentbtn qnawritebtn-primary qnawritebtn-full" value="답변달기">
                     </c:if>
                     
                     <c:if test="${sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                     </c:if>
                     <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                  </c:when>
                  <c:otherwise>
                     <c:if test="${sessionScope.memberinfo.ismanager != 'y' && sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                        <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                     </c:if>
                  </c:otherwise>
               </c:choose>
                     </div>
                  </form>
               </div>
            </c:if>
            
            <div class="qna_reply_wrap">
               <form name="qnareplyf" class="qna_reply_form" action="qna_reply" method="post" onsubmit="return replyCheck()">
                  <input type="hidden" name="qnum" value="${getQnA.qnum}"/>
                  <table class="blueone_content">
                     <tr>
                        <th width="15%">답 변 내 용</th>
                     </tr>
                     <tr>
                        <td><textarea name="reply" rows="10" class="replybox" autocomplete="off" required></textarea></td>
                     </tr>
                  </table>
                  <div class="qna_content_btn_wrap qna_managebtn">
                     <input type="submit" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" value="답변완료">
                     <c:choose>         
                  <c:when test="${sessionScope.memberinfo.ismanager == 'y'}">   
                     <c:if test="${empty getQnA.reply}">
                        <input type="button" name="qna_reply" class="qna_replybtn qnacontentbtn qnawritebtn-primary qnawritebtn-full" value="답변달기">
                     </c:if>
                     
                     <c:if test="${sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                     </c:if>
                     <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                  </c:when>
                  <c:otherwise>
                     <c:if test="${sessionScope.memberinfo.ismanager != 'y' && sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                        <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                     </c:if>
                  </c:otherwise>
               </c:choose>
                  </div>
               </form>
            </div>
            
            <div class="qna_content_btn_wrap qna_userbtn">
               <c:choose>         
                  <c:when test="${sessionScope.memberinfo.ismanager == 'y'}">   
                     <c:if test="${empty getQnA.reply}">
                        <input type="button" name="qna_reply" class="qna_replybtn qnacontentbtn qnawritebtn-primary qnawritebtn-full" value="답변달기">
                     </c:if>
                     
                     <c:if test="${sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                     </c:if>
                     <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                  </c:when>
                  <c:otherwise>
                     <c:if test="${sessionScope.memberinfo.ismanager != 'y' && sessionScope.memberinfo.mnum == getQnA.mnum && empty getQnA.reply}">
                        <input type="button" value="글수정" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="window.location='qna_update?qnum=${getQnA.qnum}'">
                        <input type="button" value="글삭제" class="qnacontentbtn qnawritebtn-primary qnawritebtn-full" onclick="deleteQnACheck('${getQnA.qnum}')">
                     </c:if>
                  </c:otherwise>
               </c:choose>
            </div>
         </div>
      </div>
   </div>
</div>

<script type="text/javascript">
      var isExistReply = '${isExistReply}';
      $(function() {
         if(isExistReply){
            $(".qna_userbtn").hide();
            $(".qna_reply_update_okbtn").hide();
            $(".qna_reply_update_cancelbtn").hide();
         }
      });
      
      var a ;
      
      function replyupdate(){
         $(".qna_reply_update_btn").hide();
         $(".qna_reply_update_cancelbtn").show();
         $(".qna_reply_update_okbtn").show();
         $(".replybox").attr("readonly", false);
         $(".replybox").focus();
         a = $(".replybox").val();
      }
      
      function replyupdate_cancel(){
         $(".qna_reply_update_btn").show();
         $(".qna_reply_update_cancelbtn").hide();
         $(".qna_reply_update_okbtn").hide();
         $(".replybox").val(a);
         $(".replybox").attr("readonly", true);

      }
   
      $(document).ready(function() {
         $('.qna_replybtn').click(function() {
            if($(".qna_reply_wrap").css("display") == "none"){
               $(".qna_reply_wrap").show();
               $(".qna_managebtn").show();
               $(".qna_userbtn").hide();
               $('.qna_replybtn').val('답변달기 취소');
               $('.replybox').focus();
            }else{
               $(".qna_reply_wrap").hide();
               $(".qna_managebtn").hide();
               $(".qna_userbtn").show();
               $('.qna_replybtn').val('답변달기');
               $('.replybox').blur();
            }
         });
      });
   
      function replyCheck(){
         if (qnareplyf.content.value==""){
            alert("내용을 입력해 주세요!!")
            qnareplyf.content.focus()
            return false
         }
         return true
      }
      
      function deleteQnACheck(qnum){
         if(confirm("정말 삭제하시겠습니까?")){
            window.location='qna_delete?qnum='+qnum ;
         }else{
            return
         }
         return
      }
   </script>

<%@ include file="../bottom.jsp" %>
