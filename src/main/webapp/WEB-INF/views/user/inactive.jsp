<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<head>
<script type="text/javascript">
var url = window.location.href;
if(url.indexOf('inactive')>0){
	window.location.href='${root}empty';
}
	$(document).ready(function(){
		$('#btn_inactive').on('click',function(e){
			e.preventDefault();
			var pronum = "${profile.pronum}";
			$.post('${root}user/inactive','pronum='+pronum,function(data){
				if(data == 1){
					openPop('nok');
					
				}
				else if(data ==0){
					openPop('ok');
				}
				
			});
		});
		$('#btn_ok').on('click',function(){
			location.href = "${root}";
		});
	});
</script>
</head>
<div class="out_wrap pop_wrap">
	<h3 class="pop_tit">계정을 비활성화하시겠습니까?</h3>
	<div class="info_box">
		<ul>
			<li>비활성화 시 나의 프로필과 내가 공유한 피드를 볼 수 없습니다.</li>
			<li>다음 로그인 시 계정 비활성화가 자동으로 해제됩니다.</li>
			<li>확인 버튼을 누르시면 계정 비활성화가 완료되고 로그아웃됩니다.</li>
		</ul>
	</div>
	<div class="btn_box">
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
			<li><button type="submit" id="btn_inactive" class="btn_close comm_btn sbm">확인</button></li>
		</ul>
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<!-- #팝업 처리완료 { -->
<div id="ok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" id="btn_ok" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- #팝업 처리 불가능 -->
<div id="nok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">계정을 비활성화 할 수 없습니다.</p>
		<p class="pop_txt">내 그룹에 다른 그룹원이 있습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 처리완료 -->
<script type="text/javascript">
	btnPop('btn_pop2');
</script>