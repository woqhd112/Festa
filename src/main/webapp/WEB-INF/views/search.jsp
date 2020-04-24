<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root }resources/images/ico/logo.png">
	<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root }resources/js/util.js"></script>
	<script type="text/javascript" src="${root }resources/js/site.js"></script>
	<script type="text/javascript" src="${root }resources/js/jh.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="shortcut icon" href="${root }resources/favicon.ico">
	<title>FESTA</title>
	<script type="text/javascript">
	
	function btn_close(){
        document.cookie = 'loginCookie' + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
        var url = window.location.href;
    	if(url.indexOf('group')>0||url.indexOf('news')>0||url.indexOf('user')>0||url.indexOf('admin')>0||url.indexOf('empty')>0){
    		window.location.href='${root}';
    	}
	}
	
		$(document).ready(function(){
			
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
			
			//로그인하기 내부팝업->로그인버튼 클릭시 로그인외부팝업생성
			$('#btnLogin').on('click', function() {
				$('#login').bPopup().close();
				openLayer('none', '${root}member/login');
			});
			var loginCheck = '${login.logincheck}';
			
			//로그인이아닐때 프로필사진,이름,뉴스피드 눌렀을경우
			$(document).on('click','.pf_picture, .fd_name, #gnb li a:eq(2), .cmt_name',function(){
				if(loginCheck==''){
					openPop('login');
					return false;
				}
			});
			
			//스크롤 내렸을때 피드 2개씩 출력
			$(window).scroll(function(){
			    var scrolltop = parseInt ( $(window).scrollTop() );
			    if( scrolltop >= $(document).height() - $(window).height() - 1 ){
					var scrollTag=$('#footer').siblings('span');
					var scroll=scrollTag.text();
					scroll++;
					scrollTag.text(scroll);
					console.log(scroll);
					var keyword = $('.search_box>input').val();
					$.get('${root}search/scroll','keyword='+keyword+'&page5='+scroll,function(){
						
					}).done(function(data){
						//검색피드 스크롤더보기
						feedList(data,'search','${login.pronum}','${login.prophoto}','${login.logincheck}');
					});
			    }
			});
			
			//그룹 비동기페이지네이션
			//해당 그룹목록의 리스트
			var tag = $('.group_list li');
			//첫화면시 페이징기능 호출,페이지뷰,로우뷰 출력
			funcLoad(tag);
			
			//페이지버튼 눌렀을때 이벤트
			$(document).on('click','.fstPage a',function(e){
				ifPage(this);
				funcLoad(tag);
				e.preventDefault();
			});
			
		});
		
		//페이징에 필요한 필드선언
		pagenation(6,6,'${paging.totalCount}');
		
	
	</script>
