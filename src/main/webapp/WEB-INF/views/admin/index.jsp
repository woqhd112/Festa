<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/" var="root"></c:url>
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
		});
	</script>
</head>
<body>
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid ne 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<div id="wrap">
	<div id="header">
		<div class="scrX">
			<div class="container">
				<h1>
					<a href="${root }admin/"><em class="snd_only">FESTA</em></a>
				</h1>
				<ul id="gnb">
					<li><a href="${root }admin/"><b>관리자</b></a></li>
					<li><a href="${root }member/logout" class="btn_pop">로그아웃</a></li>
				</ul>
				<button type="button" id="btnTop"><em class="snd_only">맨 위로</em></button>
			</div>
		</div>
	</div>
	<!-- #관리자 -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="setting_wrap">
		<!-- 관리자 상단배너 시작 { -->
		<section class="banner_area">
			<div class="container">
				<dl>
					<dt><span>관리자페이지 이용 시 주의사항</span></dt>
					<dd>회원 징계 시 다시 한번 확인하고 처리할 것 / 모든 삭제 기능 처리 시 신중하게 처리할 것</dd>
				</dl>
			</div>
		</section>
		<!-- } 관리자 상단배너 끝 -->
			<div class="container">
			<!-- 좌측 사이드메뉴 시작 { -->
			<section class="side_area">
				<ul class="lnb_list">
					<li><a href="${root }admin/" class="act">관리자 홈</a></li>
					<li><a href="${root }admin/user">회원 관리</a></li>
					<li><a href="${root }admin/group">그룹 관리</a></li>
					<li><a href="${root }admin/camp">캠핑장 관리</a></li>
					<li><a href="${root }admin/venture">사업자 계정 관리</a></li>
					<li><a href="${root }admin/report">신고 관리</a></li>
				</ul>
			</section>
			<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="snd_only">대시보드</h2>
				<div class="dashboard_wrap">
					<div>
						<div class="dash_total box">
							<p class="tt_time"><span></span> 기준</p>
							<ul>
							<c:choose>
								<c:when test="${allUser.profile gt yesterday.profile }">
									<li class="cnt_up">
										<span>전체 사용자</span><b>${allUser.profile }</b>
									</li>
								</c:when>
								<c:when test="${allUser.profile lt yesterday.profile }">
									<li class="cnt_down">
										<span>전체 사용자</span><b>${allUser.profile }</b>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<span>전체 사용자</span><b>${allUser.profile }</b>
									</li>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${allUser.group1 gt yesterday.group1 }">
									<li class="cnt_up">
										<span>전체 그룹</span><b>${allUser.group1 }</b>
									</li>
								</c:when>
								<c:when test="${allUser.group1 lt yesterday.group1 }">
									<li class="cnt_down">
										<span>전체 그룹</span><b>${allUser.group1 }</b>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<span>전체 그룹</span><b>${allUser.group1 }</b>
									</li>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${allUser.myventure gt yesterday.myventure }">
									<li class="cnt_up">
										<span>전체 사업자</span><b>${allUser.myventure }</b>
									</li>
								</c:when>
								<c:when test="${allUser.myventure lt yesterday.myventure }">
									<li class="cnt_down">
										<span>전체 사업자</span><b>${allUser.myventure }</b>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<span>전체 사업자</span><b>${allUser.myventure }</b>
									</li>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${allUser.camp gt yesterday.camp }">
									<li class="cnt_up">
										<span>전체 캠핑장</span><b>${allUser.camp }</b>
									</li>
								</c:when>
								<c:when test="${allUser.camp lt yesterday.camp }">
									<li class="cnt_down">
										<span>전체 캠핑장</span><b>${allUser.camp }</b>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<span>전체 캠핑장</span><b>${allUser.camp }</b>
									</li>
								</c:otherwise>
							</c:choose>
							</ul>
						</div>
					</div>
					<div>
						<div class="dash_new box">
							<h3>신규 가입자 현황 (지난주)</h3>
							<canvas id="newChart" width="330" height="208"></canvas>
							<ul id="newData" class="data_list">
								<li data-label="Mon">${lastWeek.monday }</li>
								<li data-label="Tue">${lastWeek.tuesday }</li>
								<li data-label="Wed">${lastWeek.wednesday }</li>
								<li data-label="Thu">${lastWeek.thursday }</li>
								<li data-label="Fri">${lastWeek.friday }</li>
								<li data-label="Sat">${lastWeek.saturday }</li>
								<li data-label="Sun">${lastWeek.sunday }</li>
							</ul>
						</div>
						<div class="dash_status box">
							<h3>신규 진행 현황</h3>
							<ul>
								<li class="cr_mint"><a href="">사용자 가입 ${week.userCount }건</a></li>
								<li class="cr_pink"><a href="">그룹 생성 ${week.groupCount }건</a></li>
								<li class="cr_sky"><a href="">사업자 신청 ${week.ventureCount }건</a></li>
								<li class="cr_mstd"><a href="">캠핑장 등록 ${week.campCount }건</a></li>
								<li class="cr_coral"><a href="">신고 접수 ${week.reportCount }건</a></li>
							</ul>
						</div>
					</div>
					<div>
						<div class="dash_age box">
							<h3>회원 연령 분포</h3>
							<canvas id="ageChart" width="175" height="175"></canvas>
							<dl id="ageData">
								<dt><span class="cr_mint"></span>10대</dt>
								<dd>${userAge.age10 }</dd>
								<dt><span class="cr_pink"></span>20대</dt>
								<dd>${userAge.age20 }</dd>
								<dt><span class="cr_sky"></span>30대</dt>
								<dd>${userAge.age30 }</dd>
								<dt><span class="cr_mstd"></span>40대</dt>
								<dd>${userAge.age40 }</dd>
								<dt><span class="cr_coral"></span>50대</dt>
								<dd>${userAge.age50 }</dd>
							</dl>
						</div>
						<div class="dash_location box">
							<h3>선호 관심지역 (상위 5개)</h3>
							<canvas id="locationChart" width="250" height="200"></canvas>
							<dl id="locationData" class="data_list">
								<c:forEach items="${prefer }" var="prefer"> 
									<dt>${prefer.proaddr }</dt>
									<dd>${prefer.addrcnt }</dd>
								</c:forEach>
							</dl>
						</div>
					</div>
				</div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type="text/javascript">
dashboard();
</script>
</body>
</html>