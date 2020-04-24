<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <script type="text/javascript" src="${root }resources/js/jh.js"></script>
    <script type="text/javascript" src="${root }resources/js/three.js"></script>
    <script type="text/javascript" src="${root }resources/js/three.module.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="shortcut icon" href="${root}resources/favicon.ico">
	<title>FESTA</title>
	<script type="text/javascript">
	$(function() {
		//지오로케이션 접근시 스크롤기능막기
		var check=false;
		var i=0;
		$(document).on('mouseenter','#reali',function(e){
			check=true;
			setTimeout(function(){
				i++;
			},2000);
			var scroll = $(document).scrollTop();
			$(document).on('scroll touchmove mousewheel',function(event){
				if(check==true&&i>=1){
					$(document).scrollTop(scroll);
				}
			});
		});
		//도큐먼트 클릭시 스크롤기능실행
		$(document).on('click',function(e){
			check=false;
			i=0;
		});
		
		// 신고하기
		$('.btn_report').on('click', function(e) {
			openLayer(e, '${root}camp/detail/report?canum=${camp.canum}&profile.pronum=${camp.profile.pronum}&profile.proname=${camp.profile.proname}&profile.proid=${camp.profile.proid}');
		});
		
		// 한줄평 등록
		var rvForm = $('.rate_form');
		rvForm.on('submit', function(e) {
			e.preventDefault();
			var rvParam = {
				'crauthor': $('[name=crauthor]').val(),
				'crcontent': $('[name=crcontent]').val(),
				'crgood': $('[name=crgood]:checked').val(),
				'canum': $('[name=canum]').val(),
				'camp.caavg': $('[name=caavg]').val(),
				'pronum': $('[name=pronum]').val(),
			};
			
			var strSize = stringValue($(this));
			if (strSize == true) {
				$.post('${root}camp/detail/revadd', rvParam)
					.done(refresh);
			}
		});
		
		// 한줄평 페이지네이션
		$(document).on('click', '.fstPage a', function(e) {
			var url = $(this).attr('href');
			$.ajax({
				type: 'GET',
				url: url,
				success: function(data) {
					var container = $('.rate_area').find('.container');
					var content = $(data).children().eq(1).children().eq(4).children().html();
					container.html(content);
				}
			});
			e.preventDefault();
		});
		
		var alertText = $('#alert').find('.pop_tit');
		var confirmBtn = $('#alert .comm_buttons .comm_btn.cfm');
		var cancleBtn = $('#alert .comm_buttons .comm_btn.cnc');
		var deleteUrl;
		
		// 삭제하기
		function cfmMessage() {
			alertText.text('한줄평을 삭제하시겠습니까?');
		}
		function delMessage() {
			alertText.text('삭제가 완료되었습니다.');
		}
		
		$(document).on('click', '.btn_delete', function(e) {
			e.preventDefault();
			deleteUrl = $(this).attr('href');
			confirmBtn.attr('id', 'deleteBtn');
			openPop('alert', cfmMessage, refresh);
		});
		
		confirmBtn.on('click', function() {
			var id = $(this).attr('id');
			if (id == 'deleteBtn') {
				$.ajax({
					type: 'POST',
					url: deleteUrl,
					success: delMessage,
					error: function() {
						alertText.text('올바른 방법으로 다시 시도해주세요.');
					}
				});
			} else if (id == 'loginBtn') {
				$('#alert').bPopup().close();
				setTimeout(function() {
					openLayer('none', '${root}member/login');
				}, 150);
			}
		});
		
		// 로그인
		function logOpen() {
			cancleBtn.text('닫기');
			confirmBtn.attr('id', 'loginBtn').text('로그인');
			alertText.text('로그인이 필요한 서비스입니다.');
		}
		function logClose() {
			cancleBtn.text('취소');
			confirmBtn.removeAttr('id').text('확인');
		}
		if ('${login eq null}' == 'true') {
			$('.btn_go a').on('click', function(e) {
				e.preventDefault();
				openPop('alert', logOpen, logClose);
			});
			$('#gnb').find('li').eq(2).find('a').on('click', function(e) {
				e.preventDefault();
				openPop('alert', logOpen, logClose);
			});
			$('.btn_liked2, .btn_bookmark2').on('click', function() {
				openPop('alert', logOpen, logClose);
			});
		}
	});
	// 좋아요/북마크
	function liked(button) {
		var liked = button.hasClass('btn_liked'),
			bookmark = button.hasClass('btn_bookmark');
		var cntTag = button.siblings('.cp_liked'),
			cnt = Number(cntTag.text());
		var plus = !button.hasClass('act');
		
		var url = '${root}camp/detail/',
			param = {
				'pronum': '${login.pronum}',
				'canum': '${camp.canum}',
			};
		if (liked && plus) {
			$.post(url+'likeadd', param)
				.done(function() {
					cntTag.text(cnt+1);
				});
		} else if (liked && !plus) {
			$.post(url+'likedel', param)
				.done(function() {
					cntTag.text(cnt-1);
				});
		}
		if (bookmark && plus) {
			$.post(url+'bookadd', param).done(refresh);
		} else if (bookmark && !plus) {
			$.post(url+'bookdel', param).done(refresh);
		}
	}
	</script>
