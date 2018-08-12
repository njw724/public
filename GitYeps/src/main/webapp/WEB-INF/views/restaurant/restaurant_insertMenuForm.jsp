<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/restStyle.css?ver=1"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/style.css?ver=1"/>"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js" ></script>

<style>
</style>
</head>
<%@include file="../top.jsp" %>
<div class="restInsert-main" style="width: auto;padding: 0;margin: 0;">
		<div class="restInsert-content-container" style="padding:15px 15px 36px 15px; width: 960px;height:100%;margin: 0 auto; display: table;">
			<div class="restInsert-container" style="width:960px;height:100%;display:block;">
						<h2 style="word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important; font-weight: bold;margin-bottom: 6px;font-size: 26px;line-height: 1.28571em;color: #d32323;">메뉴 등록</h2>
					<div class="" style="position: relative;box-sizing: border-box;vertical-align: baseline;display: block;">
					
						
						<input class="restMenu-input" id="restMenu-input" placeholder="메뉴 등록입니다." type="text" value="" style="width:200px;">
						<button type="button" value="large" class="large" style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border: 1px solid #ccc;" >
							<span>Add</span>
						</button>
						</div>
					<form name="MenuForm" enctype="multipart/form-data" method="post" action="restaurant_insertMenu"  style="margin-bottom: 18px;display: block;width:100%;height:100%;">
						<div class="menu-sections" style="margin-top:15px">
					 
						</div>
								<div class="restInsert-footer" style="display:none;">
									<button name="action_submit" type="submit" value="등록" class="restInsert-submit">
										<span>등록</span>
									</button>
									<a href="restaurant_list">취소</a>
									<input type="hidden" name="rnum" value="${param.rnum }">
								</div>
					</form>
					</div>
				</div>
			</div>

<script>

$(document).ready(function() {
	var large_count=0;
	var small_count=0;
	
	$( ".large" ).click(function() {
		var largeMenu=$("#restMenu-input").val();
		
		if(largeMenu==""||largeMenu.indexOf(' ')>=0){
			$("#restMenu-input").val('');
			$("#restMenu-input").focus();
			return false;
		}
		if($('.'+largeMenu+'').length>0){
			return false;
		}

		
		$( ".menu-sections" ).append(
    		'<div class="'+largeMenu+'-header" style="margin-bottom: 0;border-bottom: 1px solid #e6e6e6;">'+
				'<h2 class="'+largeMenu+'" style="color: #333;word-wrap: break-word !important;word-break: break-word !important;overflow-wrap: break-word !important;font-weight: bold;margin-bottom: 6px;font-size: 21px;line-height: 1.28571em;    margin: 0 0 6px; display:inline-block;padding-right:6px;">'+
                    ''+largeMenu+''+
                '</h2>'+
                '<input type="hidden" name="largeMenuList['+large_count+'].large_name" value="'+largeMenu+'">'+
                '<button type="button" class="small_add" value="'+largeMenu+'" style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border: 1px solid #ccc;">'+
					'<span>추가</span>'+
				'</button>'+
				'<button type="button" class="small_removeAll" value="'+largeMenu+'" style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border: 1px solid #ccc;">'+
					'<span>삭제</span>'+
				'</button>'+
			'</div>'+
			'<div class="'+largeMenu+'-list" style="margin-bottom: 18px !important;">'+
				
				'<input type="hidden" id="'+largeMenu+'" name="small_length" value="0">'+
			'</div>'
			);
		$("#restMenu-input").val('');
		large_count++;
	});
	
		$('.menu-sections').on('click','.small_add',function(e){
			var name=$(this).val();
			var small_length=$('.'+name+'-list').children().length;	
			
			$('input[id='+name+']').val(small_length);
			
			$('.'+name+'-list ').append(
				'<div class="menu-item" style="border-top: 0;padding: 10px 0;">'+
					'<div class="arrange arrange--6" style="margin-left: -6px;margin-right: -6px;border-collapse: separate;border-spacing: 6px 0;display: table;min-width: 100%;table-layout: auto;">'+
					'<div class="arrange_unit" style="margin-left: 3px;margin-right: 3px;border-collapse: collapse;border-spacing: 0 0;box-sizing: border-box;display: table-cell;vertical-align: top;">'+
						'<div class="photo-box biz-photo-box pb-60s">'+
							'<a class="js-lightbox-media-link js-analytics-click" href="#" data-analytics-label="biz-photo" style="color: #0073bb;text-decoration: none;    cursor: pointer;">'+
				                '<img alt="" class="photo-box-img" height="60" src="https://s3.ap-northeast-2.amazonaws.com/yepsbucket/basic/no-image.jpg" width="60" style="outline: none; border-radius: 4px;vertical-align: middle; ">'+
				            '</a>'+
						'</div>'+
					'</div>'+
					'<div class="arrange_unit arrange_unit--fill" style="margin-left: 3px;margin-right: 3px;border-collapse: collapse;border-spacing: 0 0;width: 100%;box-sizing: border-box;display: table-cell;vertical-align: top;">'+
						'<div class="arrange" style="display: table;min-width: 100%;table-layout: auto;">'+
							'<div class="arrange_unit arrange_unit--fill menu-item-details" style="width: 100%;box-sizing: border-box;display: table-cell;vertical-align: top;">'+
			                    '<input type="text" class="restMenu-input" style="width:200px;margin-bottom: 5px;" name="smallMenuList['+small_count+'].small_name">'+
			                    '<button type="button" class="small_remove" value="small_remove" style="padding: 5px 8px;font-size: 12px;line-height: 1.5em;border: 1px solid #ccc;">'+
								'<span>삭제</span>'+
							'</button>'+
			                    '<textarea style="margin-bottom: 5px;display: block;overflow:auto;" rows="2" cols="50" name="smallMenuList['+small_count+'].small_content"></textarea>'+
							'</div>'+
							'<div class="menu-item-prices arrange_unit" style="text-align:right;padding-left: 90px;box-sizing: border-box;display: table-cell;vertical-align: top;">'+
								'<ul style="list-style: none;display: block;">'+
									'<li class="menu-item-price-amount" style="font-size: 15px;font-weight: bold;display: list-item;">'+
										'<input type="text" class="restMenu-input" style="width:70px" name="smallMenuList['+small_count+'].small_price">'+
										'<span style="position:absolute;">￦</span>'+
									'</li>'+
								'</ul>'+
							'</div>'+
						'</div>'+
					'</div>'+
				'</div>'
			);																			   
			small_count++;
			$(".restInsert-footer").css('display','inline');
		});
		
		
		$('.menu-sections').on('click','.small_remove',function(e){
			$(this).parent().parent().parent().parent().parent().remove();
		});
		
		$('.menu-sections').on('click','.small_removeAll',function(e){
			var name=$(this).val();
			var small_length=$('.'+name+'-list').children().length;	
			$('.'+name+'-header').remove();
			$('.'+name+'-list').remove();
			large_count--;
			small_count-=small_length;
		});
	
	

	
	
});
</script>
</body>
</html>
<%@include file="../bottom.jsp" %>
