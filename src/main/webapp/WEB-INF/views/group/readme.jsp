<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if> --%>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty" />
	</c:if>
</c:if>
<c:url value="/" var="root" />
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
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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
			
			//로그인하기 내부팝업->로그인버튼 클릭시 로그인외부팝업생성
			$('#btnLogin').on('click', function() {
				$('#login').bPopup().close();
				openLayer('none', '${root}member/login');
			});
			var loginCheck = '${login.logincheck}';
			
			//로그인이아닐때 프로필사진,이름,뉴스피드 눌렀을경우
			$(document).on('click','#gnb li a:eq(2), #joinGroupBtn',function(){
				if(loginCheck==''){
					openPop('login');
					return false;
				}else{
					openPop('gpJoin');
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
			
			$('#btnCookie').on('click',function(){
			   $.post('${root}member/loginCookie','id='+cookie,function(data){
			      if (data.prorn == '0') {
			         location.href = "${root}user/?pronum="+data.pronum;
			      } else if (data.prorn == '1') {
			         location.href = "${root}member/stop";
			      } else if (data.prorn == '2') {
			         location.href = "${root}member/kick";
			      } else if (data.prorn == '3') {
			         location.href = "${root}admin/";
			      } else if (data.prorn == '4') {
			         location.href = "${root}";
			      }
			   });
			});
			
			$('#grsayone').on('propertychange change keyup paste input', function(){
				var httag=$('#grsayone').val().length;
				if(httag>=50){
					$('#grfail').show();
		 			$('#request').attr("disabled", "disabled");
		 			$('#request').addClass('sbm');
		 			$('#request').removeClass('cfm');
				} else if(httag==0){
					$('#grfail').hide();
		 			$('#request').attr("disabled", "disabled");
		 			$('#request').addClass('sbm');
		 			$('#request').removeClass('cfm');
				} else{
					$('#grfail').hide();
					var info=$('#grintrofail').is(':visible');
					if(info==false){
			 			$('#request').removeAttr("disabled");
			 			$('#request').removeClass('sbm');
			 			$('#request').addClass('cfm');
					}
				}
		 	});
			
			$('#request').on('click', function(){
				var grnum=$('#grnum').val();
				var grname=$('#grname').val();
				var grsayone=$('#grsayone').val();
				var pronum=$('#pronum').val();
				var proname=$('#proname').val();
				
				$.post('${root}group/join', 'grnum='+grnum+'&grname='+grname+
						'&grsayone='+grsayone+'&pronum='+pronum+'&proname='+proname, function(){
					openPop("ok");
					$('#success').on('click', function(){
						window.location.href='${root}group/standby?grnum='+grnum;
					});
				});
				
			});
			
		});
	
	</script>
</head>
<body>
<input type="hidden" id="grnum" value="${detail.grnum }" >
<input type="hidden" id="grname" value="${detail.grnum }" >
<input type="hidden" id="pronum" value="${login.pronum }" >
<input type="hidden" id="proname" value="${login.proname }" >
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
					<li><a href="${root}camp/?caaddrsel=">캠핑정보</a></li>
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
												<c:when test="${joinGroup.group.grphoto eq null || joinGroup.group.grphoto eq '' }">
													<li><a
														href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
															<span><img src="${root }resources/upload/thumb/no_profile.png"
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
												<c:when test="${joinGroup.group.grphoto eq null || joinGroup.group.grphoto eq '' }"> 
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
	<!-- #그룹 홈 (미가입 회원) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="home_wrap">
		<h2 class="snd_only">입돌아간다 그룹 홈</h2>
		<!-- 프로필영역 시작 { -->
		<section class="profile_area">
			<div class="container">
				<div class="info_box">
					<dl>
						<dt class="pf_tit">
							<a class="pf_name"
								href="">
								<b>${detail.grname }</b>
							</a>
							<c:if test="${detail.grventure eq 2 }">
								<span class="gp_official"></span>
							</c:if>
							<c:if test="${login.pronum ne detail.pronum and !empty login }">
								<a href="${root }group/gp_report"
									class="pf_opt btn_pop btn_report"> <em class="snd_only">신고하기</em>
								</a>
							</c:if>
						</dt>
						<dd class="pf_intro">${detail.grintro }
						<dd class="pf_hashtag">
							<c:choose>
								<c:when
									test="${empty detail.httitle1 && empty detail.httitle2 && empty detail.httitle3}">
								</c:when>
								<c:when
									test="${empty detail.httitle1 && empty detail.httitle3}">
									<a href="${root }search/?keyword=${detail.httitle2}">${detail.httitle2}</a>
								</c:when>
								<c:when
									test="${empty detail.httitle2 && empty detail.httitle3}">
									<a href="${root }search/?keyword=${detail.httitle1}">${detail.httitle1}</a>
								</c:when>
								<c:when
									test="${empty detail.httitle1 && empty detail.httitle2}">
									<a href="${root }search/?keyword=${detail.httitle3}">${detail.httitle3}</a>
								</c:when>
								<c:when test="${empty detail.httitle1}">
									<a href="${root }search/?keyword=${detail.httitle2}">${detail.httitle2}</a>
									<a href="${root }search/?keyword=${detail.httitle3}">${detail.httitle3}</a>
								</c:when>
								<c:otherwise>
									<a href="${root }search/?keyword=${detail.httitle1}">${detail.httitle1}</a>
									<a href="${root }search/?keyword=${detail.httitle2}">${detail.httitle2}</a>
									<a href="${root }search/?keyword=${detail.httitle3}">${detail.httitle3}</a>
								</c:otherwise>
							</c:choose>
						</dd>
						<dd class="gp_list">
							<span>그룹장 : ${detail.profile.proname}</span> <a
								class="btn_pop btn_member"
								href="${root }group/member?grnum=${detail.grnum}">멤버 :
								${detail.grtotal }명</a> <span>개설일 : ${detail.grdate }</span>
						</dd>
						<c:choose>
								<c:when test="${detail.grphoto eq null || detail.grphoto eq ''}">
									<dd class="pf_picture">
										<img src="${root }resources/upload/thumb/no_profile.png" alt="${detail.grname } 그룹 썸네일">
									</dd>
								</c:when>
								<c:otherwise>
									<dd class="pf_picture">
										<img src="${upload }/${detail.grphoto }" alt="${detail.grname } 그룹 썸네일">
									</dd>
								</c:otherwise>
						</c:choose>
					</dl>
				</div>
			</div>
		</section>
		<!-- } 프로필영역 끝 -->
		<div class="container">
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<!-- #비공개 시작 {  -->
				<div class="readme_wrap">
					<div>
						<h3 class="set_tit">${detail.grname} 그룹 멤버에게만 공개된 페이지입니다.</h3>
						<dl>
							<dt><span>${detail.grname }</span> 그룹에 가입해보세요!</dt>
							<dd>${detail.grintro} </dd>
						</dl>
						<p class="comm_buttons">
						   <button id="joinGroupBtn" class="btn_pop comm_btn cfm">가입 신청하기</button>
						</p>
					</div>
				</div>
				<!-- } #비공개 끝 -->
			</section>
			<!-- } 컨텐츠영역 끝 -->
			<!-- 우측 사이드영역 시작 { -->
			<section class="side_area">
				<div class="rcmm_list">
					<h3>
						<em class="snd_only">추천그룹 목록</em>나홀로 캠핑이 심심하신가요?
					</h3>
					<ul>
						<c:forEach items="${grouplist }" begin="0" end="2"
							var="grouplist">
							<c:if test="${login ne null }">
								<li><c:choose>
										<c:when test="${grouplist.grphoto eq null || grouplist.grphoto eq ''}">
											<a class="rc_thumb"
												href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
												<img src="${root}resources/images/thumb/no_profile.png"
												alt="${grouplist.grname } 그룹 썸네일">
											</a>
										</c:when>
										<c:otherwise>
											<a class="rc_thumb"
												href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
												<img src="${upload }/${grouplist.grphoto}"
												alt="${grouplist.grname } 그룹 썸네일">
											</a>
										</c:otherwise>
									</c:choose> <a class="rc_text"
									href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
										<b class="rc_name">${grouplist.grname }</b> <span
										class="rc_intro">${grouplist.grintro }</span>
								</a></li>
							</c:if>
							<c:if test="${login eq null }">
								<li><c:choose>
										<c:when test="${grouplist.grphoto eq null || grouplist.grphoto eq ''}">
											<a class="rc_thumb"
												href="${root }group/?grnum=${grouplist.grnum}"> <img
												src="${root}resources/images/thumb/no_profile.png"
												alt="${grouplist.grname } 그룹 썸네일">
											</a>
										</c:when>
										<c:otherwise>
											<a class="rc_thumb"
												href="${root }group/?grnum=${grouplist.grnum}"> <img
												src="${upload }/${grouplist.grphoto}"
												alt="${grouplist.grname } 그룹 썸네일">
											</a>
										</c:otherwise>
									</c:choose> <a class="rc_text"
									href="${root }group/?grnum=${grouplist.grnum}"> <b
										class="rc_name">${grouplist.grname }</b> <span
										class="rc_intro">${grouplist.grintro }</span>
								</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div class="rcmm_list">
					<h3>
						<em class="snd_only">추천캠핑장 목록</em>이 캠핑장에도 가보셨나요?
					</h3>
					<ul>
						<c:forEach items="${camplist }" begin="0" end="2" var="camplist">
							<li><c:if test="${!empty camplist.caphoto }">
									<c:set var="image1" value="${fn:split(camplist.caphoto,',') }" />
									<c:if test="${fn:length(image1) gt 1 }">
										<c:set var="image"
											value="${fn:substringBefore(camplist.caphoto,',') }" />
									</c:if>
									<c:if test="${fn:length(image1) eq 1 }">
										<c:set var="image" value="${camplist.caphoto }" />
									</c:if>
									<a class="rc_thumb"
										href="${root }camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}"> <img
										src="${upload }/${image}" alt="${camplist.caname } 썸네일">
									</a>
								</c:if> <c:if test="${empty camplist.caphoto }">
									<a class="rc_thumb"
										href="${root }camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}"> <img
										src="${root }resources/images/thumb/no_profile.png"
										alt="${camplist.caname } 썸네일">
									</a>
								</c:if> <a class="rc_text"
								href="${root }camp/detail?canum=${camplist.canum}&caaddrsel=${camplist.caaddrsel}"> <b
									class="rc_name">${camplist.caname }</b> <span
									class="rc_hashtag">${camplist.caaddrsel }</span>
							</a></li>
						</c:forEach>
					</ul>
				</div>
			</section>
			<!-- } 우측 사이드영역 끝 -->
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

	<!-- #팝업 그룹 가입신청 { -->
	<div id="gpJoin" class="fstPop">
		<div class="gp_join_wrap pop_wrap">
			<h4 class="pop_tit">페스타 개인정보 제 3자 제공 동의</h4>
			<div class="info_box">
				<p>이 서비스는 아래 개인정보를 요청합니다.</p>
				<ul>
					<li>제공받는 자 : 그룹장</li>
					<li>제공받는 정보 : 프로필 정보(이름, 관심지역,  프로필 사진, 성별)</li>
					<li>제공받는 목적 : 그룹 서비스 제공</li>
					<li>보유기간 : 해당 그룹 탈퇴 시 지체없이 파기</li>
				</ul>
			</div>
			<form class="comm_form">
				<div class="ip_box">
					<input type="text" id="grsayone" name="" required="required">
					<label for="festa1" class="comm_label"><span>(필수)</span> <span>가입신청 동기 또는 </span>하고싶은 말<span>을 입력해주세요.</span></label>
				</div>
				<p hidden="hidden" id="grfail" class="f_message rst">50자 이내로 작성해주세요</p>
				<div class="btn_box">
					<ul class="comm_buttons">
						<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
						<li><button type="button" id="request" class="btn_close comm_btn sbm" disabled="disabled">신청하기</button></li>
					</ul>
				</div>
			</form>
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
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">가입 신청이 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="success" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<!-- #팝업 처리실패 { -->
	<div id="fail" class="fstPop">
		<div class="confirm_wrap pop_wrap"> 
			<p class="pop_tit">내용을 다시 확인해주세요.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="failed" class="btn_close ok comm_btn cfm" >확인</button></li>
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
</body>
</html>