<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var week = new Array("mon","tue","wed","thu","fri","sat","sun")
var day = new Array("월요일","화요일","수요일","목요일","금요일","토요일","일요일");

// 한글 입력 방지
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
function busy_changeTime(){
	var s = document.getElementById("busy-hour-start")
	var start = s.selectedIndex;
	var e = document.getElementById("busy-hour-end")
	var j = 1
	var i = 0
	var a=parseInt(s.options[s.selectedIndex].value);
	var b=parseInt(e.options[e.selectedIndex].value);
	var c=e.options[e.selectedIndex].value
	
	if(a>=b){
		e.options.length = 0
		for (i = start; i < s.length - 1; i++) {
			var option = document.createElement('option');
			option.text = s.options[i+1].text;
			option.value = s.options[i+1].value;
			e.add(option);
		}
		for (var i = 1; i < 16; i++) {
			var option = document.createElement('option');
			option.text = s.options[j++].text + "(익일)"
			option.value = 23.5 + (0.5 * i)
			e.add(option);
		}
	}else{
		e.options.length = 0
		for (i = start; i < s.length - 1; i++) {
			var option = document.createElement('option');
			option.text = s.options[i+1].text;
			option.value = s.options[i+1].value;
			e.add(option);
		}
		for (var i = 1; i < 16; i++) {
			var option = document.createElement('option');
			option.text = s.options[j++].text + "(익일)"
			option.value = 23.5 + (0.5 * i)
			e.add(option);
		}
		for(var i=0;i<e.length;i++){
			if(c==e.options[i].value){
				document.getElementById("hour-end").options[i].selected = 'selected';
				break;
			}
		}
		if(s.options[s.selectedIndex].value=='없음'){
			e.options.length = 0
			var option = document.createElement('option');
			option.text = "";
			option.value = "";
			e.add(option);
			document.getElementById("busy-hour-end").style.display="none";
		}else{
			document.getElementById("busy-hour-end").style.display="inline-block";
		}
	}
}

function hour_changeTime(){
	var s = document.getElementById("hour-start")
	var start = s.selectedIndex;
	var e = document.getElementById("hour-end")
	var j = 1
	var i = 0
	var a=parseInt(s.options[s.selectedIndex].value);
	var b=parseInt(e.options[e.selectedIndex].value);
	var c=e.options[e.selectedIndex].value
	
	if(a>=b){
		e.options.length = 0
		for (i = start; i < s.length - 1; i++) {
			var option = document.createElement('option');
			option.text = s.options[i+1].text;
			option.value = s.options[i+1].value;
			e.add(option);
		}
		for (var i = 1; i < 16; i++) {
			var option = document.createElement('option');
			option.text = s.options[j++].text + "(익일)"
			option.value = 23.5 + (0.5 * i)
			e.add(option);
		}
	}else{
		e.options.length = 0
		for (i = start; i < s.length - 1; i++) {
			var option = document.createElement('option');
			option.text = s.options[i+1].text;
			option.value = s.options[i+1].value;
			e.add(option);
		}
		for (var i = 1; i < 16; i++) {
			var option = document.createElement('option');
			option.text = s.options[j++].text + "(익일)"
			option.value = 23.5 + (0.5 * i)
			e.add(option);
		}
		for(var i=0;i<e.length;i++){
			if(c==e.options[i].value){
				document.getElementById("hour-end").options[i].selected = 'selected';
				break;
			}
		}
		if(s.options[s.selectedIndex].value=='익일'){
			e.options.length = 0
			var option = document.createElement('option');
			option.text = "";
			option.value = "";
			e.add(option);
			document.getElementById("hour-end").style.display="none";
		}else{
			document.getElementById("hour-end").style.display="inline-block";
		}
	}
}

