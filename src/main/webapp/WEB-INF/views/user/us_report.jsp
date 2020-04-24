<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/resources/upload" var="upload"></c:url>
<c:url value="/" var="root" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var url = window.location.href;
	if(url.indexOf('report')>0){
		window.location.href='${root}empty';
	}
	$(document).ready(function(){
		//신고하기버튼 클릭
		$('#form_data').on('submit',function(e){
			e.preventDefault();
			if($('#festaRs10:checked').val()=="기타" && $('.report_11').val().length>=500){
				openPop('excess1');
			}else{
				var files = new FormData($('#form_data')[0]);
				$.ajax({
					type: "POST",
					enctype: 'multipart/form-data',
					url: '${root}user/us_report',
					data: files,
					processData: false,
					contentType: false,
					cache: false,
					success: function (data) {
						$('.comm_buttons .btn_close').click();
						openPop('ok');
					},
					error: function (e) { 
						openPop('fail');
					}
				});
			}
		});
	});
</script>
</head>
<!-- #팝업 신고하기 -->
<div class="report_wrap pop_wrap">
	<h4 class="pop_tit">정말 신고하시겠습니까?</h4>
	<form class="comm_form" id="form_data" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pronum" value="${login.pronum }">
		<input type="hidden" name="rlreporter" value="${login.proname }">
		<input type="hidden" name="reporterid" value="${login.proid }">
		<input type="hidden" name="pronum_sync" value="${profile.pronum }">
		<input type="hidden" name="rltarget" value="${profile.proname }">
		<input type="hidden" name="targetid" value="${profile.proid }">
		<div class="file_box">
			<p class="txt_hf plc_holder"><span>(필수)</span> 신고 자료를 캡쳐하여 첨부해주세요</p>
			<input type="file" class="fl_name" id="festa1" name="files" accept="image/*">
			<label for="festa1" class="btn_hf"><i class="xi-file-upload-o"></i><em class="snd_only">파일 첨부하기</em></label>
		</div>
		<ul class="rdo_list">
			<li>
				<input type="radio" class="comm_rdo report_1" id="festaRs1" name="rlreport" value="타인에 대한 욕설 또는 비방" checked="checked">
				<label for="festaRs1">타인에 대한 욕설 또는 비방</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_2" id="festaRs2" name="rlreport" value="불법정보 유출">
				<label for="festaRs2">불법정보 유출</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_3" id="festaRs3" name="rlreport" value="인신공격 또는 명예훼손">
				<label for="festaRs3">인신공격 또는 명예훼손</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_4" id="festaRs4" name="rlreport" value="같은 내용의 반복 (도배)">
				<label for="festaRs4">같은 내용의 반복 (도배)</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_5" id="festaRs5" name="rlreport" value="개인정보 유출 또는 사생활 침해 ">
				<label for="festaRs5">개인정보 유출 또는 사생활 침해</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_6" id="festaRs6" name="rlreport" value="지역감정 조장">
				<label for="festaRs6">지역감정 조장</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_7" id="festaRs7" name="rlreport" value="음란성 내용 또는 음란물 링크">
				<label for="festaRs7">음란성 내용 또는 음란물 링크</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_8" id="festaRs8" name="rlreport" value="폭력 또는 사행심 조장">
				<label for="festaRs8">폭력 또는 사행심 조장</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_9" id="festaRs9" name="rlreport" value="상업적 광고, 사이트 홍보">
				<label for="festaRs9">상업적 광고, 사이트 홍보</label>
			</li>
			<li>
				<input type="radio" class="comm_rdo report_10" id="festaRs10" name="rlreport" value="기타">
				<label for="festaRs10">기타</label>
			</li>
		</ul>
		<div class="txt_box">
			<textarea class="report_11" name="rlreport"></textarea>
		</div>
		<div class="btn_box">
			<p>
				<b>허위 신고</b>일 경우 <b>신고자의 활동에 제한</b>을 받을 수 있으니<br>
				이 점 유의해주시기 바랍니다.
			</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" class="comm_btn sbm report_btn">신고하기</button></li>
			</ul>
		</div>
	</form>
</div>
<!-- #댓글 초과팝업 { -->
<div id="excess1" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">500자 이상 입력할수 없습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<div id="ok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">신고가 정상적으로 접수되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm ok_btn">확인</button></li>
		</ul>
	</div>
</div>
<div id="fail" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">신고등록에 실패 하였습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	btnPop('btn_pop2');

	reportForm();
	fileName();
</script>

</html>