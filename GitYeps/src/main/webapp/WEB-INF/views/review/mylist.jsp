<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<html>
<head>
	<title>타이틀 정해야함.</title>
</head>
<body>
	<h2>NBPmnum(회원고유번호):${NBPmnum}</h2><p>
	
	★★file 부분만 구현해주면됨. FileDTO가져와서 꺼내주면됨.<br>
	★★상단에 있는 NBPmnum는 나중에 다 구현되면 지워주기<p>
	
	
	
	<!--  
	Filenum:${mylist_file.filenum}<br>
	-->
	Filenum:
	Name:${mylist_member.name}<br>
	ReviewCount:${mylist_member.reviewcount}<br>


	<c:if test="${empty getRnameAndRnum}">
		getRnameAndRnum의 값이 넘어오고있지 않음!
	</c:if>
	
	
	<c:forEach var="rdto" items="${getRnameAndRnum}">
		Wrote a review for <a href="review_selectedres?rnum=${rdto.rnum}&rname=${rdto.rname}">${rdto.rname}(식당명)</a><p>	
	</c:forEach>		
			
						
	Review of the Day<p>
	
	Gradepoint:${mylist_review.gradepoint}
	Joindate:${mylist_review.joindate}<p>
	Content:${mylist_review.content}<p>
	
	<a href="previous_reviews">Read previous reviews</a>
	
	
	
	<!--  
	${fileimg}<br>  -- filenum에서 가져오기 
	${name}<br>		-- mnum에서 가져오기 
	${reviewcount}	-- mnum에서 가져오기 
	Wrote a review for 식당명(갖다대면 이미지 보여주면서 누르면 식당 페이지로 이동)
	
	Review of the Day 
	
	${gradepoint}	-- rvnum에서 가져오기 
	${joindate}<br>	-- rvnum에서 가져오기(리뷰작성한 날짜이므로)
	${content} 		-- rvnum에서 가져오기 
	
	Read previous reviews -- 누르면 이전에 여기에 올라왔던 리뷰 목록들있는 페이지로이동 (이전에 올라왔던 리뷰목록들을 가져올필요없이 reviewcount가 몇이상 이면 올라오게끔 하기!)
	${recentreview}를 출력해주면됨. 
	-->
</body>
</html>


	


    