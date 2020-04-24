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
<meta property="og:image"
	content="${root }resources/images/ico/logo.png">
<script type="text/javascript"
	src="${root }resources/js/jquery-1.12.4.js"></script>
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

	$(document).ready(
			function() {
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

			   
			   
			   	
				//비밀번호 형식 유효성 검사
		         $("#propwCheck").on('propertychange change keyup paste input',function() {
		        	 if($('#propw').val() != ""){
			            var regExp = /^[A-Za-z0-9+]{8,13}$/;
			            var propw = $("#propw").val();
			            var propwCheck = $("#propwCheck").val();
			            var pw_num = propw.search(/[0-9]/g);
			            var pw_eng = propw.search(/[a-z]/gi);
			            var pwchk_num = propwCheck.search(/[0-9]/g);
			            var pwchk_eng = propwCheck.search(/[a-z]/gi);
			            if (regExp.test(propw) && regExp.test(propwCheck)) {
			               if (pw_num >= 0 && pw_eng >= 0   && pwchk_num >= 0 && pwchk_eng >= 0) {
			                  if (propw != propwCheck) {
			                     $("#pwfail").show();
			                     $("#pwok").hide();
			                     $("#pwif").hide();
			                  } else if (propw == propwCheck) {
			                     $("#pwfail").hide();
			                     $("#pwok").show();
			                     $("#pwif").hide();
			                  }
			               } else {
			                  $("#pwfail").hide();
			                  $("#pwok").hide();
			                  $("#pwif").show();
			               }
			            } else {
			               $("#pwfail").hide();
			               $("#pwok").hide();
			               $("#pwif").show();
			            }
		        	 }
		        	 if($('#pwok').attr("style")=="display: block;"){
		         			$('#changeBtn').prop('type','submit');
			        }
			        else{
			            $('#changeBtn').prop('type','button');
			        }
		         });

		         $("#propw").on('propertychange change keyup paste input',function() {
		        	if($('#propwCheck').val() != ""){
			            var regExp = /^[A-Za-z0-9+]{8,13}$/;
			            var propw = $("#propw").val();
			            var propwCheck = $("#propwCheck").val();
			            var pw_num = propw.search(/[0-9]/g);
			            var pw_eng = propw.search(/[a-z]/gi);
			            var pwchk_num = propwCheck.search(/[0-9]/g);
			            var pwchk_eng = propwCheck.search(/[a-z]/gi);
			            if (regExp.test(propw) && regExp.test(propwCheck)) {
			               if (pw_num >= 0 && pw_eng >= 0 && pwchk_num >= 0 && pwchk_eng >= 0) {
			                  if (propw != propwCheck) {
			                     $("#pwfail").show();
			                     $("#pwok").hide();
			                     $("#pwif").hide();
			                  } else if (propw == propwCheck) {
			                     $("#pwfail").hide();
			                     $("#pwok").show();
			                     $("#pwif").hide();
			                  }
			               } else {
			                  $("#pwfail").hide();
			                  $("#pwok").hide();
			                  $("#pwif").show();
			               }
			            } else {
			               $("#pwfail").hide();
			               $("#pwok").hide();
			               $("#pwif").show();
			            }
		        	}
		        	if($('#pwok').attr("style")=="display: block;"){
		         			$('#changeBtn').prop('type','submit');
			        }
			        else{
			            $('#changeBtn').prop('type','button');
			        }
		         });//비밀번호 유효성 검사 끝
		         
		         $('#changeForm').on("submit",function(e){
		        	e.preventDefault();
		        	$.post("${root}user/adm","propw="+$('#propw').val()+"&proaddr="+$('#proaddr').val()+"&projob="+$('#projob').val()+"&pronum="+$('#pronum').val());
		        	openPop("ok");
		         });
		         
		         $('#btn_ok').on('click',function(){
		        	location.href ="${root}user/check"; 
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
					<li><a href="${root }user/check" class="act">계정 관리</a></li>
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
					<h2 class="set_tit">계정 관리</h2>
					<form id="changeForm"class="set_form">
						<input type="hidden" id="pronum" name="pronum" value="${profile.pronum }"/>
						<input type="hidden" id="prointro" name="prointro" value="${profile.prointro }"/>
						<input type="hidden" id="prophoto" name="prophoto" value="${profile.prophoto }"/>
						<input type="hidden" id="proprovide" name="proprovide" value="${profile.proprovide }"/>
						<ul class="input_list">
							<li class="box">
								<p>
									<label for="festa1">아이디</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="proid" name="proid"
										value="${profile.proid }" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa2">이름</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="proname" name="proname"
										value="${profile.proname }" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa3">비밀번호</label>
								</p>
								<div>
									<input type="password" id="propw" name="propw"
										placeholder="비밀번호">
									<p hidden="hidden" id="pwif"class="f_message rst">비밀번호는
										8~13자 영문,숫자 조합이어야 합니다.</p>
									<p hidden="hidden" id="pwfail" class="f_message rst">비밀번호가 일치하지 않습니다.</p>
									<p hidden="hidden" id="pwok" class="f_message ok rst">비밀번호가 일치합니다.</p>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa4">비밀번호 확인</label>
								</p>
								<div>
									<input type="password" id="propwCheck" name="propwCheck"
										placeholder="비밀번호 확인">								</div>
							</li>

						</ul>
						<ul class="input_list">
							<li class="box">
								<p>
									<label for="festa5">성별</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="projender" name="projender"
										value="${profile.projender }" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa6">생년월일</label>
								</p>
								<div>
									<input type="text" class="rd_only" id="proidnum" name="proidnum"
										value="${profile.proidnum }" readonly="readonly">
								</div>
							</li>
						</ul>
						<ul class="input_list">
							<li class="box">
								<p>
									<label for="festa7">관심지역</label>
								</p>
								<div>
									<select class="comm_sel" id="proaddr" name="proaddr">
										<option value="서울" <c:if test="${profile.proaddr =='서울' }">selected</c:if>>서울</option>
										<option value="경기도" <c:if test="${profile.proaddr =='경기도' }">selected</c:if>>경기도</option>
										<option value="강원도" <c:if test="${profile.proaddr =='강원도' }">selected</c:if>>강원도</option>
										<option value="충청도" <c:if test="${profile.proaddr =='충청도' }">selected</c:if>>충청도</option>
										<option value="전라도" <c:if test="${profile.proaddr =='전라도'}">selected</c:if>>전라도</option>
										<option value="경상도" <c:if test="${profile.proaddr =='경상도' }">selected</c:if>>경상도</option>
										<option value="제주도" <c:if test="${profile.proaddr =='제주도' }">selected</c:if>>제주도</option>
										<option value="부산" <c:if test="${profile.proaddr =='부산' }">selected</c:if>>부산</option>
										<option value="인천" <c:if test="${profile.proaddr =='인천' }">selected</c:if>>인천</option>
										<option value="세종" <c:if test="${profile.proaddr =='세종' }">selected</c:if>>세종</option>
										<option value="대구" <c:if test="${profile.proaddr =='대구' }">selected</c:if>>대구</option>
										<option value="울산" <c:if test="${profile.proaddr =='울산' }">selected</c:if>>울산</option>
										<option value="광주" <c:if test="${profile.proaddr =='광주' }">selected</c:if>>광주</option>
										<option value="대전" <c:if test="${profile.proaddr =='대전' }">selected</c:if>>대전</option>
									</select>
									<p class="comm_sel_label"></p>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa8">직종</label>
								</p>
								<div>
									<select class="comm_sel" id="projob" name="projob">
										<option value="">(선택)</option>
										<option value="경영·사무">경영·사무</option>
										<option value="영업·고객상담">영업·고객상담</option>
										<option value="IT·인터넷">IT·인터넷</option>
										<option value="디자인">디자인</option>
										<option value="서비스">서비스</option>
										<option value="전문직">전문직</option>
										<option value="의료">의료</option>
										<option value="생산·제조">생산·제조</option>
										<option value="건설">건설</option>
										<option value="유통·무역">유통·무역</option>
										<option value="미디어">미디어</option>
										<option value="교육">교육</option>
										<option value="특수계층·공공">특수계층·공공</option>
										<option value="학생">학생</option>
										<option value="기타">기타</option>
									</select>
									<p class="comm_sel_label">IT·인터넷</p>
								</div>
							</li>
						</ul>
						<ul class="input_list">
							<li class="set_chk box">
								<p>계정 설정</p>
								<div>
									<input type="checkbox" class="comm_rdo rdo_pop" id="festa9"
										name="festa9" data-url="${root }user/inactive" > 
									<label for="festa9">계정 비활성화</label>
									<p class="txt_explan">
										계정 비활성화 시 프로필 및 공유한 피드를 볼 수 없습니다.<br> 로그인 시 비활성화가 자동으로
										해제됩니다.
									</p>
								</div>
							</li>
							<li class="set_chk box">
								<div>
									<input type="checkbox" class="comm_rdo rdo_pop" id="festa10"
										name="festa10" data-url="${root }user/out"> <label
										for="festa10">계정 탈퇴</label>
									<p class="txt_explan">
										계정 탈퇴 시 프로필 및 공유한 피드가 모두 삭제됩니다.<br> 탈퇴한 계정의 데이터는 복구할 수
										없습니다.
									</p>
								</div>
							</li>
						</ul>
						<ul class="comm_buttons">
							<li><button type="reset" class="btn_close comm_btn cnc">취소</button></li>
							<li><button id="changeBtn" type="button" class="comm_btn sbm">저장</button></li>
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
		rdoPop();
	</script>
</body>
<div id="ok" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">변경 사항이 저장되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" id="btn_ok" name="btn_ok" class="btn_close comm_btn cfm">확인</button></li>
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