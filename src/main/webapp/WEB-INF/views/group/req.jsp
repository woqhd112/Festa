<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty" />
	</c:if>
</c:if>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
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
			
			var name;
			var pronum;
			var proparam;

			var name2;
			var grnum;
			var numparam;
			
			var name3;
			var grname;
			var nameparam;
			
			$('#join').on('click', function(){
				if($('.comm_chk:checked').length==0){
					openPop('fail');
				} else{
					openPop('hello');
					$('tbody .comm_chk:checked').each(function(index){
						pronum=$(this).parent().find('#parampronum').val();
						console.log(pronum);
						$(this).attr('name', 'updateList['+index+'].pronum');
						name=$(this).attr('name');
						if(index==0){
							proparam=name+"="+pronum;
						}else if(index>0){
							proparam=proparam+"&"+name+"="+pronum
						}
						
						grnum=$(this).parent().find('#paramgrnum').val();
						console.log(grnum);
						$(this).attr('name', 'updateList['+index+'].grnum');
						name2=$(this).attr('name');
						if(index==0){
							numparam=name2+"="+grnum;
						}else if(index>0){
							numparam=numparam+"&"+name2+"="+grnum
						}
						
						grname=$(this).parent().find('#paramgrname').val();
						console.log(grname);
						$(this).attr('name', 'updateList['+index+'].grname');
						name3=$(this).attr('name');
						if(index==0){
							nameparam=name3+"="+grname;
						}else if(index>0){
							nameparam=nameparam+"&"+name3+"="+grname
						}
					});
					
					var jot = proparam.split("&");
					var jointot=jot.length;
					
					var grtotal=$('#postgrtotal').val();
					$('#grtotal').val(grtotal);

					var grnum=$('#postgrnum').val();
					$('#grnum').val(grnum);

					var pronum=$('#postpronum').val();
					$('#pronum').val(pronum);
					
					$('#hi').on('click', function(){
						var grtotal=$('#grtotal').val();
						var grnum=$('#grnum').val();
						var pronum=$('#pronum').val();
						
						$.post('${root}group/req/hello', proparam+'&'+numparam+'&'+nameparam+
								'&grtotal='+grtotal+'&jointot='+jointot+'&grnum='+grnum+'&pronum='+pronum, function(){
							openPop('ok');
							$('#success').on('click', function(){
								location.reload();
							});														
						});
					});
				}
			});
			
			$('#nojoin').on('click', function(){
				if($('.comm_chk:checked').length==0){
					openPop('fail');
				} else{
					openPop('bye');
					$('tbody .comm_chk:checked').each(function(index){
						pronum=$(this).parent().find('#parampronum').val();
						console.log(pronum);
						$(this).attr('name', 'updateList['+index+'].pronum');
						name=$(this).attr('name');
						if(index==0){
							proparam=name+"="+pronum;
						}else if(index>0){
							proparam=proparam+"&"+name+"="+pronum
						}
						
						grnum=$(this).parent().find('#paramgrnum').val();
						console.log(grnum);
						$(this).attr('name', 'updateList['+index+'].grnum');
						name2=$(this).attr('name');
						if(index==0){
							numparam=name2+"="+grnum;
						}else if(index>0){
							numparam=numparam+"&"+name2+"="+grnum
						}
					});
					
					var pronum=$('#postpronum').val();
					$('#pronum').val(pronum);
					
					$('#sorry').on('click', function(){

						var pronum=$('#pronum').val();
						
						$.post('${root}group/req/sorry', proparam+'&'+numparam+'&pronum='+pronum, function(){
							openPop('ok');
							$('#success').on('click', function(){
								location.reload();
							});
						});
					});
					
				}
			});
			
		});
	
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
		<input type="hidden" id="postgrtotal" value="${detail.grtotal }">
		<input type="hidden" id="postgrnum" value="${detail.grnum }">
		<input type="hidden" id="postpronum" value="${login.pronum }">
		<!-- #그룹 관리 -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="setting_wrap">
			<!-- 프로필영역 시작 { -->
			<section class="profile_area">
				<div class="container">
					<div class="info_box">
						<dl>
							<dt class="pf_tit">
								<a class="pf_name"
									href="${root }group/?grnum=${detail.grnum}&pronum=${detail.pronum}">
									<b>${detail.grname }</b>
								</a>
								<c:if test="${detail.grventure eq 2 }">
									<span class="gp_official"></span>
								</c:if>
								<c:if test="${login.pronum eq detail.pronum }">
									<a class="pf_opt go_settings"
										href="${root }group/profile/?grnum=${detail.grnum}"> <em
										class="snd_only">설정</em>
									</a>
								</c:if>
								<c:if test="${login.pronum ne detail.pronum }">
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
								<c:if test="${login.pronum ne detail.pronum }">
									<a class="btn_pop btn_out" href="${root }group/out">탈퇴</a>
								</c:if>
							</dd>
							<c:choose>
								<c:when test="${detail.grphoto eq null || detail.grphoto eq '' }">
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
					<p class="social_btns">
						<button type="button" class="btn_chat" onclick="window.open('${root}group/chat?grnum=${detail.grnum }','Festa chat','width=721,height=521,location=no,status=no,scrollbars=no');">그룹채팅</button>
					</p>
				</div>
			</section>
			<!-- } 프로필영역 끝 -->
			<div class="container">
				<!-- 좌측 사이드메뉴 시작 { -->
				<section class="side_area">
					<ul class="lnb_list">
						<li><a href="${root }group/profile?grnum=${detail.grnum}">그룹 관리</a></li>
						<li><a href="${root }group/user?grnum=${detail.grnum}">그룹원 관리</a></li>
						<li><a href="${root }group/req?grnum=${detail.grnum}" class="act">가입신청 조회</a></li>
					</ul>
				</section>
				<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">가입신청 조회</h2>
				<form class="set_form">
					<table class="gp req_table two">
						<caption class="snd_only">가입신청 목록</caption>
						<thead>
							<tr>
								<th class="w60">No</th>
								<th>이름 (ID)</th>
								<th class="w120">생년월일</th>
								<th class="w60">성별</th>
								<th class="w120">관심지역</th>
							</tr>
							<tr>
								<c:if test="${pageSearch.totalCount ne 0 }" >
									<th class="tb_chk">
										<input type="checkbox" class="comm_chk" name="allChecked" id="festaTbl0">
										<label for="festaTbl0"><em class="snd_only">전체선택</em></label>
									</th>
								</c:if>
								<c:if test="${pageSearch.totalCount eq 0 }" >
									<th></th>
								</c:if>
								<th class="tb_content" colspan="4">가입 동기</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${pageSearch.totalCount ne 0 }">
									<c:set var="i" value="5"/>
									<c:forEach items="${request }" var="request">
										<tr>
											<td>${request.uwrn}</td>
											<td>
												<p>
													<a href="${root }user/?pronum=${request.profile.pronum}" target="_blank">
														${request.profile.proname } (${request.profile.proid })
													</a>
												</p>
											</td>
											<td>${request.profile.proidnum }</td>
											<td>${request.profile.projender }</td>
											<td>${request.profile.proaddr }</td>
										</tr>
										<tr>
											<td class="tb_chk">
												<input type="hidden" name="" id="parampronum" value="${request.profile.pronum }">
												<input type="hidden" name="" id="paramgrnum" value="${detail.grnum}">
												<input type="hidden" name="" id="paramgrname" value="${detail.grname }">
												<input type="checkbox" class="comm_chk" name="" id="festaTbl${i}">
												<label for="festaTbl${i}"><em class="snd_only">선택</em></label>
											</td>
											<td class="tb_content" colspan="4">
												${request.grsayone }
											</td>
										</tr>
									<c:set var="i" value="${i-1 }"/>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="fstEmpty">가입 신청 건이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</form>
				<div class="table_options">
					<ul class="comm_buttons_s">
						<li><button type="submit" id="join" class="comm_btn cnc">승인</button></li>
						<li><button type="submit" id="nojoin" class="comm_btn">거절</button></li>
					</ul>
				</div>
				<div class="fstPage">
					<ul>
						<c:if test="${pageSearch.totalCount ne 0 }">
							<c:choose>
								<c:when test="${pageSearch.page2 eq 1 }">
									<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>
									<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>
								</c:when>
								<c:otherwise>
									<c:if test="${pageSearch.beginPage eq 1 }">
										<li><a class="pg_start" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.beginPage}"><em class="snd_only">맨 앞으로</em></a></li>
									</c:if>
									<c:if test="${pageSearch.beginPage ne 1 }">
										<li><a class="pg_start" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.beginPage-1}"><em class="snd_only">맨 앞으로</em></a></li>
									</c:if>
									<li><a class="pg_prev" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.page2-1}"><em class="snd_only">이전 페이지</em></a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="${pageSearch.beginPage }" varStatus="status"  end="${pageSearch.endPage }">
								<c:choose>
									<c:when test="${pageSearch.page2 == status.index}">
										<li><b>${status.index }</b></li>
									</c:when>
									<c:otherwise>
										<li><a href="${root }group/req?grnum=${detail.grnum }&page2=${status.index}">${status.index }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${pageSearch.next eq true }">
									<li><a class="pg_next" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.page2+1}"><em class="snd_only">다음 페이지</em></a></li>
									<c:if test="${pageSearch.totalPage eq pageSearch.endPage }">
										<li><a class="pg_end" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.endPage}"><em class="snd_only">맨 끝으로</em></a></li>
									</c:if>
									<c:if test="${pageSearch.totalPage ne pageSearch.endPage }">
										<li><a class="pg_end" href="${root }group/req?grnum=${detail.grnum }&page2=${pageSearch.endPage+1}"><em class="snd_only">맨 끝으로</em></a></li>
									</c:if>
								</c:when>
								<c:otherwise>
									<li><a class="pg_next off"><em class="snd_only">다음 페이지</em></a></li>
									<li><a class="pg_end off"><em class="snd_only">맨 끝으로</em></a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</ul>
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

	<div id="hello" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">선택한 회원(들)의 신청을 승인하시겠습니까?</h3>
			<input type="hidden" id="grtotal" value="">
			<input type="hidden" id="grnum" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="hi" class="btn_close comm_btn cfm">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	
	<div id="bye" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">선택한 회원(들)의 신청을 거절하시겠습니까?</h3>
			<input type="hidden" id="grnum" value="">
			<input type="hidden" id="pronum" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="sorry" class="btn_close comm_btn cfm">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
		
	<!-- #팝업 처리완료 { -->
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="success" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>

	<!-- #팝업 체크된값없음 { -->
	<div id="fail" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">아무것도 선택되지 않았습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
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