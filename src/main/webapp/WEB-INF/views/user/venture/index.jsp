<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root }resources/images/ico/logo.png">
	<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root }resources/js/util.js"></script>
	<script type="text/javascript" src="${root }resources/js/site.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="stylesheet" href="${root }resources/css/site.css">
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

			
			var mvnum = $('#mvnum').val();
			var mvname = $('#mvname').val();
			var mvaddr = $('#mvaddr').val();
			var mvaddrsuv = $('#mvaddrsuv').val();
			
			if(mvnum!=null && mvname!=null && mvaddr !=null && mvaddrsuv !=null){
				$('#save').prop('type','submit');
			}
			
			//캠핑장 이름 유효성 검사
			$("#mvname").on('propertychange change keyup paste input',function() {
				if($('#mvname').val().length>20){
					$('#mvnameCheck').show();
					$('#save').prop('type','button');
				}
				else{
					$('#mvnameCheck').hide();
					if($('#mvnameCheck').attr("style")=="display: none;" && $('#mvaddr').val()!="" && $('#mvaddrsuvCheck').attr("style")=="display: none;"){
						$('#save').prop('type','submit');
					}
					else{
						$('#save').prop('type','button');
					}
				}
				
			});//캠핑장이름 유효성 검사 긑
			
			//서브주소 유효성 검사
			$("#mvaddrsuv").on('propertychange change keyup paste input',function() {
				if($('#mvaddrsuv').val().length>40){
					$('#mvaddrsuvCheck').show();
					$('#save').prop('type','button');
				}
				else{
					$('#mvaddrsuvCheck').hide();
					if($('#mvnameCheck').attr("style")=="display: none;" && $('#mvaddr').val()!="" && $('#mvaddrsuvCheck').attr("style")=="display: none;"){
						$('#save').prop('type','submit');
					}
					else{
						$('#save').prop('type','button');
					}
				}
			});//서브주소 유효성 검사 긑
			
			$('#rst').on('submit',function(e){
				e.preventDefault();
				var mvnum = $('#mvnum').val();
				var mvname = $('#mvname').val();
				var mvaddr = $('#mvaddr').val();
				var mvaddrsuv = $('#mvaddrsuv').val();
				$.post('${root}user/venture/edit','mvnum='+mvnum+'&mvname='+mvname+'&mvaddr='+mvaddr+'&mvaddrsuv='+mvaddrsuv,function(){
					openPop("ok");
				});
			});
			
			$('#btn_ok').on('click',function(){
				window.location.reload();
			});
		});
	</script>
</head>
<body>
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if>
<c:if test="${sessionScope.login ne null }">
   <c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
      <c:redirect url="/empty"/>
   </c:if>
