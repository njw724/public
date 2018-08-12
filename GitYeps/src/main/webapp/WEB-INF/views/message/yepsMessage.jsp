<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true" %>
<html>
<head>
<title>Yeps Message</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css?ver=1"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
 	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
 	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/event_content.css?ver=1"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
</head>
<%@ include file="../top.jsp"%>
<div style="background: white;">

<div class="popup" align="left" id="writeIssue" data-popup="writeIssue"  style="z-index: 9000;">
	<div class="popup-inner" style="width: 465px; height: auto !important; max-height: 400px;">
    	<div id="flag_content_popup_title">
    	    <div id="flag_content_popup_close" data-popup-close="writeIssue">
    			<h4 style="display: table-cell; padding: 0px 7px; font-size: 100%; font: inherit;">×</h4>
    		</div>
    		<h2>
    	    	메세지 보내기
    	    </h2>
    	</div>
    	
    	<div id="flag_popup_description" style="padding: 12px 8px 0;">
    		<div>
    			<form name="sendIssueform" method="post">
    				<div>
						<h4 align="left" style="color: #d32323;">Send Report To Manager</h4>
    	    			<input type="hidden" id="issueValue" value="issue">
    	    			<h4 align="left" style="color: #d32323;">Subject is</h4>
	            		<input type="text" name="title" id="sendIssueSubject">
	        			<h4 align="left" style="color: #d32323;">Content is</h4>
	            		<textarea rows="4" name="content" id="sendIssueContent"  style="width: 95%;" placeholder="여기에 메시지를 입력하세요."></textarea>
    	    		</div>
    			</form>
    		</div>
    	</div>
    	
		<div id="flag_popup_footer">
     		<div id="flag_popup_buttons">
     			<button id="message_popup_Issue_submit_button" type="submit" value="submit" data-popup-send="SendMessage" >
     				<span>메세지 보내기</span>
     			</button>
     			<a href="#" data-popup-close="writeIssue">
    				Close
    			</a>
     		</div>
     	</div>
	</div>		
</div>


<!-- Message sendform -->
<div class="popup" align="left" id="writeMessage" data-popup="writeMessage"  style="z-index: 9000;">
	<div class="popup-inner" style="width: 465px; height: auto !important; max-height: 400px;">
    	<div id="flag_content_popup_title">
    	    <div id="flag_content_popup_close" data-popup-close="writeMessage">
    			<h4 style="display: table-cell; padding: 0px 7px; font-size: 100%; font: inherit;">×</h4>
    		</div>
    		<h2>
    	    	메세지 보내기
    	    </h2>
    	</div>
    	
    	<div id="flag_popup_description" style="padding: 12px 8px 0;">
    		<div>
    			<form name="sendform" method="post">
    				<div>
						<h4 align="left" style="color: #d32323;">Send Message To</h4>
    	    			<input type="text" id="sendformTo" name="receiver">
    	    			<h4 align="left" style="color: #d32323;">Subject is</h4>
	            		<input type="text" name="title" id="sendformSubject">
	        			<h4 align="left" style="color: #d32323;">Content is</h4>
	            		<textarea rows="4" name="content" id="sendformMessage"  style="width: 95%;" placeholder="여기에 메시지를 입력하세요."></textarea>
    	    		</div>
    			</form>
    		</div>
    	</div>
    	
		<div id="flag_popup_footer">
     		<div id="flag_popup_buttons">
     			<button id="message_popup_submit_button" type="submit" value="submit" data-popup-send="SendMessage" >
     				<span>메세지 보내기</span>
     			</button>
     			<a href="#" data-popup-close="writeMessage">
    				Close
    			</a>
     		</div>
     	</div>
	</div>		
</div>



