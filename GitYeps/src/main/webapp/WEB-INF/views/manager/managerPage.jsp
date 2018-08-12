<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Yeps!!!</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/member.css?ver=7"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/qna.css?ver=1"/>"/>
</head>
<%@ include file="../top.jsp"%> 

<div id="manager_container" style="height: auto;  float: inherit;font-family: cambria;font-weight: bold;font-size: 18;" >
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
												<option value="rname">레스토랑</option>
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
   <div id="manager_header" style="width: 70%; height: 50px; margin: 0 100px;" >
	  <h2>Management Page</h2>
   </div>
   <div id="manager_management_list" style="  width: 40%; height: 300px; margin: 0 200px; margin-bottom: 70px;">
	  <table>
	  <tr>
	  <td>
		 <a  class="btn" href="member_manager">회원 관리 페이지</a></td></tr>
		 <tr><td>
		 <a class="btn" href="event_list">이벤트 목록</a></td></tr>
		 <tr><td>
		 <a class="btn" href="eventReview_list">이벤트 리뷰 목록</a></td></tr>
		 <tr><td>
		 <a class="btn" href="event_photo_manage">이벤트 사진 관리</a></td></tr>
		 <tr><td>
		 <a class="btn" href="restaurant_list">레스토랑 목록</a></td></tr>
		 <tr><td>
		 <a class="btn" href="restReview_list">레스토랑 리뷰 목록</a></td></tr>
		
		 <tr><td>
		 <a class="btn" href="main">메인 페이지</a>&emsp;&emsp;&emsp;</td></tr>
	 </table>
	 
   </div>
   <!--  <div id="search_result_field" style="float: left; width: 60%;">
       <div id="search_result_block">
           <table>
               <tr>
               <td>검색 결과 내용 보여주기</td></tr>
           </table>
       </div>
   </div> -->
  
</div>
 <%@ include file="../bottom.jsp"%> 