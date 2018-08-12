<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>yeps - errorpage</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/errorPage.css"/>"/>
</head>
<body>
	<div class="errorpage_main-header errorpage_main-content-wrap errorpage_js-main-header errorpage_webview-hidden errorpage_main-header--simple">
		<div class="errorpage_main-header_wrapper">
			<div class="errorpage_content-container">
				<div class="errorpage_arrange arrange--18 errorpage_arrange--middle errorpage_main-header_arrange">
					<div class="errorpage_arrange_unit errorpage_arrange_unit--fill errorpage_align-middle errorpage_main-header--full_arrange_unit errorpage_main-header_search-container">
					<div class="errorpage_main-header_logo errorpage_js-analytics-click" id="logo" data-analytics-label="logo">
					    <a href="main">Yeps</a>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="errorpage_y-container errorpage_y-container--shelf errorpage_u-bg-color">
        <div class="errorpage_y-container_content errorpage_y-container_content--maintenance errorpage_u-text-centered">
            <div class="errorpage_u-space-b3">
                <img src="https://s3-media1.fl.yelpcdn.com/assets/srv0/error_pages/0fba5e79f743/assets/img/222x222_hardhatdarwin.png" srcset="https://s3-media3.fl.yelpcdn.com/assets/srv0/error_pages/b96919a24714/assets/img/222x222_hardhatdarwin@2x.png 2x" width="222">
            </div>
            <div class="errorpage_u-space-b6">
                <h2>The dog ate our website</h2>
                <div class="errorpage_u-text-subtle errorpage_u-space-b1">HTTP 404 - NOT FOUND</div>
                <p>We apologize for the inconvenience.</p>
            </div>
        </div>
    </div>
</body>
</html>