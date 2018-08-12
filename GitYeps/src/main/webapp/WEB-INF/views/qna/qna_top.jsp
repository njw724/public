<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Yeps - Q&A Support Center</title>
	<link rel="shortcut icon" type="image⁄x-icon" href="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/favicon.ico">
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_list.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/qna.css"/>"/>
   <script type="text/javascript">
   var searchString = '${map.searchString}'
   $(document).ready(function() {
      if(searchString != null){
         $(".searchString").val(searchString)
      }
   });
</script>
</head>
<body>
<div class="qna-container" style="background: white;">
   <div class="main-content-wrap header-top-addons clearfix webview-hidden">
      <div class="content-container">
         <a class="i-wrap ig-wrap-common_sprite i-18x18_review_fff-common_sprite-wrap ig-wrap-common_sprite-r header-link" href="main">
            <i class="i ig-common_sprite i-18x18_review_fff-common_sprite"></i>Comeback To the YEPS.com
         </a>
      </div>
    </div>
    
    <div id="qna_main_content_wrap">
      <div id="qna_container">
         <div id="qna_container_arrange">
            <div id="yeps_img">
               <a href="main" style="display: block;"><img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/default.png" style="width: 80px; height: 40px;"></a>
            </div>
            <div id="arrange_unit">
               <h2 id="main-header_title">Support Center</h2>
            </div>
            <div id="qna_container_arrange_return">
               <div class="main-header_nav text-right">
                  <ul class="header-nav">
                     <li class="header-nav_item">
                        <a class="header-nav_link" href="main">Return to <strong>yeps.com</strong></a>
                     </li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="main-content-wrap--full">
      <div class="top-shelf top-shelf-grey sat-top-shelf">
         <div class="content-container">
            <div class="container">
               <div class="clearfix layout-block layout-n column--responsive">
                  <div class="column column-alpha column--responsive">
                     <img alt="Yelp Support Center" class="sc-top-shelf-illustration responsive-visible-large-block" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/support-darwin.png">
                  </div>
                  <div class="column column-beta column--responsive">
                     <div class="sc-top-shelf-search-block">
                        <div class="sc-search-form-container">
                           <form action="qna_list?mode=qna" class="yform arrange arrange--6 arrange--stack-small sc-search-form" method="POST">
                              <div class="arrange_unit arrange_unit--fill sc-search-field">
                                 <input name="searchString" class="searchString" placeholder="What can we help you with?" type="text" autocomplete=off>
                                 <button class="qna_searchbtn qna_searchbtn-primary" type="submit" value="submit">
                                    <span>
                                       <span class="i-wrap ig-wrap-common_sprite i-search-common_sprite-wrap">
                                          <i class="i ig-common_sprite search-common_sprite"></i> Search Q&A
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