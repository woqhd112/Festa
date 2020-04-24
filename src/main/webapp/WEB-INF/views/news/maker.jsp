<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<script type="text/javascript">
	var url = window.location.href;
	if (url.indexOf('edit') > 0) location.href='${root}empty';
	
	$('#editForm').on('submit', function(e) {
		var parent = $(this).parents('.fstPop');
		var files = new FormData($('#editForm')[0]);
		
		var strSize = stringValue($(this));
		
		if (strSize == true) {
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: '${root}news/edit',
				data: files,
				processData: false,
				contentType: false,
				cache: false,
				success: function() {
					$('#alert .pop_tit').text('수정이 완료되었습니다.');
				},
				error: function() { 
					$('#alert .pop_tit').text('올바른 방법으로 다시 시도해주세요.');
				},
				complete: function() {
					parent.bPopup().close();
					openPop('alert', none, refresh);
				}
			});
		}
		
		e.preventDefault();
	});
</script>
<!-- #피드 수정하기 -->
<div class="feed_maker">
	<h3>피드 수정</h3>
	<form class="maker_form" id="editForm" enctype="multipart/form-data">
		<c:set var="group" value="${feed.gpnum ne 0}" />
		<c:choose>
			<c:when test="${!group}">
				<c:set var="num" value="mpnum" />
				<c:set var="content" value="mpcontent" />
				<c:set var="photo" value="mpphoto" />
				<c:set var="feedNum" value="${feed.mpnum}" />
				<c:set var="feedContent" value="${feed.mpcontent}" />
				<c:set var="feedImages" value="${feed.mpphoto}" />
			</c:when>
			<c:otherwise>
				<c:set var="num" value="gpnum" />
				<c:set var="content" value="gpcontent" />
				<c:set var="photo" value="gpphoto" />
				<c:set var="feedNum" value="${feed.gpnum}" />
				<c:set var="feedContent" value="${feed.gpcontent}" />
				<c:set var="feedImages" value="${feed.gpphoto}" />
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="${num}" value="${feedNum}">
		<div class="mk_cont box">
			<p class="pf_picture">
			<c:choose>
				<c:when test="${!empty feed.profile.prophoto}"><img src="${upload}/${feed.profile.prophoto}" alt="${feed.profile.proname}님의 프로필 썸네일" onload="squareTrim($(this), 55)"></c:when>
				<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${feed.profile.proname}님의 프로필 썸네일" onload="squareTrim($(this), 55)"></c:otherwise>
			</c:choose>
			</p>
			<textarea name="${content}" placeholder="${feed.profile.proname} 님, 무슨 생각을 하고 계신가요?" required="required">${feedContent}</textarea>
		</div>
		<div class="file_thumbnail mk_thumb box">
			<ul>
				<c:set var="i" value="0"/>
				<c:forTokens items="${feedImages}" var="images" delims=",">
					<c:set var="i" value="${i+1}"/>
					<li class="ft_thumb">
						<input type="hidden" name="${photo}" value="${images}"/>
						<input type="file" id="file${i}" name="files" accept="video/*, image/*" value="${upload}/${images}">
						<img src="${upload}/${images}" alt="">
						<button class="btn_cancle" type="button">
							<em class="snd_only">업로드 취소하기</em>
						</button>
						<label for="file${i}" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
					</li>
				</c:forTokens>
				<c:if test="${i lt 5}">
					<c:forEach begin="${i}" end="4">
						<c:set var="i" value="${i+1 }"/>
						<li class="ft_btn">
							<input type="file" id="file${i}" name="files" accept="video/*, image/*">
							<img src="" alt="">
							<button class="btn_cancle" type="button">
								<em class="snd_only">업로드 취소하기</em>
							</button>
							<label for="file${i}" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div class="mk_bottom box">
			<ul class="mk_tags">
				<li><input type="text" name="httitle1" value="${feed.httitle1}"></li>
				<li><input type="text" name="httitle2" value="${feed.httitle2}"></li>
				<li><input type="text" name="httitle3" value="${feed.httitle3}"></li>
			</ul>
			<ul class="mk_btns">
				<li>
					<label for="file1" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
				</li>
				<li>
					<button type="submit" class="btn_send"><em class="snd_only">피드 수정하기</em></button>
				</li>
			</ul>
		</div>
	</form>
</div>
<button type="button" id="close_btn" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	setFile();
</script>