<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Message Locker</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/message.css"/>"/>
 	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css"/>"/>
	<script src="//code.jquery.com/jquery.min.js"></script>
</head>
<c:if test="${not empty requestScope.msg}">
	<script type="text/javascript">
		alert("${requestScope.msg}")
	</script>
</c:if>
<%@ include file="../top.jsp"%>
<!-- Message sendform -->
<div class="popup" align="left" id="alert_writeMessage" data-popup="alert_writeMessage" style="z-index: 1;">
<form name="sendAlertform" method="post">
    <div class="popup-inner">
        <h4 align="left" style="color: #d32323;">Send Message To</h4>
        <input type="text" id="alert_sendformTo" name="receiver"><br>
        <h4 align="left" style="color: #d32323;">Subject is</h4>
        <input type="text" name="title" id="alert_sendformSubject" ><br>
        <h4 align="left" style="color: #d32323;">Content is</h4>
        <textarea rows="4" name="content" id="alert_sendformMessage"  placeholder="여기에 메시지를 입력하세요."></textarea><br><br>
        <button class="popup-send" type="button" id="alert_sendMessage" data-popup-send="alert_SendMessage" >SendMessage </button>&nbsp;&nbsp;&nbsp;
        <a data-popup-close="alert_writeMessage" style="cursor:pointer;" href="#" >  Close</a>
		<a class="popup-close" data-popup-close="alert_writeMessage" href="#" >x</a>
    </div>
 </form>
 </div> 
 <!-- Message View  -->
 <div class="popup" align="left" id="alert_popup" data-popup="popup-1" style="z-index: 1;">
    <div class="popup-inner">
        <h4 align="left" style="color: #d32323;" >Message From</h4>
           <input type="text" id="from" readOnly>
        <h4 align="left" style="color: #d32323;">Subject is</h4>
           <input type="text" id="subject" readOnly>
        <h4 align="left" style="color: #d32323;">Content is</h4>
           <textarea id="message" rows="4" readOnly></textarea>
            <button class="alert_popup-reply" id="alert_replyMessage" type="button" data-popup-close="popup-1" data-popup-open="alert_writeMessage" style="cursor:pointer;">reply </button>&nbsp;
           <a data-popup-close="alert_popup-1" href="#" onclick="readCheck('${map.lMode}');">Close</a>&nbsp;
           <input type="hidden" id="readCheck" > 
             <button class="alert_popup-delete" id="alert_deleteMessage" type="button" data-popup-close="popup-1" style="cursor:pointer;" onclick="deleteMsg('${map.lMode}');">delete </button>&nbsp;
           <a class="popup-close" data-popup-close="popup-1" href="#" onclick="readCheck('${map.lMode}');">x</a>
    </div>
 </div> 
 <div id="alertContainer" style="height: 80% ; position: relative; top: 30px; min-width: 800px; margin: 0 auto; padding: 0px; width: 900px" >
	 <div id="alert_messageHeader">
	     <label>Issues</label>
	 	 <input type="button" id="write" value="Write new Message" data-popup-open="alert_writeMessage" onclick="messageForm();">
	 </div>
	 <div id="alert_menu">	
		 <a href="message_action?filter=allLocker"><label style="cursor:pointer;">locker</label></a><label>: ${lCount}</label>
		 <a href="message_action?filter=sender"><label style="cursor:pointer;">Sent </label></a><label>: ${sCount}</label>
		 <a href="message_action?filter=msgBoxList"><label style="cursor:pointer;">msgBox </label></a><label>: ${mCount}</label>
		 <label style="float:right;"> :${aCount} </label><a href="message_alert"><label style="cursor:pointer; float:right;">alertBox</label></a>
	 </div>
	 <div id="alert_messageList" style="position:absolute; " >
		 <form name="alertform"  method="post">
			 <table  id="table" style="width: 100%;">
				 <tr>
					 <th align="left" colspan="7 " style="left: 120px; border-bottom: 1px solid #e6e6e6; height: 40px; padding: 10px;" >
					    <input type="button" name="del" id="delete" value="delete" style="cursor:pointer;" onclick="deleteCheckMsg();"> 
					    <select id="select" name="filter" >
							<option value="0"></option>
							<option value="alertMsg">모든 쪽지</option>
							<option value="readAlert">읽은 쪽지</option>
							<option value="noneAlert">안읽은 쪽지</option>
					    </select> 
					    <input type="button" id="search" value="select" style="cursor:pointer;" onclick="searching();"> <br>  
				 </tr>
			     <tr align="center"  >
	                     <td align="center"><input type="checkbox" style="cursor:pointer;" name="first"></td>
						 <td width="90px"><label>읽음</label></td>
						 <td width="90px"><label>번호</label></td>
						 <td width="100px"><label>보낸이</label></td>
						 <td width="430px"><label>제목</label></td>
						 <td width="150px"><label>받은시각</label></th>
				 </tr>
				 <tr><td colspan="7" style=" border-bottom: 1px solid #e6e6e6;"> </td></tr> 
				    <c:if test="${empty map.list}">
			           <tr>
						  <td colspan="6" align="center" valign="middle" height="60px" style="font-size:21px;">there is <span style="color:#00FEFE; font-size:23px;">no issue</span> now.</td>
					   </tr>
				    </c:if>
				 <c:forEach var="dto" items="${map.list}">
					 <tr align="center" id="list">
							 <td><input type="checkbox" name="check" value="${dto.msgNum}"></td>
							 <td>
							 <c:choose>
									 <c:when test="${dto.readNum == 1}">
									 	<label><input type="image" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/open.jpg" name="read" value="${dto.msgNum}" onclick="readMessage('${map.lMode}');"></label>
									 </c:when>
									 <c:when test="${dto.readNum == 0}">
										<label><input type="image" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/close.jpg" name="read" value="${dto.msgNum}" onclick="readMessage('${map.lMode}');"></label>
									 </c:when>
							   </c:choose></td>
						       <td style="font-weight: bold;" >	
							      <c:set var="num" value="${num-1}"/>
				                  <c:out value="${num}"/></td>
							   <td><a data-popup-open="alert_writeMessage" id="sender"  onclick="messageForm('${dto.sender}')">${dto.sender}</a>
						       <td><a class="btn" data-popup-open="popup-1" onclick="getMessage('${dto.sender}','${dto.title}','${dto.content }','${dto.msgNum}');">${dto.title}</a></td>
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
						                <div class="yeps_message_page_link_wrapper">
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
						       <div class="yeps_message_next_block">
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
<script>
	
	function list(page,lMode){
	        location.href="yeps_message?curPage=" + page + "&lMode=" + lMode;
	    }
    
    function messageForm(sender){
    	$('#alert_sendformTo').empty();
    	var sender = sender;
    	$('#alert_sendformTo').val(sender);
    }
    
    function getMessage(sender,subject,message,msgnum){
   	 var msgnum = msgnum;
   	 var sender = sender;
   	 var subject = subject;
   	 var message = message;
   	 $('#readCheck').val(msgnum) 
   	 $('#from').val(sender);
     $('#subject').val(subject);
     $('#message').val(message);
   }   
    
    $('#alert_replyMessage').click(function(){
    	var receiver = $('#from').val();
    	$('#alert_sendformTo').val(receiver);
    })

	 jQuery.noConflict();	     
	
    $('#alert_sendMessage').click(function(){
    	if($('#alert_sendformTo').val()==''){
    	alert("받는 사람을 입력해주세요");
    	$('#sendformTo').focus()
    	return false;
    	
    	}else if($('#alert_sendformSubject').val()==''){
    	alert("제목를 입력해주세요");
    	$('#sendformSubject').focus()
    	return false;
    	
    	}else if($('#alert_sendformMessage').val()==''){
    	alert("내용을 입력해주세요");
    	$('#sendformMessage').focus()
    	return false;
    	}
        document.sendAlertform.action = "message_send";
        document.sendAlertform.submit();
    });
	
	function searching() {
		var value1 = $("select[name=filter]").val();
		if (value1 == 0) {
			alert("검색키를 선택하세요.");
			alertform.filter.focus()
			return false
		}
		document.alertform.action = "message_action";
		document.alertform.submit();
	}

	function readMessage(lMode) {
		document.alertform.action = "message_read?lMode=" + lMode;
		document.alertform.submit();
	}
	
	 function readCheck(lMode){
	    	var msgnum = $('#readCheck').val();
	    	var url = "message_read?msgnum=" + msgnum +"&lMode=" + lMode;
	        window.location = url;
	    }

	function deleteCheckMsg(lMode) {
		$("input[name=check]:checked").each(function() {
			var checkVal = $(this).val();
			var lMode = lMode;
			alert(checkVal);
			for (var i = 0; i < checkVal.length; i++) {
				if (checkVal[i].checked) {
					txt += checkVal[i].value + " ";
				}
			}
		});
		document.alertform.action = "message_delete?lMode="+ lMode;
		document.alertform.submit()
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
             e.preventDefault();
             e.stopPropagation();
         });
     });
	</script>
<%@ include file="../bottom.jsp"%>

