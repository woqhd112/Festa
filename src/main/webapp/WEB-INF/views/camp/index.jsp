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
	$(function(){
		paramTop();
		
		if ('${login eq null}' == 'true') {
			var newfeedBtn = $('#gnb').find('li').eq(2).find('a');
			newfeedBtn.on('click', function(e) {
				e.preventDefault();
				openPop('alert');
			});
		}
		$('#loginBtn').on('click', function() {
			$('#alert').bPopup().close();
		});
		
		var container = $('.result_area .camp_list'),
		li = container.find('li'),
		btn = $('.btn_view_more');
		li.each(function(e) {
			if (e > 5) {
				$(this).hide();
			}
		});
		var hideOut = container.find('li:hidden').length;
		if (hideOut < 6) {
			btn.hide();
		}
		
		btn.on('click', function() {
			var start = container.find('li:visible').length;
			var end = container.find('li:hidden').length - 6;
			if (end < 1) {
				btn.hide();
			}
			for (var i=0; i<6; i++) {
				li.eq(start).show();
				start++;
			}
		});
	});
	function paramTop() {
		var param = '${param.caaddrsel}';
		var top = $('.result_area').offset().top - 100;
		if (param != '') {
			$('html, body').animate({scrollTop: top}, 0);
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
	<!-- #캠핑정보 (메인) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="camp_wrap list">
		<h2 class="snd_only">캠핑정보</h2>
		<!-- 컨텐츠영역 시작 { -->
		<section class="new_area">
			<div class="container">
				<h3 class="comm_tit">새로 등록된 <b>캠핑장</b></h3>
				<div class="camp_slide">
					<div>
						<ul class="camp_list swiper-wrapper">
						<c:choose>
							<c:when test="${!empty newCampList}">
								<c:forEach items="${newCampList}" var="camp">
								<li class="swiper-slide">
									<a class="cp_thumb" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}">
										<c:set var="image" value="${fn:substringBefore(camp.caphoto,',')}"></c:set>
										<c:if test="${!empty camp.caphoto && empty image}"><img src="${upload}/${camp.caphoto}" alt="${camp.caname}"></c:if>
										<c:if test="${!empty camp.caphoto && !empty image}"><img src="${upload}/${image}" alt="${camp.caname}"></c:if>
										<c:if test="${empty camp.caphoto && empty image}"><img src="${root}resources/images/thumb/no_profile.png" alt="${camp.caname}"></c:if>
									</a>
									<a class="cp_text" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}">
										<b class="cp_name">${camp.caname}</b>
										<span>
											<b class="cp_loc">${camp.caaddrsel}</b>
											<c:if test="${!empty camp.httitle1}">#${camp.httitle1}</c:if>
											<c:if test="${!empty camp.httitle2}">#${camp.httitle2}</c:if>
											<c:if test="${!empty camp.httitle3}">#${camp.httitle3}</c:if>
										</span>
									</a>
								</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="fstEmpty">등록된 캠핑장이 없습니다.</li>
							</c:otherwise>
						</c:choose>
						</ul>
					</div>
					<button type="button" class="swiper-prev"><em class="snd_only">이전</em></button>
					<button type="button" class="swiper-next"><em class="snd_only">다음</em></button>
				</div>
			</div>
		</section>
		<section class="tab_area">
			<div class="container">
				<h3 class="comm_tit">어떤 <span>캠</span><span>핑</span><span>장</span>을 찾고 있나요?</h3>
				<ul class="tab_list">
					<li><a href="?caaddrsel="<c:if test="${empty param.caaddrsel}"> class="on"</c:if>>전체</a></li>
					<li><a href="?caaddrsel=서울"<c:if test="${param.caaddrsel eq '서울'}"> class="on"</c:if>>서울</a></li>
					<li><a href="?caaddrsel=경기도"<c:if test="${param.caaddrsel eq '경기도'}"> class="on"</c:if>>경기도</a></li>
					<li><a href="?caaddrsel=강원도"<c:if test="${param.caaddrsel eq '강원도'}"> class="on"</c:if>>강원도</a></li>
					<li><a href="?caaddrsel=충청도"<c:if test="${param.caaddrsel eq '충청도'}"> class="on"</c:if>>충청도</a></li>
					<li><a href="?caaddrsel=전라도"<c:if test="${param.caaddrsel eq '전라도'}"> class="on"</c:if>>전라도</a></li>
					<li><a href="?caaddrsel=경상도"<c:if test="${param.caaddrsel eq '경상도'}"> class="on"</c:if>>경상도</a></li>
					<li><a href="?caaddrsel=제주도"<c:if test="${param.caaddrsel eq '제주도'}"> class="on"</c:if>>제주도</a></li>
					<li><a href="?caaddrsel=인천"<c:if test="${param.caaddrsel eq '인천'}"> class="on"</c:if>>인천</a></li>
					<li><a href="?caaddrsel=세종"<c:if test="${param.caaddrsel eq '세종'}"> class="on"</c:if>>세종</a></li>
					<li><a href="?caaddrsel=대구"<c:if test="${param.caaddrsel eq '대구'}"> class="on"</c:if>>대구</a></li>
					<li><a href="?caaddrsel=울산"<c:if test="${param.caaddrsel eq '울산'}"> class="on"</c:if>>울산</a></li>
					<li><a href="?caaddrsel=광주"<c:if test="${param.caaddrsel eq '광주'}"> class="on"</c:if>>광주</a></li>
					<li><a href="?caaddrsel=대전"<c:if test="${param.caaddrsel eq '대전'}"> class="on"</c:if>>대전</a></li>
				</ul>
			</div>
		</section>
		<section class="result_area">
			<div class="container">
				<h3 class="comm_tit">
					<c:choose>
						<c:when test="${empty param.caaddrsel}">페스타만의 </c:when>
						<c:otherwise>${param.caaddrsel}의 </c:otherwise>
					</c:choose>
					<b>검증된 캠핑장</b>
				</h3>
				<ul class="camp_list">
				<c:choose>
					<c:when test="${!empty campList}">
						<c:forEach items="${campList}" var="camp">
						<li>
							<a class="cp_thumb" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}">
								<c:set var="image" value="${fn:substringBefore(camp.caphoto,',')}"></c:set>
								<c:if test="${!empty camp.caphoto && empty image}"><img src="${upload}/${camp.caphoto}" alt="${camp.caname}"></c:if>
								<c:if test="${!empty camp.caphoto && !empty image}"><img src="${upload}/${image}" alt="${camp.caname}"></c:if>
								<c:if test="${empty camp.caphoto && empty image}"><img src="${root}resources/images/thumb/no_profile.png" alt="${camp.caname}"></c:if>
								<b class="cp_liked">${camp.cagood}</b>
							</a>
							<a class="cp_text" href="${root}camp/detail?canum=${camp.canum}&caaddrsel=${camp.caaddrsel}">
								<b class="cp_name">${camp.caname}</b>
								<span>
									<b class="cp_loc">${camp.caaddrsel}</b>
									<c:if test="${!empty camp.httitle1}">#${camp.httitle1}</c:if>
									<c:if test="${!empty camp.httitle2}">#${camp.httitle2}</c:if>
									<c:if test="${!empty camp.httitle3}">#${camp.httitle3}</c:if>
								</span>
							</a>
						</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="fstEmpty">등록된 캠핑장이 없습니다.</li>
					</c:otherwise>
				</c:choose>
				</ul>
				<button class="comm_btn btn_view_more">더 보기</button>
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
		<h4 class="pop_tit">로그인이 필요한 서비스입니다.</h4>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
			<li><a href="${root}member/login" id="loginBtn" class="comm_btn cfm btn_pop">로그인</a></li>
		</ul>
	</div>
</div>
<!-- } #팝업 -->
<script type="text/javascript">
	campSlider();
</script>
</body>
</html>