<!-- Message View -->
<div class="popup" align="left" id="popup" data-popup="popup-1"  style="z-index: 9000;">
	<div class="popup-inner" style="width: 465px; height: auto !important; max-height: 400px;">
    	<div id="flag_content_popup_title">
    	    <div id="flag_content_popup_close" data-popup-close="popup-1">
    			<h4 style="display: table-cell; padding: 0px 7px; font-size: 100%; font: inherit;" onclick="readCheck('${map.lMode}');">×</h4>
    		</div>
    		<h2>
    	    	메세지 보기
    	    </h2>
    	</div>
    	
    	<div id="flag_popup_description" style="padding: 12px 8px 0;">
    		<div>
    			<div>
					<h4 align="left" style="color: #d32323;">Message From</h4>
    	    		<input type="text" id="view_from" readOnly>
    	    		<h4 align="left" style="color: #d32323;">Subject is</h4>
	          		<input type="text" id="subject" readOnly>
	        		<h4 align="left" style="color: #d32323;">Content is</h4>
	           		<textarea rows="4" id="message" readOnly style="width: 95%;"></textarea>
    	    	</div>
    		</div>
    	</div>
    	
		<div id="flag_popup_footer">
     		<div id="flag_popup_buttons">
     			<button id="replyMessage" class="popup-reply" type="button" data-popup-close="popup-1" data-popup-open="writeMessage">
     				<span>답장 보내기</span>
     			</button>
			    <button class="popup-delete" id="deleteMessage" type="button" data-popup-close="popup-1" style="cursor:pointer;" onclick="deleteMsg('${map.lMode}');">
			    	<span>삭제</span>
			    </button>&nbsp;
    			<input type="hidden" id="view_msgnum"> 
    			<input type="hidden" id="pageMode">
     			<a href="#" data-popup-close="popup-1" onclick="readCheck('${map.lMode}');">
    				Close
    			</a>
     		</div>
     	</div>
	</div>		
</div>











<!-- Message sendform -->
<!-- <div class="popup" align="left" id="writeMessage" data-popup="writeMessage"  style="z-index: 9000;"> -->
<!--     <form name="sendform" method="post"> -->
<!-- 	    <div class="popup-inner"> -->
<!-- 	        <h4 align="left"  style="color: #d32323;">Send Message To</h4> -->
<!-- 	            <input type="text" id="sendformTo" name="receiver"> -->
<!-- 	        <h4 align="left" style="color: #d32323;">Subject is</h4> -->
<!-- 	            <input type="text" name="title" id="sendformSubject" > -->
<!-- 	        <h4 align="left" style="color: #d32323;">Content is</h4> -->
<!-- 	            <textarea rows="4" name="content" id="sendformMessage"  placeholder="여기에 메시지를 입력하세요."></textarea> -->
<!-- 	                <button class="popup-send" id="sendMessage" type="button" data-popup-send="SendMessage" onclick="sendMessage()">SendMessage </button> -->
<!-- 			        <a data-popup-close="writeMessage" style="cursor:pointer;" href="#">  Close</a> -->
<!-- 					<a class="popup-close" data-popup-close="writeMessage" href="#" >X</a> -->
<!-- 	    </div> -->
<!-- 	</form> -->
<!-- </div>  -->
	<!-- Message View  -->
