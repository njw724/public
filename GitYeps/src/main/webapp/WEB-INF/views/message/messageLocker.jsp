<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Message Locker</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
</head>
<c:if test="${not empty requestScope.msg}">
	<script type="text/javascript">
		alert("${requestScope.msg}")
	</script>
</c:if>
<body>
<%-- <%@ include file="../top.jsp"%> --%>
   <div id="lockerContainer" style="height:80%;" >
		<caption>
			<h1 align="center" style="font-family: consolas; color: #d32323;">yeps Message</h1>
		</caption>
		<hr color="green" width="70%">
		<br>
		<div align="center" id="menu" >
			<h3 align="center">Menu</h3>
			<br>  <div class="btn group" align="left">
		<button class="btn btn-danger" data-target="#sendform" data-toggle="modal" id="write">쪽지쓰기</button>
		<button class="btn btn-default" data-target="#sendform" data-toggle="modal" data-receiver="Me" id="writeToMe">내게쓰기</button>
		</div><br><br> 
			<div align="center" id="tag">
				<a href="message_action?filter=receive"><label>받은 쪽지 </label></a><a href="#"><label>:: ${map.count}</label></a><br> <br> 
				<a href="message_action?filter=send"><label>보낸 쪽지 </label></a><a href="#"><label>:: ${sCount}</label></a><br> <br> 
				<a href="message_action?filter=msgBox"><label>쪽지함 </label></a><a href="#"><label>:: ${mCount}</label></a><br> <br> 
			</div>
		</div>
		 <div class="modal fade" id="sendform" >
               <div class="modal-dialog">
                  <div class="modal-content">
                   <!-- header -->
                   <div class="modal-header">
                     <!-- 닫기(x) 버튼 -->
                     <button type="button" class="close" data-dismiss="modal">×</button>
                     <!-- header title -->
                     <h3 class="modal-receiver" align="left">To</h3>
                     <input type="text" style="width: 100%; height: 40; border-radius: 7px; font-family: consolas; font-weight: bold; font-size: 22px;" name="receiver" id="receiver">  
                   </div>
                   <!-- body -->
                   <div class="modal-body">
                       <h3 align="left">Subject</h3><br>
                       <input type="text" style="width: 100%; height: 40; border-radius: 7px; font-family: consolas; font-weight: bold; font-size: 22px;"name="title" id="title"> 
                   </div>
                   <!-- Footer -->
                   <div class="modal-footer" align="left">
                    <h3 align="left" style="font-weitht: bold;">Message</h3>
                    <textarea style="width: 100%; border-radius: 7px; font-size:20px;" cols="100%"
									rows="5" name="content" id="content" placeholder=" 여기에 내용을 입력하세요."></textarea>
								<br><br>
				    <button type="button" class="btn btn-danger" onclick="sendMsg()">SendMessage</button>
				    <button type="reset" name="cancel" value="cancel" style="background: #00ff0000; border: 0;">cancel</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                   </div>
                  </div>
                 </div>
                </div>
                <div class="modal fade" id="messageView" >
               <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h3 style="font-family: consolas; font-weight: bold; font-size: 26px; color: #d32323;" >from</h3>
					<label id="sender" style="font-family: consolas; font-weight: bold; font-size: 22px; color:#000000;" ></label>
                    </div>
                  <div class="modal-body">
                   <h3 style="font-family: consolas; font-weight: bold; font-size: 26px; color: #d32323;" >subject</h3><br>
                   <h4 style="font-family: consolas; font-weight: bold; font-size: 23px; color:#000000;"></h4>   
                   </div>
                  <div class="modal-footer">
                    <h3 align="left" style="font-weitht: bold; font-size: 26px; font-family: consolas;">Message</h3>
                    <textarea style="width: 100%; border-radius: 9px; font-weitht: bold; font-size: 22px; color:000000; font-family: consolas;" 
                    cols="100%" rows="6" name="content"  disabled >여기로 내용을 불러온다.</textarea><br><br>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" style="background: #00ff0000; border: 0; color:000000;">close</button>
                  </div>
                 </div>
                </div>
               </div>
		<br><br>
		<div id="messageList"  align="left" style="height: 60%; width: 70%; float: left;  padding:1;">
			<form name="lockerform" id="lockerform" method="post">
				<table border="0" id="table">
					<tr valign="middle">
						<td width="60px" align="center" rowspan="3" valign="middle"><br> 
						<input type="checkbox" name="first"></td>
						<th align="left" colspan="6">
						<input type="button" name="del" value="삭제" style="color: #ffffff; background: #d32323; border-radius: 5px; font-weight: bold; font-family: consolas;" onclick="deleteMsg();"> 
						<input type="button" name="reply" id="reply" value="답장" style="color: #ffffff; background: #d32323; border-radius: 5px; font-weight: bold; font-family: consolas;" > 
						<input type="button" name="locker" value="쪽지함" style="color: #ffffff; background: #d32323; border-radius: 5px; font-weight: bold; font-family: consolas;" onclick="lockerToMsgBox();"> 
						<select name="filter" style="border-radius: 4px;">
								<option value="0">:: 필터 ::</option>
								<option value="allMsgl">모든 쪽지</option>
								<option value="noneMsgl">안읽은 쪽지</option>
								<option value="msgBox">쪽지함</option>
						</select> 
						<input type="button" id="search" value="검색" style="color: #ffffff; background: #d32323; border-radius: 5px; font-weight: bold; font-family: consolas;" onclick="searching();"> 
				    </tr>
				<tr><td><br></tr>
                    <tr align="center">
						<td width="60px"><label>읽음</label></td>
						<td width="60px"><label>번호</label></td>
						<td width="60px"><label>보낸이</label></td>
						<td width="500px"><label>제목</label></td>
						<th width="120px"><label>받은시각</label></th>
					</tr>
					<c:if test="${empty map.list}">
						<tr>
							<td colspan="6" align="center">보관함이 비었습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="dto" items="${map.list}">
						<tr align="center" id="list">
							<td><input type="checkbox" name="check" value="${dto.msgNum}"></td>
							<td><c:choose>
									<c:when test="${dto.readNum == 1}">
										<label><input type="image" src="resources/img/open.jpg" name="read" value="${dto.msgNum}" onclick="readMessage();"></label>
									</c:when>
									<c:when test="${dto.readNum == 0}">
										<label><input type="image" src="resources/img/close.jpg" name="read" value="${dto.msgNum}" onclick="readMessage();"></label>
									</c:when>
								</c:choose></td>
						<td style="font-weight: bold;" >	
							<c:set var="num" value="${num-1}"/>
				            <c:out value="${num}"/></td>
							<td><button type="button" name="sender" value="${dto.sender}" class="btn btn-default" data-target="#sendform" data-toggle="modal" data-receiver="${dto.sender}"
						    style="background: #00ff0000; border: 0; font-weight: bold; font-family: consolas; color:#0073bb; font-size:17px;" >${dto.sender}</button>
						    <td><button type="button" name="title" value="${dto.msgNum}" class="btn btn-default" data-target="#messageView" data-toggle="modal" 
						    data-title="${dto.title}" data-sender="${dto.sender}" data-content="${dto.content}"
						    style="background: #00ff0000; border: 0; font-weight: bold; font-family: consolas; color:#0073bb; font-size:17px;" onclick="readCheck('${dto.msgNum}')" >${dto.title}</button></td>
							<td><label>${dto.reg_date}</label></td>
						</tr>
					</c:forEach>
						<tr>
					<td colspan="7" align="center">
                <c:if test="${map.yepsPager.curBlock > 1}">
                    <a href="javascript:list('${map.yepsPager.prevPage}')">[이전]</a>
                </c:if>
                <c:forEach var="num" begin="${map.yepsPager.blockBegin}" end="${map.yepsPager.blockEnd}">
                    <c:choose>
                        <c:when test="${num == map.yepsPager.curPage}">
                            <span style="color: red">  [${num}]  </span>&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:list('${num}')">  [${num}] </a>&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.yepsPager.curBlock <= map.yepsPager.totBlock}">
                    <a href="javascript:list('${map.yepsPager.nextPage}')">[다음]</a>
                </c:if>
				</table>
			<br>
			</form>
		</div>
		<br>
	</div>
    <script>
	function list(page){
	        location.href="yeps_message?curPage=" + page;
	    }

	 jQuery.noConflict();
	    $('#sendform').on('show.bs.modal', function (event) {
	    	var button = $(event.relatedTarget); // Button that triggered the modal
	    	var receiver = button.data('receiver'); // Extract info from data-* attributes
	    	var modal = $(this);
	    	modal.find('.modal-header input').val("  " + receiver);
	    	});

	    $('#messageView').on('show.bs.modal', function (event) { //  윈도우가 오픈할때 아래의 옵션을 적용
	         var button = $(event.relatedTarget) // 모달 윈도우를 오픈하는 버튼
	         var content = $(this).button.data('content') // 버튼에서 data-contnet 값을 content 변수에 저장
	         var sender = button.data('sender')
	         var title = button.data('title')
	         var modal = $(this)
	         modal.find('.modal-footer textarea').val('Content : ' + content) // 모달위도우에서 .modal-footer에 textarea를  찾아 content 값을 넣어줌
	         modal.find('.modal-header #sender').text('  ' + sender)
	         modal.find('.modal-body h4').text(' ' + title)
	    
	     })
	     
	function sendMsg(){
    	if($('#receiver').val()==''){
    	alert("받는 사람을 입력해주세요");
    	$('#receiver').focus()
    	return false;
    	
    	}else if($('#title').val()==''){
    	alert("제목를 입력해주세요");
    	$('#title').focus()
    	return false;
    	
    	}else if($('#content').val()==''){
    	alert("내용을 입력해주세요");
    	$('#content').focus()
    	return false;
    	}
        document.msgform.action = "message_send";
        document.msgform.submit();
    } 
	
	function searching() {
		var value1 = $("select[name=filter]").val();
		if (value1 == 0) {
			alert("검색키를 선택하세요.");
			lockerform.filter.focus()
			return false
		}
		document.lockerform.action = "message_search";
		document.lockerform.submit();
	}

	function readMessage() {
		document.lockerform.action = "message_readLocker";
		document.lockerform.submit();
	}
	
	 function readCheck(msgnum){
	        var msgnum = msgnum;
	    	var url = "message_read?title=" + msgnum ;
	    	alert(msgnum)
	        window.location = url;
	    }

	function lockerToMsgBox() {
		$("input[name=check]:checked").each(function() {
			var checkVal = $(this).val();
			alert(checkVal);
			for (var i = 0; i < checkVal.length; i++) {
				if (checkVal[i].checked) {
					txt += checkVal[i].value + " ";
				}
			}
			document.lockerform.action = "message_lockerToMsgBox";
			document.lockerform.submit();
		});
	}

	function deleteMsg() {
		$("input[name=check]:checked").each(function() {
			var checkVal = $(this).val();
			alert(checkVal);
			for (var i = 0; i < checkVal.length; i++) {
				if (checkVal[i].checked) {
					txt += checkVal[i].value + " ";
				}
			}
		});
		document.lockerform.action = "message_delete";
		document.lockerform.submit()
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
				} else {$(this).parent().parent().removeClass("selected");
				}
			});
		});
	</script>
<%@ include file="../bottom.jsp"%>