function busy_add() {
	var div = document.createElement("DIV");
	var span = document.createElement("SPAN");
	var d = document.getElementById("busy-day")
	var day2 = d.options[d.selectedIndex].value;
	var s = document.getElementById("busy-hour-start")
	var start = s.options[s.selectedIndex].text;
	var e = document.getElementById("busy-hour-end")
	var end = e.options[e.selectedIndex].text;
	var parent = document.getElementById("busy-display");
	
	if(parent.childNodes.length>6){
		return false;
	}

	for(var i=1;i<parent.childNodes.length;i++){
		if(parent.childNodes[i].id=="busy"+week[day2]){
			return false;
		}
	}
	
	if (day2 > 5) {
		document.getElementById("busy-day").value = -1
	}
	document.getElementById("busy-day").value = d.options[d.selectedIndex + 1].value;
	
	div.setAttribute("id", "busy"+week[day2]);
	div.setAttribute("class","restInsert-hours");
	
	if(s.options[s.selectedIndex].value=='없음'){
		document.getElementById("busy-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+"없음"+
		"<a style='margin-left: 6px;' href='#' onclick='remove2("+day2+")'>삭제</a>" 
		document.getElementsByName("busytime").value="없음";
	}else{
		document.getElementById("busy-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+
		"<span>"+start+"</span>"+"<span>"+"&nbsp-&nbsp"+"</span>"+"<span>"+end+"&nbsp"+"</span>"+
		"<a href='#' onclick='remove2("+day2+")'>삭제</a>"
		document.getElementsByName("busytime").value=start +"&nbsp"+end;
	}
}

function hour_add() {
	var div = document.createElement("DIV");
	var span = document.createElement("SPAN");
	var d = document.getElementById("day")
	var day2 = d.options[d.selectedIndex].value;
	var s = document.getElementById("hour-start")
	var start = s.options[s.selectedIndex].text;
	var e = document.getElementById("hour-end")
	var end = e.options[e.selectedIndex].text;
	var parent = document.getElementById("hours-display");
	
	if(parent.childNodes.length>7){
		return false;
	}

	for(var i=1;i<parent.childNodes.length;i++){
		if(parent.childNodes[i].id==week[day2]){
			return false;
		}
	}
	
	if (day2 > 5) {
		document.getElementById("day").value = -1
	}
	document.getElementById("day").value = d.options[d.selectedIndex + 1].value;
	
	div.setAttribute("id", week[day2]);
	div.setAttribute("class","restInsert-hours");
	
	if(s.options[s.selectedIndex].value=='익일'){
		document.getElementById("hours-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+"익일"+
		"<a style='margin-left: 6px;' href='#' onclick='remove("+day2+")'>삭제</a>" +
		"<input type='hidden' name='"+week[day2]+"' value='익일'/>";
	}else{
		document.getElementById("hours-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+
		"<span>"+start+"</span>"+"<span>"+"&nbsp-&nbsp"+"</span>"+"<span>"+end+"&nbsp"+"</span>"+
		"<a href='#' onclick='remove("+day2+")'>삭제</a>" +
		"<input type='hidden' name='"+week[day2]+"' value='"+start+" "+end+"'/>";
	}
}

function remove(obj) {
	var parent = document.getElementById("hours-display");
	var child = document.getElementById(week[obj]);
// 	var scrolly=$(window).scrollTop();
	parent.removeChild(child);
}
function remove2(obj) {
	var parent = document.getElementById("busy-display");
	var child = document.getElementById("busy"+week[obj]);
// 	var scrolly=$(window).scrollTop();
	parent.removeChild(child);
}


function goPopup() {
	var pop = window.open("jusoPopup", "도로명 주소","width=570,height=420, scrollbars=yes, resizable=yes");
}

function jusoCallBack(roadAddrPart1, addrDetail, roadAddrPart2, zipNo) {
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다
	document.restForm.roadAddrPart1.value = roadAddrPart1;
	document.restForm.roadAddrPart2.value = roadAddrPart2;
	document.restForm.addrDetail.value = addrDetail;
	document.restForm.zipNo.value = zipNo;
	
	document.getElementById("roadAddrPart1").style.display="block";
	document.getElementById("roadAddrPart1-label").style.display="inline-block";
	
	document.getElementById("addrDetail").style.display="block";
	document.getElementById("addrDetail-label").style.display="inline-block";
	
	document.getElementById("roadAddrPart2").style.display="block";
	document.getElementById("roadAddrPart2-label").style.display="inline-block";
	
}

function test() {
	var reststyle=new Array();
	var reststyle_name = document.getElementsByName("reststyle");
	for (var i = 0; i < reststyle_name.length; i++) {
		if (reststyle_name[i].checked) {
			reststyle.push(reststyle_name[i].value)
			alert(reststyle[i])
		}
	}
	document.getElementById("reststyle").value = reststyle.join(',')

	var alcohol=new Array();
	var alcohol_name = document.getElementsByName("alcohol");
	for (var i = 0; i < alcohol_name.length; i++) {
		if (alcohol_name[i].checked) {
			alcohol.push(alcohol_name[i].value)
		}
	}
	document.getElementById("alcohol").value =alcohol.join(',')
	
	alert("실행")
	return true;
}
</script>
<html>
<head>
<script src="resources/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=1"/>"/>
<link href="resources/styles/magic-check.css" rel="stylesheet">

	<title>가게 등록</title>
</head>
<%@include file="../top.jsp" %>
	<div class="restInsert-main" style="width: auto;padding: 0;margin: 0;">
		<div class="restInsert-content-container" style="padding:15px 15px 36px 15px; width: 960px;height:100%;margin: 0 auto; display: table;">
			<div class="restInsert-container" style="width:960px;height:100%;display:block;">
				<div class="restInsert-layout-full" style="width:990px;height:100%;margin:0px -15px;display:block;">
					<div class="restInsert-alpha" style="width:50%;height:100%;float: left;padding: 0 15px;display:inline-block;">

						<h2 style="word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;
						font-weight: bold;margin-bottom: 6px;font-size: 26px;line-height: 1.28571em;color: #d32323;">가게 등록</h2>
							<form name="restForm" id="restForm" enctype="multipart/form-data" method="post" action="restaurant_insert" onsubmit="return test();"
							style="margin-bottom: 18px;display: block;width:100%;height:100%;">
								<ul style="list-style:none;">
									<li class="restInsert-list">
										<label for="attr_BusinessName" class="restInsert-label-bold">가게 이름</label>
										<input class="restInsert-input" id="" name="rname" placeholder="가게 이름을 입력해주세요" type="text" value="지원의 집">	
									</li>
									<li class="restInsert-list">
										<label for="rest_filename" class="restInsert-label-bold">레스토랑 사진</label>
										<input class="restInsert-input" id="rest_filename" name="rest_filename" placeholder="클릭!!" type="text" value="" onclick="">
									</li>
									<li class="restInsert-list">
										<label for="zipNo" class="restInsert-label-bold">우편번호</label>
										<input class="restInsert-input" id="" name="zipNo" placeholder="" type="text" value="21100" onclick="goPopup();" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="roadAddrPart1-label" for="roadAddrPart1" class="restInsert-label-bold" style="display:none;">도로명 주소</label>
										<input class="restInsert-input" id="roadAddrPart1" name="roadAddrPart1" placeholder="" type="text" value="인천광역시 계양구 봉오대로463번길 12" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="addrDetail-label" for="addrDetail" class="restInsert-label-bold" style="display:none;">상세주소</label>
										<input class="restInsert-input" id="addrDetail" name="addrDetail" placeholder="" type="text" value="1동 502호" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="roadAddrPart2-label"  for="roadAddrPart2" class="restInsert-label-bold" style="display:none;">상세주소2</label>
										<input class="restInsert-input" id="roadAddrPart2" name="roadAddrPart2" placeholder="" type="text" value="(효성동, 하나아파트)" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label for="raddress" class="restInsert-label-bold">전화번호</label><br>
											<select class="restInsert-hp" name="raddress">
												<option value="02">02</option>
												<option value="031">031</option>
												<option value="032">032</option>
												<option value="033">033</option>
												<option value="041">041</option>
												<option value="042">042</option>
												<option value="043">043</option>
												<option value="044">044</option>
												<option value="051">051</option>
												<option value="052">052</option>
												<option value="053">053</option>
												<option value="054">054</option>
												<option value="055">055</option>
												<option value="061">061</option>
												<option value="062">062</option>
												<option value="063">063</option>
												<option value="064">064</option>
										</select>
									<input class="restInsert-hp" type="text" name="hp2" value="297" maxlength="4"  onkeypress="txtOnlyNum(event)" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width:126.5px;">
									- <input class="restInsert-hp" type="text" name="hp3" value="7765" maxlength="4"  onkeypress="txtOnlyNum(event)" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width:126.5px;">
									</li>
									<li class="restInsert-list">
										<label for="foodstyle" class="restInsert-label-bold">음식 종류</label>
										<input class="restInsert-input" id="" name="foodstyle" placeholder="" type="text" value="한식,중식">	
									</li>
									<li class="restInsert-list">
										<label for="day" class="restInsert-label-bold">영업시간</label>
									<div class="restInsert-business-hours" style="width:450px;height:auto;">
									
										<div class="day-hours" id="hours-display" style="width:450px;height:auto;margin-bottom: 6px;">
												
										</div>
											<ul style="width:450px;heigth:55px; margin: -3px;display: block;font-size: 0;line-height: 1;text-align: left;    list-style: none;">
												<li class="restInsert-li">
													<select class="restInsert-day" id="day">
														<option value="0">월요일</option>
														<option value="1">화요일</option>
														<option value="2">수요일</option>
														<option value="3">목요일</option>
														<option value="4">금요일</option>
														<option value="5">토요일</option>
														<option value="6">일요일</option>
													</select>
												</li>
												<li class="restInsert-li" style="width:153px;">
													<select class="restInsert-day" id="hour-start" onchange="hour_changeTime()" style="width:">
														<option value="익일">익일</option>
														<option value="0.0" selected>오전 12:00</option>
														<option value="0.5">오전 12:30</option>
														<option value="1.0">오전 1:00</option>
														<option value="1.5">오전 1:30</option>
														<option value="2.0">오전 2:00</option>
														<option value="2.5">오전 2:30</option>
														<option value="3.0">오전 3:00</option>
														<option value="3.5">오전 3:30</option>
														<option value="4.0">오전 4:00</option>
														<option value="4.5">오전 4:30</option>
														<option value="5.0">오전 5:00</option>
														<option value="5.5">오전 5:30</option>
														<option value="6.0">오전 6:00</option>
														<option value="6.5">오전 6:30</option>
														<option value="7.0">오전 7:00</option>
														<option value="7.5">오전 7:30</option>
														<option value="8.0">오전 8:00</option>
														<option value="8.5">오전 8:30</option>
														<option value="9.0">오전 9:00</option>
														<option value="9.5">오전 9:30</option>
														<option value="10.0">오전 10:00</option>
														<option value="10.5">오전 10:30</option>
														<option value="11.0">오전 11:00</option>
														<option value="11.5">오전 11:30</option>
														<option value="12.0">오후 12:00</option>
														<option value="12.5">오후 12:30</option>
														<option value="13.0">오후 1:00</option>
														<option value="13.5">오후 1:30</option>
														<option value="14.0">오후 2:00</option>
														<option value="14.5">오후 2:30</option>
														<option value="15.0">오후 3:00</option>
														<option value="15.5">오후 3:30</option>
														<option value="16.0">오후 4:00</option>
														<option value="16.5">오후 4:30</option>
														<option value="17.0">오후 5:00</option>
														<option value="17.5">오후 5:30</option>
														<option value="18.0">오후 6:00</option>
														<option value="18.5">오후 6:30</option>
														<option value="19.0">오후 7:00</option>
														<option value="19.5">오후 7:30</option>
														<option value="20.0">오후 8:00</option>
														<option value="20.5">오후 8:30</option>
														<option value="21.0">오후 9:00</option>
														<option value="21.5">오후 9:30</option>
														<option value="22.0">오후 10:00</option>
														<option value="22.5">오후 10:30</option>
														<option value="23.0">오후 11:00</option>
														<option value="23.5">오후 11:30</option>
													</select>
												</li>
												<li class="restInsert-li" style="width:153px;">
													<select class="restInsert-day" id="hour-end">
														<option value="0.5">오전 12:30</option>
														<option value="1.0">오전 1:00</option>
														<option value="1.5">오전 1:30</option>
														<option value="2.0">오전 2:00</option>
														<option value="2.5">오전 2:30</option>
														<option value="3.0">오전 3:00</option>
														<option value="3.5">오전 3:30</option>
														<option value="4.0">오전 4:00</option>
														<option value="4.5">오전 4:30</option>
														<option value="5.0">오전 5:00</option>
														<option value="5.5">오전 5:30</option>
														<option value="6.0">오전 6:00</option>
														<option value="6.5">오전 6:30</option>
														<option value="7.0">오전 7:00</option>
														<option value="7.5">오전 7:30</option>
														<option value="8.0">오전 8:00</option>
														<option value="8.5">오전 8:30</option>
														<option value="9.0">오전 9:00</option>
														<option value="9.5">오전 9:30</option>
														<option value="10.0">오전 10:00</option>
														<option value="10.5">오전 10:30</option>
														<option value="11.0">오전 11:00</option>
														<option value="11.5">오전 11:30</option>
														<option value="12.0">오후 12:00</option>
														<option value="12.5">오후 12:30</option>
														<option value="13.0">오후 1:00</option>
														<option value="13.5">오후 1:30</option>
														<option value="14.0">오후 2:00</option>
														<option value="14.5">오후 2:30</option>
														<option value="15.0">오후 3:00</option>
														<option value="15.5">오후 3:30</option>
														<option value="16.0">오후 4:00</option>
														<option value="16.5">오후 4:30</option>
														<option value="17.0">오후 5:00</option>
														<option value="17.5">오후 5:30</option>
														<option value="18.0">오후 6:00</option>
														<option value="18.5">오후 6:30</option>
														<option value="19.0">오후 7:00</option>
														<option value="19.5">오후 7:30</option>
														<option value="20.0">오후 8:00</option>
														<option value="20.5">오후 8:30</option>
														<option value="21.0">오후 9:00</option>
														<option value="21.5">오후 9:30</option>
														<option value="22.0">오후 10:00</option>
														<option value="22.5">오후 10:30</option>
														<option value="23.0">오후 11:00</option>
														<option value="23.5">오후 11:30</option>
														<option value="24.0">오전 12:00(익일)</option>
														<option value="24.5">오전 12:30(익일)</option>
														<option value="25.0">오전 1:00(익일)</option>
														<option value="25.5">오전 1:30(익일)</option>
														<option value="26.0">오전 2:00(익일)</option>
														<option value="26.5">오전 2:30(익일)</option>
														<option value="27.0">오전 3:00(익일)</option>
														<option value="27.5">오전 3:30(익일)</option>
														<option value="28.0">오전 4:00(익일)</option>
														<option value="28.5">오전 4:30(익일)</option>
														<option value="29.0">오전 5:00(익일)</option>
														<option value="29.5">오전 5:30(익일)</option>
														<option value="30.0">오전 6:00(익일)</option>
														<option value="30.5">오전 6:30(익일)</option>
														<option value="31.0">오전 7:00(익일)</option> 
													</select>
												</li>
												<li class="restInsert-li">
													<button type="button" value="submit" class="restInsert-button " style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border: 1px solid #ccc;" onclick="hour_add()">
														<span>Add</span>
													</button>
												</li>
											</ul>
									</div>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">좌석</label><br>
										<div class="checkbox" style="width:370px;height:auto;">
											<input class="magic-checkbox" type="checkbox" id="reststyle" name="reststyle" value="좌석" checked>
											<label for="reststyle" class="restInsert-label" style="width:15%">좌석</label>
											
											<input class="magic-checkbox" type="checkbox" id="reststyle2" name="reststyle" value="테이블석" checked>
											<label for="reststyle2" class="restInsert-label" style="width:20%">테이블석</label>
											
											<input class="magic-checkbox" type="checkbox" id="reststyle3" name="reststyle" value="야외석" checked>
											<label for="reststyle3" class="restInsert-label" style="width:15%">야외석</label>
										</div>
									
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">예약</label><br>
										
										<input class="magic-radio" type="radio" id="reserv" name="reserv" value="가능" checked>
										<label for="reserv" class="restInsert-label">가능</label>
										<input class="magic-radio" type="radio" id="reserv2" name="reserv" value="불가능">
										<label for="reserv2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold-bold">배달</label><br>
																				
										<input class="magic-radio" type="radio" id="delivery" name="delivery" value="가능" checked>
										<label for="delivery" class="restInsert-label">가능</label>
										<input class="magic-radio" type="radio" id="delivery2" name="delivery" value="불가능">
										<label for="delivery2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">포장</label><br>
																				
										<input class="magic-radio" type="radio" id="takeout" name="takeout" value="가능" checked>
										<label for="takeout" class="restInsert-label">가능</label>
										<input class="magic-radio" type="radio" id="takeout2" name="takeout" value="불가능">
										<label for="takeout2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">주차장</label><br>
																														
										<input class="magic-radio" type="radio" id="parking" name="parking" value="가능" checked>
										<label for="parking" class="restInsert-label">가능</label>
										<input class="magic-radio" type="radio" id="parking2" name="parking" value="불가능">
										<label for="parking2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">단체예약</label><br>
																																								
										<input class="magic-radio" type="radio" id="groupreserv" name="groupreserv" value="가능" checked>
										<label for="groupreserv" class="restInsert-label">가능</label>
										<input class="magic-radio" type="radio" id="groupreserv2" name="groupreserv" value="불가능">
										<label for="groupreserv2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">소음</label><br>
										
										<input class="magic-radio" type="radio" id="noise" name="noise" value="조용함" >
										<label for="noise" class="restInsert-label">조용함</label>
										
										<input class="magic-radio" type="radio" id="noise2" name="noise" value="평균" checked>
										<label for="noise2" class="restInsert-label">평균</label>
										
										<input class="magic-radio" type="radio" id="noise3" name="noise" value="시끄러움">
										<label for="noise3" class="restInsert-label">시끄러움</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">키드존</label><br>
										
										<input class="magic-radio" type="radio" id="kidzone" name="kidzone" value="키드존" checked>
										<label for="kidzone" class="restInsert-label">키드존</label>
										<input class="magic-radio" type="radio" id="kidszone2" name="kidzone" value="노키드존">
										<label for="kidzone2" class="restInsert-label">노키드존</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">주류</label><br>
										
										<div class="checkbox" style="width:390px;height:auto;">
										
											<input class="magic-checkbox" type="checkbox" id="alcohol" name="alcohol" value="소주" checked>
											<label for="alcohol" class="restInsert-label" style="width:15%">소주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol2" name="alcohol" value="맥주" checked>
											<label for="alcohol2" class="restInsert-label" style="width:15%">맥주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol3" name="alcohol" value="양주" checked>
											<label for="alcohol3" class="restInsert-label" style="width:15%">양주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol4" name="alcohol" value="막걸리" checked>
											<label for="alcohol4" class="restInsert-label" style="width:15%">막걸리</label>
										</div>
									</li>
									<li class="restInsert-list">
										<label class="restInsert-label-bold">대기실</label><br>
										
										<input class="magic-radio" type="radio" id="waiting" name="waiting" value="있음" checked>
										<label for="waiting" class="restInsert-label" style="width:15%">있음</label>
										
										<input class="magic-radio" type="radio" id="waiting2" name="waiting" value="없음">
										<label for="waiting2" class="restInsert-label" style="width:15%">없음</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">WIFI</label><br>

										 <input class="magic-radio" type="radio" id="wifi" name="wifi" value="있음" checked>
										 <label for="wifi" class="restInsert-label" style="width:25%;">있음</label>
										
										<input class="magic-radio" type="radio" id="wifi2" name="wifi" value="없음">
										<label for="wifi2" class="restInsert-label" style="width:25%;">없음</label>
										
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">화장실</label><br>
										
										<input class="magic-radio" type="radio" id="toilet" name="toilet" value="있음" checked>
										<label for="toilet" class="restInsert-label" style="width:25%;">있음</label>
										
										<input class="magic-radio" type="radio" id="toilet2" name="toilet" value="없음">
										<label for="toilet2" class="restInsert-label" style="width:25%;">없음</label>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">테이블 수</label><br>
										<input class="restInsert-input" id="" name="tablecount" type="text" value="12" style="width:237px;display:inline-block;"maxlength="3" >
										<select class="restInsert-hp" name="standard"  style="width:147px;">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4" selected>4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
										</select>
										<span style="font-weight: bold;"> 인 기준</span>
									</li>
									<li class="restInsert-list">
										<label for="roadAddrPart1" class="restInsert-label-bold">바쁜시간</label><br>
									<div class="restInsert-busy-hours" id="restInsert-busy-hours" style="width:450px;height:auto;">
										<input type="hidden" name="busytime" value="">
										<div class="busy-hours" id="busy-display" style="width:450px;height:auto;margin-bottom: 6px;"></div>
											<ul style="width:450px;heigth:55px; margin: -3px;display: block;font-size: 0;line-height: 1;text-align: left;    list-style: none;">
												<li class="restInsert-li">
													<select class="restInsert-day" id="busy-day">
														<option value="0">월요일</option>
														<option value="1">화요일</option>
														<option value="2">수요일</option>
														<option value="3">목요일</option>
														<option value="4">금요일</option>
														<option value="5">토요일</option>
														<option value="6">일요일</option>
													</select>
												</li>
												<li class="restInsert-li">
													<select class="restInsert-day" id="busy-hour-start" onchange="busy_changeTime()" style="width:147px">
														<option value="없음">없음</option>
														<option value="0.0" selected>오전 12:00</option>
														<option value="0.5">오전 12:30</option>
														<option value="1.0">오전 1:00</option>
														<option value="1.5">오전 1:30</option>
														<option value="2.0">오전 2:00</option>
														<option value="2.5">오전 2:30</option>
														<option value="3.0">오전 3:00</option>
														<option value="3.5">오전 3:30</option>
														<option value="4.0">오전 4:00</option>
														<option value="4.5">오전 4:30</option>
														<option value="5.0">오전 5:00</option>
														<option value="5.5">오전 5:30</option>
														<option value="6.0">오전 6:00</option>
														<option value="6.5">오전 6:30</option>
														<option value="7.0">오전 7:00</option>
														<option value="7.5">오전 7:30</option>
														<option value="8.0">오전 8:00</option>
														<option value="8.5">오전 8:30</option>
														<option value="9.0">오전 9:00</option>
														<option value="9.5">오전 9:30</option>
														<option value="10.0">오전 10:00</option>
														<option value="10.5">오전 10:30</option>
														<option value="11.0">오전 11:00</option>
														<option value="11.5">오전 11:30</option>
														<option value="12.0">오후 12:00</option>
														<option value="12.5">오후 12:30</option>
														<option value="13.0">오후 1:00</option>
														<option value="13.5">오후 1:30</option>
														<option value="14.0">오후 2:00</option>
														<option value="14.5">오후 2:30</option>
														<option value="15.0">오후 3:00</option>
														<option value="15.5">오후 3:30</option>
														<option value="16.0">오후 4:00</option>
														<option value="16.5">오후 4:30</option>
														<option value="17.0">오후 5:00</option>
														<option value="17.5">오후 5:30</option>
														<option value="18.0">오후 6:00</option>
														<option value="18.5">오후 6:30</option>
														<option value="19.0">오후 7:00</option>
														<option value="19.5">오후 7:30</option>
														<option value="20.0">오후 8:00</option>
														<option value="20.5">오후 8:30</option>
														<option value="21.0">오후 9:00</option>
														<option value="21.5">오후 9:30</option>
														<option value="22.0">오후 10:00</option>
														<option value="22.5">오후 10:30</option>
														<option value="23.0">오후 11:00</option>
														<option value="23.5">오후 11:30</option>
													</select>
												</li>
												<li class="restInsert-li">
													<select class="restInsert-day" id="busy-hour-end" style="width:147px">
														<option value="0.5">오전 12:30</option>
														<option value="1.0">오전 1:00</option>
														<option value="1.5">오전 1:30</option>
														<option value="2.0">오전 2:00</option>
														<option value="2.5">오전 2:30</option>
														<option value="3.0">오전 3:00</option>
														<option value="3.5">오전 3:30</option>
														<option value="4.0">오전 4:00</option>
														<option value="4.5">오전 4:30</option>
														<option value="5.0">오전 5:00</option>
														<option value="5.5">오전 5:30</option>
														<option value="6.0">오전 6:00</option>
														<option value="6.5">오전 6:30</option>
														<option value="7.0">오전 7:00</option>
														<option value="7.5">오전 7:30</option>
														<option value="8.0">오전 8:00</option>
														<option value="8.5">오전 8:30</option>
														<option value="9.0">오전 9:00</option>
														<option value="9.5">오전 9:30</option>
														<option value="10.0">오전 10:00</option>
														<option value="10.5">오전 10:30</option>
														<option value="11.0">오전 11:00</option>
														<option value="11.5">오전 11:30</option>
														<option value="12.0">오후 12:00</option>
														<option value="12.5">오후 12:30</option>
														<option value="13.0">오후 1:00</option>
														<option value="13.5">오후 1:30</option>
														<option value="14.0">오후 2:00</option>
														<option value="14.5">오후 2:30</option>
														<option value="15.0">오후 3:00</option>
														<option value="15.5">오후 3:30</option>
														<option value="16.0">오후 4:00</option>
														<option value="16.5">오후 4:30</option>
														<option value="17.0">오후 5:00</option>
														<option value="17.5">오후 5:30</option>
														<option value="18.0">오후 6:00</option>
														<option value="18.5">오후 6:30</option>
														<option value="19.0">오후 7:00</option>
														<option value="19.5">오후 7:30</option>
														<option value="20.0">오후 8:00</option>
														<option value="20.5">오후 8:30</option>
														<option value="21.0">오후 9:00</option>
														<option value="21.5">오후 9:30</option>
														<option value="22.0">오후 10:00</option>
														<option value="22.5">오후 10:30</option>
														<option value="23.0">오후 11:00</option>
														<option value="23.5">오후 11:30</option>
														<option value="24.0">오전 12:00(익일)</option>
														<option value="24.5">오전 12:30(익일)</option>
														<option value="25.0">오전 1:00(익일)</option>
														<option value="25.5">오전 1:30(익일)</option>
														<option value="26.0">오전 2:00(익일)</option>
														<option value="26.5">오전 2:30(익일)</option>
														<option value="27.0">오전 3:00(익일)</option>
														<option value="27.5">오전 3:30(익일)</option>
														<option value="28.0">오전 4:00(익일)</option>
														<option value="28.5">오전 4:30(익일)</option>
														<option value="29.0">오전 5:00(익일)</option>
														<option value="29.5">오전 5:30(익일)</option>
														<option value="30.0">오전 6:00(익일)</option>
														<option value="30.5">오전 6:30(익일)</option>
														<option value="31.0">오전 7:00(익일)</option> 
													</select>
												</li>
												<li class="restInsert-li">
													<button type="button" value="submit" class="restInsert-button " style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border:1px solid #ccc;" onclick="busy_add();" >
														<span>Add</span>
													</button>
												</li>
											</ul>
									</div>	
									</li>
								</ul>
								<div class="restInsert-footer">
									<button id="restInsert-submit" name="action_submit" type="submit" value="등록" class="restInsert-submit">
										<span>등록</span>
									</button>
									<a href="#">취소</a>
								</div>
							</form>
					</div>
					<div class="restInsert-beta" style="width:40%;height:100%;float: left;padding: 0 15px;display:inline-block;">
				
					</div>
				</div>
			</div>
		</div>
	</div>		
<script>

</script>
</body>
</html>
<%@include file="../bottom.jsp" %>