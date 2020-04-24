<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root}resources/images/ico/logo.png">
	<script type="text/javascript" src="${root}resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root}resources/js/util.js"></script>
	<script type="text/javascript" src="${root}resources/js/site.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="shortcut icon" href="${root}resources/favicon.ico">
	<title>FESTA</title>
	<script type="text/javascript">
	function btn_close(){
        document.cookie = 'loginCookie' + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
        var url = window.location.href;
    	if(url.indexOf('group')>0||url.indexOf('news')>0||url.indexOf('user')>0||url.indexOf('admin')>0||url.indexOf('empty')>0){
    		window.location.href='${root}';
    	}
	}
	$(function(){
		var cookie = '${cookie.loginCookie.value}';
		var login = '${login ne null}';

		if(cookie!=''&&login=='false'){
			openPop('loginCookie',none,btn_close);
		}

		setInterval(function(){
			$.post('${root}member/loginSession','',function(data){
				if(data==''&&document.cookie!=''){
					clearInterval();
					openPop('loginCookie',none,btn_close);
				}
			});
		},1000*60*10);
		
		$('#btnCookie').on('click',function(){
			$.post('${root}member/loginCookie','id='+cookie,function(data){
				if (data.prorn == '0') {
					location.reload();
				} else if (data.prorn == '1') {
					location.href = "${root}member/stop";
				} else if (data.prorn == '2') {
					location.href = "${root}member/kick";
				} else if (data.prorn == '3') {
					location.reload();
				} else if (data.prorn == '4') {
					location.href = "${root}";
				}
			});
		});
		
		// 피드 더보기
		$(window).on('scroll', function(){
			var active = $(window).scrollTop() >= $(document).height() - $(window).height() - 1;
			if (active) moreFeed();
		});
		
		// 신고
		$(document).on('click', '.btn_report', function(e) {
			var url = makeUrl($(this));
			openLayer(e, url);
		});
		
		// 피드 수정
		$(document).on('click', '.btn_edit', function(e) {
			var url = makeUrl($(this));
			openLayer(e, url);
		});
		
		// 댓글입력
		$(document).on('submit', '.message_form', function(e) {
			e.preventDefault();
			var input = $(this).find('input[type=text]');
			stringValue($(this));
			
			var strSize = stringValue($(this));
			if (strSize == true) {
				post($(this));
			}
		});
		
		// 피드/댓글 삭제
		$('#deleteForm').on('submit', function(e) {
			e.preventDefault();
			post($(this));
		});
	});
	// 그룹/개인
	function feedSeparate(tag) {
		var group = tag.find('.fd_group');
		var mpnum, gpnum;
		if (!group.length > 0) {
			// 개인피드
			mpnum = tag.data('num');
			gpnum = 0;
		} else {
			// 그룹피드
			mpnum = 0;
			gpnum = tag.data('num');
		}
		return {
			mpnum: mpnum,
			gpnum: gpnum,
		}
	}
	function post(form) {
		var type = form.attr('method'),
			url = form.attr('action'),
			data = form.serialize();
		var success;
		if (form.attr('id') == 'deleteForm') {
			$('#alert').bPopup().close();
			success = function() {
				var alertText = form.siblings('.pop_tit'),
					alertBtns = form.siblings('.comm_buttons');
				form.hide();
				alertBtns.show();
				alertText.text('삭제가 완료되었습니다.');
				openPop('alert', none, refresh);
			}
		} else {
			success = refresh;
		}
		$.ajax({
			type: type,
			url: url,
			data: data,
			success: success(),
			error: function() {
				$('#alert .pop_tit').text('올바른 방법으로 다시 시도해주세요.');
				openPop('alert', none, refresh);
			},
		});
	}
	function deleted(button) {
		var viewer = button.parents('.feed_viewer'),
			group = viewer.find('.fd_group');
		var feed = button.parents('.feed_options');
		
		var delForm = $('#deleteForm'),
			delInput = delForm.find('input[type=hidden]');
		var alertText = $('#alert').find('.pop_tit'),
			alertBtns = delForm.siblings('.comm_buttons');
		
		delForm.show();
		alertBtns.hide();
		
		if (feed.length > 0) {
			alertText.text('피드를 삭제하시겠습니까?');
			delForm.attr('action', '${root}news/del');
			if (!group.length > 0) {
				delInput.attr({
					'name': 'mpnum',
					'value': viewer.data('num'),
				});
			} else {
				delInput.attr({
					'name': 'gpnum',
					'value': viewer.data('num'),
				});
			}
			
		} else {
			alertText.text('댓글을 삭제하시겠습니까?');
			delForm.attr('action', '${root}news/cmmtdel');
			if (!group.length > 0) {
				delInput.attr({
					'name': 'mcnum',
					'value': button.data('num'),
				})
			} else {
				delInput.attr({
					'name': 'gcnum',
					'value': button.data('num'),
				})
			}
		}
		openPop('alert');
	}
	// 좋아요
	function liked(button) {
		var plus = !button.hasClass('act');
		var viewer = button.parents('.feed_viewer'),
			cntTag = viewer.find('.fd_liked'),
			cnt = Number(cntTag.text());
		var feedNum = feedSeparate(viewer);
		var url = '${root}news/',
			param = {
				pronum: '${login.pronum}',
				mpnum: feedNum.mpnum,
				gpnum: feedNum.gpnum,
			};
		
		if (plus) {
			$.post(url+'likeadd', param)
				.done(function() {
					cntTag.text(cnt+1);
				});
		} else {
			$.post(url+'likedel', param)
				.done(function() {
					cntTag.text(cnt-1);
				});
		}
	}
	// 신고/수정하기 경로
	function makeUrl(button) {
		var viewer = button.parents('.feed_viewer');
		var feed = feedSeparate(viewer);
		var url = button.attr('href');
		var param = {
			mpnum: feed.mpnum,
			gpnum: feed.gpnum,
		};
		var keys = Object.keys(param),
			values = Object.values(param);
		for (var i=0; i<keys.length; i++) {
			(i == 0) ? url += '?' : url += '&';
			url += keys[i] + '=' + values[i];
		}
		return url;
	}
	// 피드 더보기
	function moreFeed() {
		var container = $('.content_area');
		var page = $('#pageNum'),
			pageNum = Number(page.text());
		page.text(pageNum += 1);
		var param = {
				'pronum': '${login.pronum}',
				'pageSearch.page5': pageNum,
		};
		$.post('${root}news/more', param)
			.success(function(html) {
				var target = $(html).find('.feed_viewer');
				target.appendTo(container);
				commSlider();
				scrBar();
			});
	}
	// 댓글 더보기
	function moreComment(button) {
		var viewer = button.parents('.feed_viewer');
		var feedNum = feedSeparate(viewer);
		var page = button.find('span'),
			pageNum = Number(page.text());
		page.text(pageNum += 1);
		var param = {
			'mpnum': feedNum.mpnum,
			'gpnum': feedNum.gpnum,
			'pageSearch.page4': pageNum,
		}
		var container = viewer.find('.comment_list');
		$.get('${root}news/comment', param)
			.success(function(data) {
				var size;
				if (data.length < 4) {
					size = data.length;
					button.hide();
				} else {
					size = 3;
				}
				
				for (var i=0; i<size; i++) {
					var d = data[i];
					var photo, trim, num, content, date;
					if (d.profile.prophoto != '') {
						photo = '${upload}/'+d.profile.prophoto;
						trim = 'onload="squareTrim($(this), 30)"';
					} else {
						photo = '${root}resources/images/thumb/no_profile.png'
						trim = 'width="30"';
					}
					if (d.gpnum == undefined) {
						num = d.mcnum;
						content = d.mccontent;
						date = d.mcdate1;
					} else {
						num = d.gcnum;
						content = d.gccontent;
						date = d.gcdate1;
					}
					var tag = '<li>'
						+ '<a href="${root}user/?pronum='+d.pronum+'" class="pf_picture" '+trim+'>'
						+ '<img src="'+photo+'" alt="'+d.profile.proname+'님의 프로필 썸네일" '+trim+'>'
						+ '</a>'
						+ '<p class="cmt_content">'
						+ '<a href="${root}user/?pronum='+d.pronum+'" class="cmt_name">'+d.profile.proname+'</a>'
						+ '&nbsp;'+content
						+ '<span class="cmt_date">'+date+'</span>'
						+ '<button class="btn_delete" data-num="'+num+'" onclick="deleted($(this))"><em class="snd_only">삭제하기</em></button>'
						+ '</p>'
						+ '</li>';
					container.append(tag);
				}
			});
	}
	</script>
