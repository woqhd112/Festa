<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="out_wrap pop_wrap">
	<h3 class="pop_tit">그룹을 삭제하시겠습니까?</h3>
	<div class="info_box">
		<ul>
			<li>삭제한 그룹의 데이터는 복구할 수 없습니다.</li>
			<li>확인 버튼을 누르시면 그룹 삭제가 완료됩니다.</li>
		</ul>
	</div>
	<p>[다음 문구를 똑같이 입력해주세요.]</p>
	<p class="out_words">여행하는 과정에서 행복을 느낀다</p>
	<form class="comm_form">
		<div class="ip_box">
			<input type="text" id="" name="" required="required">
			<p class="f_message"></p>
		</div>
		<div class="btn_box">
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
				<li><button type="button" class="btn_pop2 comm_btn sbm" data-layer="ok">확인</button></li>
			</ul>
		</div>
	</form>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<!-- #팝업 처리불가 {
<div id="" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">그룹을 삭제할 수 없습니다.</p>
		<p class="pop_txt">아직 탈퇴하지 않은 그룹 멤버가 있습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
} #팝업 처리불가 -->
<!-- #팝업 처리완료 { -->
<div id="ok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 처리완료 -->
<script type="text/javascript">
	btnPop('btn_pop2');
</script>