</head>
<body>
<div id="wrap">
	<div id="header">
			<div class="scrX">
				<div class="container">
					<h1>
						<a href="${root }"><em class="snd_only">FESTA</em></a>
					</h1>
					<form class="search_box">
						<input type="text" name="keyword" value="${paging.keyword }" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
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
	<!-- #캠핑정보 (리스트) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="search_wrap">
		<!-- 컨텐츠영역 시작 { -->
		<section class="title_area container">
			<h2 class="comm_tit"><b>${paging.keyword }</b>(으)로 검색한 결과입니다.</h2>
		</section>
		<section class="camp_area">
			<div class="container">
				<h3 class="sub_tit">캠핑장</h3>
				<c:if test="${!empty searchCamp }">
				<div class="camp_slide">
					<div>
						<ul class="camp_list swiper-wrapper">
							<c:forEach items="${searchCamp }" var="searchCamp">
								<li class="swiper-slide">
									<a class="cp_thumb" href="${root }camp/detail?canum=${searchCamp.canum}&caaddrsel=${searchCamp.caaddrsel}">
									<c:if test="${!empty searchCamp.caphoto }">
									<c:set var="image1" value="${fn:split(searchCamp.caphoto,',') }" />
									<c:if test="${fn:length(image1) gt 1 }">
										<c:set var="image"
											value="${fn:substringBefore(searchCamp.caphoto,',') }" />
									</c:if>
									<c:if test="${fn:length(image1) eq 1 }">
										<c:set var="image" value="${searchCamp.caphoto }" />
									</c:if>
										<img src="${upload }/${image}" alt="${searchCamp.caname } 캠핑장 썸네일">
									</c:if>
									<c:if test="${empty searchCamp.caphoto }">
										<img src="${root}resources/images/thumb/no_profile.png" alt="${searchCamp.caname } 캠핑장 썸네일">
									</c:if>
										<b class="cp_liked">${searchCamp.cagood }</b>
									</a>
									<a class="cp_text" href="${root }camp/detail?canum=${searchCamp.canum}&caaddrsel=${searchCamp.caaddrsel}">
										<b class="cp_name">${searchCamp.caname }</b>
										<span>
											<b class="cp_loc">${searchCamp.caaddrsel }</b>
											<c:choose>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle2 && empty searchCamp.httitle3}">
												</c:when>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle2}">
													#${searchCamp.httitle3}
												</c:when>
												<c:when
													test="${empty searchCamp.httitle2 && empty searchCamp.httitle3}">
													#${searchCamp.httitle1}
												</c:when>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle3}">
													#${searchCamp.httitle2}
												</c:when>
												<c:when test="${empty searchCamp.httitle1}">
													#${searchCamp.httitle2}
													#${searchCamp.httitle3}
												</c:when>
												<c:when test="${empty searchCamp.httitle2}">
													#${searchCamp.httitle1}
													#${searchCamp.httitle3}
												</c:when>
												<c:when test="${empty searchCamp.httitle3}">
													#${searchCamp.httitle1}
													#${searchCamp.httitle2}
												</c:when>
												<c:otherwise>
													#${searchCamp.httitle1}
													#${searchCamp.httitle2}
													#${searchCamp.httitle3}
												</c:otherwise>
											</c:choose>
										</span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<button type="button" class="swiper-prev"><em class="snd_only">이전</em></button>
					<button type="button" class="swiper-next"><em class="snd_only">다음</em></button>
				</div>
				</c:if>
				<c:if test="${empty searchCamp }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
			</div>
		</section>
		<section class="group_area">
			<div class="container">
				<h3 class="sub_tit">그룹</h3>
				<c:if test="${!empty searchGroup }">
					<ul class="group_list">
						<c:forEach items="${searchGroup }" var="searchGroup">
							<li>
								<c:if test="${login ne null }">
									<a class="gp_thumb" href="${root }group/?grnum=${searchGroup.grnum}&pronum=${login.pronum}">
									<c:if test="${!empty searchGroup.grphoto }">
										<img src="${upload }/${searchGroup.grphoto}" alt="${searchGroup.grname } 그룹 썸네일">
									</c:if>
									<c:if test="${empty searchGroup.grphoto }">
										<img src="${root}resources/images/thumb/no_profile.png" alt="${searchGroup.grname } 그룹 썸네일">
									</c:if>
									</a>
									<a class="gp_text" href="${root }group/?grnum=${searchGroup.grnum}&pronum=${login.pronum}">
										<strong>${searchGroup.grname }</strong>
										<span>${searchGroup.grintro }</span>
										<b>${searchGroup.graddr }</b>
									</a>
								</c:if>
								<c:if test="${login eq null }">
									<a class="gp_thumb" href="${root }group/?grnum=${searchGroup.grnum}">
									<c:if test="${!empty searchGroup.grphoto }">
										<img src="${upload }/${searchGroup.grphoto}" alt="${searchGroup.grname } 그룹 썸네일">
									</c:if>
									<c:if test="${empty searchGroup.grphoto }">
										<img src="${root}resources/images/thumb/no_profile.png" alt="${searchGroup.grname } 그룹 썸네일">
									</c:if>
									</a>
									<a class="gp_text" href="${root }group/?grnum=${searchGroup.grnum}">
										<strong>${searchGroup.grname }</strong>
										<span>${searchGroup.grintro }</span>
										<b>${searchGroup.graddr }</b>
									</a>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty searchGroup }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
				<div class="fstPage">
					<ul>
					
					</ul>
				</div>
			</div>
		</section>
		<section class="feed_area">
			<div class="container">
				<h3 class="sub_tit">피드</h3>
				<ul class="feed_list">
				<c:if test="${!empty searchFeed }">
					<c:forEach items="${searchFeed }" var="searchFeed">
						<c:choose>
							<c:when test="${searchFeed.gpnum eq 0 }">
								<li<c:if test="${searchFeed.mpphoto ne '' }"> class="half"</c:if>>
									<a class="text box btn_feed" href="${root }search/feed?mpnum=${searchFeed.mpnum}">
										<c:choose>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2 && empty searchFeed.httitle3}">
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle3}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle2 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle2}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle1}">
													<span class="fd_hashtag">${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}</span>
												</c:when>
												<c:otherwise>
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:otherwise>
											</c:choose>
										<span class="fd_content">${searchFeed.mpcontent }</span>
									</a>
									<c:if test="${searchFeed.mpphoto ne '' }">
										<a class="thumb box btn_feed" href="${root }search/feed?mpnum=${searchFeed.mpnum}">
										
										 <c:set var="mpphoto1" value="${fn:split(searchFeed.mpphoto,',') }"/>
										 <c:if test="${fn:length(mpphoto1) gt 1 }">
										 	<c:set var="mpphoto" value="${fn:substringBefore(searchFeed.mpphoto,',') }"/>
										 </c:if>
										 <c:if test="${fn:length(mpphoto1) eq 1 }">
										 	<c:set var="mpphoto" value="${searchFeed.mpphoto }"/>
										 </c:if>
											<span class="fd_thumb"><img src="${upload }/${mpphoto}" alt="피드 썸네일"></span>
										</a>
									</c:if>
									<p class="info box btn_pop">
										<a class="pf_picture" href="${root }user/?pronum=${searchFeed.pronum}">
										<c:if test="${!empty searchFeed.profile.prophoto }">
											<img src="${upload }/${searchFeed.profile.prophoto}" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</c:if>
										<c:if test="${empty searchFeed.profile.prophoto }">
											<img src="${root }resources/images/thumb/no_profile.png" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</c:if>
										</a>
										<a class="fd_name" href="${root }user/?pronum=${searchFeed.pronum}">${searchFeed.profile.proname }</a>
										<span class="fd_liked">${searchFeed.good }</span>
										<span class="fd_comment">${searchFeed.mptotal }</span>
										<span class="fd_date">${searchFeed.date1 }</span>
									</p>
								
							</c:when>
							<c:otherwise>
								<li<c:if test="${searchFeed.gpphoto ne '' }"> class="half"</c:if>>
									<a class="text box btn_feed" href="${root }search/feed?gpnum=${searchFeed.gpnum}">
										<c:choose>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2 && empty searchFeed.httitle3}">
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle3}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle2 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle2}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle1}">
													<span class="fd_hashtag">${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}</span>
												</c:when>
												<c:otherwise>
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:otherwise>
											</c:choose>
										<span class="fd_content">${searchFeed.gpcontent }</span>
									</a>
									<c:if test="${searchFeed.gpphoto ne '' }">
										<a class="thumb box btn_feed" href="${root }search/feed?gpnum=${searchFeed.gpnum}">
										<c:set var="gpphoto1" value="${fn:split(searchFeed.gpphoto,',') }"/>
										 <c:if test="${fn:length(gpphoto1) gt 1 }">
										 	<c:set var="gpphoto" value="${fn:substringBefore(searchFeed.gpphoto,',') }"/>
										 </c:if>
										 <c:if test="${fn:length(mpphoto1) eq 1 }">
										 	<c:set var="gpphoto" value="${searchFeed.gpphoto }"/>
										 </c:if>
											<span class="fd_thumb"><img src="${upload }/${gpphoto}" alt="피드 썸네일"></span>
										</a>
									</c:if>
									<p class="info box btn_pop">
										<a class="pf_picture" href="${root }user/?pronum=${searchFeed.pronum}">
										<c:if test="${!empty searchFeed.profile.prophoto }">
											<img src="${upload }/${searchFeed.profile.prophoto}" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</c:if>
										<c:if test="${empty searchFeed.profile.prophoto }">
											<img src="${root }resources/images/thumb/no_profile.png" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</c:if>
										</a>
										<a class="fd_name" href="${root }user/?pronum=${searchFeed.pronum}">${searchFeed.profile.proname }</a>
										<span class="fd_liked">${searchFeed.good }</span>
										<c:if test="${login ne null }">
											<a class="fd_group" href="${root }group/?grnum=${searchFeed.grnum}&pronum=${login.pronum}">${searchFeed.group.grname }</a>
										</c:if>
										<c:if test="${login eq null }">
											<a class="fd_group" href="${root }group/?grnum=${searchFeed.grnum}">${searchFeed.group.grname }</a>
										</c:if>
										<span class="fd_comment">${searchFeed.gptotal }</span>
										<span class="fd_date">${searchFeed.date1 }</span>
									</p>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${empty searchFeed }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
				</ul>
			</div>
		</section>
		<!-- } 컨텐츠영역 끝 -->
	</div>
	<span class="snd_only">1</span>
	<!-- } 서브페이지 -->
	<div id="footer">
		<div class="container">
			<div class="img_box">
				<img src="${root }resources/images/ico/logo_w.png" alt="FESTA">
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
		<p class="pop_tit">로그인을 유지 시키겠습니까?</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
			<li><button type="button" id="btnCookie" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
<script type="text/javascript">
	campSlider();
	openFeed();
</script>
</body>
</html>