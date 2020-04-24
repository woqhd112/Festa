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
			
			var textBox = $('#delete .pop_tit');
			var text;
			
			//피드삭제버튼 눌렀을때
			$(document).on('click', '.btn_feed.dt', function() {
				var value = $(this).data('value');
				 $('#num').val(value);
				 console.log($('#num').val());
				 text = '선택하신 피드를 삭제하시겠습니까?';
				 textBox.text(text);
				 console.log(text);
			});
			
			//댓글삭제버튼 눌렀을때
			$(document).on('click', '.btn_cmmt.dt', function() {
				var value = $(this).data('value');
				 $('#num').val(value);
				 console.log($('#num').val());
				 text = '선택하신 댓글 삭제하시겠습니까?';
				 textBox.text(text);
				 console.log(text);
			});
			
			//삭제하기버튼 클릭시
			$(document).on('click', '#delete_btn', function() {
				//그 버튼이 댓글일때
				if(text == '선택하신 댓글 삭제하시겠습니까?'){
					console.log(text);
					var gcnum = $('#num').val();
					$.post('${root}admin/group/detail/cmmtdel','gcnum='+gcnum,function(){
						$('#delete').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				//그 버튼이 게시글일때
				}else if(text == '선택하신 피드를 삭제하시겠습니까?'){
					console.log(text);
					var gpnum = $('#num').val();
					$.post('${root}admin/group/detail/del','gpnum='+gpnum,function(){
						$('#delete').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				}
			});
			
			//댓글 더보기버튼
			$(document).on('click', '.cmt_btn_more.dt', function() {
				var btn = $(this);
				var pageTag = $(this).find('span');
				var myPage = pageTag.text();
				myPage++;
				pageTag.text(myPage);
				var feed = btn.parents('.feed_viewer');
				var comments = btn.siblings('.comment_list');
				var gpnum = feed.find('input[type=hidden]').val();
				$.get('${root}admin/group/detail/cmmt','grnum=${groupinfo.grnum}&gpnum='+gpnum+'&pageSearch.page4='+myPage,function(data){
					$(data).each(function(index){
						var prophoto=data[index].profile.prophoto;
						var prophototag;
						if(prophoto==null||prophoto==''||prophoto==undefined||prophoto.inEmpty){
							prophototag='<img src="${root}resources/images/thumb/no_profile.png" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
						}else{
							prophototag='<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
						}
						if(index==3){
							 return false;
						}else if(data.length<4){
							btn.hide();
						}
						comments.append('<li>'+
								'<a href="${root }admin/user/detail?pronum='+data[index].pronum+'" class="pf_picture">'+
								prophototag+
								'</a><p class="cmt_content">'+
									'<a href="${root }admin/user/detail?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].gcauthor+'</a>&nbsp;'+
									data[index].gccontent+
									'<span class="cmt_date">'+data[index].gcdate1+'</span>'+
									'<button class="btn_pop btn_delete btn_cmmt dt" data-layer="delete" data-value="'+data[index].gcnum+'"><em class="snd_only">삭제하기</em></button></p>'+
							'</li>');
					});//each문 end  
				});//ajax통신 end
			});//댓글더보기 end
			
			//스크롤 내렸을때 피드 2개씩 출력
			$(window).scroll(function(){
			    var scrolltop = parseInt ( $(window).scrollTop() );
			    if( scrolltop >= $(document).height() - $(window).height() - 1 ){
					var scrollTag=$('#footer').siblings('span');
					var scroll=scrollTag.text();
					scroll++;
					scrollTag.text(scroll);
					console.log(scroll);
					$.get('${root}admin/group/detail/scroll','grnum=${groupinfo.grnum}&pageSearch.page5='+scroll,function(){
						
					}).done(function(data){
						feedList(data,'admin/group');
					});
			    }
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
<div id="wrap" class="adm">
	<section class="banner_area">
		<div class="container">
			<dl>
				<dt><span>관리자페이지 이용 시 주의사항</span></dt>
				<dd>회원 징계 시 다시 한번 확인하고 처리할 것 / 모든 삭제 기능 처리 시 신중하게 처리할 것</dd>
			</dl>
		</div>
	</section>
	<!-- #그룹 홈 (가입한 회원) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="home_wrap">
		<h2 class="snd_only">${groupinfo.grname } 그룹 홈</h2>
		<!-- 프로필영역 시작 { -->
		<section class="profile_area">
			<div class="container w720">
				<div class="info_box">
					<dl>
						<dt class="pf_tit">
							<a class="pf_name" href="">
								<b>${groupinfo.grname }</b>
							</a>
							<c:if test="${groupinfo.grventure eq 2 }">
								<!-- 캠핑장 공식그룹일 경우 { -->
								<span class="gp_official"></span>
								<!-- } 캠핑장 공식그룹일 경우 -->
							</c:if>
						</dt>
						<dd class="pf_intro">${groupinfo.grintro }</dd>
						<dd class="pf_hashtag">
							<c:choose>
								<c:when
									test="${empty groupinfo.httitle1 && empty groupinfo.httitle2 && empty groupinfo.httitle3}">
								</c:when>
								<c:when
									test="${empty groupinfo.httitle1 && empty groupinfo.httitle2}">
									<a href="">${groupinfo.httitle3}</a>
								</c:when>
								<c:when
									test="${empty groupinfo.httitle2 && empty groupinfo.httitle3}">
									<a href="">${groupinfo.httitle1}</a>
								</c:when>
								<c:when
									test="${empty groupinfo.httitle1 && empty groupinfo.httitle3}">
									<a href="">${groupinfo.httitle2}</a>
								</c:when>
								<c:when test="${empty groupinfo.httitle1}">
									<a href="">${groupinfo.httitle2}</a>
									<a href="">${groupinfo.httitle3}</a>
								</c:when>
								<c:when test="${empty groupinfo.httitle2}">
									<a href="">${groupinfo.httitle1}</a>
									<a href="">${groupinfo.httitle3}</a>
								</c:when>
								<c:when test="${empty groupinfo.httitle3}">
									<a href="">${groupinfo.httitle1}</a>
									<a href="">${groupinfo.httitle2}</a>
								</c:when>
								<c:otherwise>
									<a href="">${groupinfo.httitle1}</a>
									<a href="">${groupinfo.httitle2}</a>
									<a href="">${groupinfo.httitle3}</a>
								</c:otherwise>
							</c:choose>
						</dd>
						<dd class="gp_list">
							<span>그룹장 : ${groupinfo.profile.proname }</span>
							<a class="btn_pop btn_member" href="${root }admin/group/detail/member?grnum=${groupinfo.grnum}">멤버 : ${groupinfo.grtotal }명</a>
							<span>개설일 : ${groupinfo.grdate }</span>
						</dd>
						<dd class="pf_picture">
							<c:if test="${!empty groupinfo.grphoto }">
								<img src="${upload }/${groupinfo.grphoto}" alt="${groupinfo.grname } 그룹 썸네일">
							</c:if>
							<c:if test="${empty groupinfo.grphoto }">
								<img src="${root }resources/images/thumb/no_profile.png" alt="${groupinfo.grname } 그룹 썸네일">
							</c:if>
						</dd>
					</dl>
				</div>
			</div>
		</section>
		<!-- } 프로필영역 끝 -->
		<div class="container w720">
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<!-- #공지사항 시작 {  -->
				<div class="feed_notice">
					<h3>공지사항</h3>
					<ul>
					<c:choose>
						<c:when test="${!empty groupnotice }">
							<c:forEach items="${groupnotice }" begin="0" end="4" var="groupnotice">
								<li><a class="btn_feed" href="${root }admin/group/detail/ntc_feed?gnnum=${groupnotice.gnnum}">${groupnotice.gncontent }</a></li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li class="fstEmpty">등록된 공지사항이 없습니다.</li>
						</c:otherwise>
					</c:choose>
					</ul>
				</div>
				<!-- } #공지사항 끝 -->
				<!-- #텍스트+썸네일 피드 시작 { -->
				<c:forEach items="${groupfeed }" var="groupfeed">
					<!-- #텍스트 피드 시작 { -->
					<div class="feed_viewer">
						<div class="tit box">
							<dl class="feed_inform">
								<dt>
									<a href="${root }admin/user/detail?pronum=${groupfeed.pronum}">
										<input type="hidden" value="${groupfeed.gpnum }">
										<c:if test="${!empty groupfeed.profile.prophoto }">
											<span class="pf_picture"><img src="${upload }/${groupfeed.profile.prophoto}" alt="${groupfeed.profile.proname }님의 프로필 썸네일"></span>
										</c:if>
										<c:if test="${empty groupfeed.profile.prophoto }">
											<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${groupfeed.profile.proname }님의 프로필 썸네일"></span>
										</c:if>
										<span class="fd_name">${groupfeed.gpauthor }</span>
									</a>
									<a href="${root }admin/group/detail?grnum=${groupinfo.grnum}">
										<span class="fd_group">${groupinfo.grname }</span>
									</a>
								</dt>
								<dd>
									<span class="fd_date">${groupfeed.gpdate1 }</span>
									<b class="fd_liked">${groupfeed.gpgood }</b>
								</dd>
							</dl>
							<ul class="feed_options">
								<li><button class="btn_pop btn_delete btn_feed dt" data-layer="delete" data-value="${groupfeed.gpnum }"><em class="snd_only">삭제하기</em></button></li>
							</ul>
						</div>
						<div class="text box">
							<div class="scrBar">
								<div class="feed_content">
									<ul class="fd_hashtag">
										<c:choose>
											<c:when
												test="${empty groupfeed.httitle1 && empty groupfeed.httitle2 && empty groupfeed.httitle3}">
											</c:when>
											<c:when
												test="${empty groupfeed.httitle1 && empty groupfeed.httitle2}">
												<li><a href="">${groupfeed.httitle3}</a></li>
											</c:when>
											<c:when
												test="${empty groupfeed.httitle2 && empty groupfeed.httitle3}">
												<li><a href="">${groupfeed.httitle1}</a></li>
											</c:when>
											<c:when
												test="${empty groupfeed.httitle1 && empty groupfeed.httitle3}">
												<li><a href="">${groupfeed.httitle2}</a></li>
											</c:when>
											<c:when test="${empty groupfeed.httitle1}">
												<li><a href="">${groupfeed.httitle2}</a></li>
												<li><a href="">${groupfeed.httitle3}</a></li>
											</c:when>
											<c:when test="${empty groupfeed.httitle2}">
												<li><a href="">${groupfeed.httitle1}</a></li>
												<li><a href="">${groupfeed.httitle3}</a></li>
											</c:when>
											<c:when test="${empty groupfeed.httitle3}">
												<li><a href="">${groupfeed.httitle1}</a></li>
												<li><a href="">${groupfeed.httitle2}</a></li>
											</c:when>
											<c:otherwise>
												<li><a href="">${groupfeed.httitle1}</a></li>
												<li><a href="">${groupfeed.httitle2}</a></li>
												<li><a href="">${groupfeed.httitle3}</a></li>
											</c:otherwise>
										</c:choose>
									</ul>
									<pre class="fd_content"><c:out value="${groupfeed.gpcontent }"/></pre>
								</div>
								<ul class="comment_list">
								<c:set var="i" value="0"/>
								<c:set var="doneLoop" value="false"/>
								<c:forEach items="${groupcmmt }" var="groupcmmt">
									<c:if test="${groupfeed.gpnum eq groupcmmt.gpnum }">
										<c:if test="${not doneLoop }">
										<li>
											<!-- # 프로필 이미지 없음 { -->
											<a href="${root }admin/user/detail?pronum=${groupcmmt.pronum}" class="pf_picture">
											<c:if test="${!empty groupcmmt.profile.prophoto }">
												<img src="${upload }/${groupcmmt.profile.prophoto}" alt="${groupcmmt.profile.proname }님의 프로필 썸네일">
											</c:if>
											<c:if test="${empty groupcmmt.profile.prophoto }">
												<img src="${root }resources/images/thumb/no_profile.png" alt="${groupcmmt.profile.proname }님의 프로필 썸네일">
											</c:if>
											</a>
											<!-- } # 프로필 이미지 없음 -->
											<p class="cmt_content">
												<a href="${root }admin/user/detail?pronum=${groupcmmt.pronum}" class="cmt_name">${groupcmmt.gcauthor }</a>
												${groupcmmt.gccontent }
												<span class="cmt_date">${groupcmmt.gcdate1 }</span>
												<button class="btn_pop btn_delete btn_cmmt dt" data-layer="delete" data-value="${groupcmmt.gcnum }"><em class="snd_only">삭제하기</em></button>
											</p>
										</li>
											<c:set var="i" value="${i+1 }"/>
											<c:if test="${i eq 3 }">
												<c:set var="doneLoop" value="true"/>
											</c:if>
										</c:if>
									</c:if>
								</c:forEach>
								</ul>
								<c:if test="${groupfeed.gptotal gt 3 }">
									<button class="cmt_btn_more dt"><span class="snd_only">1</span>댓글 더 보기</button>
								</c:if>
							</div>
						</div>
					<c:if test="${groupfeed.gpphoto ne '' }">
						<!-- # 썸네일 영역 { -->
						<div class="img box">
							<div class="thumb_slide">
								<div class="swiper-wrapper">
									<c:set var="feedphoto" value="${groupfeed.gpphoto }" />
									<c:forTokens items="${feedphoto }" delims="," var="item">
										<div class="swiper-slide">
											<img src="${upload }/${item }" alt="">
										</div>
									</c:forTokens>
								</div>
								<div class="swiper-pagination"></div>
							</div>
						</div>
					</c:if>
					</div>
				</c:forEach>
				<!-- } #텍스트 피드 끝 -->
			</section>
			<!-- } 컨텐츠영역 끝 -->
		</div>
	</div>
	<!-- } 서브페이지 -->
	<span class="snd_only">1</span>
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
<!-- #피드 삭제하기 { -->
<div id="delete" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 피드를 삭제하시겠습니까?</h4>
		<input type="hidden" id="num" value="">
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="delete_btn" class="comm_btn cfm">삭제하기</button></li>
			</ul>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- } #팝업 삭제하기 -->

<!-- #팝업 처리완료 { -->
<div id="success" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close ok comm_btn cfm">확인</button></li>
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
	feedType('feed_viewer');
	openFeed();
</script>
</body>
</html>