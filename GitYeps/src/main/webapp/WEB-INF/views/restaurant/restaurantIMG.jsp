review_recentlist<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
   <title>레스토랑 리스트 사진목록 + 리뷰 + 평점 달 수 있도록 구현해둔 곳</title>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=4"/>"/>
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/review.css?ver=5"/>"/>
   <script src="//code.jquery.com/jquery.min.js"></script>
   
   <script type="text/javascript">
      
      var locked = 0;
      function show(gradepoint){
      if(locked==1){
         var i;
         var image;
         var el;
         
         for(i = 1; i<= 5; i++){
            image = 'image' + i;
            el = document.getElementById(image);
            el.src = "resources/img/gradepoint_no_color.png";   
         }
      }
      var i;
      var image;
      var el;
      
      for(i = 1; i <= gradepoint; i++){
         image = 'image' + i;
         el = document.getElementById(image);
         el.src = "resources/img/gradepoint_yes_color.png";
      }
         
      function noshow(gradepoint){
         if (locked==1)
            return;
         var i;
         var image;
         var el;
      
         for(i = 1; i<= gradepoint; i++){
            image = 'image' + i;
            el = document.getElementById(image);
            el.src = "resources/img/gradepoint_no_color.png";
         }
      }
      function lock(gradepoint){
         show(gradepoint);      
         locked = 1;            
      }
      function mark(gradepoint){
         lock(gradepoint);
         //alert("선택" + gradepoint);   
         document.review_writeF.gradepoint.value=gradepoint;   
         }
      }
   </script>
   
</head>
   <%@ include file="../top.jsp" %>
      <div class="div1">
         <div class="div2">
            <div class="div3">
               <div class="div3-1">
                  <h1>Your First Review Awaits</h1>
               </div>
               <div class="div3-2">
                  <h3>Review your favorite businesses and share your experiences with our community. Need a little help getting started?<a href="https://www.yelp-support.com/article/Getting-started-with-your-first-review?l=en_US">Check out these tips.</a></h3>
               </div>
               <div class="div3-3">
                  <label class="label00">Find</label>
                  <input type="text" class="text00">
               </div>
               <div class="div3-4">
                  <label class="label00">Near</label>
                  <input type="text" class="text00">
               </div>
               <div class="div3-5">
                  <input type="button" value="">
               </div>
            <div class="div4">
                  <img  width="260" src="https://s3-media4.fl.yelpcdn.com/assets/srv0/war_pages/3a7a5118019b/assets/img/writeareview/260x160_bizhouse_YNRA.png" srcset="https://s3-media1.fl.yelpcdn.com/assets/srv0/war_pages/4b1305d39b44/assets/img/writeareview/260x160_bizhouse_YNRA@2x.png 2x">
            </div>
            </div>   
         </div>
      </div>
   
   
   <div class="div11">
      <div class="div22">
             <div class="div33">
               <h3>Been to these businesses recently?</h3>
            </div>
               <c:if test="${empty rlist}">
                  <td>목록이 없음</td>
               </c:if>
            <div class="div44">
               <c:forEach var="dto" items="${rlist}">
                 <div class="div55">   
                  <div class="div55-1">
                     사진(식당번호):${dto.rnum}
                  </div>
                  <div class="div55-2">
                     <div class="div55-2-1">
                        <a href="review_selectedres?rnum=${dto.rnum}&rname=${dto.rname}">
                           식당명: ${dto.rname}
                        </a>
                     </div>   
                     <div class="div55-2-2">
                        위치:${dto.raddress}
                     </div>
                     <div class="div55-2-3">
                        <a href="review_write?rname=${dto.rname}&rnum=${dto.rnum}">
                           별점:미구현
                        </a>
                     </div>
                  </div>
                 </div>     
               </c:forEach>
             </div>
      </div>   
   </div>
  </body>
</html>

<%@ include file="../bottom.jsp" %>
