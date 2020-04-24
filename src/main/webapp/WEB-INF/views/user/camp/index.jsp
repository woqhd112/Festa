<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image"
	content="${root }resources/images/ico/logo.png">
<script type="text/javascript"
	src="${root }resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${root }resources/js/util.js"></script>
<script type="text/javascript" src="${root }resources/js/site.js"></script>
<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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

		
		var myVenture = "${myVenture}";
		var campCheck = "${campCheck}";
		var tmp = "${myCamp.caphoto}";
		tmp = tmp.split(',');
		if(tmp.length==1){
			$('#caphoto').val(tmp[0]);
			$('#imgCaphoto').attr('src','${upload }/'+tmp[0]);
		}
		else if(tmp.length>1){
			$('#caphoto').val(tmp[tmp.length-1]);
			$('#imgCaphoto').attr('src','${upload }/'+tmp[tmp.length-1]);
		}
		
		//canum, caname, caaddr, caintro  , caaddrsuv is not null
		
		var caname = $('#caname').val();
		var caaddr = $('#caaddr').val();
		var caintro = $('#caintro').val();
		var caaddrsuv = $('#caaddrsuv').val();
		if(caname!=null && caaddr !=null && caaddrsuv !=null && caintro.length>0){
			$('#apply').prop('type','submit');
		}
		
		//메인소개 유효성
		$("#caintro").on('propertychange change keyup paste input',function() {
			if($('#caintro').val().length>500){
				$('#caintroCheck').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caintroCheck').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});//메인소개 유효성 종료
		
		//한줄소개 유효성
		$('#caintroone').on('propertychange change keyup paste input',function() {
			if($('#caintroone').val().length>20){
				$('#caintrooneCheck').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caintrooneCheck').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});//한줄소개 유효성 종료
		
		//해시태그 유효성
		$('#httitle1').on('propertychange change keyup paste input',function() {
			if($('#httitle1').val().length>20){
				$('#httitleCheck').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		$('#httitle2').on('propertychange change keyup paste input',function() {
			if($('#httitle2').val().length>20){
				$('#httitleCheck').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		$('#httitle3').on('propertychange change keyup paste input',function() {
			if($('#httitle3').val().length>20){
				$('#httitleCheck').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		//해시태그 유효성 종료
		
		//시설안내 유효성
		$('#caguide1').on('propertychange change keyup paste input',function() {
			if($('#caguide1').val().length>30){
				$('#caguide1Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide1Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide2').on('propertychange change keyup paste input',function() {
			if($('#caguide2').val().length>30){
				$('#caguide2Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide2Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide3').on('propertychange change keyup paste input',function() {
			if($('#caguide3').val().length>30){
				$('#caguide3Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide3Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide4').on('propertychange change keyup paste input',function() {
			if($('#caguide4').val().length>30){
				$('#caguide4Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide4Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide5').on('propertychange change keyup paste input',function() {
			if($('#caguide5').val().length>30){
				$('#caguide5Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide5Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide6').on('propertychange change keyup paste input',function() {
			if($('#caguide6').val().length>30){
				$('#caguide6Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide6Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		
		$('#caguide7').on('propertychange change keyup paste input',function() {
			if($('#caguide7').val().length>30){
				$('#caguide7Check').show();
				$('#apply').prop('type','button');
			}
			else{
				$('#caguide7Check').hide();
				if($('#canum').val()!="" && $('#caname').val()!="" && $('#caaddr').val()!="" && $('#caintro').val()!=""&& $('#caaddrsuv').val()!="" && $('#caintroCheck').attr("style")=="display: none;" && $('#caintrooneCheck').attr("style")=="display: none;" && $('#httitleCheck').attr("style")=="display: none;" && $('#caguide1Check').attr("style")=="display: none;" && $('#caguide2Check').attr("style")=="display: none;" && $('#caguide3Check').attr("style")=="display: none;" && $('#caguide4Check').attr("style")=="display: none;" && $('#caguide5Check').attr("style")=="display: none;"  && $('#caguide6Check').attr("style")=="display: none;"  && $('#caguide7Check').attr("style")=="display: none;"){
					$('#apply').prop('type','submit');
				}
				else{
					$('#apply').prop('type','button');
				}
			}
		});
		//시설안내 유효성 종료
		
		$('#rst').on('submit',function(e){
			e.preventDefault();

			var files = new FormData($('#rst')[0]);
			$.ajax({
				type:"POST",
				enctype:'multipart/form-data',
				url:'${root}/user/camp/edit',
				data: files,
				processData: false,
				contentType: false,
				cache: false,
				success:function(data){
					openPop('updateOk');
					$('#finish_update').on('click',function(){
						window.location.reload();
					});
				},
				error:function(e){
					e.preventDefault();
				}
			});
		});
		
		$('#btn_cancle').on('click',function(){
			var size = $("input[name='caphoto']").length;
			var mainPhoto = $("input[name='caphoto']").eq(size-1).val();
			for(var i = 1;i<size;i++){
				console.log(mainPhoto);
				console.log(i);
				if(mainPhoto==$("input[name='caphoto']").eq(i).val()){
					alert(i);
					$("input[name='caphoto']").eq(i).val();
				}
			}
		});;
	});
/* action="${root }user/camp/edit" method="post" */ 

	
</script>
</head>
<body>
<c:if test="${sessionScope.login eq null}">
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
							<li><a href="${root}member/login" id="btn_pop"
								class="btn_pop">로그인</a></li>
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
									<b>${login.proname }</b>
								</dt>
								<dd>
									<span class="btn_mylist">나의 그룹</span>
									<div class="my_list">
										<ul>
											<c:forEach items="${joinGroup }" var="joinGroup">
												<c:choose>
													<c:when test="${joinGroup.group.grphoto eq null }">
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
												<li><a
													href="${root}camp/detail?canum=${bookMark.camp.canum}&caaddrsel=${bookMark.camp.caaddrsel}">
														<span> <c:set var="image"
																value="${fn:substringBefore(bookMark.camp.caphoto,',')}"></c:set>
															<c:if
																test="${!empty bookMark.camp.caphoto && empty image}">
																<img src="${upload}/${bookMark.camp.caphoto}"
																	alt="${bookMark.camp.caname}">
															</c:if> <c:if
																test="${!empty bookMark.camp.caphoto && !empty image}">
																<img src="${upload}/${image}"
																	alt="${bookMark.camp.caname}">
															</c:if> <c:if
																test="${empty bookMark.camp.caphoto && empty image}">
																<img src="${root}resources/images/thumb/no_profile.png"
																	alt="${bookMark.camp.caname}">
															</c:if>
													</span> <b>${bookMark.camp.caname}</b>
												</a></li>
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
		<!-- #유저 관리 -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="setting_wrap">
			<!-- 프로필영역 시작 { -->
			<section class="profile_area">
				<div class="container">
					<div class="info_box">
						<dl>
							<dt class="pf_tit">
								<a class="pf_name" href="${root}user/?pronum=${login.pronum}"><b>${login.proname }</b></a>
								<!-- 마이페이지일 경우 톱니바퀴 버튼 {  -->
								<a class="pf_opt go_settings" href="${root }user/profile"><em
									class="snd_only">설정</em></a>
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
							<li><a href="${root }user/venture/">사업자 계정 관리</a></li>
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
								<li><a href="${root }user/camp/" class="act">캠핑장 관리</a></li>
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
					<h2 class="set_tit">캠핑장 관리</h2>
					<form id="rst" class="set_form" enctype="multipart/form-data">
						<ul class="input_list">
							<li class="box">
								<p>캠핑장 사진</p>
								<div class="file_thumbnail mk_thumb" style="display: block">
									<ul>
										<c:set var="count" value="0" />
										<c:forTokens items="${myCamp.caphoto }" delims="," var="item">
											<c:set var="count" value="${count+1 }" />
											<li class="ft_thumb">
												<input type="hidden" id="caphoto${count }" name="caphoto" value="${item }" />
												<input type="file" id="file${count }" name="files" accept="video/*, image/*" value="${item }" /> 
												<img id="img${count }" src="${upload }/${item}" alt="" onload="squareTrim($(this), 80)">
												<button class="btn_cancle" id="btn_caphoto${count }" type="button">
													<em class="snd_only">업로드 취소하기</em>
												</button> <label for="file${count }" class="btn_file">
													<em	class="snd_only">사진/동영상 업로드하기</em>
												</label>
											</li>
										</c:forTokens>
										<c:forEach begin="${count }" end="4">
										<c:set var="count" value="${count+1 }" />
											<li class="ft_btn"><input type="file"
												id="file${count }" name="files" accept="video/*, image/*" /> <img
												src="" alt="">
												<button class="btn_cancle" type="button">
													<em class="snd_only">업로드 취소하기</em>
												</button> <label for="file${count }" class="btn_file"><em
													class="snd_only">사진/동영상 업로드하기</em></label></li>
										</c:forEach>
									</ul>
									<p class="txt_explan">파일 크기 00MB 이하, 최대 5개까지 업로드 가능합니다.</p>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa1">캠핑장 이름</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="caname" name="caname"
										value="${myCamp.caname }" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa2">대표자</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="proname" name="proname"
										value="${myVenture.proname }" readonly="readonly">
								</div>
							</li>
						</ul>
						<ul class="input_list">
							<li class="box">
								<p>
									<label for="festa5">캠핑장 주소</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="caaddr" name="caaddr"
										value="${myCamp.caaddr }" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<div>
									<input type="text" class="rd_only" id="caaddrsuv"
										name="caaddrsuv" value="${myCamp.caaddrsuv }"
										readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>지역권</p>
								<div>
									<select class="comm_sel" id="caaddrsel" name="caaddrsel">
										<option value="서울">서울</option>
										<option value="경기도">경기도</option>
										<option value="강원도">강원도</option>
										<option value="충청도">충청도</option>
										<option value="전라도">전라도</option>
										<option value="경상도">경상도</option>
										<option value="제주도">제주도</option>
										<option value="인천">인천</option>
										<option value="세종">세종</option>
										<option value="대구">대구</option>
										<option value="울산">울산</option>
										<option value="광주">광주</option>
										<option value="대전">대전</option>
									</select>
									<p class="comm_sel_label">서울</p>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa7">한줄 소개 </label>
								</p>
								<div>
									<input type="text" id="caintroone" name="caintroone" value="${myCamp.caintroone }"
										placeholder="한줄 소개글을 입력해주세요">
									<p hidden="hidden" id="caintrooneCheck" class="f_message rst" style="display: none;">20자를 초과하였습니다.</p>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa8" class="rq">메인 소개</label>
								</p>
								<div>
									<textarea id="caintro" name="caintro"
										placeholder="500자 이내로 작성해주세요">${myCamp.caintro }</textarea>
									<p hidden="hidden" id="caintroCheck" class="f_message rst" style="display: none;">500자를 초과하였습니다.</p>
								</div>
							</li>
							<li class="set_tags box">
								<p>해시태그 등록</p>
								<div>
									<ul>
										<li><input type="text" id="httitle1" name="httitle1" value="${myCamp.httitle1 }"></li>
										<li><input type="text" id="httitle2" name="httitle2" value="${myCamp.httitle2 }"></li>
										<li><input type="text" id="httitle3" name="httitle3" value="${myCamp.httitle3 }">
										</li>
									</ul>
									<p hidden="hidden" id="httitleCheck" class="f_message rst" style="display: none;">20자를 초과하였습니다.</p>
								</div>
							</li>
							
							<li class="set_inputs box">
								<p>시설 안내</p>
								<div>
									<!-- <button type="button" class="btn_hf" id="btnAddInput"
										data-field="caguide">
										<i class="xi-plus"></i><em class="snd_only">입력창 추가하기</em>
									</button> -->
									<c:choose>
										<c:when
											test="${myCamp.caguide1 eq '' and myCamp.caguide2 eq '' and myCamp.caguide3 eq '' and myCamp.caguide4 eq '' and myCamp.caguide5 eq '' and myCamp.caguide6 eq '' and myCamp.caguide7 eq '' }">
											<li class="fstEmpty">등록된 시설 안내 사항이 없습니다</li>
										</c:when>
										<c:otherwise>
											<ul><li><input type="text" id="caguide1" name="caguide1" value="${myCamp.caguide1 }">
											<p hidden="hidden" id="caguide1Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide2" name="caguide2" value="${myCamp.caguide2 }">
											<p hidden="hidden" id="caguide2Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide3" name="caguide3" value="${myCamp.caguide3 }">
											<p hidden="hidden" id="caguide3Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide4" name="caguide4" value="${myCamp.caguide4 }">
											<p hidden="hidden" id="caguide4Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide5" name="caguide5" value="${myCamp.caguide5 }">
											<p hidden="hidden" id="caguide5Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide6" name="caguide6" value="${myCamp.caguide6 }">
											<p hidden="hidden" id="caguide6Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
											<ul><li><input type="text" id="caguide7" name="caguide7" value="${myCamp.caguide7 }">
											<p hidden="hidden" id="caguide7Check" class="f_message rst" style="display: none;">30자를 초과하였습니다.</p>
											</li></ul>
										</c:otherwise>
									</c:choose>
									<p class="txt_explan">시설안내는 최대 7개까지 등록 가능합니다.</p>
								</div>
							</li>
						</ul>
						<ul class="comm_buttons">
							<li><button type="reset" class="btn_close comm_btn cnc">취소</button></li>
							<li><button type="button" id="apply" class="comm_btn sbm">저장</button></li>
						</ul>
						<input type="hidden" id="canum" name="canum" value="${myCamp.canum }"/>
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
						<span>경기도 성남시 분당구 느티로 2, AK와이즈플레이스</span> <span>김채찍과노예들</span> <span>사업자등록번호
							: 123-45-67890</span>
					</p>
					<p>
						<span>통신판매신고번호 : 제 2020-서울강남-0000</span> <span>대표번호 :
							010-3332-8616</span> <span>담당자 : 김덕수</span> <span>문의 :
							010-3332-8616</span>
					</p>
					<p>&copy; DEOKSOORR. All RIGHTS RESERVED.</p>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		addInputs();
		setOneFile();
		setFile();
	</script>
</body>
<div id="updateOk" class="fstPop pop2">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">수정이 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" id="finish_update" name="finish_update" class="btn_close comm_btn cfm">확인</button></li>
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