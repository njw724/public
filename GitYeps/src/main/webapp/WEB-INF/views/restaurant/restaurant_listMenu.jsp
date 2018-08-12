<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Insert title here</title>
<style>
.biz-menu .sub-menu::after {
    margin-left: 8px;
    content: "•";
    color: #999;
}
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
</head>
<%@include file="../top.jsp" %>
	<div class="main-content-wrap main-content-wrap--full" style="    background: white;min-width: 1020px;">
		<div class="menu-super-container" style="width: 960px;margin: 0 auto;padding:15 15 36 15px;height:100%;display:table;">
			<div class="container biz-menu">
				<div class="menu-header" style="    margin-bottom: 20px;border-bottom: 1px solid #ccc;padding-bottom: 10px;">
					<ul class="breadcrumbs" style="max-width: 100%;overflow: hidden !important;text-overflow: ellipsis !important;white-space: nowrap !important;word-wrap: normal !important;    list-style: none;    display: block;">
						<li style="display: inline;margin-right: 3px;    text-align: -webkit-match-parent;">
							<strong style=" font-weight: bold;">
								<a href="#" style="font-weight: bold;color: #0073bb;text-decoration: none;cursor: pointer;">${getRest.rname}</a>
							</strong>
						</li>	
						<li style="display: inline;margin-right: 3px;    text-align: -webkit-match-parent;">
							<span aria-hidden="true" style="width: 14px; height: 14px;" class="icon icon--14-chevron-right icon--size-14 u-space-r1">
							    <svg id="14x14_chevron_right" height="100%" viewBox="0 0 14 14" width="100%">
							    	<path d="M4.793 12a1 1 0 0 1-.707-1.707L7.38 7 4.085 3.707A1 1 0 1 1 5.5 2.293L10.207 7 5.5 11.707a.997.997 0 0 1-.707.293z"></path>
						    	</svg>
							</span>
						</li>					
					</ul>
				</div>
				<div class="clearfix layout-block layout-a" style="margin: 0 -15px;">
					<div class="column column-alpha" style="float: left;padding: 0 15px;min-height: 1px;    box-sizing: border-box;width: 66.66667%;">
						<h1 style="    margin-bottom: 10px;font-size: 21px;    word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;font-weight: bold;    line-height: 1.2em;color: #333;padding-top: 6px; ">
 							${getRest.rname} 메뉴
                		</h1>
                		<ul class="sub-menus" style="    margin-bottom: 20px;    list-style: none;    display: block;">
                			<li class="sub-menu inline-block" style="margin-right: 5px;display: inline-block;    text-align: -webkit-match-parent;">
                				<strong style="font-weight: bold;">메인 메뉴</strong>
                			</li>
                		</ul>
	                		<div class="menu-sections" style="margin-top: 15px;">
                		<c:forEach var="large" items="${largeList}" varStatus="status1">
	                			<div class="section-header section-header--no-spacing" style="margin-bottom: 0;border-bottom: 1px solid #e6e6e6;">
	                				<h2 class="alternate" style="color: #333;word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;font-weight: bold;margin-bottom: 6px;font-size: 21px;line-height: 1.28571em;    margin: 0 0 6px;    display: block;">
					                    ${large.large_name}
					                </h2>
	                			</div>
			                		<div class="u-space-b3" style="margin-bottom: 18px !important;">
			                			<c:forEach var="small" items="${smallList}" varStatus="status2" begin="${count}" end="${smallSize.get(status1.index)-1}">
			                			<c:set var="count" value="${count+1}"/>
			                				<div class="menu-item" style="border-top: 0;padding: 10px 0;">
			                					<div class="arrange arrange--6" style="margin-left: -6px;margin-right: -6px;border-collapse: separate;border-spacing: 6px 0;    display: table;min-width: 100%;table-layout: auto;">
			                						<div class="arrange_unit" style="margin-left: 3px;margin-right: 3px;border-collapse: collapse;border-spacing: 0 0;    box-sizing: border-box;display: table-cell;vertical-align: top;">
			                							<div class="photo-box biz-photo-box pb-60s">
			                								<a class="js-lightbox-media-link js-analytics-click" href="#" data-analytics-label="biz-photo" style="color: #0073bb;text-decoration: none;    cursor: pointer;">
												                <img alt="" class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/no-image.jpg" width="60" style="outline: none; border-radius: 4px;vertical-align: middle; ">
												            </a>
			                							</div>
			                						</div>
			                						<div class="arrange_unit arrange_unit--fill" style=" margin-left: 3px;margin-right: 3px;border-collapse: collapse;border-spacing: 0 0;    width: 100%;    box-sizing: border-box;display: table-cell;vertical-align: top;">
			                							<div class="arrange" style="display: table;min-width: 100%;table-layout: auto;">
			                								<div class="arrange_unit arrange_unit--fill menu-item-details" style="    width: 100%;    box-sizing: border-box;display: table-cell;vertical-align: top;">
			                									<h4 style="word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;font-weight: bold;margin-bottom: 6px;font-size: 14px;line-height: 1.28571em;color: #333;    margin: 0 0 3px;    display: block;">
									                                    <a href="/menu/fog-harbor-fish-house-san-francisco-2/item/blue-cheese-garlic-bread">${small.small_name} </a>
									                            </h4>
									                            <p class="menu-item-details-description" style="margin-bottom: 5px;display: block;">${small.small_content}</p>
			                								</div>
			                								<div class="menu-item-prices arrange_unit" style="text-align: right;padding-left: 90px;box-sizing: border-box;display: table-cell;vertical-align: top;">
			                									<ul style="list-style: none;    display: block;">
			                										<li class="menu-item-price-amount" style="font-size: 15px;font-weight: bold;display: list-item;">
			                											${small.small_price}￦
			                										</li>
			                									</ul>
			                								</div>
			                							</div>
			                						</div>
			                					</div>
			                				</div>
			                				</c:forEach>
			                			</div>
                		</c:forEach>
	                		</div>
					</div>
					<div class="column column-beta popular-section" style="float: left;padding: 0 15px;min-height: 1px;    box-sizing: border-box;width: 33.33333%;">
					<c:if test="${empty largeList }">
						<a href="restaurant_insertMenuForm?rnum=${getRest.rnum}">메뉴 등록</a>
					</c:if>
					<c:if test="${!empty largeList }">
						<a href="restaurant_updateMenuForm?rnum=${getRest.rnum}">메뉴 수정</a>	
					</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
<%@include file="../bottom.jsp" %>