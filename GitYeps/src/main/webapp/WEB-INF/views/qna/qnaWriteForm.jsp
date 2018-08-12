<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/magic-check.css"/>"/>
<html>
<head>
   <title>QnA</title>
   <script type="text/javascript">
      function qna_writeCheck(){
         if (qnawritef.title.value==""){
            alert("제목을 입력해 주세요!!")
            qnawritef.title.focus()
            return false
         }
         if (qnawritef.content.value==""){
            alert("내용을 입력해 주세요!!")
            qnawritef.content.focus()
            return false
         }
         return true
      }
   </script>
</head>   
<%@  include file="qna_top.jsp" %>
<div class="qna-content-container">
      <div class="container">
         <div class="YblockContentMain">
            <div class="qna_view not_list faq" style="display:none;">
               <h1>자주 묻는 질문</h1>
               <div class="qna_location">
                  <div class="location_list">
                     <span><a href="qna_list"><small>Q&amp;A홈</small></a></span>
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
            
            <div class="qna">
               <div class="Yinformation">
                  <p>자주 묻는 질문이 궁금하다면 <a href="qna_list?mode=faq" id="lik1to1Inquery">자주묻는질문</a>을 활용해 주세요!</p>
                  <input id="qnabtn" type="button" class="qnabtn qnabtn-primary qnabtn-full" value="돌아가기" onclick="window.location='qna_list?mode=qna'">
               </div>
            </div>
            
            <div id="faqList">
               <form name="qnawritef" class="qnawritef" action="qna_write" method="post" onsubmit="return qna_writeCheck()">
                  <table class="blueone_write">
                     <tr>
                        <th colspan="2">Question</th>
                     </tr>
                     <tr>
                        <th width="20%">작 성 자</th>
                        <td>${sessionScope.memberinfo.email}</td>
                     </tr>
                     <tr>
                        <th width="20%">제 목</th>
                        <td><input type="text" name="title" maxlength="50" autocomplete=off></td>
                     </tr>
                     <tr>
                        <th width="20%">내 용</th>
                        <td><textarea name="content" rows="13" cols="50" class="box" autocomplete=off></textarea></td>
                     </tr>
                     <tr>
                        <td colspan="2" align="center">
                           <input class="magic-checkbox" type="checkbox" id="secret" name="secret" value="y">
                           <label for="secret" style="width:20%">비밀글</label>
                           <input type="submit" class="qnawritebtn qnawritebtn-primary qnawritebtn-full" value="작성하기">
                        </td>
                     </tr>
                  </table>
               </form>
            </div>
         </div>
      </div>
   </div>
</div>
<%@ include file="../bottom.jsp" %>
