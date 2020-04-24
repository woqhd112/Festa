<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty" />
	</c:if>
</c:if>
<c:url value="/resources/upload" var="upload" />
<c:url value="/" var="root" />
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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="${root }resources/css/site.css">
<link rel="shortcut icon" href="${root }resources/favicon.ico">
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
		
		$("input:checkbox[name='ntc']").on('click', function(){
			$('.mk_tags').hide();
			$('#insertform').attr("action", "${root}group/noticeadd");
			$('#ntc1').removeAttr("name").attr({name : "gnauthor"}); 
			$('#ntc4').removeAttr("name").attr({name : "gncontent"});
			
			if("on" != $("input:checkbox[name='ntc']:checked").val()){
				$("#insertform").attr("action", "${root}group/add");
				$('#ntc1').removeAttr("name").attr({name : "gpauthor"}); 
				$('#ntc4').removeAttr("name").attr({name : "gpcontent"});
				$(".mk_tags").show();
				$('.btn_send').on('click', function(e){
	    			e.preventDefault();	
				});
			}
		});
		
		$('#contentsend').on('click', function(){

			var content=$('#ntc4').val().length;
			var ht1=$('#httitle1').val().length;
			var ht2=$('#httitle2').val().length;
			var ht3=$('#httitle3').val().length;
			if(content>=500){
				openPop("cnfull");
				$('#cnfailed').on('click', function(){
					$('#ntc4').focus();					
				});
				return false;
			};
			if(ht1>=20){
				openPop("htfull");
				$('#htfailed').on('click', function(){
					$('#httitle1').focus();		
				})
				return false;
			}
			if(ht2>=20){
				openPop("htfull");
				$('#htfailed').on('click', function(){
					$('#httitle2').focus();		
				})
				return false;
			}
			if(ht3>=20){
				openPop("htfull");
				$('#htfailed').on('click', function(){
					$('#httitle3').focus();		
				})
				return false;
			}
		});
		
		$('.feed_viewer').each(function(index){
			if(index>1){
				$('.feed_viewer').eq(index).hide();
			}
		});

		//스크롤시 게시글 로드 
		$(window).scroll(function(){
			var scrolltop = parseInt ( $(window).scrollTop() );
			if( scrolltop >= $(document).height() - $(window).height() - 1 ){
				var scrollTag=$('#footer').siblings('span');
				var scroll=scrollTag.text();
				scroll++;
				scrollTag.text(scroll);
				console.log(scroll);
				var curfeedcnt=$('.feed_viewer').length;
				$('.feed_viewer').eq(scroll*2).show();
				$('.feed_viewer').eq(scroll*2+1).show();
		    }
		});

		//댓글 입력하기 버튼클릭
		$(document).on('submit', '.message_form', function(e){
			var btn=$(this).find('.btn_send.cmmt');
			var feed=btn.parents('.feed_viewer.ind');
			var gccontent=feed.find('#groupCmmtAddCont').val();
			var gcauthor=feed.find('#cmmtName').val();
			var gpnum=feed.find('#cmmtGpnum').val();
			var pronum=feed.find('#cmmtPronum').val();
			var grnum=feed.find('#cmmtGrnum').val();
			console.log(gccontent+'/'+gcauthor+'/'+gpnum+'/'+pronum+'/'+grnum);
			var gctest=gccontent.length;
			if(gctest>=500){
				openPop("cmmtfull");
				$('#cmmtfailed').on('click', function(){
					$('#groupCmmtAddCont').focus();					
				});
				return false;
			};
			e.preventDefault();
			$.post('${root}group/cmmtadd', 'gccontent='+gccontent+'&gcauthor='+gcauthor+'&gpnum='+gpnum+'&pronum='+pronum+'&grnum='+grnum, function(html){
				window.location.reload();
			});
		});
		
		//댓글 더보기
		$(document).on('click', '.cmt_btn_more.dt', function() {
			var btn = $(this);
			var pageTag = $(this).find('span');
			var myPage = pageTag.text();
			myPage++;
			pageTag.text(myPage);
			var feed = btn.parents('.feed_viewer.ind');
			var comments = btn.siblings('.comment_list.ind');
			var del=$('#cmmtPronum').val();
			var gpnum = feed.find('#cmmtGpnum').val();
			var pronum=feed.find('#cmmtPronum').val();
			var mpronum=feed.find('#masterPronum').val();
			var fpronum=feed.find('#feedPronum').val();
			$.get('${root}group/cmmt','gpnum='+gpnum+'&pageSearch.page4='+myPage,function(data){
				$(data).each(function(index){
					if(index==3){
						return false;
					}else if(data.length<4){
						btn.hide();
					}
					if(del == data[index].pronum || del == fpronum || pronum == mpronum){
						comments.append('<li>'+
								'<a href="" class="pf_picture">'+
									'<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].gcauthor+'님의 프로필 썸네일" onload="squareTrim($(this), 30)" >'+
								'</a><p class="cmt_content">'+
									'<a href="" class="cmt_name">'+data[index].gcauthor+'</a>&nbsp;&nbsp;'+data[index].gccontent+
									'<span class="cmt_date">'+data[index].gcdate1+'</span>'+
									'<button class="btn_pop btn_delete btn_cmmt" data-layer="delete" data-value="'+data[index].gcnum+'"><em class="snd_only">삭제하기</em></button></p>'+
							'</li>');
						$('.snd_only').last().focus();
					}else{
						comments.append('<li>'+
								'<a href="" class="pf_picture">'+
									'<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].gcauthor+'님의 프로필 썸네일" onload="squareTrim($(this), 30)" >'+
								'</a><p class="cmt_content">'+
									'<a href="" class="cmt_name">'+data[index].gcauthor+'</a>&nbsp;&nbsp;'+data[index].gccontent+
									'<span class="cmt_date">'+data[index].gcdate1+'</span></li>');
						$('<li>').last().focus();
					}
				});//each문 end
			});//ajax통신 end		
		});//댓글더보기 end
		

		//댓글삭제 클릭시
		$(document).on('click', '#groupcmmtdelete', function() {
			var cmmtdel = $(this).data('value');
			$('#num').val(cmmtdel);
		});

		//댓글삭제 클릭>확인시
		$('#deletecmmt').on('click', function(){
			var gcnum = $('#num').val();
			$.post('${root}group/cmmtdel', 'gcnum='+gcnum, function(data){
				openPop("ok");
				$('#success').on('click', function(){
					window.location.reload();
				});
			}); 
		});

		//피드삭제 클릭시
		$(document).on('click', '#delgroupfeed', function() {
			var feeddel = $(this).data('value');
			$('#fnum').val(feeddel);
		});
		
		//피드삭제 클릭>확인시
		$('#deletefeed').on('click', function(){
			var gpnum = $('#fnum').val();
			$.post('${root}group/del', 'gpnum='+gpnum, function(data){
				openPop("ok");
				$('#success').on('click', function(){
					window.location.reload();					
				});
			}); 
		});
		
		//탈퇴하기 클릭
		$('#groupbyebtn').on('click', function(){
	 		var grnum=$('#postgrnum').val();
	 		$('#grnum').val(grnum);
	 		var pronum=$('#postpronum').val();
	 		$('#pronum').val(pronum);
	 		var grtotal=$('#postgrtotal').val();
	 		$('#grtotal').val(grtotal);
	 		var pronum2=$('#pronum').val();
	 		console.log(pronum2);
	 		
	 		//그룹삭제 키값검사
		 	$('#keymsg').on('propertychange change keyup paste input', function(){
		 		var keymsg=$('#keymsg').val();
		 		var sucmsg='여행하는 과정에서 행복을 느낀다'
		 		if(keymsg == sucmsg){
		 			$('#outgroup').removeAttr("disabled");
		 			$('#outgroup').removeClass('sbm');
		 			$('#outgroup').addClass('cfm');

		 			var grnum=$('#grnum').val();
		 			var pronum=$('#pronum').val();
		 			var grtotal=$('#grtotal').val();
		 			
	 				$('#outgroup').on('click', function(){
		 				$.post('${root}/group/out', 'grnum='+grnum+'&pronum='+pronum+'&jointot=1'+'&grtotal='+grtotal, function(data){
								openPop("ok");
								$('#success').on('click', function(){
									window.location.href='${root}user/?pronum='+pronum;
								});
		 				});
	 				})
		 		}else{
		 			$('#outgroup').attr("disabled", "disabled");
		 			$('#outgroup').removeClass('cfm');
		 			$('#outgroup').addClass('sbm');
		 		}
		 	});
		});
		
		//좋아요 버튼클릭시
		$(document).on('click','.btn_liked',function(){
			var pronum = $('#wrap>input[type=hidden]').eq(0).val();
			var num;
			var checking = $(this).hasClass('act');
			//좋아요 등록;
			if(checking){
				num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
				$.post('${root}group/likeadd','pronum='+pronum+'&gpnum='+num, function(html){
					window.location.reload();
				});
			//좋아요 해제
			}else{
				num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
				$.post('${root}group/likedel','pronum='+pronum+'&gpnum='+num, function(){
					window.location.reload();
				});
			}
		});
		
		//좋아요버튼 갯수조절
	    var goodSize = $('.content_area>.feed_viewer .feed_options').length;
		if($('#wrap>input[type=hidden]').eq(0).val()!=''){
		    for(var i = 0; i< goodSize; i++){
		    	if($('.content_area>.feed_viewer .feed_options').eq(i).find('.btn_liked').hasClass('act')==false){
					$('.content_area>.feed_viewer .feed_options').eq(i).prepend('<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>');
		        }
		    }
		}
		
		//검색
		$('#keyword').val('');
		$('#search').on('click', function(){
			var keyword=$('#keyword').val();
			$.post('${root}search/', 'keyword='+keyword);
		});
		
		// 신고하기 팝업
		$('.btn_report').on('click', function(e) {
			var url = $(this).attr('href');
			openLayer(e, url);
		});
	});