</c:if>
<div id="wrap">
	<div id="header">
		<div class="scrX">
			<div class="container">
				<h1>
					<a href="${root }"><em class="snd_only">FESTA</em></a>
				</h1>
				<form action="${root }search/" class="search_box">
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
							<li><a href="${root}member/login" id="btn_pop" class="btn_pop">로그인</a></li>
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
													<c:when test="${joinGroup.group.grphoto eq null || joinGroup.group.grphoto eq ''}">
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
													<c:when test="${joinGroup.group.grphoto eq null || joinGroup.group.grphoto eq ''}"> 
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
				<button type="button" id="btnTop"><em class="snd_only">맨 위로</em></button>
			</div>
		</div>
	</div>
	<!-- #유저 관리 -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="setting_wrap">
		<!-- 프로필영역 시작 { -->
		<section class="profile_area">
			<div class="container">
				<div class="info_box">
					<dl>
						<dt class="pf_tit">
							<a class="pf_name" href="${root}user/?pronum=${login.pronum}"><b>${profile.proname }</b></a>
							<!-- 마이페이지일 경우 톱니바퀴 버튼 {  -->
							<a class="pf_opt go_settings" href="${root }user/profile"><em class="snd_only">설정</em></a>
							<!-- } 마이페이지일 경우 톱니바퀴 버튼 -->
						</dt>
						<dd class="pf_intro">${profile.prointro }</dd>
						<dd class="pf_hashtag">
							<a href="">${sessionScope.profile.proaddr }</a>
						</dd>
						<dd class="pf_picture">
							<c:if test="${!empty profile.prophoto }">
									<img src="${upload }/${profile.prophoto}"
										alt="${profile.proname }님의 프로필 썸네일">
								</c:if>
								<c:if test="${empty profile.prophoto}">
									<img src="${root }resources/upload/thumb/no_profile.png" alt="${profile.proname }님의 프로필 썸네일" >
								</c:if>
						</dd>
					</dl>
				</div>
				<div class="cnt_list">
					<ul>
						<li>피드<b>${myFeedCount }</b></li>
						<li>팔로워<a class="btn_pop" href="${root }user/follower?pronum=${profile.pronum}">${myFollowerCount}</a></li>
							<li>팔로우<a id="myFollowingCount" class="btn_pop" href="${root }user/following?pronum=${profile.pronum}">${myFollowingCount }</a></li>
					</ul>
				</div>
			</div>
		</section>
		<!-- } 프로필영역 끝 -->
		<div class="container">
			<!-- 좌측 사이드메뉴 시작 { -->
			<section class="side_area">
				<ul class="lnb_list">
					<li><a href="${root }user/profile">프로필 관리</a></li>
					<c:if test="${profile.proprovide ne 1 }">
					<li><a href="${root }user/check">계정 관리</a></li>
					</c:if>
					<!-- 그룹장이 아닌 경우 { -->
					<c:if test="${groupCheck != 1 }">
					<li><a href="${root }user/group">그룹 생성</a></li>
					</c:if>
					<!-- 사업자가인 경우 -->
					<c:if test="${myVenture ne null }">
					<li><a href="${root }user/venture/" class="act">사업자 계정 관리</a></li>
					</c:if>
					<!-- 사업자가 아닌 경우{ -->
					<c:if test="${myVenture eq null}">
					<c:if test="${myVentureRequestCheck eq 0 }">
					<li><a href="${root}user/venture/add">사업자 계정 신청</a></li>
					</c:if>
					<c:if test="${myVentureRequestCheck ne 0 }">
					<li><a href="${root}user/venture/standby">사업자 계정 신청</a></li>
					</c:if>
					</c:if>
					<!-- 사업자이면서 캠핑장 있는 경우 -->
					<c:if test="${myVenture ne null }">
					<c:if test="${campCheck == 1 }">
					<li><a href="${root }user/camp/">캠핑장 관리</a></li>
					</c:if>
					</c:if>
					<!-- 사업자이지만 캠핑장이 없는 경우 -->
					<c:if test="${myVenture ne null }">
					<c:if test="${campCheck == 0 }">
					<li><a href="${root}user/camp/add">캠핑장 등록</a></li>
					</c:if>
					</c:if>
					<!-- 사업자계정 등록 전 { -->
				</ul>
			</section>
			<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">사업자 계정 관리</h2>
				<form  id="rst" class="set_form">
					<input type="hidden" id="mvnum" name="mvnum" value="${myVenture.mvnum }"/>
					<ul class="input_list">
						<li class="box">
							<p><label for="festa2">이름</label></p>
							<div>
								<input type="text" class="rd_only" id="proname" name="proname" value="${myVenture.proname }" readonly="readonly">
							</div>
						</li>
						<li class="box">
							<p><label for="festa3">사업자 등록번호</label></p>
							<div>
								<input type="text" class="rd_only" id="mvnumber" name="mvnumber" value="${myVenture.mvnumber }" readonly="readonly">
							</div>
						</li>
						<li class="box">
							<p>사업자등록증</p>
							<div>
								<input type="text" class="rd_only" id="mvphoto" name="mvphoto" value="${myVenture.mvphoto }" readonly="readonly">
								<p class="txt_explan">사업자등록 정보 변경이 필요한 경우 고객센터에 문의하세요.</p>
							</div>
						</li>
					</ul>
					<ul class="input_list">
						<li class="box">
							<p><label for="festa5">캠핑장 이름</label></p>
							<div>
								<input type="text" id="mvname" name="mvname" value="${myVenture.mvname }">
								<p hidden="hidden" id="mvnameCheck" class="f_message rst" style="display: none;">20자를 초과하였습니다.</p>
							</div>
						</li>
						<li class="set_half box">
							<p>캠핑장 주소</p>
							<div>
								<input type="text" class="txt_hf kko_addr1 rd_only" id="mvaddr" name="mvaddr" value="${myVenture.mvaddr }" placeholder="캠핑장 주소를 검색해주세요" readonly="readonly">
								<button type="button" id="btnKkoAddr" class="btn_hf"><i class="xi-search"></i><em class="snd_only">주소 검색하기</em></button>
								<div id="kkoAddr">
									<button type="button" class="kko_close"><i class="xi-close-square"></i><em class="snd_only">주소검색 창 닫기</em></button>
								</div>
							</div>
						</li>
						<li class="box">
							<div>
								<input type="text" class="kko_addr2" id="mvaddrsuv" name="mvaddrsuv" value="${myVenture.mvaddrsuv }" placeholder="상세주소를 입력해주세요">
								<p hidden="hidden" id="mvaddrsuvCheck" class="f_message rst" style="display: none;">40자를 초과하였습니다.</p>
							</div>
						</li>
					</ul>
					<ul class="comm_buttons">
						<li><button type="reset" class="btn_close comm_btn cnc">취소</button></li>
						<li><button type="button" id="save" class="comm_btn sbm">저장</button></li>
					</ul>
				</form>
			</section>
			<!-- } 컨텐츠영역 끝 -->
		</div>
	</div>
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
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	kakaoAddr();
</script>
</body>
<!-- #팝업 처리완료 { -->
<div id="ok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" id="btn_ok" class="btn_close comm_btn cfm">확인</button></li>
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
</html>
