<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty" />
	</c:if>
</c:if>
<c:if test="${sessionScope.login eq null and empty cookie.loginCookie.value}">
   <c:redirect url="/empty"/>
</c:if>
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
			var jgnum;
			var jgparam;
			
			$('#userkick').on('click', function(){
				if($('.comm_chk:checked').length==0){
					openPop('fail');
				}else{
					openPop('kick');
					$('tbody .comm_chk:checked').each(function(index){
						jgnum=$(this).parent().find('#postjgnum').val();
						console.log(jgnum);
						$(this).attr('name', 'joinGroupList['+index+'].jgnum');
						name=$(this).attr('name');
						if(index==0){
							jgparam=name+"="+jgnum;
						}else if(index>0){
							jgparam=jgparam+"&"+name+"="+jgnum
						}
					});
					
					var jot = jgparam.split("&");
					var jointot=jot.length;

					var grnum = $('#postgrnum').val();
					var grtotal = $('#postdeluser').val();
					$('#grnum').val(grnum);
					$('#jointot').val(jointot);
					$('#grtotal').val(grtotal);
					
					$('#jgnum').val(jgparam);
					var jgnum = $('#jgnum').val();
					
					console.log(jgparam);
					
					//삭제하기버튼 클릭시 데이터삭제
					$('#bye').on('click', function() {
						
						var grnum=$('#grnum').val();
						var grtotal=$('#grtotal').val();
						var jointot=$('#jointot').val();
						
						$.post('${root}group/user/kick', jgnum+'&grtotal='+grtotal+'&grnum='+grnum+'&jointot='+jointot, function(){
							openPop('ok');
							$('#success').click(function(){
								location.reload();
							});
						});
					});
				}
			});
			
			
			//전체추방
			$('#userallkick').on('click', function(){
				
				var grnum = $('#postgrnum').val();
				$('#grnum').val(grnum);
				var pronum = $('#postpronum').val();
				$('#pronum').val(pronum);
				var grtotal = $('#postdeluser').val();
				$('#jointot').val(grtotal-1);
				$('#grtotal').val(grtotal);
				console.log(jointot);
				
				//전체추방 키값검사
			 	$('#keymsg').on('propertychange change keyup paste input', function(){
			 		var keymsg=$('#keymsg').val();
			 		var sucmsg='웃어라, 함께 웃을 것이다. 울어라, 혼자 울 것이다.'
			 		if(keymsg == sucmsg){
			 			$('#outgroup').removeAttr("disabled");
			 			$('#outgroup').removeClass('sbm');
			 			$('#outgroup').addClass('cfm');
	
			 			var grnum=$('#grnum').val();
			 			var pronum=$('#pronum').val();
			 			var jointot=$('#jointot').val();
			 			var grtotal=$('#grtotal').val();
			 			
		 				$('#outgroup').on('click', function(){
			 				$.post('${root}/group/user/allkick', 'grnum='+grnum+'&pronum='+pronum+'&jointot='+jointot+'&grtotal='+grtotal, function(data){
									openPop("ok");
									$('#success').on('click', function(){
										location.reload();
										//window.location.href='http://localhost:8080/festa/group/user?grnum='+grnum;
									});
			 				});
		 				})
			 		}else{
			 			$('#outgroup').attr("disabled", "disabled");
			 			$('#outgroup').removeClass('cfm');
			 			$('#outgroup').addClass('sbm');
			 		}
			 	});
				
			})
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
			<input type="hidden" id="postgrnum" value="${detail.grnum }" />
			<input type="hidden" id="postpronum" value="${login.pronum }" />
			<input type="hidden" id="postjointot" value="${detail.jointot }" />
			<input type="hidden" id="postdeluser" value="${detail.grtotal }" />
			</div>
		</div>
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
						<li><a href="${root }group/user?grnum=${detail.grnum}" class="act">그룹원 관리</a></li>
						<li><a href="${root }group/req?grnum=${detail.grnum}">가입신청 조회</a></li>
					</ul>
				</section>
				<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">그룹원 관리</h2>
				<input type="hidden" id="grnum" value="${detail.grnum }" />
				<div class="table_options">
					<form class="search_form">
						<input type="hidden" id="" name="grnum" value="${detail.grnum }" >
						<input type="text" id="keyword" name="keyword" value="${pageSearch.keyword }" placeholder="이름을 입력해주세요">
						<button id="searchkeyword" type="submit"><i class="xi-search"></i></button>
					</form>
				</div>
				<form class="set_form">
					<table class="gp us_table one">
						<caption class="snd_only">그룹원 목록</caption>
						<thead>
							<tr>
								<c:if test="${detail.grtotal ne 1 }" >
									<th class="tb_chk">
										<input type="checkbox" class="comm_chk" name="allChecked" id="allChecked">
										<label for="allChecked"><em class="snd_only">전체선택</em></label>
									</th>
								</c:if>
								<th class="w60">No</th>
								<th>이름 (ID)</th>
								<th class="w120">생년월일</th>
								<th class="w60">성별</th>
								<th class="w100">관심지역</th>
								<th class="w120">가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${pageSearch.totalCount ne 0 }">
									<c:set var="i" value="10"/>
									<c:forEach items="${userdetail }" var="userdetail">
									<c:if test="${login.pronum ne userdetail.pronum }" >
										<tr>
											<td class="tb_chk">
												<input type="hidden" name="" id="postjgnum" value="${userdetail.joinGroup.jgnum }">
												<c:if test="${login.pronum ne userdetail.pronum }">
													<input type="checkbox" class="comm_chk" name="" id="festaTbl${i}">
												</c:if>
												<label for="festaTbl${i}"><em class="snd_only">선택</em></label>
											</td>
											<td>
												${userdetail.prorn }
											</td>
											<td>
												<p>
													<a href="${root }user/?pronum=${userdetail.pronum}" target="_blank">
														${userdetail.proname } (${userdetail.proid})
													</a>
												</p>
											</td>
											<td>${userdetail.proidnum }</td>
											<td>${userdetail.projender }</td>
											<td>${userdetail.proaddr }</td>
											<td>${userdetail.prodate }</td>
										</tr>
									<c:set var="i" value="${i-1 }"/>
									</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<c:if test="${detail.grtotal eq 1 }">
											<td colspan="7" class="fstEmpty">가입한 그룹원이 없습니다.</td>
										</c:if>
										<td colspan="7" class="fstEmpty">검색한 그룹원이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<ul class="table_options comm_buttons_s">
						<li><button type="button" id="userkick" class="comm_btn btn_pop cnc" >추방</button></li>
						<li><button type="button" id="userallkick" class="comm_btn btn_pop" data-layer="allkick" >전체 추방</button></li>
					</ul>
				</form>
				<div class="fstPage">
					<ul>
						<c:if test="${pageSearch.totalCount ne 0 }">
							<c:choose>
								<c:when test="${pageSearch.page eq 1 }">
									<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>
									<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>
								</c:when>
								<c:otherwise>
									<c:if test="${pageSearch.beginPage eq 1 }">
										<li><a class="pg_start" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.beginPage}&keyword=${pageSearch.keyword}"><em class="snd_only">맨 앞으로</em></a></li>
									</c:if>
									<c:if test="${pageSearch.beginPage ne 1 }">
										<li><a class="pg_start" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.beginPage-1}&keyword=${pageSearch.keyword}"><em class="snd_only">맨 앞으로</em></a></li>
									</c:if>
									<li><a class="pg_prev" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.page-1}&keyword=${pageSearch.keyword}"><em class="snd_only">이전 페이지</em></a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="${pageSearch.beginPage }" varStatus="status"  end="${pageSearch.endPage }">
								<c:choose>
									<c:when test="${pageSearch.page == status.index}">
										<li><b>${status.index }</b></li>
									</c:when>
									<c:otherwise>
										<li><a href="${root }group/user?grnum=${detail.grnum }&page=${status.index}&keyword=${pageSearch.keyword}">${status.index }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${pageSearch.next eq true }">
									<li><a class="pg_next" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.page+1}&keyword=${pageSearch.keyword}"><em class="snd_only">다음 페이지</em></a></li>
									<c:if test="${pageSearch.totalPage eq pageSearch.endPage }">
										<li><a class="pg_end" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.endPage}&keyword=${pageSearch.keyword}"><em class="snd_only">맨 끝으로</em></a></li>
									</c:if>
									<c:if test="${pageSearch.totalPage ne pageSearch.endPage }">
										<li><a class="pg_end" href="${root }group/user?grnum=${detail.grnum }&page=${pageSearch.endPage+1}&keyword=${pageSearch.keyword}"><em class="snd_only">맨 끝으로</em></a></li>
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

	<div id="kick" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">선택한 회원(들)을 추방하시겠습니까?</h3>
			<input type="hidden" id="grnum" value="">
			<input type="hidden" id="jgnum" value="">
			<input type="hidden" id="jointot" value="">
			<input type="hidden" id="grtotal" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="bye" class="btn_close comm_btn cfm">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	
	<div id="allkick" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">전체 회원을 추방하시겠습니까?</h3>
			<div class="info_box">
				<ul>
					<li>회원 추방 후에는 취소가 불가능합니다.</li>
					<li>확인 버튼을 누르시면 나를 제외한 모든 회원이 추방됩니다.</li>
				</ul>
			</div>
			<p>[다음 문구를 똑같이 입력해주세요.]</p>
			<p class="out_words">웃어라, 함께 웃을 것이다. 울어라, 혼자 울 것이다.</p>
			<form class="comm_form">
				<div class="ip_box">
					<input type="text" id="keymsg" name="" required="required">
					<input type="hidden" id="grnum" value="">
					<input type="hidden" id="pronum" value="">
					<input type="hidden" id="jointot" value="">
					<input type="hidden" id="grtotal" value="">
					<p class="f_message"></p>
				</div>
				<div class="btn_box">
					<ul class="comm_buttons">
						<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
						<li><button type="button" id="outgroup" class="btn_close comm_btn sbm" disabled="disabled">확인</button></li>
					</ul>
				</div>
			</form>
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