<!--         <div class="popup" align="left" id="popup" data-popup="popup-1" style="z-index: 9000;"> -->
<!-- 		    <div class="popup-inner"> -->
<!-- 			  <h4 align="left"  style="color: #d32323;">Message From</h4> -->
<!-- 			     <input type="text" id="from" readOnly> -->
<!-- 			  <h4 align="left"  style="color: #d32323;">Subject is</h4> -->
<!-- 			     <input type="text" id="subject" readOnly> -->
<!-- 			  <h4 align="left"  style="color: #d32323;">Content is</h4> -->
<!-- 			     <textarea id="message" rows="4" readOnly></textarea> -->
<!-- 			        <button class="popup-reply" id="replyMessage" type="button" data-popup-close="popup-1" data-popup-open="writeMessage" style="cursor:pointer;">reply </button> -->
<%-- 			         <button class="popup-delete" id="deleteMessage" type="button" data-popup-close="popup-1" style="cursor:pointer;" onclick="deleteMsg('${map.lMode}');">delete </button>&nbsp; --%>
<%-- 			           <a data-popup-close="popup-1" href="#" style="cursor:pointer;" onclick="readCheck('${map.lMode}');">Close</a> --%>
<!-- 				           <input type="hidden" id="readCheck" > <input type="hidden" id="pageMode"> -->
<%-- 				       <a class="popup-close" style="cursor:pointer;" data-popup-close="popup-1" href="#" onclick="readCheck('${map.lMode}');">x</a> --%>
<!-- 		       </div> -->
<!-- 	      </div>  -->
	          <div id="messageContainer">
	              <div id="messageHeader">
		            <c:choose>
                    	<c:when test="${ where eq 'yeps' }">
                       		<label> Messages</label>
                    	</c:when>
                    	<c:when test="${where eq 'locker' }">
                       		<label> Locker</label>
                    	</c:when>
                    	<c:when test="${where eq 'alert' }">
                       		<label> alert </label>
                    	</c:when>
					</c:choose>
				    <input type="button" id="write" value="Write New Message" data-popup-open="writeMessage" onclick="messageForm();">
		          </div>
		      <div id="menu">
	            <a href="message_action?filter=msgBoxList"><label style="cursor:pointer;">InBox :  ${mCount} </label></a>&nbsp;&nbsp;
			    <a href="message_action?filter=sender"><label style="cursor:pointer;">Sent :  ${sCount} </label></a>&nbsp;&nbsp;
			    <a href="message_action?filter=allLocker"><label style="cursor:pointer;">locker :  ${lCount} </label></a>
			    <c:if test="${ key eq 'almighty' }">
					<a href="message_action?filter=alertMsg" style="float:right;"><label style="cursor:pointer;">alertBox :  ${aCount}</label></a>
				</c:if>
			      
			  </div>
		  <div id="messageList"  style="position:absolute;">
	         <form name="msgform" method="post" >
				  <table  id="table" style="width: 100%;">
					   <tr>
						   <th align="left" colspan="7 " style="left: 120px; border-bottom: 1px solid #e6e6e6; height: 40px; padding:10px;" >
						   <input type="button" style="cursor:pointer;" name="delete" id="delete" value="delete"  onclick="deleteCheckMsg('${map.lMode}');"> 
						<!-- 	<button type="button" style="cursor:pointer;" id="reply"  >reply</button> -->
						   <input type="button"style="cursor:pointer;"  name="locker" id="locker" value="locker" onclick="moveToLocker();"> 
						   <select  id="select" name="filter" >
									<option value="allMsg">모든 쪽지</option>
									<option value="readMsg">읽은 쪽지</option>
									<option value="noneMsg">안읽은 쪽지</option>
								<c:if test="${where eq 'yeps' }">
                              		<option value="allLocker">보관함</option>
                           		</c:if>
                           		<c:if test="${where eq 'locker' or where eq 'alert'}">
                              		<option value="msgBoxList">쪽지함</option>
                           		</c:if>
							</select> 
						    <input type="button" id="search" value="select" onclick="searching();">
						    <input type="button" id="issue" style="float: right;" data-popup-open="writeIssue" value="Report" > <br> 
						   
					        </tr>
	                        <tr align="center" >
	                            <td align="center"><input type="checkbox" style="cursor:pointer;" name="first"></td>
								<td width="90px"><label>읽음</label></td>
								<td width="100px"><label>보낸이</label></td>
								<td width="430px"><label>제목</label></td>
								<c:choose>
								   <c:when test="${mode eq 'send'}">
								       <td width="150px"><label>보낸 시각</label></td>
								   </c:when>
								   <c:when test="${mode eq 'receive'}">
									   <td width="150px"><label>받은 시각</label></td>
								   </c:when>
								</c:choose>
							</tr>
