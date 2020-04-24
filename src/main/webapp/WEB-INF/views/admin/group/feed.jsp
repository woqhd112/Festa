<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var url = window.location.href;
	if(url.indexOf('feed')>0){
		window.location.href='${root}empty';
	}
	$(document).ready(function(){
		/* var closeBtn = $('#success2').find('.btn_close');
		closeBtn.on('click', function() {
			var target = $('#delete2').find('.btn_close');
			setTimeout(function() {
				target.trigger('click');
			}, 250);
			
			console.log(target);
		}); */
		var textBox = $('#delete2 .pop_tit');
		var text;
		
		//피드삭제버튼 눌렀을때
		$(document).on('click', '.btn_feed.pp', function() {
			var value = $(this).data('value');
			 $('#num').val(value);
			 console.log($('#num').val());
			 text = '선택하신 피드를 삭제하시겠습니까?';
			 textBox.text(text);
			 console.log(text);
		});
		
		//댓글삭제버튼 눌렀을때
		$(document).on('click', '.btn_cmmt.pp', function() {
			var value = $(this).data('value');
			 $('#num').val(value);
			 console.log($('#num').val());
			 text = '선택하신 댓글 삭제하시겠습니까?';
			 textBox.text(text);
			 console.log(text);
		});
		
		//삭제하기버튼 클릭시
		$(document).on('click', '#delete_btn', function() {
			//그 버튼이 댓글일때
			if(text == '선택하신 댓글 삭제하시겠습니까?'){
				console.log(text);
				var gncnum = $('#num').val();
				$.post('${root}admin/group/detail/ntc_feed/cmmtdel','gncnum='+gncnum,function(data){
					$('#delete2').find('.comm_buttons .btn_close').click();
					$('.btn_close.ok').click(function(){
						location.reload();
					});
				});
			//그 버튼이 게시글일때
			}else if(text == '선택하신 피드를 삭제하시겠습니까?'){
				console.log(text);
				var gnnum = $('#num').val();
				$.post('${root}admin/group/detail/ntc_feed/del','gnnum='+gnnum,function(){
					$('#delete2').find('.comm_buttons .btn_close').click();
					$('.btn_close.ok').click(function(){
						location.reload();
					});
				});
			}
		});
		
		//댓글 더보기버튼
		$(document).on('click', '.cmt_btn_more.pp', function() {
			var btn = $(this);
			var pageTag = $(this).find('span');
			var myPage = pageTag.text();
			myPage++;
			pageTag.text(myPage);
			console.log('현재페이지',myPage);
			var feed = btn.parents('.feed_viewer');
			var comments = btn.siblings('.comment_list');
			var gnnum = feed.find('input[type=hidden]').val();
			console.log('공지사항번호',gnnum);
			$.get('${root}admin/group/detail/notice/cmmt','gnnum=${noticedetail.gnnum}&pageSearch.page4='+myPage,function(data){
				$(data).each(function(index){
					var prophoto=data[index].profile.prophoto;
					var prophototag;
					if(prophoto==null||prophoto==''||prophoto==undefined||prophoto.inEmpty){
						prophototag='<img src="${root}resouces/images/thumb/no_profile.png" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}else{
						prophototag='<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}
					if(index==3){
						 return false;
					}else if(data.length<4){
						btn.hide();
					}
					comments.append('<li>'+
							'<a href="${root }admin/user/detail?pronum='+data[index].pronum+'" class="pf_picture">'+
							prophototag+
							'</a><p class="cmt_content">'+
								'<a href="${root }admin/user/detail?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].gncauthor+'</a>&nbsp;'+
								data[index].gnccontent+
								'<span class="cmt_date">'+data[index].gncdate1+'</span>'+
								'<button class="btn_pop btn_delete btn_cmmt pp" data-layer="delete2" data-value="'+data[index].gncnum+'"><em class="snd_only">삭제하기</em></button></p>'+
						'</li>');
				});//each문 end
			});//ajax통신 end
		});//댓글더보기 end
	});
</script>
</head>
<!-- #팝업 피드 -->
<!-- #텍스트+썸네일 피드 시작 { -->
<body>
<div class="adm">
	<div class="feed_viewer<c:if test="${noticedetail.gnphoto ne '' }"> half</c:if>">
		<div class="tit box">
			<dl class="feed_inform">
				<dt>
					<a href="${root }admin/user/detail?pronum=${noticedetail.profile.pronum}">
						<input type="hidden" value="${noticedetail.gnnum }">
						<c:if test="${!empty noticedetail.profile.prophoto }">
							<span class="pf_picture"><img src="${upload }/${noticedetail.profile.prophoto}" alt="${noticedatail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
						</c:if>
						<c:if test="${empty noticedetail.profile.prophoto }">
							<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${noticedatail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
						</c:if>
						<span class="fd_name">${noticedetail.gnauthor }</span>
					</a>
					<a href="${root }admin/group/detail?grnum=${noticedetail.grnum}">
						<span class="fd_group">${noticedetail.group.grname }</span>
					</a>
				</dt>
				<dd>
					<span class="fd_date">${noticedetail.gndate1 }</span>
				</dd>
			</dl>
			<ul class="feed_options">
				<li><button class="btn_pop btn_delete btn_feed pp" data-layer="delete2" data-value="${noticedetail.gnnum }"><em class="snd_only">삭제하기</em></button></li>
			</ul>
		</div>
		<div class="text box">
			<div class="scrBar">
				<div class="feed_content">
					<pre class="fd_content"><c:out value="${noticedetail.gncontent }"/></pre>
				</div>
				<ul class="comment_list">
					<c:set var="i" value="0"/>
					<c:set var="doneLoop" value="false"/>
					<c:forEach items="${noticecmmt }" var="noticecmmt">
						<c:if test="${not doneLoop }">
						<li>
							<!-- # 프로필 이미지 없음 { -->
							<a href="${root }admin/user/detail?pronum=${noticecmmt.pronum}" class="pf_picture">
							<c:if test="${!empty noticecmmt.profile.prophoto }">
								<img src="${upload }/${noticecmmt.profile.prophoto}" alt="${noticecmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
							</c:if>
							<c:if test="${empty noticecmmt.profile.prophoto }">
								<img src="${root }resources/images/thumb/no_profile.png" alt="${noticecmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
							</c:if>
							</a>
							<!-- } # 프로필 이미지 없음 -->
							<p class="cmt_content">
								<a href="${root }admin/user/detail?pronum=${noticecmmt.pronum}" class="cmt_name">${noticecmmt.gncauthor }</a>
								${noticecmmt.gnccontent }
								<span class="cmt_date">${noticecmmt.gncdate1 }</span>
								<button class="btn_pop btn_delete btn_cmmt pp" data-layer="delete2" data-value="${noticecmmt.gncnum }"><em class="snd_only">삭제하기</em></button>
							</p>
						</li>
							<c:set var="i" value="${i+1 }"/>
							<c:if test="${i eq 3 }">
								<c:set var="doneLoop" value="true"/>
							</c:if>
						</c:if>
					</c:forEach>
				</ul>
				<c:if test="${noticedetail.gntotal gt 3 }">
					<button class="cmt_btn_more pp"><span class="snd_only">1</span>3개의 댓글 더 보기</button>
				</c:if>
			</div>
		</div>
		<c:if test="${!empty noticedetail.gnphoto }">
		<!-- # 썸네일 영역 { -->
		<div class="img box">
			<div class="thumb_slide">
				<div class="swiper-wrapper">
					<c:set var="feedphoto" value="${noticedetail.gnphoto }" />
					<c:forTokens items="${feedphoto }" delims="," var="item">
						<div class="swiper-slide">
							<img src="${upload }/${item }" alt="">
						</div>
					</c:forTokens>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
		</c:if>
		<!--  } # 썸네일 영역 -->
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<!-- #피드 삭제하기 { -->
<div id="delete2" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 피드를 삭제하시겠습니까?</h4>
		<input type="hidden" id="num" value="">
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="delete_btn" class="btn_pop comm_btn cfm" data-layer="success2">삭제하기</button></li>
			</ul>
		</form>
	</div>
</div>
<!-- } #팝업 삭제하기 -->
<!-- #팝업 처리완료 { -->
<div id="success2" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close ok comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #텍스트+썸네일 피드 끝 -->
<script type="text/javascript">
	scrBar();
	btnPop('btn_pop2');
</script>
</body>
</html>