</script>
<title>FESTA</title>
</head>
<body>
	<input type="hidden" id="grnum" value="${detail.grnum }">
	<input type="hidden" id="pronum" value="${detail.profile.pronum }">
	<input type="hidden" id="proname" value="${detail.profile.proname }">
	<input type="hidden" id="proid" value="${detail.profile.proid }">
	<div id="wrap">
		<input type="hidden" value="${login.pronum }">
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
		<!-- #그룹 홈 (가입한 회원) -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="home_wrap">
			<h2 class="snd_only">${detail.grname } 그룹 홈</h2>
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
										class="pf_opt btn_report"> <em class="snd_only">신고하기</em>
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
								<span>그룹장 : ${detail.profile.proname}</span>
									<a class="btn_pop btn_member" href="${root }group/member?grnum=${detail.grnum}">
									멤버 : ${detail.grtotal }명</a> <span>개설일 : ${detail.grdate }</span>
								<c:if test="${login.pronum ne detail.pronum }">
									<a class="btn_pop btn_out" id="groupbyebtn" data-layer="groupbye" style="cursor: pointer">탈퇴</a>
								</c:if>
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
					<p class="social_btns">
						<button type="button" class="btn_chat" onclick="window.open('${root}group/chat?grnum=${detail.grnum }','Festa chat','width=721,height=521,location=no,status=no,scrollbars=no');">그룹채팅</button>
					</p>
				</div>
			</section>
			<!-- } 프로필영역 끝 -->
			<input type="hidden" id="postgrnum" value="${detail.grnum }" />
			<input type="hidden" id="postpronum" value="${login.pronum }" />
			<input type="hidden" id="postgrtotal" value="${detail.grtotal }" />
			<div class="container">
				<!-- 컨텐츠영역 시작 { -->
				<section class="content_area">
					<!-- #공지사항 시작 {  -->
					<div class="feed_notice">
						<h3>공지사항 [최근 5개]</h3>
						<ul>
							<c:choose>
								<c:when test="${!empty ntc }">
									<c:forEach items="${ntc}" var="ntc">
										<li><a class="btn_feed"
											href="${root }group/ntc_feed?gnnum=${ntc.gnnum}&grnum=${detail.grnum}">
												<b>${ntc.gndate1 }</b>&nbsp;&nbsp;|&nbsp;&nbsp;${ntc.gncontent } </a></li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li class="fstEmpty">등록된 공지사항이 없습니다.</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<!-- } #공지사항 끝 -->
					<!-- #피드만들기 시작 { -->
					<div class="feed_maker">
						<h3>피드 만들기</h3>
						<form action="${root }group/add" class="maker_form" method="post" enctype="multipart/form-data" id="insertform">
							<input type="hidden" id="ntc1" name="gpauthor" value="${login.proname }" />
							<input type="hidden" id="ntc2" name="pronum" value="${login.pronum }" />
							<input type="hidden" id="ntc3" name="grnum" value="${detail.grnum }" />
							<c:if test="${login.pronum eq detail.pronum }">
								<p class="mk_noti">
									<input type="checkbox" name="ntc" class="comm_chk" id="festaNt">
									<label for="festaNt">공지</label>
								</p>
							</c:if>
							<div class="mk_cont box">
								<c:choose>
									<c:when test="${login.prophoto eq null }">
										<p class="pf_picture">
											<img src="${root}resources/images/thumb/no_profile.png"
												alt="${login.proname } 님의 프로필 썸네일">
										</p>
									</c:when>
									<c:otherwise>
										<p class="pf_picture">
											<img src="${upload }/${login.prophoto }"
												alt="${login.proname } 님의 프로필 썸네일">
										</p>
									</c:otherwise>
								</c:choose>
								<textarea id="ntc4" name="gpcontent" placeholder="${login.proname } 님, 무슨 생각을 하고 계신가요?" required="required"></textarea>
							</div>
							<div class="file_thumbnail mk_thumb box">
								<ul>
									<li class="ft_btn">
										<input type="file" id="file1" name="files" accept="video/*, image/*">
										<img src=""alt="">
										<button class="btn_cancle" type="button">
											<em class="snd_only">업로드 취소하기</em>
										</button>
										<label for="file1" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
									<li class="ft_btn">
										<input type="file" id="file2" name="files" accept="video/*, image/*">
										<img src="" alt="">
										<button class="btn_cancle" type="button">
											<em class="snd_only">업로드 취소하기</em>
										</button>
										<label for="file2" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
									<li class="ft_btn">
										<input type="file" id="file3" name="files" accept="video/*, image/*">
										<img src="" alt="">
										<button class="btn_cancle" type="button">
											<em class="snd_only">업로드 취소하기</em>
										</button>
										<label for="file3" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
									<li class="ft_btn">
										<input type="file" id="file4" name="files" accept="video/*, image/*">
										<img src="" alt="">
										<button class="btn_cancle" type="button">
											<em class="snd_only">업로드 취소하기</em>
										</button>
										<label for="file4" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
									<li class="ft_btn">
										<input type="file" id="file5" name="files" accept="video/*, image/*">
										<img src="" alt="">
										<button class="btn_cancle" type="button">
											<em class="snd_only">업로드 취소하기</em>
										</button>
										<label for="file5" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
								</ul>
							</div>
							<div class="mk_bottom box">
								<ul class="mk_tags">
									<li><input type="text" id="httitle1" name="httitle1"></li>
									<li><input type="text" id="httitle2" name="httitle2"></li>
									<li><input type="text" id="httitle3" name="httitle3"></li>
								</ul>
								<ul class="mk_btns">
									<li>
										<label for="file1" class="btn_file">
											<em class="snd_only">사진/동영상 업로드하기</em>
										</label>
									</li>
									<li>
										<button type="submit" class="btn_send" id="contentsend">
											<em class="snd_only">피드 게시하기</em>
										</button>
									</li>
								</ul>
							</div>
						</form>
					</div>
					<!-- } #피드만들기 끝 -->
					<c:forEach items="${feed }" var="feed">
						<!-- #텍스트 피드 시작 { -->
						<div class="feed_viewer ind">
							<div class="tit box">
								<dl class="feed_inform">
									<dt>
										<a href="${root }user/?pronum=${feed.pronum}">
											<input type="hidden" value="${feed.pronum}" />
											<input type="hidden" value="${feed.gpnum}" />
											<input type="hidden" id="cmmtName" value="${login.proname}" />
											<input type="hidden" id="cmmtPronum" value="${login.pronum}" />
											<input type="hidden" id="cmmtGrnum" value="${detail.grnum }" />
											<input type="hidden" id="masterPronum" value="${detail.pronum }" />
											<input type="hidden" id="feedPronum" value="${feed.pronum }" />
											<c:choose>
												<c:when test="${feed.profile.prophoto eq '' }">
													<span class="pf_picture"><img src="${root}resources/images/thumb/no_profile.png" alt="${feed.gpauthor}님의 프로필 썸네일"></span>
												</c:when>
												<c:otherwise>
													<span class="pf_picture"><img src="${upload }/${feed.profile.prophoto}" alt="${feed.gpauthor}님의 프로필 썸네일"></span>
												</c:otherwise>
											</c:choose>
											<span class="fd_name">${feed.gpauthor}</span>
										</a> 
										<a href="${root }group/?grnum=${detail.grnum }&pronum=${login.pronum}">
											<span class="fd_group">${detail.grname}</span>
										</a>
									</dt>
									<dd>
										<span class="fd_date">${feed.gpdate1 }</span>
										<b class="fd_liked">${feed.gpgood }</b>
									</dd>
								</dl>
								<input type="hidden" id="likefuck" value="${feed.gpgood }" />
								<ul class="feed_options">
									<c:forEach items="${goodlist }" var="goodlist">
										<c:if test="${goodlist.gpnum eq feed.gpnum }">
											<li>
												<button class="btn_liked act"><em class="snd_only">하트</em></button>
											</li>
										</c:if>
									</c:forEach>
									<c:if test="${(login.pronum ne feed.pronum) and !(login.pronum eq detail.pronum)}">
										<li><a href="${root }group/report?gpnum=${feed.gpnum}&profile.pronum=${feed.profile.pronum}&profile.proid=${feed.profile.proid}&profile.proname=${feed.profile.proname}"
											class="btn_report"> <em class="snd_only">신고하기</em>
										</a></li>
									</c:if>
									<c:if test="${login.pronum eq feed.pronum}">
										<li>
											<a href="${root }group/maker?gpnum=${feed.gpnum}" class="btn_pop btn_edit" id="feedmaker">
												<em	class="snd_only">수정하기</em>
											</a>
										</li>
									</c:if>
									<c:if test="${(login.pronum eq feed.pronum ) or (detail.pronum eq login.pronum)}">
										<li>
											<button class="btn_delete feed btn_pop" id="delgroupfeed" data-layer="deletegrfeed" data-value="${feed.gpnum }">
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
													test="${empty feed.httitle1 && empty feed.httitle2 && empty feed.httitle3}">
												</c:when>
												<c:when
													test="${empty feed.httitle1 && empty feed.httitle2}">
													<li><a href="${root }search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li>
												</c:when>
												<c:when
													test="${empty feed.httitle2 && empty feed.httitle3}">
													<li><a href="${root }search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li>
												</c:when>
												<c:when
													test="${empty feed.httitle1 && empty feed.httitle3}">
													<li><a href="${root }search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li>
												</c:when>
												<c:when test="${empty feed.httitle1}">
													<li><a href="${root }search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feed.httitle2}">
													<li><a href="${root }search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feed.httitle3}">
													<li><a href="${root }search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li>
												</c:when>
												<c:otherwise>
													<li><a href="${root }search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<pre class="fd_content"><c:out value="${feed.gpcontent }" /></pre>
									</div>
									<input type="hidden" id="cmmtGpnum" value="${feed.gpnum}" />
									<ul class="comment_list ind">
										<c:set var="i" value="0" />
										<c:set var="doneLoop" value="false" />
										<c:forEach items="${feedcmmt }" var="feedcmmt">
											<c:if test="${(feed.gpnum eq feedcmmt.gpnum) and (detail.grnum eq feed.grnum)}">
												<c:if test="${not doneLoop }">
													<li class="">
														<c:choose>
															<c:when test="${feedcmmt.profile.prophoto eq null }">
																<a href="${root }user/?pronum=${feedcmmt.pronum}" class="pf_picture">
																	<img src="${root }resources/upload/thumb/no_profile.png" alt="${feedcmmt.gcauthor }님의 프로필 썸네일">
																</a>
															</c:when>
															<c:otherwise>
																<a href="${root }user/?pronum=${feedcmmt.pronum}" class="pf_picture">
																	<img src="${upload }/${feedcmmt.profile.prophoto}" alt="${feedcmmt.gcauthor }님의 프로필 썸네일">
																</a>
															</c:otherwise>
														</c:choose>
														<!-- } # 프로필 이미지 없음 -->
														<p class="cmt_content">
														<input type="hidden" id="delCmmtNum" value="${feedcmmt.gcnum}" />
														<a href="${root }user/?pronum=${feedcmmt.pronum}" class="cmt_name">${feedcmmt.gcauthor }</a>&nbsp;&nbsp;${feedcmmt.gccontent }
														<span class="cmt_date">${feedcmmt.gcdate1 }</span>
															<c:if test="${(login.pronum eq feed.pronum ) or (login.pronum eq feedcmmt.pronum) or (login.pronum eq detail.pronum)}">
																<button class="btn_delete btn_pop" id="groupcmmtdelete" data-layer="deletegrcmmt" data-value="${feedcmmt.gcnum }">
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
									<c:if test="${feed.gptotal gt 3 }">
										<button class="cmt_btn_more dt">
											<span class="snd_only">1</span>댓글 더 보기
										</button>
									</c:if>
								</div>
								<form class="message_form">
									<c:choose>
										<c:when test="${login.prophoto eq null}">
											<a class="pf_picture" href="">
												<img src="${root}resources/images/thumb/no_profile.png" alt="${login.proname } 님의 프로필 썸네일">
											</a>
										</c:when>
										<c:otherwise>
											<a class="pf_picture" href="">
												<img src="${upload }/${login.prophoto }" alt="${login.proname } 님의 프로필 썸네일">
											</a>
										</c:otherwise>
									</c:choose>
									<p class="msg_input">
										<input type="text" class="msg_txt" id="groupCmmtAddCont" name="groupCmmtAddCont" placeholder="메세지를 입력해주세요" required="required">
										<button type="submit" class="btn_send cmmt">
											<em class="snd_only">전송</em>
										</button>
									</p>
								</form>
							</div>
							<c:if test="${feed.gpphoto ne '' }">
								<!-- # 썸네일 영역 { -->
								<div class="img box">
									<div class="thumb_slide">
										<div class="swiper-wrapper">
											<c:set var="feedphoto" value="${feed.gpphoto }" />
											<%-- <c:out value='${gpphoto }'/> --%>
											<c:forTokens items="${feedphoto }" delims="," var="item">
												<div class="swiper-slide">
													<img src="${upload }/${item }" alt="">
												</div>
											</c:forTokens>
										</div>
										<div class="swiper-pagination"></div>
									</div>
								</div>
								<!--  } # 썸네일 영역 -->
							</c:if>
						</div>
						<!-- } #텍스트 피드 끝 -->
					</c:forEach>
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
											<c:when test="${empty grouplist.grphoto}">
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
		<span class="snd_only">0</span>
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
	
	<div id="deletegrcmmt" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">댓글을 삭제하시겠습니까?</h3>
			<input type="hidden" id="num" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" id="colosecmmt" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="deletecmmt" class="btn_close comm_btn cfm">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	
	<div id="deletegrfeed" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">피드를 삭제하시겠습니까?</h3>
			<input type="hidden" id="fnum" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" id="closefeed"  class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="deletefeed" class="btn_close comm_btn cfm" >확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	
	<div id="groupbye" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">그룹을 탈퇴하시겠습니까?</h3>
			<div class="info_box">
				<ul>
					<li>탈퇴 후에도 그룹에 작성한 나의 피드는 삭제되지 않습니다.</li>
					<li>확인 버튼을 누르시면 그룹 탈퇴가 완료됩니다.</li>
				</ul>
			</div>
			<p>[다음 문구를 똑같이 입력해주세요.]</p>
			<p class="out_words">여행하는 과정에서 행복을 느낀다</p>
			<form class="comm_form">
				<div class="ip_box">
					<input type="text" id="keymsg" name="" required="required">
					<input type="hidden" id="grnum" value="" />
					<input type="hidden" id="pronum" value="" />
					<input type="hidden" id="grtotal" value="" />
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
	</div>
	<button type="button" class="btn_close">
		<em class="snd_only">창 닫기</em>
	</button>
		
	<!-- #팝업 처리완료 { -->
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap"> 
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="success" class="btn_close ok comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<!-- #공백불 { -->
	<div id="uploadfail" class="fstPop">
		<div class="confirm_wrap pop_wrap"> 
			<p class="pop_tit">공백입력은 불가능합니다.</p>
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
	
	<!-- #게시글 초과 -->
	<div id="cnfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">게시글은 500자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="cnfailed" class="btn_close comm_btn cfm">확인</button></li>
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
	
	<!-- #해시태그 초과 -->
	<div id="htfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">해시태그는 20자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="htfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>

	<script type="text/javascript">
		feedType('feed_viewer');
		btnPop('btn_pop2');
		setFile();
		openFeed();
	</script>
</body>
</html>