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
	<meta property="og:image" content="/images/ico/logo.png">
	<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root }resources/js/util.js"></script>
	<script type="text/javascript" src="${root }resources/js/site.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
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
			
			//그룹 이름 유효성 검사
			$('#grname').on('propertychange change keyup paste input',function() {
				if($('#grname').val().length<=20){
					$('#grnameCheck').hide();
					if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
						$('#createGroup').prop('type','submit');
					}	
					else{
						$('#createGroup').prop('type','button');
					}
				}
				else{
					$('#grnameCheck').show();
					$('#createGroup').prop('type','button');
				}
			});//그룹이름 유효성 검사 종료
			
			//그룹 소개 유효성 검사
			$('#grintro').on('propertychange change keyup paste input',function() {
				if($('#grintro').val().length<=500){
					$('#grintroCheck').hide();
					if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
						$('#createGroup').prop('type','submit');
					}	
					else{
						$('#createGroup').prop('type','button');
					}
				}
				else{
					$('#grintroCheck').show();
					$('#createGroup').prop('type','button');
				}
			});//그룹 소개 유효성 종료
			
			//관심 지역 유효성
			$('#graddr').change(function(){
        	 if($('#graddr option:selected').val() ==""){
         		$('#selectfail').show();
         	}
         	else{
         		$('#selectfail').hide();
         	}
				if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
          			$('#createGroup').prop('type','submit');
	            }
	            else{
	            	$('#createGroup').prop('type','button');
	            }
         });//관심지역 유효성 검사 종료
         
         //해시태그 유효성 검사
         $('#httitle1').on('propertychange change keyup paste input',function() {
			if($('#httitle1').val().length>20 || $('#httitle2').val().length>20  || $('#httitle3').val().length>20){
				$('#httitleCheck').show();
				$('#createGroup').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
					$('#createGroup').prop('type','submit');
				}
				else{
					$('#createGroup').prop('type','button');
				}
			}
		});
		$('#httitle2').on('propertychange change keyup paste input',function() {
			if($('#httitle1').val().length>20 || $('#httitle2').val().length>20  || $('#httitle3').val().length>20){
				$('#httitleCheck').show();
				$('#createGroup').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
					$('#createGroup').prop('type','submit');
				}
				else{
					$('#createGroup').prop('type','button');
				}
			}
		});
		$('#httitle3').on('propertychange change keyup paste input',function() {
			if($('#httitle1').val().length>20 || $('#httitle2').val().length>20  || $('#httitle3').val().length>20){
				$('#httitleCheck').show();
				$('#createGroup').prop('type','button');
			}
			else{
				$('#httitleCheck').hide();
				if($('#grname').val().length>0 && $('#grnameCheck').attr("style")=="display: none;"  && $('#grintroCheck').attr("style")=="display: none;" && $('#grintro').val().length>0 && $('#graddr option:selected').val() != "" && $('#httitleCheck').attr("style")=="display: none;"){
					$('#createGroup').prop('type','submit');
				}
				else{
					$('#createGroup').prop('type','button');
				}
			}
		});
		//해시태그 유효성 종료
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
							<a class="pf_name" href="${root}user/?pronum=${login.pronum}"><b>${login.proname }</b></a>
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
					<li><a href="${root }user/group" class="act">그룹 생성</a></li>
					</c:if>
					<!-- 사업자가인 경우 -->
					<c:if test="${myVenture ne null }">
					<li><a href="${root }user/venture/">사업자 계정 관리</a></li>
					</c:if>
					<!-- 사업자가 아닌 경우{ -->
					<c:if test="${myVenture eq null}">
					<c:if test="${myVentureRequestCheck eq null }">
					<li><a href="${root}user/venture/add">사업자 계정 신청</a></li>
					</c:if>
					<c:if test="${myVentureRequestCheck ne null }">
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
				<h2 class="set_tit">그룹 생성</h2>
				<form action="${root }user/group" method="post" class="set_form" enctype="multipart/form-data">
					<input type="hidden" id="pronum" name="pronum" value="${profile.pronum }"/>
					<ul class="input_list">
						<li class="set_file1 box">
							<p>그룹 대표사진</p>
							<div>
									<p class="pf_picture">
										<input type="file" id="file1" name="files" accept="image/*">
										<img src="${root }resources/upload/thumb/no_profile.png" alt="">
									</p>
									<ul class="comm_buttons_s">
										<li>
										<label for="file1" class="comm_btn cfm">등록</label>
										</li>
										<li>
											<button type="button" class="comm_btn">삭제</button>
										</li>
									</ul>
								</div>
						</li>
						<li class="box">
							<p><label for="">그룹 이름</label></p>
							<div>
								<input type="text" id="grname" name="grname" required="required">
								<p hidden="hidden" id="grnameCheck" class="f_message rst" style="display: none;">20자 이내로 작성해주세요</p>
							</div>
						</li>
						<li class="box">
							<p><label for="festa3">그룹 소개</label></p>
							<div>
								<textarea id="grintro" name="grintro" placeholder="500자 이내로 작성해주세요"></textarea>
								<p hidden="hidden" id="grintroCheck" class="f_message rst" style="display: none;">500자 이내로 작성해주세요</p>
							</div>
						</li>
					</ul>
					<ul class="input_list">
						<li class="box">
							<p><label for="festa4">그룹 관심지역</label></p>
							<div>
								<select class="comm_sel" id="graddr" name="graddr">
									<option value="">관심지역을 선택해주세요</option>
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
								<p class="comm_sel_label">관심지역을 선택해주세요</p>
								<p hidden="hidden" id="selectfail"
                              class="f_message rst">관심지역을 다시 설정하세요.</p>
							</div>
						</li>
						<li class="set_tags box">
							<p>해시태그 등록</p>
							<div>
								<ul>
									<li><input type="text" id="httitle1" name="httitle1"></li>
									<li><input type="text" id="httitle2" name="httitle2"></li>
									<li><input type="text" id="httitle3" name="httitle3"></li>
								</ul>
								<p hidden="hidden" id="httitleCheck" class="f_message rst" style="display: none;">20자를 초과하였습니다.</p>
							</div>
						</li>
					</ul>
					<ul class="comm_buttons">
						<li><button id="createGroup" type="button" class="comm_btn sbm">그룹 생성</button></li>
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
<script type="text/javascript">
setOneFile();
</script>
</body>
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