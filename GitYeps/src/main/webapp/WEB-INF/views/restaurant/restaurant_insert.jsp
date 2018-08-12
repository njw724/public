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
	var j = 1;
	var i = 0;
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
				document.getElementById("busy-hour-end").options[i].selected = 'selected';
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
		if(s.options[s.selectedIndex].value=='휴일'){
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
		"<a style='margin-left: 6px;' href='javascript:void(0);' onclick='busy_remove("+day2+")'>삭제</a>" 
		document.getElementsByName("busytime").value="없음";
	}else{
		document.getElementById("busy-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+
		"<span>"+start+"</span>"+"<span>"+"&nbsp-&nbsp"+"</span>"+"<span>"+end+"&nbsp"+"</span>"+
		"<a href='javascript:void(0);' onclick='busy_remove("+day2+")'>삭제</a>"
		document.getElementsByName("busytime").value=start +"&nbsp"+end;
	}
}
function food_add(){
	var div = document.createElement("DIV");
	var span = document.createElement("SPAN");
	var parent = document.getElementById("food-display");
	var foodstyle = document.getElementById("foodstyle");
	var food_value = foodstyle.options[foodstyle.selectedIndex].value;
	if(parent.childNodes.length>3){
		return false;
	}
	for(var i=0;i<parent.childNodes.length;i++){
		if(parent.childNodes[i].id==food_value){
			return false;
		}
	}
	
	div.setAttribute("id", food_value);
	div.setAttribute("class","restInsert-hours");
	
	parent.appendChild(div).innerHTML = "<span>"+food_value+"</span>"+
	"<a href='javascript:void(0);' onclick='food_remove()'>&nbsp삭제</a>"+
	"<input type='hidden' name='foodstyle' value='"+food_value+"'/>";;
	
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
		"<a style='margin-left: 6px;' href='javascript:void(0);' onclick='remove("+day2+")'>삭제</a>" +
		"<input type='hidden' name='"+week[day2]+"' value='익일'/>";
	}else{
		document.getElementById("hours-display").appendChild(div).innerHTML = "<span>"+day[day2]+"    "+"</span>"+
		"<span>"+start+"</span>"+"<span>"+"&nbsp-&nbsp"+"</span>"+"<span>"+end+"&nbsp"+"</span>"+
		"<a href='javascript:void(0);' onclick='remove("+day2+")'>삭제</a>" +
		"<input type='hidden' name='"+week[day2]+"' value='"+start+" - "+end+"'/>";
	}
}

