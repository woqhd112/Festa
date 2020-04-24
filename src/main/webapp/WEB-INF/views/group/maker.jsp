<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<!-- #피드 수정하기 -->
<script type="text/javascript">

	$('#update_feed').on('submit', function(e){
		e.preventDefault();
		var gpcontent = $('#gpcontent1').val();
		console.log(gpcontent);
		
		if(gpcontent == '' || gpcontent == null){
			console.log('??');
			e.preventDefault();
			return false;
			//openPop('makerFail');
			//$('#makerfailed').on('click', function(){
			//	location.reload();
			//});
		}
		var content=$('#gpcontent1').val().length;
		var ht1=$('#httitle1_1').val().length;
		var ht2=$('#httitle2_1').val().length;
		var ht3=$('#httitle3_1').val().length;
		
		if(content>=500){
			openPop("cneditfull");
			$('#editcnfailed').on('click', function(){
				$('#gpcontent1').focus();					
			});
			return false;
		};
		if(ht1>=20){
			openPop("hteditfull");
			$('#edithtfailed').on('click', function(){
				$('#httitle1_1').focus();		
			})
			return false;
		}
		if(ht2>=20){
			openPop("hteditfull");
			$('#edithtfailed').on('click', function(){
				$('#httitle2_1').focus();		
			})
			return false;
		}
		if(ht3>=20){
			openPop("hteditfull");
			$('#edithtfailed').on('click', function(){
				$('#httitle3_1').focus();		
			})
			return false;
		}
		
		var httitle1= $('#httitle1_1').val();
		var httitle2= $('#httitle2_1').val();
		var httitle3= $('#httitle3_1').val();
		var mpnum = "${feedDetail.gpnum}";
		
		var files = new FormData($('#update_feed')[0]);
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: '${root}group/maker',
			data: files,
			processData: false,
			contentType: false,
			cache: false,
			success: function (data) {
				openPop('updateOk');
				$('#finish_update').on('click', function() {
					location.reload();
				});
			},
			error: function (e) { 
				openPop('fail');
				e.preventDefault();
			}
		});
	});

</script>
<!-- #피드 수정하기 -->
<div class="feed_maker">
	<h3>피드 수정하기</h3>
	<form class="maker_form" id="update_feed" enctype="multipart/form-data">
		<input type="hidden" name="gpnum" value="${feedDetail.gpnum }"/>
		<!-- 그룹페이지일 경우 공지 {
		<p class="mk_noti">
			<input type="checkbox" class="comm_chk" id="festaNt" name="">
			<label for="festaNt">공지</label>
		</p>
		} 그룹페이지일 경우 공지 -->
			<div class="mk_cont box">
			<c:choose>
				<c:when test="${login.prophoto eq null }">
					<p class="pf_picture">
						<img src="${root}resources/images/thumb/no_profile.png"
							alt="${login.proname } 님의 프로필 썸네일" onload="squareTrim($(this), 60)">
					</p>
				</c:when>
				<c:otherwise>
					<p class="pf_picture">
						<img src="${upload }/${login.prophoto }"
							alt="${login.proname } 님의 프로필 썸네일" onload="squareTrim($(this), 60)">
					</p>
				</c:otherwise>
			</c:choose>
			<textarea id="gpcontent1" name="gpcontent" placeholder="${login.proname } 님, 무슨 생각을 하고 계신가요?" required="required">${feedDetail.gpcontent}</textarea>
		</div>
		<div class="file_thumbnail mk_thumb box" style="display: block">
			<ul>
				<c:set var="count" value="0" />
				<c:forTokens items="${feedDetail.gpphoto }" delims="," var="item">
					<c:set var="count" value="${count+1 }" />
					<li class="ft_thumb">
						<input type="hidden" id="gpphoto${count }" name="gpphoto" value="${item }" />
						<input type="file" id="file1_${count }" name="filess" accept="video/*, image/*" value="${item }" /> 
						<img src="${upload }/${item}" alt="">
						<button class="btn_cancle" id="btn_gpphoto${count }" type="button">
							<em class="snd_only">업로드 취소하기</em>
						</button> <label for="file1_${count }" class="btn_file">
							<em	class="snd_only">사진/동영상 업로드하기</em>
						</label>
					</li>
				</c:forTokens>
				<c:forEach begin="${count }" end="4">
				<c:set var="count" value="${count+1 }" />
					<li class="ft_btn"><input type="file"
						id="file1_${count }" name="filess" accept="video/*, image/*" /> <img
						src="" alt="">
						<button class="btn_cancle" type="button">
							<em class="snd_only">업로드 취소하기</em>
						</button> <label for="file1_${count }" class="btn_file"><em
							class="snd_only">사진/동영상 업로드하기</em></label></li>
				</c:forEach>
			</ul>
		</div>
		<div class="mk_bottom box">
			<ul class="mk_tags">
				<li><input type="text" id="httitle1_1" name="httitle1" value="${feedDetail.httitle1 }"/></li>
				<li><input type="text" id="httitle2_1" name="httitle2" value="${feedDetail.httitle2 }"/></li>
				<li><input type="text" id="httitle3_1" name="httitle3" value="${feedDetail.httitle3 }"/></li>
			</ul>
			<ul class="mk_btns">
				<li>
					<label for="file1_1" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
				</li>
				<li>
					<button type="submit" class="btn_send" id="feedUpdate" name="feedUpdate"><em class="snd_only">피드 게시하기</em></button>
				</li>
			</ul>
		</div>
	</form>
</div>

	
	<div id="updateOk" class="fstPop pop2">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">수정이 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="finish_update" name="finish_update" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>


	<!-- #게시글 초과 -->
	<div id="cneditfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">게시글은 500자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="editcnfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>

	<!-- #해시태그 초과 -->
	<div id="hteditfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">해시태그는 20자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="edithtfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>

<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	btnPop('btn_pop2');
	setFile();
</script>
