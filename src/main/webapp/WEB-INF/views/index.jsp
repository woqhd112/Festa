<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image" content="${root }resources/images/ico/logo.png">
<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${root }resources/js/util.js"></script>
<script type="text/javascript" src="${root }resources/js/site.js"></script>
<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
<link rel="shortcut icon" href="${root }resources/favicon.ico">
<title>FESTA</title>
<script type="text/javascript">
	$(document).ready(function(){
		
		//로그인하기 내부팝업->로그인버튼 클릭시 로그인외부팝업생성
		$('#btnLogin').on('click', function() {
			$('#login').bPopup().close();
			openLayer('none', '${root}member/login');
		});
		var loginCheck = '${login.logincheck}';
		
		//로그인이아닐때 프로필사진,이름,뉴스피드 눌렀을경우
		$(document).on('click','#gnb li a:eq(2)',function(){
			if(loginCheck==''){
				openPop('login');
				return false;
			}
		});
		
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
	}); 
	function btn_close(){
        document.cookie = 'loginCookie' + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
        var url = window.location.href;
    	if(url.indexOf('group')>0||url.indexOf('news')>0||url.indexOf('user')>0||url.indexOf('admin')>0||url.indexOf('empty')>0){
    		window.location.href='${root}';
    	}
	}
</script>
</head>
<body>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<!-- 그룹 -->
	<div id="wrap">
		<div id="header">
			<div class="scrX">
				<div class="container">
					<h1>
						<a href="${root }"><em class="snd_only">FESTA</em></a>
					</h1>
					<form class="search_box" action="${root }search/">
						<input type="text" name="keyword" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
						<button type="submit">
							<img src="${root }resources/images/ico/btn_search.png" alt="검색">
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
													<c:when test="${empty joinGroup.group.grphoto }">
														<li><a
															href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
																<span><img src="${root}resources/images/thumb/no_profile.png"
																	alt="${joinGroup.group.grname } 그룹 썸네일"></span> <b>${joinGroup.group.grname }</b>
														</a></li>
													</c:when>
													<c:otherwise>
														<li><a
															href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
																<span><img src="${upload }/${joinGroup.group.grphoto}"
																	alt="${joinGroup.group.grname } 그룹 썸네일"></span> <b>${joinGroup.group.grname }</b>
														</a></li>
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
													<c:when test="${empty joinGroup.group.grphoto }"> 
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
		<div id="main">
			<section class="visual_area">
				<div class="container">
					<div>
						<div class="text_box">
							<img src="resources/images/main/bg_copy.png"
								alt="솔직한 리뷰, 믿을 수 있는 캠핑! FESTA">
						</div>
						<form class="search_box" action="${root }search/">
							<input type="text" name="keyword" placeholder="캠핑장 또는 그룹" required="required">
							<button type="submit">검색</button>
						</form>
					</div>
				</div>
			</section>
			<section class="group_area">
				<div class="container">
					<h2 class="main_tit">
						<em class="snd_only">추천 그룹</em>이런 그룹은 어때요?
					</h2>
					<ul class="group_list">
						<c:forEach items="${grouplist }" var="grouplist">
							<c:if test="${login ne null }">
								<li><a class="gp_thumb" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}"> 
								<c:if test="${empty grouplist.grphoto }">
									<img src="${root}resources/images/thumb/no_profile.png" alt="${grouplist.grname } 그룹 썸네일">
								</c:if>
								<c:if test="${!empty grouplist.grphoto }">
									<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
								</c:if>
								</a> <a class="gp_text" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}"> <strong>${grouplist.grname }</strong> <span>${grouplist.grintro }</span>
								</a></li>
							</c:if>
							<c:if test="${login eq null }">
								<li><a class="gp_thumb" href="${root }group/?grnum=${grouplist.grnum}"> 
								<c:if test="${empty grouplist.grphoto }">
									<img src="${root}resources/images/thumb/no_profile.png" alt="${grouplist.grname } 그룹 썸네일">
								</c:if>
								<c:if test="${!empty grouplist.grphoto }">
									<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
								</c:if>
								</a> <a class="gp_text" href="${root }group/?grnum=${grouplist.grnum}"> <strong>${grouplist.grname }</strong> <span>${grouplist.grintro }</span>
								</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</section>
			<section class="camp_area">
				<div class="container">
					<h2 class="main_tit">
						<em class="snd_only">추천 캠핑장</em>믿고 가는 캠핑장 베스트
					</h2>
					<div class="slide_box">
						<div class="swiper-wrapper">
							<c:forEach items="${camplist }" var="camplist">
								<dl class="swiper-slide">
									<dt>
									<c:if test="${!empty camplist.caphoto }">
										<c:set var="image1" value="${fn:split(camplist.caphoto,',') }" />
										<c:if test="${fn:length(image1) gt 1 }">
											<c:set var="image"
												value="${fn:substringBefore(camplist.caphoto,',') }" />
										</c:if>
										<c:if test="${fn:length(image1) eq 1 }">
											<c:set var="image" value="${camplist.caphoto }" />
										</c:if>
										<span><img src="${upload }/${image}"
											alt="${camplist.caname } 썸네일"></span>
									</c:if>
									<c:if test="${empty camplist.caphoto }">
										<span><img src="${root }resources/images/thumb/no_profile.png"
												alt="${camplist.caname } 썸네일"></span>
									</c:if>
									</dt>
									<dd>
										<a href="${root }camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}"
											class="txtbox"> <strong>${camplist.caname }</strong> <span>${camplist.caaddrsel }</span>
											<b class="cp_liked">${camplist.cagood }</b>
										</a>
									</dd>
								</dl>
							</c:forEach>
						</div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
			</section>
		</div>
		<div id="footer">
			<div class="container">
				<div class="img_box">
					<img src="resources/images/ico/logo_w.png" alt="FESTA">
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
<!-- #팝업 처리완료 { -->
<div id="login" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">로그인이 필요한 서비스입니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
			<li><button type="button" id="btnLogin" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
<!-- #팝업 처리완료 { -->
<div id="loginCookie" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">기존 정보로 로그인 하시겠습니까?</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close btnCookieClose comm_btn cnc">로그아웃</button></li>
			<li><button type="button" id="btnCookie" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
	<script type="text/javascript">
		main();
	</script>
</body>
</html>