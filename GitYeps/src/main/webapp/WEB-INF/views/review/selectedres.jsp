<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    
<html>
<head>
	<title>아직 타이틀 미설정</title>
	
	<style>
		.a{color:darkred;}
		.off{color:black;}
		.on{color:blue;}
	</style>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=3"/>"/>
   <script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	
	 <script type="text/javascript">
		  function review_keyword(){
			 selectKeyword.submit();
		  }
		  function buttonClick(obj) {
			  if(obj.className == "off") {
				  obj.className = "on";
			  } else {
				  obj.className = "off"
			  }
			  //EstimateCount.submit();
		  }
     </script>

</head>
<body>
<%@ include file="../top.jsp" %>
	<form name="selectKeyword" action="review_keyword?rname=${rname}" method="post">  
	
		평균평점 |리뷰작성자수 | Details<br>
		지도 | 사진1 |사진2 |사진3 ...<p>

		사진1 - 리뷰<br> 
		사진2 - 리뷰<br> 
		사진3 - 리뷰<p>

	<a href="">Show more review highlights</a><p>
	<hr>
		식당사진|ad(광고)|식당명<br>
		평점|리뷰작성자수|위치
		내용...................<a href="">read more</a><br>
		식당위치 
	<hr>
	<hr>
		식당사진|ad(광고)|식당명<br>
		평점|리뷰작성자수|위치
		내용...................<a href="">read more</a><br>
		식당위치 
	<hr><p>

	<h1 class="a">Ask the Community</h1>
	Yelp users haven’t asked any questions yet about <b>${rname}</b><p>
	
	<input type="button" value="Ask a Question">

	<hr>

	<a href="restaurant_qna">See all 2 question for ${rname}</a><p><p>

	<h1 class="a">Recommended Reviews for ${rname}</h1>

	<input type="text" placeholder="Search within the reviews" autocomplete="on" name="SearchKeyword">

	<button onclick="javascript:review_keyword()">검색</button><p><p><p>
 	
	별점 주기<br>
	<a href="review_write?rname=${rname}&rnum=${rnum}">Start your review of ${rname}</a><p>
 
 	</form>
 	<!--  
 	<form name="EstimateCount" action="review_EstimateCount_update" method="post">
 	--> 
 	<table border="1">
	<tr>
 		<c:if test="${empty selectedDataM}">
 			<td>해당 식당에 대한 회원정보가 없습니다.</td>
 		</c:if>
 	</tr>	
	<tr>
 		<c:forEach var="mdto" items="${selectedDataM}">
 			<td>
 				작성자:${mdto.name}<br>
 				리뷰수:${mdto.reviewcount}<br>
 				사진수:${mdto.imagecount}<p>
 			</td>
 		</c:forEach>
 	</tr>
 	<tr>
 		<c:if test="${empty selectedDataRV}">
 			<td>해당 식당에 대한 리뷰가 없습니다.</td>
 		</c:if>
 	</tr>
 	<tr>
		<c:forEach var="rvdto" items="${selectedDataRV}">
			
			<td>
				평점:${rvdto.gradepoint}/
				작성일:${rvdto.joindate}<p>
				내용:${rvdto.content}<p>	
				Was this review...?<br>
				
		  		<button class="off" onclick="javascript:buttonClick(this)">Useful</button>
		  		<button class="off" onclick="javascript:buttonClick(this)">Funny</button>
		  		<button class="off" onclick="javascript:buttonClick(this)">Cool</button>

			</td>	
		</c:forEach>
	</tr>
	</table>
	<p><p><p>


	★Useful/Funny/Cool 버튼 눌렀을때 자동으로 숫자 올라가게 해주기 
	★ 페이징 처리 ★
	<!--  
	</form>
	-->
</body>
</html> 
<%@ include file="../bottom.jsp" %>



 


 




