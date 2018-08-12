<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>타이틀을 입력하세요.</title>
	
<script type="text/javascript">

function check_delete(){
    var fname = document.masterf;

    for(var i=0; i < fname.elements.length; i++){
        var e = fname.elements[i];
        
        if(e.checked!==true){
         	fname.isManager.checked==false
         }
        if{
       	 fname.isManager.checked==true 
        }
        
        if(fname.isManager.checked==false){
        	 e.checked = false;
        }
    }
}
</script>

</head>
<body>
	
	<form name="masterf" action="master_setAuthorization" method="post">
		<h2>권한설정란</h2><p>
		<input type="checkbox" name="isManager" value="isManager" onClick='check_delete();' >isManager<br>
		<input type="checkbox" name="select" value="controlCate" >controlCate<br>
		<input type="checkbox" name="select" value="controlEvent" >controlEvent<br>
		<input type="checkbox" name="select" value="controlMember" >controlMember<br>
		<input type="checkbox" name="select" value="controlStore" >controlStore<br>
		<input type="checkbox" name="select" value="controlReview" >controlReview<p>
	
		<input type="submit" value="보내기">	
	</form>
	
</body>
</html>