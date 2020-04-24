<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url><c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" /><c:url value="/upload" var="upload"></c:url>
<!DOCTYPE html>
<head> 
<script type="text/javascript">
var url = window.location.href;
if(url.indexOf('out')>0){
	window.location.href='${root}empty';
}
$(document).ready(function(){
	$("#recheck").on('propertychange change keyup paste input',function(){
		if($('#check').text() == $('#recheck').val()){
			$('#checkRst').attr("type","submit");
		}
		else{
			$('#checkRst').attr("type","button");
		}
	});
	
	$('#rst').on('submit',function(e){
		e.preventDefault();
		$('#checkRst').on('click',function(){
			var pronum = "${profile.pronum}";
			$.post('${root}user/out','pronum='+pronum,function(data){
				if(data == 1){
					openPop('nok');
				}
				else if(data ==0){
					openPop('ok');
				}
			});
		});
	});
	$('#btn_ok').on('click',function(){
		location.href="${root}"
	});

});
</script>
</head>
<div class="out_wrap pop_wrap">
	<h3 class="pop_tit">계정을 탈퇴하시겠습니까?</h3>
	<div class="info_box">
		<ul>
			<li>탈퇴 후에는 해당 계정을 사용할 수 없습니다.</li>
			<li>탈퇴한 계정의 데이터는 복구할 수 없습니다.</li>
			<li>확인 버튼을 누르시면 회원 탈퇴가 완료됩니다.</li>
		</ul>
	</div>
	<p>[다음 문구를 똑같이 입력해주세요.]</p>
	<p id="check" class="out_words">여행하는 과정에서 행복을 느낀다</p>
	<form id="rst" class="comm_form">
		<div class="ip_box">
			<input type="text" id="recheck" name="recheck" required="required">
		</div>
		<div class="btn_box">
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
				<li><button type="button" id="checkRst" class="comm_btn sbm" data-layer="ok">확인</button></li>
			</ul>
		</div>
	</form>
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