</head>
<body>
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
	<c:redirect url="${root}empty"/>
</c:if>
<c:if test="${sessionScope.login ne null }">
   <c:if test="${sessionScope.login.proid eq 'admin@festa.com'}">
      <c:redirect url="${root}empty"/>
   </c:if>
</c:if>
<div id="wrap">
	<div id="header">
		<div class="scrX">
			<div class="container">
				<h1>
					<a href="${root}"><em class="snd_only">FESTA</em></a>
				</h1>
				<form class="search_box" action="${root}search/">
					<input type="text" name="keyword" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
					<button type="submit">
						<img src="${root}resources/images/ico/btn_search.png" alt="검색">
					</button>
				</form>
				<ul id="gnb">
					<li><a href="${root}camp/">캠핑정보</a></li>
					<li><a href="${root}hot/">인기피드</a></li>
					<li><a href="${root}news/?pronum=${login.pronum}">뉴스피드</a></li>
					<c:if test="${login eq null }">
					<li><a href="${root}member/login" class="btn_pop">로그인</a></li>
					</c:if>
					<c:if test="${login ne null }">
					<li><a href="${root}user/?pronum=${login.pronum}">마이페이지</a></li>
					</c:if>
				</ul>
				<c:if test="${login ne null }">
				<div id="userMenu" class="fstLyr">
					<button class="btn_menu">
						<em class="snd_only">나의 메뉴 더보기</em>
					</button>
					<dl class="menu_box" tabindex="0">
						<dt>
							<b>${login.proname }님 환영합니다.</b>
						</dt>
						<dd>
							<span class="btn_mylist">나의 그룹</span>
							<div class="my_list">
								<ul>
									<c:forEach items="${joinGroup }" var="joinGroup">
									<c:choose>
										<c:when test="${joinGroup.group.grphoto eq null }">
										<li>
											<a href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
												<span><img src="${root }resources/upload/thumb/no_profile.png" alt="${joinGroup.group.grname } 그룹 썸네일"></span>
												<b>${joinGroup.group.grname }</b>
											</a>
										</li>
										</c:when>
										<c:otherwise>
										<li>
											<a href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
												<span><img src="${upload }/${joinGroup.group.grphoto}" alt="${joinGroup.group.grname } 그룹 썸네일"></span>
												<b>${joinGroup.group.grname }</b>
											</a>
										</li>
										</c:otherwise>
									</c:choose>
									</c:forEach>
								</ul>
							</div>
						</dd>
						<dd>
							<span class="btn_mylist">나의 채팅</span>
							<div class="my_list">
								<ul>
									<c:forEach items="${joinGroup }" var="joinGroup">
										<c:choose>
											<c:when test="${joinGroup.group.grphoto eq null }"> 
												<li>
													<a style="cursor: pointer" onclick="window.open('${root}group/chat?grnum=${joinGroup.grnum }','Festa chat','width=721,height=521,location=no,status=no,scrollbars=no');">
														<span><img src="${root}resources/images/thumb/no_profile.png" alt="${joinGroup.group.grname } 그룹 썸네일"></span>
														<b>${joinGroup.group.grname }</b>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li>
													<a style="cursor: pointer" onclick="window.open('${root}group/chat?grnum=${joinGroup.grnum }','Festa chat','width=721,height=521,location=no,status=no,scrollbars=no');">
														<span><img src="${upload }/${joinGroup.group.grphoto}" alt="${joinGroup.group.grname } 그룹 썸네일"></span>
														<b>${joinGroup.group.grname }</b>
													</a>
												</li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</ul>
							</div>
						</dd>
						<dd>
							<span class="btn_mylist">나의 캠핑장</span>
							<div class="my_list">
								<ul>
								<c:forEach items="${bookMark}" var="bookMark">
									<li>
										<a href="${root}camp/detail?canum=${bookMark.camp.canum}&caaddrsel=${bookMark.camp.caaddrsel}">
											<span>
												<c:set var="image" value="${fn:substringBefore(bookMark.camp.caphoto,',')}"></c:set>
												<c:if test="${!empty bookMark.camp.caphoto && empty image}"><img src="${upload}/${bookMark.camp.caphoto}" alt="${bookMark.camp.caname}"></c:if>
												<c:if test="${!empty bookMark.camp.caphoto && !empty image}"><img src="${upload}/${image}" alt="${bookMark.camp.caname}"></c:if>
												<c:if test="${empty bookMark.camp.caphoto && empty image}"><img src="${root}resources/images/thumb/no_profile.png" alt="${bookMark.camp.caname}"></c:if>
											</span>
											<b>${bookMark.camp.caname}</b>
										</a>
									</li>
								</c:forEach>
								</ul>
							</div>
						</dd>
						<dd class="btn_logout">
							<form>
								<a href="${root}member/logout" class="btn_pop">로그아웃</a>
							</form>
						</dd>
					</dl>
				</div>
				</c:if>
				<button type="button" id="btnTop">
					<em class="snd_only">맨 위로</em>
				</button>
			</div>
		</div>
	</div>
	<!-- #뉴스피드 -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="feed_wrap">
		<h2 class="snd_only">뉴스피드</h2>
		<em id="pageNum" class="snd_only">1</em>
		<div class="container">
		<c:choose>
			<c:when test="${feedList ne null}">
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
			<c:forEach items="${feedList}" var="feed">
				<c:set var="groupFeed" value="${feed.gpnum ne 0}" />
				<c:choose>
					<c:when test="${!groupFeed}">
						<c:set var="feedContent" value="${feed.mpcontent}" />
						<c:set var="feedImages" value="${feed.mpphoto}" />
						<c:set var="feedNum" value="${feed.mpnum}" />
						<c:set var="cmmtCount" value="${feed.mptotal}" />
						<c:set var="feedComment" value="${followComment}" />
					</c:when>
					<c:otherwise>
						<c:set var="feedContent" value="${feed.gpcontent}" />
						<c:set var="feedImages" value="${feed.gpphoto}" />
						<c:set var="feedNum" value="${feed.gpnum}" />
						<c:set var="cmmtCount" value="${feed.gptotal}" />
						<c:set var="feedComment" value="${groupComment}" />
					</c:otherwise>
				</c:choose>
				<div class="feed_viewer<c:if test="${!empty feedImages}"> half</c:if>" data-num="${feedNum}">
					<div class="tit box">
						<dl class="feed_inform">
							<dt>
								<a href="${root}user/?pronum=${feed.pronum}">
									<span class="pf_picture">
									<c:choose>
										<c:when test="${!empty feed.profile.prophoto}"><img src="${upload}/${feed.profile.prophoto}" alt="${feed.profile.proname}님의 프로필 썸네일"></c:when>
										<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${feed.profile.proname}님의 프로필 썸네일"></c:otherwise>
									</c:choose>
									</span>
									<span class="fd_name">${feed.profile.proname}</span>
								</a>
								<c:if test="${groupFeed}">
								<a href="${root}group/?grnum=${feed.grnum}&pronum=${login.pronum}"><span class="fd_group">${feed.group.grname}</span></a>
								</c:if>
							</dt>
							<dd>
								<span class="fd_date">${feed.date1}</span>
								<b class="fd_liked">${feed.good}</b>
							</dd>
						</dl>
						<ul class="feed_options">
							<li>
								<button class="btn_liked<c:forEach items="${goodlist}" var="good"><c:if test="${good.mpnum eq feedNum || good.gpnum eq feedNum}"> act</c:if></c:forEach>" onclick="liked($(this))"><em class="snd_only">하트</em></button>
							</li>
							<c:choose>
								<c:when test="${login.pronum eq feed.pronum}">
									<li><a href="${root}news/edit" class="btn_edit"><em class="snd_only">수정하기</em></a></li>
									<li><button class="btn_delete" data-num="${feedNum}" onclick="deleted($(this))"><em class="snd_only">삭제하기</em></button></li>
								</c:when>
								<c:otherwise>
									<li><a href="${root}news/report" class="btn_report"><em class="snd_only">신고하기</em></a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<div class="text box">
						<div class="scrBar">
							<div class="feed_content">
								<ul class="fd_hashtag">
									<c:if test="${!empty feed.httitle1}"><li><a href="${root}search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li></c:if>
									<c:if test="${!empty feed.httitle2}"><li><a href="${root}search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li></c:if>
									<c:if test="${!empty feed.httitle3}"><li><a href="${root}search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li></c:if>
								</ul>
								<pre class="fd_content">${feedContent}</pre>
							</div>
							<ul class="comment_list">
								<c:set var="i" value="0" />
								<c:set var="doneLoop" value="false" />
								<c:forEach items="${feedComment}" var="comment">
								<c:if test="${not doneLoop}">
								<c:set var="groupCmmt" value="${feedComment eq groupComment}" />
								<c:choose>
									<c:when test="${!groupCmmt}">
										<c:set var="cmmtNum" value="${comment.mcnum}" />
										<c:set var="cmmtContent" value="${comment.mccontent}" />
										<c:set var="cmmtDate" value="${comment.mcdate1}" />
										<c:set var="myComment" value="${feed.mpnum eq comment.mpnum}"></c:set>
									</c:when>
									<c:otherwise>
										<c:set var="cmmtNum" value="${comment.gcnum}" />
										<c:set var="cmmtContent" value="${comment.gccontent}" />
										<c:set var="cmmtDate" value="${comment.gcdate1}" />
										<c:set var="gpComment" value="${feed.gpnum eq comment.gpnum}"></c:set>
									</c:otherwise>
								</c:choose>
								<c:if test="${myComment or gpComment}">
								<li>
									<a href="${root}user/?pronum=${comment.pronum}" class="pf_picture">
									<c:choose>
										<c:when test="${!empty comment.profile.prophoto}"><img src="${upload}/${comment.profile.prophoto}" alt="${comment.profile.proname}님의 프로필 썸네일"></c:when>
										<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${comment.profile.proname}님의 프로필 썸네일"></c:otherwise>
									</c:choose>
									</a>
									<p class="cmt_content">
										<a href="${root}user/?pronum=${comment.pronum}" class="cmt_name">${comment.profile.proname}</a>
										&nbsp;${cmmtContent}
										<span class="cmt_date">${cmmtDate}</span>
										<c:if test="${login.pronum eq comment.pronum}"><button class="btn_delete" data-num="${cmmtNum}" onclick="deleted($(this))"><em class="snd_only">삭제하기</em></button></c:if>
									</p>
								</li>
								<c:set var="i" value="${i+1}" />
								<c:if test="${i eq 3 }"><c:set var="doneLoop" value="true" /></c:if>
								</c:if>
								</c:if>
								</c:forEach>
							</ul>
							<c:if test="${cmmtCount gt 3}">
								<button class="cmt_btn_more" onclick="moreComment($(this))"><span class="snd_only">1</span>댓글 더 보기</button>
							</c:if>
						</div>
						<form class="message_form" method="POST" action="${root}news/cmmtadd">
						<c:choose>
							<c:when test="${!groupFeed}">
								<c:set var="number" value="mpnum" />
								<c:set var="author" value="mcauthor" />
								<c:set var="content" value="mccontent" />
								<c:set var="sync" value="pronum_sync" />
								<c:set var="syncValue" value="${feed.pronum}" />
							</c:when>
							<c:otherwise>
								<c:set var="number" value="gpnum" />
								<c:set var="author" value="gcauthor" />
								<c:set var="content" value="gccontent" />
								<c:set var="sync" value="grnum" />
								<c:set var="syncValue" value="${feed.grnum}" />
							</c:otherwise>
						</c:choose>
							<a class="pf_picture" href="${root}user/?pronum=${login.pronum}">
							<c:choose>
								<c:when test="${!empty login.prophoto}"><img src="${upload}/${login.prophoto}" alt="나의 프로필 썸네일"></c:when>
								<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일"></c:otherwise>
							</c:choose>
							</a>
							<div class="msg_input">
								<input type="hidden" name="${number}" value="${feedNum}">
								<input type="hidden" name="pronum" value="${login.pronum}">
								<input type="hidden" name="${author}" value="${login.proname}">
								<input type="hidden" name="${sync}" value="${syncValue}">
								<input type="text" class="msg_txt" name="${content}" placeholder="메세지를 입력해주세요" required="required">
								<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
							</div>
						</form>
					</div>
					<c:if test="${!empty feedImages}">
					<div class="img box">
						<div class="thumb_slide">
							<div class="swiper-wrapper">
							<c:forTokens items="${feedImages}" var="images" delims=",">
								<div class="swiper-slide"><img src="${upload}/${images}" alt=""></div>
							</c:forTokens>
							</div>
							<div class="swiper-pagination"></div>
						</div>
					</div>
					</c:if>
				</div>
			</c:forEach>
			</section>
			<!-- } 컨텐츠영역 끝 -->
			<!-- 우측 사이드영역 시작 { -->
			<section class="side_area">
				<div class="rcmm_list">
					<h3><em class="snd_only">추천그룹 목록</em>나홀로 캠핑이 심심하신가요?</h3>
					<ul>
						<c:forEach items="${grouplist }" begin="0" end="2" var="grouplist">
							<c:if test="${login ne null }">
								<li>
									<a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
										<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
									</a>
									<a class="rc_text" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
										<b class="rc_name">${grouplist.grname }</b>
										<span class="rc_intro">${grouplist.grintro }</span>
									</a>
								</li>
							</c:if>
							<c:if test="${login eq null }">
								<li>
									<a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}">
										<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
									</a>
									<a class="rc_text" href="${root }group/?grnum=${grouplist.grnum}">
										<b class="rc_name">${grouplist.grname }</b>
										<span class="rc_intro">${grouplist.grintro }</span>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div class="rcmm_list">
					<h3><em class="snd_only">추천캠핑장 목록</em>이 캠핑장에도 가보셨나요?</h3>
					<ul>
					<c:forEach items="${camplist}" begin="0" end="2" var="camplist">
						<li>
							<c:if test="${!empty camplist.caphoto}"><c:set var="image1" value="${fn:split(camplist.caphoto,',')}" />
							<c:if test="${fn:length(image1) gt 1}"><c:set var="image" value="${fn:substringBefore(camplist.caphoto,',')}" /></c:if>
							<c:if test="${fn:length(image1) eq 1}"><c:set var="image" value="${camplist.caphoto}" /></c:if>
							<a class="rc_thumb" href="${root}camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}">
								<img src="${upload }/${image}" alt="${camplist.caname} 썸네일">
							</a>
							</c:if>
							<c:if test="${empty camplist.caphoto}">
							<a class="rc_thumb" href="${root}camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}">
								<img src="${root}resources/images/thumb/no_profile.png" alt="${camplist.caname} 썸네일">
							</a>
							</c:if>
							<a class="rc_text" href="${root}camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}">
								<b class="rc_name">${camplist.caname }</b>
								<span class="rc_hashtag">${camplist.caaddrsel}</span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
			</section>
			<!-- } 우측 사이드영역 끝 -->
			</c:when>
			<c:otherwise>
			<section class="follow_wrap">
				<h3>회원님을 위한 추천</h3>
				<div>
					<ul>
						<c:forEach items="${grouplist}" var="grouplist">
						<li>
							<a href="${root}group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
								<span class="pf_picture">
								<c:choose>
									<c:when test="${!empty grouplist.grphoto}"><img src="${upload}/${grouplist.grphoto}" alt="${grouplist.grname} 썸네일" onload="squareTrim($(this), 50)"></c:when>
									<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${grouplist.grname} 썸네일" width="50"></c:otherwise>
								</c:choose>
								</span>
								<b class="fw_name">${grouplist.grname}</b>
								<span class="fw_intro">${grouplist.grintro}</span>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</section>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
	<!-- } 서브페이지 -->
	<div id="footer">
		<div class="container">
			<div class="img_box">
				<img src="${root}resources/images/ico/logo_w.png" alt="FESTA">
			</div>
			<div class="text_box">
				<p>
					<span>FESTA</span>
					<span>서울 강남구 테헤란로5길 11 YBM빌딩 2층</span>
				</p>
				<p>
					<span>사업자등록번호 : 123-45-67890</span>
					<span>대표번호 : 02-3453-5404</span>
					<span>담당자 : 김진혁</span>
				</p>
				<p>&copy; FESTA. All RIGHTS RESERVED.</p>
			</div>
		</div>
	</div>
</div>
<!-- #팝업 { -->
<div id="alert" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit"></p>
		<form id="deleteForm" method="POST" action="" style="display: none">
			<input type="hidden" name="" value="">
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
				<li><button type="submit" class="comm_btn cfm">확인</button></li>
			</ul>
		</form>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<div id="loginCookie" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">기존 정보로 로그인 하시겠습니까?</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close btnCookieClose comm_btn cnc">로그아웃</button></li>
			<li><button type="button" id="btnCookie" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 -->
<script type="text/javascript">
	commSlider();
</script>
</body>
</html>