<!-- 							<tr><td colspan="7" style=" border-bottom: 1px solid #e6e6e6;"> </td></tr>  -->
						        <c:if test="${empty map.list}">
					        <tr >
								<c:choose>
                            		<c:when test="${mode eq 'send' or mode eq ''}">
                               			<td colspan="6" align="center" height="60px">보낸 쪽지가 없습니다.</td>
                            		</c:when>
                            		<c:when test="${mode eq 'receive' or mode eq 'locker'}">
                               			<td colspan="6" align="center" height="60px">받은 쪽지가 없습니다.</td>
                            		</c:when>
                        		</c:choose>

							   
						    </tr>
					            </c:if> 
					        <c:forEach var="dto" items="${map.list}">
					            <input type="hidden" id="readVal" value="readVal">
					        <tr align="center" id="list">
							    <td><input type="checkbox" style="cursor:pointer;" name="check" value="${dto.msgNum}"></td>
							    <td><c:choose>
									    <c:when test="${dto.readNum == 1}">
											<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/open.jpg">
									    </c:when>
									    <c:when test="${dto.readNum == 0}">
											<img src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/close.jpg">
									    </c:when>
								    </c:choose></td>
							    <td><a class="btn" data-popup-open="writeMessage" id="sender" name="sender" onclick="messageForm('${dto.sender}')">${dto.sender}</a>
							    <td><a class="btn" data-popup-open="popup-1"  onclick="getMessage('${dto.sender}','${dto.title}','${dto.content }','${dto.msgNum}','${map.lMode}');">${dto.title}</a></td>
						        <td><label>${dto.reg_date}</label></td>
						     </tr>
					         </c:forEach>
					     </table>
					  </form> 
					   <div class="yeps_message_section" style="font-size: 14px; ">
	                      <div class="yeps_message_pagination_block">
	                          <div class="yeps_message_pagination_wrap">
	                              <div class="yeps_message_page_of_pages" >
	                                  <c:if test="${map.yepsPager.blockEnd == 0}">
	                                      Page ${map.yepsPager.curPage} of 1
	                                  </c:if>
	                                  <c:if test="${map.yepsPager.blockEnd != 0}">
	                                      Page ${map.yepsPager.curPage} of ${map.yepsPager.blockEnd}
	                                  </c:if>
	                             </div>
	                     <!--  페이징 처리!! 현재페이지는 span이 되고 나머지는 a로    -->
	                         <c:if test="${map.yepsPager.blockEnd != 1}">
	                             <div class="yeps_message_page_link_wrapper" style="text-align: right;">
	                                 <div class="yeps_message_page_link_wrap">
	                                     <c:if test="${map.yepsPager.curBlock > 1}">
	                                         <div class="yeps_message_next_block">
	                                             <a class="yeps_message_next_block_action" href="javascript:list('1')">
	                                                 <span>Start</span>
	                                             </a>
	                                         </div>
	                                     </c:if>
	                                 <c:if test="${map.yepsPager.curBlock > 1}">
	                                     <div class="yeps_message_next_block">
	                                         <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.prevPage}','${map.lMode}')">
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
	                                        <div class="yeps_message_page_link_option">
		                                        <c:choose>
		                                            <c:when test="${num == map.yepsPager.curPage}">
		                                                <span class="yeps_message_page_option_action">
		                                                    ${num}
		                                                </span>
		                                            </c:when>
		                                            <c:otherwise>
		                                                <a href="javascript:list('${num}','${map.lMode}')" class="yeps_message_page_option_link_action">
		                                                    ${num}
		                                                </a>
		                                            </c:otherwise>
		                                        </c:choose>
		                                    </div>
	                                    </c:forEach>
	                                <c:if test="${map.yepsPager.curBlock <= map.yepsPager.totBlock}">
	                                    <div class="yeps_message_next_block">
	                                        <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.nextPage}','${map.lMode}')">
	                                            <span>Next</span>
	                                            <span style="width: 24px; height: 24px; fill: currentColor;" class="icon">
	                                                <svg class="icon_svg">
	                                                    <path d="M9.525 5.636L8.11 7.05 13.06 12l-4.95 4.95 1.415 1.414L15.89 12 9.524 5.636z"></path>
	                                                </svg>
	                                            </span>
	                                        </a>
	                                    </div>
	                                </c:if>
	                            <c:if test="${map.yepsPager.curPage <= map.yepsPager.totPage}">
	                                <div class="yeps_message_next_block" style="display: inline-block;">
	                                    <a class="yeps_message_next_block_action" href="javascript:list('${map.yepsPager.totPage}','${map.lMode}')">
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
	<script>
	
	
	
	$("#replyMessage").click(function(){
		
		 var receiver = $('#view_from').val();
		 var msgnum = $('#view_msgnum').val();
		 var lMode = $('#pageMode').val();
			
		 $("#sendformTo").val(receiver);
		 
		 var url = "message_read?msgnum=" + msgnum + "&lMode=" + lMode ;
	     window.location = url;
		
	}); 
	
 	$('#message_popup_Issue_submit_button').click(function(){
 	    var report = $('#issueValue').val();
 	    document.sendIssueform.action = "message_send?report=" + report + "&where=msgbox";
 	    document.sendIssueform.submit();
	});
	
    function list(page,lMode){
        location.href="yeps_message?curPage=" + page + "&lMode=" + lMode;
    }
    
    function messageForm(sender){
    	$('#sendformTo').empty();
    	var sender = sender;
    	$('#sendformTo').val(sender);
    }
    
    function getMessage(sender,subject,message,msgnum,lmode){
    	 var msgnum = msgnum;
    	 var sender = sender;
    	 var subject = subject;
    	 var message = message;
    	 var lmode = lmode;
    	 $('#pageMode').val(lmode)
    	 $('#view_msgnum').val(msgnum) 
    	 $('#view_from').val(sender);
         $('#subject').val(subject);
         $('#message').val(message);
    }   

   $('#message_popup_submit_button').click(function(){
    	
    	if($('#sendformTo').val()==''){
    	alert("받는 사람을 입력해주세요");
    	$('#sendformTo').focus()
    	return false;
    	
    	}else if($('#sendformSubject').val()==''){
    	alert("제목를 입력해주세요");
    	$('#sendformSubject').focus()
    	return false;
    	
    	}else if($('#sendformMessage').val()==''){
    	alert("내용을 입력해주세요");
    	$('#sendformMessage').focus()
    	return false;
    	}
        document.sendform.action = "message_send";
        document.sendform.submit(); 
    });
    
    function searching(){
	   var selectValue = $("select[name=filter]").val();
	    if(selectValue ==0){
	    	alert("검색키를 선택하세요.");
	        msgform.filter.focus()
	        return false
	    }
	    document.msgform.action = "message_action";
	    document.msgform.submit();
    }

    function readCheck(){
    	var lMode = $('#pageMode').val();
    	var msgnum = $('#view_msgnum').val();
    	var url = "message_read?msgnum=" + msgnum + "&lMode=" + lMode ;
        window.location = url;
    }
    
    function deleteMsg(lMode){
    	var msgnum = $('#readCheck').val();
    	var lMode = lMode;
    	var url = "message_delete?msgNum=" + msgnum + "&lMode=" + lMode;
        window.location = url;
    }
	  
    function deleteCheckMsg(lMode) {
    	$("input[name=check]:checked").each(function() {
			var checkVal = $(this).val();
			var lMode = lMode;
	    for (var i = 0; i < checkVal.length; i++) {
		         if (checkVal[i].checked) {
		            txt += checkVal[i].value + " ";
	    }}});
    	document.msgform.action = "message_delete?lMode="+ lMode;
    	document.msgform.submit();
		}
    
    function moveToLocker(){
    	$("input[name=check]:checked").each(function() {
			var checkVal = $(this).val();
			
		for (var i = 0; i < checkVal.length; i++) {
		         if (checkVal[i].checked) {
		            txt += checkVal[i].value + " ";
	    }}});
    	document.msgform.action = "message_moveToLocker";
    	document.msgform.submit();
    }

    $(document).ready(function() {
		var tbl = $("#table");
		// 테이블 헤더에 있는 checkbox 클릭시
		$(":checkbox:first", tbl).click(function() {
		    // 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
			if ($(this).is(":checked")) {
				$(":checkbox", tbl).attr("checked", "checked");
			} else {
				$(":checkbox", tbl).removeAttr("checked");
			}
			// 모든 체크박스에 change 이벤트 발생시키기               
			    $(":checkbox", tbl).trigger("change");
			});

			// 헤더에 있는 체크박스외 다른 체크박스 클릭시
			$(":checkbox:not(:first)", tbl).click(function() {
				var allCnt = $(":checkbox:not(:first)",tbl).length;
				var checkedCnt = $(":checkbox:not(:first)",tbl).filter(":checked").length;

				// 전체 체크박스 갯수와 현재 체크된 체크박스 갯수를 비교해서 헤더에 있는 체크박스 체크할지 말지 판단
				if (allCnt == checkedCnt) {
					$(":checkbox:first", tbl).attr("checked", "checked");
				} else {
					$(":checkbox:first", tbl).removeAttr("checked");
					
				}}).change(function() {
				if ($(this).is(":checked")) {
					
				// 체크박스의  부모 > 부모니까  tr이 되고 tr에  selected 라는  class 를 추가한다.
					$(this).parent().parent().addClass("selected");
				} else {
					$(this).parent().parent().removeClass("selected");
				}
			});
		});
    
    $('#delete').hover(function() {
    	$('#delete').css('background', 'red');
    })
    $('#delete').mouseleave(function() {
    	$('#delete').css('background', '#d32323');
    })
    
    jQuery.noConflict();
    $(function() {
          //----- OPEN
          $('[data-popup-open]').on('click', function(e)  {
              var targeted_popup_class = jQuery(this).attr('data-popup-open');
              $('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
           e.preventDefault();
           e.stopPropagation();
          });
    
          //----- CLOSE
          $('[data-popup-close]').on('click', function(e)  {
              var targeted_popup_class = jQuery(this).attr('data-popup-close');
              $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);
              $('#subject').empty();
              $('#from').empty(); 
              $('#message').empty();
              $('#sendformTo').empty();
              e.preventDefault();
              e.stopPropagation();
          });
      });
    
</script>
<%@ include file="../bottom.jsp"%>
