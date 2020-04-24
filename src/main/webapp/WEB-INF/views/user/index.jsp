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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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

	$(document).ready(function() {
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

		
		//팔로우중인지 확인
		var pronum = "${login.pronum}";
		var pronum_sync="${profile.pronum}";
		console.log('pronum='+pronum);
		$.get('${root}user/isfollw',"pronum="+pronum+"&pronum_sync="+pronum_sync,function(data){
			console.log(data);
			if(data==0){
				$('#follow').removeClass("act");
				$('#follow').text('팔로우');
			}
		});
		
 		$('#follow').on('click',function(){
			var unFollow = $(this).hasClass('act');
			//등록
			if(unFollow){
				$.post('${root}user/indexFollow','pronum='+ ${login.pronum}+'&mfgname='+"${login.proname}"+'&pronum_sync='+${profile.pronum}+'&myFollower.mfrname='+"${profile.proname}",function(data){
					location.href = "${root}user/?pronum="+data.pronum_sync;
				});
			}
			//해제
			else{ 
				$.post('${root}user/indexUnfollow','pronum='+${login.pronum}+'&mfgname='+"${login.proname}"+'&pronum_sync='+${profile.pronum},function(data){
					location.href = "${root}user/?pronum="+data.pronum_sync;
				});
			}
		});
		
		$('.feed_viewer').each(function(index) {
			if (index > 1) {
				$('.feed_viewer').eq(index).hide();
			}
		});

		$(window).scroll(function() {
			var scrolltop = parseInt($(window).scrollTop());
			if (scrolltop >= $(document).height()- $(window).height() - 1) {
				var scrollTag = $('#footer').siblings('span');
				var scroll = scrollTag.text();
				scroll++;
				scrollTag.text(scroll);
				console.log(scroll);
				var curfeedcnt = $('.feed_viewer').length;
				$('.feed_viewer').eq(scroll * 2).show();
				$('.feed_viewer').eq(scroll * 2 + 1).show();
				}
		});
			//댓글 입력하기
			$(document).on('submit','.message_form',function(e) {
				e.preventDefault();
				btn = $(this);
				var feed = btn.parents('.feed_viewer.ind');
				var mccontent = feed.find('#mccontent').val();
				
				var mcauthor = "${login.proname}";
				var mpnum = feed.find('#mpnum').val();
				var pronum = '${login.pronum}';
				var pronum_sync = feed.find('#pronum_sync').val();
				var tmp = mccontent.length;
				if(tmp>=500){
					openPop('cmmtfull');
					$('#cmmtfailed').on('click',function(){
						$('#mccontent').focus();
					});
					return false;
				}
				$.post('${root}user/cmmtadd','mccontent=' + mccontent+ '&mcauthor='+ mcauthor+ '&mpnum=' + mpnum+ '&pronum='+ pronum +'&pronum_sync='+pronum_sync, function(data) {
					window.location.reload();
				});
			});
			
			//댓글더보기
			$(document).on('click','.cmt_btn_more.dt',function() {
				var btn = $(this);
				var pageTag = $(this).find('span');
				var myPage = pageTag.text();
				myPage++;
				pageTag.text(myPage);
				var feed = btn.parents('.feed_viewer.ind');
				var comments = btn.siblings('.comment_list.ind');
				var del = $('#pronum').val();
				var mccontent = feed.find('#mccontent').val();
				var mcauthor = feed.find('#mcauthor').val();
				var mpnum = feed.find('#mpnum').val();
				var pronum = feed.find('#pronum').val();
				var fpronum = feed.find('#feedPronum').val();
				$.get('${root}user/cmmt','mpnum='+ mpnum+ '&pageSearch.page4='+ myPage,function(data) {
					console.log(mpnum);
				$(data).each(function(index) {
				if (index == 3) {
					return false;
				} else if (data.length < 4) {
					btn.hide();
				}
				if (del == data[index].pronum|| del == fpronum|| pronum == mpronum) {
					console.log("데이터 : "+data[index].pronum);
					var check = "${!empty profile.prophoto}";
					var tag = '<li>'
						+ '<a href="${root}user/?pronum='+data[index].pronum+'" class="pf_picture">';
						
					if (check == "true") {
						tag += '<img src="${upload }/${profile.prophoto}" alt="'+data[index].mcauthor+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					} else {
						tag += '<img src="${root }resources/upload/thumb/no_profile.png" alt="'+data[index].gcauthor+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}
					
						tag += '</a><p class="cmt_content">'
							+ '<a href="${root}user/?pronum='+data[index].pronum+'" class="cmt_name">'
							+ data[index].mcauthor
							+ '</a>&nbsp;&nbsp;'
							+ data[index].mccontent
							+ '<span class="cmt_date">'
							+ data[index].mcdate1
							+ '</span>';
					var pronum_check ="${profile.pronum eq login.pronum}";
					if(pronum_check == "true"){
						tag += '<button class="btn_pop btn_delete btn_cmmt" id="mycmmtdelete" data-layer="deletecmmt" data-value="'+data[index].mcnum+'"><em class="snd_only">삭제하기</em></button></p>'
					}
						tag	+= '</li>';
					
					comments.append(tag);

					$('.snd_only').last().focus();
				} else {
					comments.append('<li>'
						+ '<a href="" class="pf_picture">'
						+ '<img src="${root }resources/upload/thumb/no_profile.png" alt="'+data[index].mcauthor+'님의 프로필 썸네일">'
						+ '</a><p class="cmt_content">'
						+ '<a href="" class="cmt_name">'
						+ data[index].mcauthor
						+ '</a>&nbsp;&nbsp;'
						+ data[index].mccontent
						+ '<span class="cmt_date">'
						+ data[index].mcdate1
						+ '</span></li>');
					$('<li>').last().focus();
				}
			});//each문 end
		});//ajax통신 end		
	});//댓글더보기 end
						
	//댓글 삭제 클릭
	 $(document).on('click','#mycmmtdelete', function() {
		var cmmtdel = $(this).data('value');
		console.log(cmmtdel);
		$('#num').val(cmmtdel);
	}); 
		
	//댓글삭제 클릭>확인
	$('#deletecmmt').on('click',function() {
		var mcnum = $('#num').val();
		$.post('${root}user/cmmtdel', 'mcnum='+ mcnum, function(data) {
			$('.btn_close.comm_btn.cfm').on('click', function() {
				location.reload();
			});
		});
	});

	//피드 삭제
	$(document).on('click','#delmyfeed', function() {
		var feeddel = $(this).data('value');
		$('#fnum').val(feeddel);
	});
	
	//피드삭제>확인
	$('#deletefeedForm').on('submit',function(e) {
		e.preventDefault();
		var mpnum = $('#fnum').val();
		$.post('${root}user/del','mpnum='+mpnum,function(data) {
			openPop('ok');
			$('.btn_close.comm_btn.cfm').on('click',function() {
				location.reload();
			});
		});
	});
	
	//좋아요 버튼 클릭시
	$(document).on('click','.btn_liked',function(){
		var pronum = $(this).parents('.feed_viewer').find('.feed_inform').find('#feedPronum').val();
		var num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
		var checking = $(this).hasClass('act');
		//좋아요 등록
		if(checking){
			console.log('mpnum = '+num);
			$.post('${root}user/likeadd','pronum='+pronum+'&mpnum='+num,function(html){
				window.location.reload();
			});
		}
		//좋아요 해제
		else{
			console.log('mpnum = '+num);
			$.post('${root}user/likedel','pronum='+pronum+'&mpnum='+num,function(html){
				window.location.reload();
			});
		}
	})
	
	//좋아요버튼 갯수조절
	var goodSize =$('.content_area>.feed_viewer .feed_options').length;
	if($('#wrap>input[type=hidden]').eq(0).val()!=''){
	    for(var i = 0; i< goodSize; i++){
	    	if($('.content_area>.feed_viewer .feed_options').eq(i).find('.btn_liked').hasClass('act')==false){
				$('.content_area>.feed_viewer .feed_options').eq(i).prepend('<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>');
	        }
	    }
	}
	
	//피드 등록 유효성
	
	$(document).on('click','#contentsend',function(){
		console.log('접속');
		if($('#mpcontent').val().length>=500){
			openPop("cnfull");
			$('#cnfailed').on('click',function(){
				$('#mpcontent').focus();
			});
			return false;
		};
		if($('#httitle1').val().length>=20){
			openPop("htfull");
			$('#htfailed').on('click',function(){
				$('#httitle1').focus();
			});
			return false;
		};
		if($('#httitle2').val().length>=20){
			openPop("htfull");
			$('#htfailed').on('click',function(){
				$('#httitle2').focus();
			});
			return false;
		};
		if($('#httitle3').val().length>=20){
			openPop("htfull");
			$('#htfailed').on('click',function(){
				$('#httitle3').focus();
			});
			return false;
		};
	})
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
		<!-- #유저 홈 -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="home_wrap">
			<h2 class="snd_only">${login.proname }님의계정홈</h2>
			<!-- 프로필영역 시작 { -->
			<section class="profile_area">
				<div class="container">
					<div class="info_box">
						<dl>
							<dt class="pf_tit">
								<a class="pf_name" href="${root}user/?pronum=${login.pronum}"><b>${profile.proname }</b></a>
								<!-- 마이페이지일 경우 톱니바퀴 버튼 -->
								<!-- 유저페이지일 경우 신고하기  -->
								<c:if test="${login.pronum eq profile.pronum }">
									<a class="pf_opt go_settings" href="${root }user/profile"><em
										class="snd_only">설정</em></a>
								</c:if>
								<c:if test="${login.pronum ne profile.pronum }">
									<a href="${root }user/us_report"
										class="pf_opt btn_pop btn_report"><em class="snd_only">신고하기</em></a>
									<button type="button" id="follow" class="btn_follow act">팔로잉</button>
								</c:if>
								<!-- } 유저페이지일 경우 신고하기 -->
							</dt>
							<dd class="pf_intro">${profile.prointro }</dd>
							<dd class="pf_hashtag">
								<a href="">${profile.proaddr }</a>
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
				<!-- 컨텐츠영역 시작 { -->
				<section class="content_area">
					<!-- #피드 만들기 -->
					<c:if test="${login.pronum eq profile.pronum}">
						<div class="feed_maker">
							<h3>피드 만들기</h3>
							<form action="${root }user/add" method="post" class="maker_form" enctype="multipart/form-data">
								<input type="hidden" name="mpauthor" value="${login.proname }" />
								<input type="hidden" id="mypronum" name="pronum" value="${login.pronum }" />
								<div class="mk_cont box">
									<p class="pf_picture">
										<c:if test="${!empty profile.prophoto }">
									<img src="${upload }/${profile.prophoto}"
										alt="${profile.proname }님의 프로필 썸네일">
								</c:if>
								<c:if test="${empty profile.prophoto}">
									<img src="${root }resources/upload/thumb/no_profile.png" alt="${profile.proname }님의 프로필 썸네일" >
								</c:if>
									</p>
									<textarea id="mpcontent" name="mpcontent"
										placeholder="${profile.proname } 님, 무슨 생각을 하고 계신가요?" required="required"></textarea>
								</div>
								<div class="file_thumbnail mk_thumb box">
									<ul>
										<li class="ft_btn">
											<input type="file" id="file1" name="files" accept="video/*, image/*"> 
											<img src=""	alt="">
											<button class="btn_cancle" type="button">
												<em class="snd_only">업로드 취소하기</em>
											</button> <label for="file1" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
										<li class="ft_btn"><input type="file" id="file2"
											name="files" accept="video/*, image/*"> <img src=""
											alt="">
											<button class="btn_cancle" type="button">
												<em class="snd_only">업로드 취소하기</em>
											</button> <label for="file2" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
										<li class="ft_btn"><input type="file" id="file3"
											name="files" accept="video/*, image/*"> <img src=""
											alt="">
											<button class="btn_cancle" type="button">
												<em class="snd_only">업로드 취소하기</em>
											</button> <label for="file3" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
										<li class="ft_btn"><input type="file" id="file4"
											name="files" accept="video/*, image/*"> <img src=""
											alt="">
											<button class="btn_cancle" type="button">
												<em class="snd_only">업로드 취소하기</em>
											</button> <label for="file4" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
										<li class="ft_btn"><input type="file" id="file5"
											name="files" accept="video/*, image/*"> <img src=""
											alt="">
											<button class="btn_cancle" type="button">
												<em class="snd_only">업로드 취소하기</em>
											</button> <label for="file5" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
									</ul>
								</div>
								<div class="mk_bottom box">
									<ul class="mk_tags">
										<li><input type="text" id="httitle1" name="httitle1"></li>
										<li><input type="text" id="httitle2" name="httitle2"></li>
										<li><input type="text" id="httitle3" name="httitle3"></li>
									</ul>
									<ul class="mk_btns">
										<li><label for="file1" class="btn_file"><em
												class="snd_only">사진/동영상 업로드하기</em></label></li>
										<li>
											<button type="submit" class="btn_send" id="contentsend">
												<em class="snd_only">피드 게시하기</em>
											</button>
										</li>
									</ul>
								</div>
							</form>
						</div>
					</c:if>
					<!-- } #피드만들기 끝 -->
					<!-- #텍스트+썸네일 피드 시작 { -->
					<c:forEach items="${myFeedSelectAll }" var="myFeedSelectAll">
						<div class="feed_viewer ind">
							<div class="tit box">
								<dl class="feed_inform">
									<dt>
										<a href=""> 
											<input type="hidden" id="mcauthor"	name="mcauthor" value="${profile.proname }" /> 
											<input type="hidden" id="mpnum" name="mpnum" value="${myFeedSelectAll.mpnum }" /> 
											<input type="hidden" id="pronum" name="pronum" value="${profile.pronum }" /> 
											<input type="hidden" id="pronum_sync" name="pronum_sync" value="${myFeedSelectAll.pronum}" /> 
											<input type="hidden" id="feedPronum" value="${myFeedSelectAll.pronum }" /> 
											<span class="pf_picture"> 
											<c:if test="${!empty profile.prophoto }">
									<img src="${upload }/${profile.prophoto}"
										alt="${profile.proname }님의 프로필 썸네일">
								</c:if>
								<c:if test="${empty profile.prophoto}">
									<img src="${root }resources/upload/thumb/no_profile.png" alt="${profile.proname }님의 프로필 썸네일" >
								</c:if>
											</span> 
											<span class="fd_name">${profile.proname }</span>
										</a>
									</dt>
									<dd>
										<span class="fd_date">${myFeedSelectAll.mpdate }</span> <b
											class="fd_liked">${myFeedSelectAll.mpgood }</b>
									</dd>
								</dl>
								<ul class="feed_options">
									<c:forEach items="${goodlist }" var="goodlist">
										<c:if test="${goodlist.mpnum eq myFeedSelectAll.mpnum }">

											<li><a href="" class="btn_liked act"><em class="snd_only">하트</em></a></li>
										</c:if>
									</c:forEach>
									<c:if test="${login.pronum ne myFeedSelectAll.pronum }">
									
										<li><a href="${root }user/report?mpnum=${myFeedSelectAll.mpnum}"
											class="btn_pop btn_report"><em class="snd_only">신고하기</em></a></li>
									</c:if>
									<c:if test="${login.pronum eq myFeedSelectAll.pronum }">
										<li>
											<input type="hidden" name="makerMpnum" id="makerMpnum" value="${myFeedSelectAll.mpnum }"/>
											<a href="${root }user/maker?mpnum=${myFeedSelectAll.mpnum}" class="btn_pop btn_edit" id="feedmaker">
											<em class="snd_only">수정하기</em>
											</a>
										</li>
										<li>
											<button class="btn_delete feed btn_pop" id="delmyfeed" name="delmyfeed" data-layer="deletefeed" data-value="${myFeedSelectAll.mpnum }">
												<em class="snd_only">삭제하기</em>
											</button>
										</li>
									</c:if>
								</ul>
							</div>
							<div class="text box">
								<div class="scrBar">
									<div class="feed_content">
										<ul class="fd_hashtag">
											<c:choose>
												<c:when
													test="${empty myFeedSelectAll.httitle1 && empty myFeedSelectAll.httitle2 && empty myFeedSelectAll.httitle3 }">
												</c:when>
												<c:when
													test="${empty myFeedSelectAll.httitle2 && empty myFeedSelectAll.httitle3 }">
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle1}">${myFeedSelectAll.httitle1 }</a></li>
												</c:when>
												<c:when test="${empty myFeedSelectAll.httitle3 }">
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle1}">${myFeedSelectAll.httitle1 }</a></li>
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle2}">${myFeedSelectAll.httitle2 }</a></li>
												</c:when>
												<c:otherwise>
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle1}">${myFeedSelectAll.httitle1 }</a></li>
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle2}">${myFeedSelectAll.httitle2 }</a></li>
													<li><a href="${root }search/?keyword=${myFeedSelectAll.httitle3}">${myFeedSelectAll.httitle3 }</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<pre id="feed_mpcontent" class="fd_content"><c:out value="${myFeedSelectAll.mpcontent }"/></pre>
									</div>
									<input type="hidden" id="cmmtMpnum" value="${myFeedSelectAll.mpnum }"/>
									<ul class="comment_list ind">
										<c:set var="i" value="0" />
										<c:set var="doneLoop" value="false" />
										<c:forEach items="${myFeedCmmtSelectAll }" var="myFeedCmmtSelectAll">
											<c:if test="${myFeedSelectAll.mpnum eq myFeedCmmtSelectAll.mpnum }">
												<c:if test="${not doneLoop }">
													<li class="">
														<!-- # 프로필 이미지 없음 { -->
														<a
														href="${root }user/?pronum=${myFeedCmmtSelectAll.pronum}"
														class="pf_picture"><c:if
																test="${!empty myFeedCmmtSelectAll.profile.prophoto }">
																<img src="${upload }/${myFeedCmmtSelectAll.profile.prophoto}"
																	alt="${myFeedCmmtSelectAll.profile.proname }님의 프로필 썸네일">
															</c:if> <c:if test="${empty myFeedCmmtSelectAll.profile.prophoto}">
																<img src="${root }resources/upload/thumb/no_profile.png"
																	alt="${myFeedCmmtSelectAll.profile.proname }님의 프로필 썸네일">
															</c:if> </a> <!-- } # 프로필 이미지 없음 -->
														<p class="cmt_content">
														<input type="hidden" id="delCmmtNum" value="${myFeedCmmtSelectAll.mcnum}" />
														<a href="${root }user/?pronum=${myFeedCmmtSelectAll.pronum}" class="cmt_name">${myFeedCmmtSelectAll.mcauthor }</a>&nbsp;&nbsp;${myFeedCmmtSelectAll.mccontent }
														<span class="cmt_date">${myFeedCmmtSelectAll.mcdate1 }</span>
															<c:if test="${profile.pronum eq login.pronum}">
																<button class="btn_delete btn_pop" id="mycmmtdelete" data-layer="deletecmmt" data-value="${myFeedCmmtSelectAll.mcnum }">
																	<em class="snd_only">삭제하기</em>
																</button>
															</c:if>
														</p>
													</li>													
													<c:set var="i" value="${i+1 }" />
													<c:if test="${i eq 3 }">
														<c:set var="doneLoop" value="true" />
													</c:if>
												</c:if>
											</c:if>
										</c:forEach>
									</ul>
									<c:if test="${myFeedSelectAll.mptotal gt 3}">
										<button class="cmt_btn_more dt">
											<span class="snd_only">1</span>댓글 더 보기
										</button>
									</c:if>
								</div>
								<form class="message_form">
									<a class="pf_picture" href="${root }user/?pronum=${login.pronum}"> 
									<c:if test="${!empty login.prophoto }">
									<img src="${upload }/${login.prophoto}"
										alt="${login.proname }님의 프로필 썸네일">
								</c:if>
								<c:if test="${empty login.prophoto}">
									<img src="${root }resources/upload/thumb/no_profile.png" alt="${login.proname }님의 프로필 썸네일" >
								</c:if>
									</a>
									<p class="msg_input">
										<input type="text" class="msg_txt" id="mccontent" name="mccontent" placeholder="메세지를 입력해주세요" required="required">
										<button type="submit" class="btn_send cmmt">
											<em class="snd_only">전송</em>
										</button>
									</p>
								</form>
							</div>
							<c:if test='${myFeedSelectAll.mpphoto ne "" }'>
								<!-- # 썸네일 영역 { -->
								<div class="img box">
									<div class="thumb_slide">
										<div class="swiper-wrapper">
											<c:set var="myphoto" value="${myFeedSelectAll.mpphoto }" />
											<c:forTokens items="${myphoto }" delims="," var="item">
												<div class="swiper-slide">
													<img src="${upload }/${item }" alt="">
												</div>
											</c:forTokens>
										</div>
										<div class="swiper-pagination"></div>
									</div>
								</div>
							</c:if>
							<!--  } # 썸네일 영역 -->
						</div>
						<!-- } #텍스트+썸네일 피드 끝 -->
						<!-- #텍스트 피드 시작 { -->
					</c:forEach>
					<!-- } #텍스트 피드 끝 -->
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
				<!--  } 우측 사이드영역 끝 -->
			</div>
		</div>
		<!-- } 서브페이지 -->
		<span class="snd_only">0</span>
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
	<div id="deletecmmt" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">댓글을 삭제하시겠습니까?</h3>
			<input type="hidden" id="num" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="deletecmmt"
							class="btn_pop2 comm_btn sbm" data-layer="ok">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>

	<div id="deletefeed" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">피드를 삭제하시겠습니까?</h3>
			<input type="hidden" id="fnum" value="">
			<form id="deletefeedForm">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="submit" id="deletefeed"
							class="btn_pop2 comm_btn sbm">확인</button></li>
				</ul>
			</div>
			</form>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>

	<!-- #팝업 처리불가 {
	<div id="" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">그룹을 삭제할 수 없습니다.</p>
			<p class="pop_txt">아직 탈퇴하지 않은 그룹 멤버가 있습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	} #팝업 처리불가 -->

	<!-- #팝업 처리완료 { -->
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close ok comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
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
	<!-- } #팝업 처리완료 -->
	<script type="text/javascript">
		feedType('feed_viewer');
		btnPop('btn_pop2');
		setFile();
	</script>
	
	<!-- #게시글 초과 -->
	<div id="cnfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">게시글은 500자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="cnfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<!-- #해시태그 초과 -->
	<div id="htfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">해시태그는 20자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="htfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<!-- #댓글 초과 -->
	<div id="cmmtfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">댓글은 500자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="cmmtfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
</html>