function remove(obj) {
	var parent = document.getElementById("hours-display");
	var child = document.getElementById(week[obj]);
	parent.removeChild(child);
}
function busy_remove(obj) {
	var parent = document.getElementById("busy-display");
	var child = document.getElementById("busy"+week[obj]);
	parent.removeChild(child);
}
function food_remove(){
	var parent = document.getElementById("food-display");
	var foodstyle = document.getElementById("foodstyle");
	var child = foodstyle.options[foodstyle.selectedIndex].value;
	for(var i=0;i<parent.childNodes.length;i++){
		if(parent.childNodes[i].id==child){
			parent.removeChild(parent.childNodes[i]);
		}
	}
	
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
	
// 	var rname=document.getElementById("rname").value
	if(document.getElementById("rname").value==""){
		alert("가게 이름을 입력해주세요 !! ")
		document.getElementById("rname").focus()
		return false;
	}
	if(document.getElementById("input_file").value==""){
		alert("사진을 등록 해주세요!!")
		document.getElementById("input_file").focus()
		return false;
	}
	
	if(document.getElementById("zipNo").value==""||document.getElementById("roadAddrPart1").value==""||document.getElementById("addrDetail").value==""||document.getElementById("roadAddrPart2").value==""){
		alert("주소를 입력 해주세요!!")
		document.getElementById("zipNo").focus();
		return false;
	}
	
	if(document.getElementById("hp2").value==""||document.getElementById("hp3").value==""){
		alert("전화번호를 입력 해주세요!!")
		document.getElementById("hp2").focus();
		return false;
	}
	
	var hours_parent = document.getElementById("hours-display");
	
	if(hours_parent.childNodes.length<8){
		alert("모든 요일을 입력 해주세요!!")
		document.getElementById("day").focus();
		return false;
	}
	var food_parent = document.getElementById("food-display");
	
	if(food_parent.childNodes.length<1){
		alert("음식 종류를 최소 1개 이상 선택해주세요!!")
		document.getElementById("foodstyle").focus();
		return false;
	}
	
	
	
	var reststyle_name = document.getElementsByName("reststyle");
	if(!reststyle_name[0].checked && !reststyle_name[1].checked && !reststyle_name[2].checked){
		alert("좌석 한개 이상 선택해 주세요!!")
		return false;
	}
	
	if(!document.getElementById("reserv").checked && !document.getElementById("reserv2").checked){
		alert("예약을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("delivery1").checked && !document.getElementById("delivery2").checked){
		alert("배달을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("takeout1").checked && !document.getElementById("takeout2").checked){
		alert("포장을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("parking").checked && !document.getElementById("parking2").checked){
		alert("주차장을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("groupreserv").checked && !document.getElementById("groupreserv2").checked){
		alert("단체예약을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("noise").checked && !document.getElementById("noise2").checked && !document.getElementById("noise3").checked){
		alert("소음을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("kidszone").checked && !document.getElementById("kidszone2").checked ){
		alert("키드존을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("waiting").checked && !document.getElementById("waiting2").checked ){
		alert("대기실을 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("wifi").checked && !document.getElementById("wifi2").checked ){
		alert("WIFI를 선택해 주세요!!")
		return false;
	}
	if(!document.getElementById("toilet").checked && !document.getElementById("toilet2").checked ){
		alert("화장실을 선택해 주세요!!")
		return false;
	}
	if(document.getElementById("tablecount").value==""){
		alert("테이블 갯수를 작성 해주세요!!")
		document.getElementById("tablecount").focus();
		return false;
	}	
	
	

	
	var foodstyle=new Array();
	var foodstyle_name = document.getElementsByName("foodstyle");
	for (var i=0;i<foodstyle_name.length;i++){
		if (foodstyle_name[i].checked) {
			foodstyle.push(foodstyle_name[i].value)
		}
	}
	document.getElementById("foodstyle").value = foodstyle.join(',')
	
	var reststyle=new Array();
	for (var i = 0; i < reststyle_name.length; i++) {
		if (reststyle_name[i].checked) {
			reststyle.push(reststyle_name[i].value)
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
	return true;
}
</script>
<html>
<head>
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

						<h2 style="word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important; font-weight: bold;margin-bottom: 6px;font-size: 26px;line-height: 1.28571em;color: #d32323;">가게 등록</h2>
							<form name="restForm" id="restForm" enctype="multipart/form-data" method="post" action="restaurant_insert" onsubmit="return test();"
							style="margin-bottom: 18px;display: block;width:100%;height:100%;">
								<ul style="list-style:none;">
									<li class="restInsert-list">
										<label for="attr_BusinessName" class="restInsert-label-bold">가게 이름</label>
										<input class="restInsert-input" id="rname" name="rname" placeholder="가게 이름을 입력해주세요" type="text" value="">	
									</li>
									<li class="restInsert-list">
									 <label for="attr_BusinessName" class="restInsert-label-bold">사진 선택</label>
						               <div class="filebox bs3-primary preview-image" style="margin: 6px 0 18px; width: 100%; height: 30px; display: block; text-align:left;">
						                  <label for="input_file" id="input_file_label"style="width: 80px; color: black; display: inline-block; padding: .5em .75em; font-size: 14px; vertical-align: middle; text-align: center; cursor: pointer; border: 1px solid #999; border-radius: 3px;">사진 올리기</label>
						                  <input type="file" id="input_file" class="upload-hidden" name="rest_filename" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0,0,0,0); border: 0;" >
						               </div> 
									</li>
									<li class="restInsert-list">
										<label for="zipNo" class="restInsert-label-bold">우편번호</label>
										<input class="restInsert-input" id="zipNo" name="zipNo" placeholder="" type="text" value="" onclick="goPopup();" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="roadAddrPart1-label" for="roadAddrPart1" class="restInsert-label-bold" style="display:none;">도로명 주소</label>
										<input class="restInsert-input" id="roadAddrPart1" name="roadAddrPart1" placeholder="" type="text" value="" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="addrDetail-label" for="addrDetail" class="restInsert-label-bold" style="display:none;">상세주소</label>
										<input class="restInsert-input" id="addrDetail" name="addrDetail" placeholder="" type="text" value="" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label id="roadAddrPart2-label"  for="roadAddrPart2" class="restInsert-label-bold" style="display:none;">상세주소2</label>
										<input class="restInsert-input" id="roadAddrPart2" name="roadAddrPart2" placeholder="" type="text" value="" style="display:none;" readonly>	
									</li>
									<li class="restInsert-list">
										<label for="raddress" class="restInsert-label-bold">전화번호</label><br>
											<select class="restInsert-hp" name="raddress">
												<option value="010">010</option>
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
									<input class="restInsert-hp" type="text" id="hp2" name="hp2" value="" maxlength="4"  onkeypress="txtOnlyNum(event)" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width:126.5px;">
									- <input class="restInsert-hp" type="text" id="hp3" name="hp3" value="" maxlength="4"  onkeypress="txtOnlyNum(event)" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width:126.5px;">
									</li>
									
									
									<li class="restInsert-list">
										<label for="category" class="restInsert-label-bold">카테고리 등록</label>
											
											
											<select class="restInsert-day" id="category" name="category" style="width:390px">
												<option value="Restaurants">레스토랑</option>
												<option value="Bars">바</option>
												<option value="Food">음식점</option>
												<option value="Breakfast & Brunch">아침식사 & 브런치</option>
												<option value="Coffee & Tea">카페</option>
											</select>
									</li>
									
									<li class="restInsert-list">
										<label for="foodstyle" class="restInsert-label-bold">음식 종류</label>
										<ul style="width:460px;heigth:55px; margin: -3px;display: block;font-size: 0;line-height: 1;text-align: left;    list-style: none;">
												<li class="restInsert-li">
													<select class="restInsert-day" id="foodstyle" style="width:390px;">
														<option value="한식">한식</option>
														<option value="일식">일식</option>
														<option value="중식">중식</option>
														<option value="양식">양식</option>
													</select>
												</li>
												<li class="restInsert-li">
													<button type="button" value="submit" class="restInsert-button" style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border:1px solid #ccc;" onclick="food_add()">
														<span>Add</span>
													</button>
												</li>
											</ul>
										<div class="day-hours" id="food-display" style="width:460px;height:auto;margin-bottom: 6px;">
												
										</div>
									</li>
									
									<li class="restInsert-list">
										<label for="price" class="restInsert-label-bold">가격 범위</label>
										<select class="restInsert-day" id="price" name="price" style="width:390px">
											<option value="1">￦(10,000원 이하)</option>
											<option value="2">￦￦(10,000원~30,000원)</option>
											<option value="3">￦￦￦(30,000원~50,000원)</option>
											<option value="4">￦￦￦￦(50,000원 이상)</option>
										</select>
									</li>
									
									<li class="restInsert-list">
										<label for="day" class="restInsert-label-bold">영업시간</label>
									<div class="restInsert-business-hours" style="width:460px;height:auto;">
										<div class="day-hours" id="hours-display" style="width:460px;height:auto;margin-bottom: 6px;">
												
										</div>
											<ul style="width:460px;heigth:55px; margin: -3px;display: block;font-size: 0;line-height: 1;text-align: left;    list-style: none;">
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
												<li class="restInsert-li">
													<select class="restInsert-day" id="hour-start" onchange="hour_changeTime()" style="width:147px">
														<option value="휴일">휴일</option>
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
													<select class="restInsert-day" id="hour-end" style="width:147px">
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
										<label for="reststyle" class="restInsert-label-bold">좌석</label><br>
										<div class="checkbox" style="width:370px;height:auto;">
											<input class="magic-checkbox" type="checkbox" id="reststyle" name="reststyle" value="좌식" >
											<label for="reststyle" class="restInsert-label" style="width:60px">좌식</label>
											
											<input class="magic-checkbox" type="checkbox" id="reststyle2" name="reststyle" value="테이블식" >
											<label for="reststyle2" class="restInsert-label" style="width:63px">테이블식</label>
											
											<input class="magic-checkbox" type="checkbox" id="reststyle3" name="reststyle" value="야외식" >
											<label for="reststyle3" class="restInsert-label"style="width:60px">야외식</label>
										</div>
									
									</li>
									<li class="restInsert-list">
										<label for="reserv" class="restInsert-label-bold">예약</label><br>
										
										<input class="magic-radio" type="radio" id="reserv" name="reserv" value="가능" >
										<label for="reserv" class="restInsert-label" style="width:58px">가능</label>
										<input class="magic-radio" type="radio" id="reserv2" name="reserv" value="불가능">
										<label for="reserv2" class="restInsert-label">불가능</label>
									</li>
									
									<li class="restInsert-list">
										<label for="delivery" class="restInsert-label-bold">배달</label><br>
										
										<input class="magic-radio" type="radio" id="delivery1" name="delivery" value="가능" >
										<label for="delivery1" class="restInsert-label" style="width:58px">가능</label>
										<input class="magic-radio" type="radio" id="delivery2" name="delivery" value="불가능">
										<label for="delivery2" class="restInsert-label">불가능</label>
									</li>
									
									<li class="restInsert-list">
										<label for="takeout" class="restInsert-label-bold">포장</label><br>
																				
										<input class="magic-radio" type="radio" id="takeout1" name="takeout" value="가능" >
										<label for="takeout1" class="restInsert-label" style="width:58px">가능</label>
										<input class="magic-radio" type="radio" id="takeout2" name="takeout" value="불가능">
										<label for="takeout2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="parking" class="restInsert-label-bold">주차장</label><br>
																														
										<input class="magic-radio" type="radio" id="parking" name="parking" value="가능" >
										<label for="parking" class="restInsert-label" style="width:58px">가능</label>
										<input class="magic-radio" type="radio" id="parking2" name="parking" value="불가능">
										<label for="parking2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="groupreserv" class="restInsert-label-bold">단체예약</label><br>
																																								
										<input class="magic-radio" type="radio" id="groupreserv" name="groupreserv" value="가능" >
										<label for="groupreserv" class="restInsert-label" style="width:58px">가능</label>
										<input class="magic-radio" type="radio" id="groupreserv2" name="groupreserv" value="불가능">
										<label for="groupreserv2" class="restInsert-label">불가능</label>
									</li>
									<li class="restInsert-list">
										<label for="noise" class="restInsert-label-bold">소음</label><br>
										
										<input class="magic-radio" type="radio" id="noise" name="noise" value="조용함" >
										<label for="noise" class="restInsert-label" style="width:58px">조용함</label>
										
										<input class="magic-radio" type="radio" id="noise2" name="noise" value="평균" >
										<label for="noise2" class="restInsert-label" style="width:58px">평균</label>
										
										<input class="magic-radio" type="radio" id="noise3" name="noise" value="시끄러움">
										<label for="noise3" class="restInsert-label" style="width:58px">시끄러움</label>
									</li>
									<li class="restInsert-list">
										<label for="kidszone" class="restInsert-label-bold">키드존</label><br>
										
										<input class="magic-radio" type="radio" id="kidszone" name="kidszone" value="키드존" >
										<label for="kidszone" class="restInsert-label" style="width:58px">키드존</label>
										<input class="magic-radio" type="radio" id="kidszone2" name="kidszone" value="노키드존">
										<label for="kidszone2" class="restInsert-label">노키드존</label>
									</li>
									<li class="restInsert-list">
										<label for="alcohol" class="restInsert-label-bold">주류</label><br>
										
										<div class="checkbox" style="width:390px;height:auto;">
										
											<input class="magic-checkbox" type="checkbox" id="alcohol" name="alcohol" value="소주" >
											<label for="alcohol" class="restInsert-label" style="width:60px">소주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol2" name="alcohol" value="맥주" >
											<label for="alcohol2" class="restInsert-label" style="width:60px">맥주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol3" name="alcohol" value="양주" >
											<label for="alcohol3" class="restInsert-label" style="width:60px">양주</label>
											
											<input class="magic-checkbox" type="checkbox" id="alcohol4" name="alcohol" value="막걸리" >
											<label for="alcohol4" class="restInsert-label" style="width:60px">막걸리</label>
											
										</div>
									</li>
									<li class="restInsert-list">
										<label for="waiting" class="restInsert-label-bold">대기실</label><br>
										
										<input class="magic-radio" type="radio" id="waiting" name="waiting" value="있음" >
										<label for="waiting" class="restInsert-label" style="width:58px">있음</label>
										
										<input class="magic-radio" type="radio" id="waiting2" name="waiting" value="없음">
										<label for="waiting2" class="restInsert-label" >없음</label>
									</li>
									<li class="restInsert-list">
										<label for="wifi" class="restInsert-label-bold">WIFI</label><br>

										 <input class="magic-radio" type="radio" id="wifi" name="wifi" value="있음" >
										 <label for="wifi" class="restInsert-label" style="width:58px;">있음</label>
										
										<input class="magic-radio" type="radio" id="wifi2" name="wifi" value="없음">
										<label for="wifi2" class="restInsert-label">없음</label>
										
									</li>
									<li class="restInsert-list">
										<label for="toilet" class="restInsert-label-bold">화장실</label><br>
										
										<input class="magic-radio" type="radio" id="toilet" name="toilet" value="있음" >
										<label for="toilet" class="restInsert-label" style="width:58px;">있음</label>
										
										<input class="magic-radio" type="radio" id="toilet2" name="toilet" value="없음">
										<label for="toilet2" class="restInsert-label">없음</label>
									</li>
									<li class="restInsert-list">
										<label for="tablecount" class="restInsert-label-bold">테이블 수</label><br>
										<input class="restInsert-input" id="tablecount" name="tablecount" type="text" value="12" style="width:237px;display:inline-block;"maxlength="3" >
										<select class="restInsert-hp" name="standard"  style="width:147px;">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
										</select>
										<span style="font-weight: bold;"> 인 기준</span>
									</li>
									<!--< li class="restInsert-list">
									<label for="busytime" class="restInsert-label-bold">바쁜시간</label><br>
									<div class="restInsert-busy-hours" id="restInsert-busy-hours" style="width:460px;height:auto;">
										<input type="hidden" name="busytime" value="">
										<div class="busy-hours" id="busy-display" style="width:460px;height:auto;margin-bottom: 6px;"></div>
											<ul style="width:460px;heigth:55px; margin: -3px;display: block;font-size: 0;line-height: 1;text-align: left;    list-style: none;">
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
													<button type="button" value="submit" class="restInsert-button " style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border:1px solid #ccc;display:absolute;" onclick="busy_add();" >
														<span>Add</span>
													</button>
												</li>
											</ul>
									</div>	
									</li> -->
								</ul>
								<div class="restInsert-footer">
									<button id="restInsert-submit" name="action_submit" type="submit" value="등록" class="restInsert-submit">
										<span>등록</span>
									</button>
									<a href="restaurant_list">취소</a>
								</div>
							</form>
					</div>
					<div class="restInsert-beta" style="width:40%;height:100%;float: left;padding: 0 15px;display:inline-block;">
						<div class="restInsert-image" style="box-shadow: 0 6px 12px rgba(0,0,0,1);margin-top:20px;">
							<img id="preview" src="" width="100%" style="display:none;border: 1px solid #999;border-radius: 5px;">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
<script>

</script>
<script>
var file = document.querySelector('#input_file');
file.onchange = function () {
    var fileList = file.files ;
    // 읽기
    var reader = new FileReader();
    reader.readAsDataURL(fileList[0]);

    //로드 한 후
    reader.onload = function  () {
        //로컬 이미지를 보여주기
        document.getElementById("preview").style.display="block";
        document.querySelector('#preview').src = reader.result;

        //썸네일 이미지 생성
        var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
        tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
        tempImage.onload = function () {
            //리사이즈를 위해 캔버스 객체 생성
            var canvas = document.createElement('canvas');
            var canvasContext = canvas.getContext("2d");

            //캔버스 크기 설정
            canvas.width = 100; //가로 100px
            canvas.height = 100; //세로 100px

            //이미지를 캔버스에 그리기
            canvasContext.drawImage(this, 0, 0, 100, 100);

            //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
            var dataURI = canvas.toDataURL("image/jpeg");

            //썸네일 이미지 보여주기
//             document.querySelector('#thumbnail').src = dataURI;
           
        };
    };
};
</script>
</body>
</html>
<%@include file="../bottom.jsp" %>