</head>
<body>
<c:if test="${sessionScope.login ne null }">
   <c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
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
	<!-- #캠핑정보 (상세) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="camp_wrap detail">
		<h2 class="snd_only">캠핑정보</h2>
		<!-- 컨텐츠영역 시작 { -->
		<section class="info_area">
			<div class="container">
				<div class="tit box">
					<div>
						<h3><span>${camp.caaddrsel}</span> ${camp.caname}</h3>
						<p class="cp_subtit">${camp.caintroone}</p>
						<ul class="cp_hashtag">
							<c:if test="${!empty camp.httitle1}"><li><a href="${root}search/?keyword=${camp.httitle1}">${camp.httitle1}</a></li></c:if>
							<c:if test="${!empty camp.httitle2}"><li><a href="${root}search/?keyword=${camp.httitle2}">${camp.httitle2}</a></li></c:if>
							<c:if test="${!empty camp.httitle3}"><li><a href="${root}search/?keyword=${camp.httitle3}">${camp.httitle3}</a></li></c:if>
						</ul>
						<ul class="cp_options">
							<li>
								<b class="cp_liked">${camp.cagood}</b>
							<c:choose>
								<c:when test="${login ne null}">
								<c:forEach items="${goodlist}" var="good">
									<c:if test="${camp.canum eq good.canum}">
										<c:set var="active" value=" act"></c:set>
									</c:if>
								</c:forEach>
									<button type="button" class="btn_liked${active}" onclick="liked($(this));"><em class="snd_only">하트</em></button>
								</c:when>
								<c:otherwise><button type="button" class="btn_liked2"><em class="snd_only">하트</em></button></c:otherwise>
							</c:choose>
							</li>
							<li>
							<c:choose>
								<c:when test="${login ne null}">
								<c:forEach items="${bookMark}" var="book">
									<c:if test="${book.camp.canum eq camp.canum}">
										<c:set var="active2" value=" act"></c:set>
									</c:if>
								</c:forEach>
								<button type="button" class="btn_bookmark${active2}" onclick="liked($(this));"><em class="snd_only">저장하기</em></button>
								</c:when>
								<c:otherwise><button type="button" class="btn_bookmark2"><em class="snd_only">저장하기</em></button></c:otherwise>
							</c:choose>
							</li>
							<c:if test="${login ne null}">
							<li><a href="${root}camp/detail/report" class="btn_report"><em class="snd_only">신고하기</em></a></li>
							</c:if>
							<li><a class="btn_back" href="${root}camp/"><em class="snd_only">목록으로</em></a></li>
						</ul>
						<ul class="cp_date">
							<li>정보 등록일 ${camp.cadate}</li>
							<li>최근 수정일 ${camp.cadateup}</li>
						</ul>
					</div>
				</div>
				<div class="intro box">
					<h4 class="snd_only">캠핑장 썸네일</h4>
					<div class="thumb_3d">
						<iframe id="reali" src="${root}admin/camp/gl_camp" width="720" height="380" scrolling="no" frameborder="1"></iframe>
					</div>
					<div class="text_box">
						<h4 class="sub_tit">캠핑장 소개</h4>
						<c:if test="${!empty ventureGroup}">
							<p class="btn_go"><a href="${root}group/?grnum=${ventureGroup.grnum}&pronum=${login.pronum}">그룹 바로가기</a></p>
						</c:if>
						<div class="scrBar">
							<p>${camp.caintro}</p>
						</div>
					</div>
				</div>
				<div class="info box">
					<h4 class="sub_tit">캠핑장 시설 안내</h4>
					<ol class="info_list">
						<c:if test="${!empty camp.caguide1}"><li>${camp.caguide1}</li></c:if>
						<c:if test="${!empty camp.caguide2}"><li>${camp.caguide2}</li></c:if>
						<c:if test="${!empty camp.caguide3}"><li>${camp.caguide3}</li></c:if>
						<c:if test="${!empty camp.caguide4}"><li>${camp.caguide4}</li></c:if>
						<c:if test="${!empty camp.caguide5}"><li>${camp.caguide5}</li></c:if>
						<c:if test="${!empty camp.caguide6}"><li>${camp.caguide6}</li></c:if>
						<c:if test="${!empty camp.caguide7}"><li>${camp.caguide7}</li></c:if>
						<!-- # 시설 안내 없음 {
						<li class="fstEmpty">등록된 시설 안내 사항이 없습니다</li>
						} # 시설 안내 없음 -->
					</ol>
				</div>
			</div>
		</section>
		<section class="photo_area">
			<div class="container">
				<h4 class="sub_tit">캠핑장 사진</h4>
				<div class="thumb_slide">
					<div class="swiper-wrapper">
					<c:choose>
						<c:when test="${!empty camp.caphoto}">
							<c:forTokens items="${camp.caphoto}" var="images" delims=",">
								<div class="swiper-slide"><img src="${upload}/${images}" alt="${camp.caname}"></div>
							</c:forTokens>
						</c:when>
						<c:otherwise>
							<div class="swiper-slide"><img src="${root}resources/images/thumb/no_profile.png" alt="${camp.caname}"></div>
						</c:otherwise>
					</c:choose>
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</section>
		<section class="location_area">
			<div class="container">
				<h4 class="sub_tit">오시는 길</h4>
				<p id="mapAddress">${camp.caaddr}&nbsp;${camp.caaddrsuv}</p>
				<div id="map"></div>
			</div>
		</section>
		<section class="rate_area">
			<div class="container">
				<h4 class="sub_tit">
					<p>
						한줄평 <c:if test="${campReviewCount ne null}"><span><fmt:formatNumber value='${campReviewCount}' pattern='000' />개</span></c:if>
					</p>
					<c:if test="${camp.caavg eq 0 }">
						<p>평점 <span>0점</span></p>
					</c:if>
					<c:if test="${camp.caavg ne 0 }">
						<p>평점 <span><fmt:formatNumber value="${camp.caavg}" pattern=".0" />점</span></p>
					</c:if>
				</h4>
				<ul class="rate_list">
				<c:choose>
					<c:when test="${!empty campReviewList}">
						<c:forEach items="${campReviewList}" var="review">
						<li>
							<a class="pf_picture" href="${root}user/?pronum=${review.pronum}">
							<c:choose>
								<c:when test="${!empty review.profile.prophoto}"><img src="${upload}/${review.profile.prophoto}" alt="${review.crauthor}" width="80"></c:when>
								<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${camp.caname}" onload="squareTrim($(this), 80)"></c:otherwise>
							</c:choose>
							</a>
							<p class="rt_user">
								<a class="rt_name" href="${root}user/?pronum=${review.pronum}">
									<b>${review.crauthor}</b>
								</a>
								<c:if test="${review.crgood eq 1.0}"><span class="rt_star"><img src="${root}resources/images/ico/shp_star1.png" alt="별 1개"></span></c:if>
								<c:if test="${review.crgood eq 2.0}"><span class="rt_star"><img src="${root}resources/images/ico/shp_star2.png" alt="별 2개"></span></c:if>
								<c:if test="${review.crgood eq 3.0}"><span class="rt_star"><img src="${root}resources/images/ico/shp_star3.png" alt="별 3개"></span></c:if>
								<c:if test="${review.crgood eq 4.0}"><span class="rt_star"><img src="${root}resources/images/ico/shp_star4.png" alt="별 4개"></span></c:if>
								<c:if test="${review.crgood eq 5.0}"><span class="rt_star"><img src="${root}resources/images/ico/shp_star5.png" alt="별 5개"></span></c:if>
							</p>
							<p class="rt_cont">${review.crcontent}</p>
							<p class="rt_date">${review.crdate}</p>
							<c:if test="${login.pronum eq review.pronum}">
							<p class="rt_option">
								<a class="btn_delete" href="${root}camp/detail/revdel?canum=${camp.canum}&crnum=${review.crnum}"><em class="snd_only">삭제하기</em></a>
							</p>
							</c:if>
						</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="fstEmpty"><i class="xi-error-o"></i>등록된 한줄평이 없습니다</li>
					</c:otherwise>
				</c:choose>
				</ul>
				<c:if test="${!empty campReviewList}">
				<div class="fstPage">
					<ul>
					<c:choose>
						<c:when test="${paging.endPage le paging.totalPage}"><c:set var="end" value="${paging.endPage}" /></c:when>
						<c:otherwise><c:set var="end" value="${paging.totalPage}" /></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${paging.page2 eq 1}">
						<li><span class="pg_start off"><em class="snd_only">맨 앞으로</em></span></li>
						<li><span class="pg_prev off ${paging.page2}"><em class="snd_only">이전 페이지</em></span></li>
						</c:when>
						<c:otherwise>
							<c:if test="${paging.beginPage eq 1}">
							<li><a class="pg_start" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=1"><em class="snd_only">맨 앞으로</em></a></li>
							</c:if>
							<c:if test="${paging.beginPage gt 1}">
							<li><a class="pg_start" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${paging.beginPage-1}"><em class="snd_only">맨 앞으로</em></a></li>
							</c:if>
						<li><a class="pg_prev ${paging.page2}" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${paging.page2-1}"><em class="snd_only">이전 페이지</em></a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${paging.beginPage}" end="${end}">
						<li>
						<c:choose>
							<c:when test="${paging.page2 eq i}"><li><b>${i}</b></li></c:when>
							<c:otherwise><a href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${i}">${i}</a></c:otherwise>
						</c:choose>
						</li>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.next eq true}">
						<li>
							<a class="pg_next" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${paging.page2+1}"><em class="snd_only">다음 페이지</em></a></li>
							<c:if test="${paging.endPage ne paging.totalPage}">
							<li><a class="pg_end" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${paging.endPage+1}"><em class="snd_only">맨 끝으로</em></a></li>
							</c:if>
							<c:if test="${paging.endPage eq paging.totalPage}">
							<li><a class="pg_end" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}&pageSearch.page2=${paging.endPage}"><em class="snd_only">맨 끝으로</em></a></li>
							</c:if>
						</c:when>
						<c:otherwise>
						<li><span class="pg_next off"><em class="snd_only">다음 페이지</em></span></li>
						<li><span class="pg_end off"><em class="snd_only">맨 끝으로</em></span></li>
						</c:otherwise>
					</c:choose>
					</ul>
				</div>
				</c:if>
				<h4 class="snd_only">한줄평 작성</h4>
				<c:choose>
				<c:when test="${login ne null}">
				<form class="rate_form">
					<input type="hidden" name="pronum" value="${login.pronum}">
					<input type="hidden" name="canum" value="${camp.canum}">
					<input type="hidden" name="caavg" value="${camp.caavg}">
					<input type="hidden" name="crauthor" value="${login.proname}">
					<div>
						<p class="rt_name">${login.proname}</p>
						<ul class="rt_rates">
							<li>
								<input type="radio" id="rtRate1" name="crgood" value="1.0">
								<label for="rtRate1"><em class="snd_only">별 1개</em></label>
							<li>
								<input type="radio" id="rtRate2" name="crgood" value="2.0">
								<label for="rtRate2"><em class="snd_only">별 2개</em></label>
							</li>
							<li>
								<input type="radio" id="rtRate3" name="crgood" value="3.0">
								<label for="rtRate3"><em class="snd_only">별 3개</em></label>
							</li>
							<li>
								<input type="radio" id="rtRate4" name="crgood" value="4.0">
								<label for="rtRate4"><em class="snd_only">별 4개</em></label>
							</li>
							<li>
								<input type="radio" id="rtRate5" name="crgood" value="5.0" checked="checked">
								<label for="rtRate5"><em class="snd_only">별 5개</em></label>
							</li>
						</ul>
						<textarea class="rt_input" name="crcontent" placeholder="주제와 무관한 댓글, 허위 사실은 삭제될 수 있습니다." required="required"></textarea>
					</div>
					<button type="submit" class="rt_btn_send">등록</button>
					<p class="rt_caution"><span>캠핑장에 관련된 내용이 아니거나 허위사실 기재 시 운영원칙에 따라 삭제될 수 있습니다.</span></p>
				</form>
				</c:when>
				<c:otherwise>
				<form class="rate_form">
					<div class="fstEmpty">
						<textarea class="rt_input fstEmpty" placeholder="로그인이 필요한 서비스입니다." disabled="disabled"></textarea>
					</div>
					<button type="button" class="rt_btn_send">등록</button>
					<p class="rt_caution"><span>캠핑장에 관련된 내용이 아니거나 허위사실 기재 시 운영원칙에 따라 삭제될 수 있습니다.</span></p>
				</form>
				</c:otherwise>
				</c:choose>
			</div>
		</section>
		<section class="others_area">
			<div class="container">
				<h3 class="comm_tit">${camp.caaddrsel}의 <b>또 다른 캠핑장</b></h3>
				<div class="camp_slide"> 	
					<div>
						<ul class="camp_list swiper-wrapper">
							<c:forEach items="${sameList}" var="same">
							<li class="swiper-slide" data-canum="${same.canum}">
								<a class="cp_thumb" href="${root}camp/detail?canum=${same.canum}&caaddrsel=${same.caaddrsel}">
								<c:set var="image" value="${fn:substringBefore(same.caphoto,',')}"></c:set>
								<c:if test="${!empty same.caphoto && empty image}"><img src="${upload}/${same.caphoto}" alt="${same.caname}"></c:if>
								<c:if test="${!empty same.caphoto && !empty image}"><img src="${upload}/${image}" alt="${same.caname}"></c:if>
								<c:if test="${empty same.caphoto && empty image}"><img src="${root}resources/images/thumb/no_profile.png" alt="${same.caname}"></c:if>
								<b class="cp_liked">${same.cagood}</b>
								</a>
								<a class="cp_text" href="${root}camp/detail?canum=${same.canum}&caaddrsel=${same.caaddrsel}">
									<b class="cp_name">${same.caname}</b>
									<span>
										<b class="cp_loc">${same.caaddrsel}</b>
										<c:if test="${!empty same.httitle1}">#${same.httitle1}</c:if>
										<c:if test="${!empty same.httitle2}">#${same.httitle2}</c:if>
										<c:if test="${!empty same.httitle3}">#${same.httitle3}</c:if>
									</span>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
					<button type="button" class="swiper-prev"><em class="snd_only">이전</em></button>
					<button type="button" class="swiper-next"><em class="snd_only">다음</em></button>
				</div>
			</div>
		</section>
		<!-- } 컨텐츠영역 끝 -->
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
		<h4 class="pop_tit"></h4>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c1b67c433937cf5e372c63766fb1ccca&libraries=services"></script>
<script type="text/javascript">
	campDetail();
</script>
</body>
</html>