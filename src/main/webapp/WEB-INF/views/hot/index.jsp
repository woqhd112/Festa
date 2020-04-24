<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root}resources/images/ico/logo.png">
	<script type="text/javascript" src="${root}resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root}resources/js/util.js"></script>
	<script type="text/javascript" src="${root}resources/js/site.js"></script>
	<script type="text/javascript" src="${root }resources/js/jh.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="shortcut icon" href="${root}resources/favicon.ico">
	<title>FESTA</title>
	<script type="text/javascript">
	
		function btn_close(){
	        document.cookie = 'loginCookie' + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
	        var url = window.location.href;
	    	if(url.indexOf('group')>0||url.indexOf('news')>0||url.indexOf('user')>0||url.indexOf('admin')>0||url.indexOf('empty')>0){
	    		window.location.href='${root}';
	    	}else{
	    		location.reload();
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
			
			//로그인하기 내부팝업->로그인버튼 클릭시 로그인외부팝업생성
			$('#btnLogin').on('click', function() {
				$('#login').bPopup().close();
				openLayer('none', '${root}member/login');
			});
			var loginCheck = '${login.logincheck}';
			
			//로그인이아닐때 프로필사진,이름,뉴스피드 눌렀을경우
			$(document).on('click','.pf_picture, .fd_name, .cmt_name, #gnb li a:eq(2)',function(){
				if(loginCheck==''){
					openPop('login');
					return false;
				}
			});
			
			//스크롤 내렸을때 피드 2개씩 출력
			$(window).scroll(function(){
			    var scrolltop = parseInt ( $(window).scrollTop() );
			    if( scrolltop >= $(document).height() - $(window).height() - 1 ){
					var scrollTag=$('#footer').siblings('span');
					var scroll=scrollTag.text();
					scroll++;
					scrollTag.text(scroll);
					console.log(scroll);
					$.get('${root}hot/scroll','page5='+scroll,function(){
						
					}).done(function(data){
						//인기피드 스크롤더보기
						feedList(data,'hot','${login.pronum}','${login.prophoto}','${login.logincheck}');
					});
			    }
			});
			
			//좋아요 버튼클릭시
			$(document).on('click','.btn_liked',function(){
				var pronum = $('#wrap>input[type=hidden]').eq(0).val();
				var num;
				var checking = $(this).hasClass('act');
				var heart = $(this).parent().parent().siblings('.feed_inform').find('.fd_liked');
				//좋아요 등록
				if(checking){
					//그 피드가 개인피드일때
					if($(this).parent().parent().siblings('.feed_inform').find('.fd_group').length==0){
						num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
						$.post('${root}hot/likeadd','pronum='+pronum+'&mpnum='+num,function(){
							heart.html(Number(heart.text())+1);
						});
					//그 피드가 그룹피드일때
					}else{
						num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
						$.post('${root}hot/likeadd','pronum='+pronum+'&gpnum='+num,function(){
							heart.html(Number(heart.text())+1);
						});
					}
					
				//좋아요 해제
				}else{
					//그 피드가 개인피드일때
					if($(this).parent().parent().siblings('.feed_inform').find('.fd_group').length==0){
						num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
						$.post('${root}hot/likedel','pronum='+pronum+'&mpnum='+num,function(){
							heart.html(Number(heart.text())-1);
						});
					//그 피드가 그룹피드일때
					}else{
						num = $(this).parent().parent().siblings('.feed_inform').find('input[type=hidden]').eq(1).val();
						$.post('${root}hot/likedel','pronum='+pronum+'&gpnum='+num,function(){
							heart.html(Number(heart.text())-1);
						});
					}
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
		
			//피드삭제버튼 눌렀을때
			$(document).on('click', '.btn_feed', function() {
				if($(this).parent().parent().siblings('.feed_inform').find('.fd_group').length==0){
					$('#feednum').attr('name','mpnum');
				}else{
					$('#feednum').attr('name','gpnum');
				}
				var value = $(this).data('value');
				 $('#feednum').val(value);
			});
			
			//댓글삭제버튼 눌렀을때
			$(document).on('click', '.btn_cmmt', function() {
				if($(this).parent().parent().parent().parent().parent().parent().parent().siblings('.tit.box').find('.fd_group').length==0){
					$('#cmmtnum').attr('name','mcnum');
				}else{
					$('#cmmtnum').attr('name','gcnum');
				}
				var value = $(this).data('value');
				 $('#cmmtnum').val(value);
			});
			
			//피드삭제하기버튼 클릭시
			$(document).on('click', '#delete_btn_feed', function() {
				if($('#feednum').attr('name')=='mpnum'){
					var mpnum = $('#feednum').val();
					$.post('${root}hot/del','mpnum='+mpnum,function(){
						$('#delete_feed').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				}else{
					var gpnum = $('#feednum').val();
					$.post('${root}hot/del','gpnum='+gpnum,function(){
						$('#delete_feed').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				}
			});
			
			//댓글삭제하기버튼 클릭시
			$(document).on('click', '#delete_btn_cmmt', function() {
				if($('#cmmtnum').attr('name')=='mcnum'){
					var mcnum = $('#cmmtnum').val();
					$.post('${root}hot/cmmtdel','mcnum='+mcnum,function(){
						$('#delete_cmmt').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				}else{
					var gcnum = $('#cmmtnum').val();
					$.post('${root}hot/cmmtdel','gcnum='+gcnum,function(){
						$('#delete_cmmt').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close.ok').click(function(){
							location.reload();
						});
					});
				}
			});
			
			//그룹피드댓글 더보기버튼
			$(document).on('click', '.cmt_btn_more.gc', function() {
				var btn = $(this);
				var pageTag = $(this).find('span');
				var myPage = pageTag.text();
				myPage++;
				pageTag.text(myPage);
				var feed = btn.parents('.feed_viewer');
				var comments = btn.siblings('.comment_list');
				var gpnum = feed.find('input[type=hidden]').eq(1).val();
				console.log(gpnum);
				$.get('${root}hot/groupfeed/cmmt','gpnum='+gpnum+'&pageSearch.page4='+myPage,function(data){
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
						var delbtn;
						if('${login.pronum}'==''){
							delbtn = '';
						}else if('${login.pronum}'!=data[index].pronum){
							delbtn = '';
						}else{
							delbtn = '<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="'+data[index].gcnum+'"><em class="snd_only">삭제하기</em></button></p>';
						}
						comments.append('<li>'+
								'<a href="${root }user/?pronum='+data[index].pronum+'" class="pf_picture">'+
								prophototag+
								'</a><p class="cmt_content">'+
									'<a href="${root }user/?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].gcauthor+'</a>&nbsp;'+
									data[index].gccontent+
									'<span class="cmt_date">'+data[index].gcdate1+'</span>'+
									delbtn+
							'</li>');
					});//each문 end  
				});//ajax통신 end
			});//댓글더보기 end
			
			//개인피드댓글 더보기버튼
			$(document).on('click', '.cmt_btn_more.mc', function() {
				var btn = $(this);
				var pageTag = $(this).find('span');
				var myPage = pageTag.text();
				myPage++;
				pageTag.text(myPage);
				var feed = btn.parents('.feed_viewer');
				var comments = btn.siblings('.comment_list');
				var mpnum = feed.find('input[type=hidden]').eq(1).val();
				console.log(mpnum);
				$.get('${root}hot/myfeed/cmmt','mpnum='+mpnum+'&pageSearch.page4='+myPage,function(data){
					$(data).each(function(index){
						var prophoto=data[index].profile.prophoto;
						var prophototag;
						if(prophoto==null|prophoto==''||prophoto==undefined||prophoto.inEmpty){
							prophototag='<img src="${root}resources/images/thumb/no_profile.png" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
						}else{
							prophototag='<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
						}
						if(index==3){
							 return false;
						}else if(data.length<4){
							btn.hide();
						}
						var delbtn;
						if('${login.pronum}'==''){
							delbtn = '';
						}else if('${login.pronum}'!=data[index].pronum){
							delbtn = '';
						}else{
							delbtn='<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="'+data[index].mcnum+'"><em class="snd_only">삭제하기</em></button></p>'
						}
						comments.append('<li>'+
								'<a href="${root }user/?pronum='+data[index].pronum+'" class="pf_picture">'+
								prophototag+
								'</a><p class="cmt_content">'+
									'<a href="${root }user/?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].mcauthor+'</a>&nbsp;'+
									data[index].mccontent+
									'<span class="cmt_date">'+data[index].mcdate1+'</span>'+
									delbtn+
							'</li>');
					});//each문 end  
				});//ajax통신 end
			});//댓글더보기 end
			
			//댓글등록
			$(document).on('submit','.message_form',function(e){
				e.preventDefault();
				var sendBtn = $(this).find('.btn_send');
				var thisValues = $(this).parents('.feed_viewer').find('.feed_inform');
				var pronum = $('#wrap>input[type=hidden]').eq(0).val();
				var pronum_sync = thisValues.find('input[type=hidden]').eq(0).val();
				var content = sendBtn.siblings('.msg_txt').val();
				var author = '${login.proname}';
				var thisnum = thisValues.find('input[type=hidden]').eq(1).val();
				var grnum = thisValues.find('input[type=hidden]').eq(2).val();
				if(sendBtn.siblings('.msg_txt').val().length>0&&sendBtn.siblings('.msg_txt').val().length<500){
					//개인피드 댓글등록
					if(thisValues.find('.fd_group').length==0){
						$.post('${root}hot/cmmtadd','mpnum='+thisnum+'&pronum='+pronum+'&pronum_sync='+pronum_sync+'&mcauthor='+author+'&mccontent='+content,function(){
							location.reload();
							
						});
					//그룹피드 댓글등록
					}else{
						$.post('${root}hot/cmmtadd','gpnum='+thisnum+'&pronum='+pronum+'&grnum='+grnum+'&gcauthor='+author+'&gccontent='+content,function(){
							location.reload();
						});
					}
				//해당 input[type=text].val.length
				}else if(sendBtn.siblings('.msg_txt').val().length>=500){
					openPop('excess_comm');
				}
			});
			
			
		});
		
			
	</script>
</head>
<body>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<div id="wrap">
	<input type="hidden" value="${login.pronum }">
	<div id="header">
		<div class="scrX">
			<div class="container">
				<h1>
					<a href="${root}"><em class="snd_only">FESTA</em></a>
				</h1>
				<form class="search_box" action="${root }search/">
					<input type="text" name="keyword" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
					<button type="submit"><img src="${root}resources/images/ico/btn_search.png" alt="검색"></button>
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
													<c:when test="${empty joinGroup.group.grphoto }">
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
													<c:when test="${empty joinGroup.group.grphoto }"> 
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
	<!-- #인기피드 -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="feed_wrap">
		<h2 class="snd_only">인기피드</h2>
		<div class="container">
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<!-- #텍스트+썸네일 피드 시작 { -->
				<c:forEach items="${feedList }" var="feedList">
					<c:choose>
						<c:when test="${feedList.gpnum eq 0 }">
						<div class="feed_viewer">
							<div class="tit box">
								<dl class="feed_inform">
									<dt>
										<a href="${root }user/?pronum=${feedList.pronum}">
											<input type="hidden" value="${feedList.pronum }">
											<input type="hidden" value="${feedList.mpnum }">
											<c:if test="${!empty feedList.profile.prophoto }">
												<span class="pf_picture"><img src="${upload }/${feedList.profile.prophoto}" alt="${feedList.profile.proname }님의 프로필 썸네일"></span>
											</c:if>
											<c:if test="${empty feedList.profile.prophoto }">
												<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${feedList.profile.proname }님의 프로필 썸네일"></span>
											</c:if>
											<span class="fd_name">${feedList.mpauthor }</span>
										</a>
									</dt>
									<dd>
										<span class="fd_date">${feedList.date1 }</span>
										<b class="fd_liked">${feedList.good }</b>
									</dd>
								</dl>
								<ul class="feed_options">
									<c:if test="${login ne null}">
										<c:forEach items="${goodlist }" var="goodlist">
											<c:if test="${goodlist.mpnum eq feedList.mpnum }">
												<li><button class="btn_liked act"><em class="snd_only">하트</em></button></li>
											</c:if>
										</c:forEach>
										<c:if test="${login.pronum ne feedList.pronum }">
											<li><a href="${root}hot/report?mpnum=${feedList.mpnum}&profile.pronum=${feedList.pronum}&profile.proname=${feedList.profile.proname}&profile.proid=${feedList.profile.proid}" class="btn_pop btn_report"><em class="snd_only">신고하기</em></a></li>
										</c:if>
									</c:if>
									<c:if test="${login ne null and login.pronum eq feedList.pronum }">
										<li><a href="${root }hot/maker?mpnum=${feedList.mpnum}" class="btn_pop btn_edit"><em class="snd_only">수정하기</em></a></li>
										<li><button class="btn_pop btn_delete btn_feed" data-layer="delete_feed" data-value="${feedList.mpnum }"><em class="snd_only">삭제하기</em></button></li>
									</c:if>
								</ul>
							</div>
							<div class="text box">
								<div class="scrBar">
									<div class="feed_content">
										<ul class="fd_hashtag">
											<c:choose>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle2 && empty feedList.httitle3}">
												</c:when>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle2}">
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when
													test="${empty feedList.httitle2 && empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
												</c:when>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle1}">
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle2}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
												</c:when>
												<c:otherwise>
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<pre class="fd_content"><c:out value="${feedList.mpcontent }"/></pre>
									</div>
									<ul class="comment_list">
										<c:set var="i" value="0" />
										<c:set var="doneLoop" value="false" />
										<c:forEach items="${myFeedCmmt }" var="myFeedCmmt">
											<c:if test="${feedList.mpnum eq myFeedCmmt.mpnum }">
												<c:if test="${not doneLoop }">
												<li>
													<!-- # 프로필 이미지 없음 { -->
													<a href="${root }user/?pronum=${myFeedCmmt.pronum}" class="pf_picture">
													<c:if test="${!empty myFeedCmmt.profile.prophoto }">
														<img src="${upload }/${myFeedCmmt.profile.prophoto}" alt="${myFeedCmmt.profile.proname }님의 프로필 썸네일">
													</c:if>
													<c:if test="${empty myFeedCmmt.profile.prophoto }">
														<img src="${root }resources/images/thumb/no_profile.png" alt="${myFeedCmmt.profile.proname }님의 프로필 썸네일">
													</c:if>
													</a>
													<!-- } # 프로필 이미지 없음 -->
													<p class="cmt_content">
														<a href="${root }user/?pronum=${myFeedCmmt.pronum}" class="cmt_name">${myFeedCmmt.mcauthor }</a>
														${myFeedCmmt.mccontent }
														<span class="cmt_date">${myFeedCmmt.mcdate1 }</span>
														<c:if test="${login ne null and login.pronum eq myFeedCmmt.pronum }">
															<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="${myFeedCmmt.mcnum }"><em class="snd_only">삭제하기</em></button>
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
									<c:if test="${feedList.mptotal gt 3 }">
										<button class="cmt_btn_more mc"><span class="snd_only">1</span>댓글 더 보기</button>
									</c:if>
								</div>
								<c:if test="${login ne null }">
									<form class="message_form">
										<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
										<c:if test="${!empty login.prophoto }">
											<img src="${upload }/${login.prophoto}" alt="나의 프로필 썸네일">
										</c:if>
										<c:if test="${empty login.prophoto }">
											<img src="${root }resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일">
										</c:if>
										</a>
										<p class="msg_input">
											<input type="text" class="msg_txt" name="mccontent" placeholder="메세지를 입력해주세요" required="required">
											<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
										</p>
									</form>
								</c:if>
							</div>
							<input type="hidden" value="${feedList.mpphoto }">
							<c:if test="${feedList.mpphoto ne '' }">
								<!-- # 썸네일 영역 { -->
								<div class="img box">
									<div class="thumb_slide">
										<div class="swiper-wrapper">
											<c:set var="feedphoto" value="${feedList.mpphoto }" />
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
						<!-- } #텍스트+썸네일 피드 끝 -->
						</c:when>
						<c:otherwise>
						<div class="feed_viewer">
							<div class="tit box">
								<dl class="feed_inform">
									<dt>
										<a href="${root }user/?pronum=${feedList.pronum}">
											<input type="hidden" value="${feedList.pronum }">
											<input type="hidden" value="${feedList.gpnum }">
											<input type="hidden" value="${feedList.grnum }">
											<c:if test="${!empty feedList.profile.prophoto }">
												<span class="pf_picture"><img src="${upload }/${feedList.profile.prophoto}" alt="${feedList.profile.proname }님의 프로필 썸네일"></span>
											</c:if>
											<c:if test="${empty feedList.profile.prophoto }">
												<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${feedList.profile.proname }님의 프로필 썸네일"></span>
											</c:if>
											<span class="fd_name">${feedList.gpauthor }</span>
										</a>
										<c:if test="${login ne null }">
											<a href="${root }group/?grnum=${feedList.grnum}&pronum=${login.pronum}">
												<span class="fd_group">${feedList.group.grname }</span>
											</a>
										</c:if>
										<c:if test="${login eq null }">
											<a href="${root }group/?grnum=${feedList.grnum}">
												<span class="fd_group">${feedList.group.grname }</span>
											</a>
										</c:if>
									</dt>
									<dd>
										<span class="fd_date">${feedList.date1 }</span>
										<b class="fd_liked">${feedList.good }</b>
									</dd>
								</dl>
								<ul class="feed_options">
									<c:if test="${login ne null}">
										<c:forEach items="${goodlist }" var="goodlist">
											<c:if test="${goodlist.gpnum eq feedList.gpnum }">
												<li><button class="btn_liked act"><em class="snd_only">하트</em></button></li>
											</c:if>
										</c:forEach>
										<c:if test="${login.pronum ne feedList.pronum }">
											<li><a href="${root}hot/report?gpnum=${feedList.gpnum}&profile.pronum=${feedList.pronum}&profile.proname=${feedList.profile.proname}&profile.proid=${feedList.profile.proid}" class="btn_pop btn_report"><em class="snd_only">신고하기</em></a></li>
										</c:if>
									</c:if>
									<c:if test="${login ne null and login.pronum eq feedList.pronum }">
										<li><a href="${root }hot/maker?gpnum=${feedList.gpnum}" class="btn_pop btn_edit"><em class="snd_only">수정하기</em></a></li>
										<li><button class="btn_pop btn_delete btn_feed" data-layer="delete_feed" data-value="${feedList.gpnum }"><em class="snd_only">삭제하기</em></button></li>
									</c:if>
								</ul>
							</div>
							<div class="text box">
								<div class="scrBar">
									<div class="feed_content">
										<ul class="fd_hashtag">
											<c:choose>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle2 && empty feedList.httitle3}">
												</c:when>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle2}">
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when
													test="${empty feedList.httitle2 && empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
												</c:when>
												<c:when
													test="${empty feedList.httitle1 && empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle1}">
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle2}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:when>
												<c:when test="${empty feedList.httitle3}">
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
												</c:when>
												<c:otherwise>
													<li><a href="${root }search/?keyword=${feedList.httitle1}">${feedList.httitle1}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle2}">${feedList.httitle2}</a></li>
													<li><a href="${root }search/?keyword=${feedList.httitle3}">${feedList.httitle3}</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<pre class="fd_content"><c:out value="${feedList.gpcontent }"/></pre>
									</div>
									<ul class="comment_list">
										<c:set var="i" value="0" />
										<c:set var="doneLoop" value="false" />
										<c:forEach items="${groupFeedCmmt }" var="groupFeedCmmt">
											<c:if test="${feedList.gpnum eq groupFeedCmmt.gpnum }">
												<c:if test="${not doneLoop }">
												<li>
													<!-- # 프로필 이미지 없음 { -->
													<a href="${root }user/?pronum=${groupFeedCmmt.pronum}" class="pf_picture">
													<c:if test="${!empty groupFeedCmmt.profile.prophoto }">
														<img src="${upload }/${groupFeedCmmt.profile.prophoto}" alt="${groupFeedCmmt.profile.proname }님의 프로필 썸네일">
													</c:if>
													<c:if test="${empty groupFeedCmmt.profile.prophoto }">
														<img src="${root }resources/images/thumb/no_profile.png" alt="${groupFeedCmmt.profile.proname }님의 프로필 썸네일">
													</c:if>
													</a>
													<!-- } # 프로필 이미지 없음 -->
													<p class="cmt_content">
														<a href="${root }user/?pronum=${groupFeedCmmt.pronum}" class="cmt_name">${groupFeedCmmt.gcauthor }</a>
														${groupFeedCmmt.gccontent }
														<span class="cmt_date">${groupFeedCmmt.gcdate1 }</span>
														<c:if test="${login ne null and login.pronum eq groupFeedCmmt.pronum }">
															<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="${groupFeedCmmt.gcnum }"><em class="snd_only">삭제하기</em></button>
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
									<c:if test="${feedList.gptotal gt 3 }">
										<button class="cmt_btn_more gc"><span class="snd_only">1</span>댓글 더 보기</button>
									</c:if>
								</div>
								<c:if test="${login ne null }">
									<form class="message_form">
										<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
										<c:if test="${!empty login.prophoto }">
											<img src="${upload }/${login.prophoto}" alt="나의 프로필 썸네일">
										</c:if>
										<c:if test="${empty login.prophoto }">
											<img src="${root }resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일">
										</c:if>
										</a>
										<p class="msg_input">
											<input type="text" class="msg_txt" name="gccontent" placeholder="메세지를 입력해주세요" required="required">
											<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
										</p>
									</form>
								</c:if>
							</div>
							<input type="hidden" value="${feedList.gpphoto }">
							<c:if test="${feedList.gpphoto ne '' }">
								<!-- # 썸네일 영역 { -->
								<div class="img box">
									<div class="thumb_slide">
										<div class="swiper-wrapper">
											<c:set var="feedphoto" value="${feedList.gpphoto }" />
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
						<!-- } #텍스트+썸네일 피드 끝 -->
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</section>
			<!-- } 컨텐츠영역 끝 -->
			<!-- 우측 사이드영역 시작 { -->
			<section class="side_area">
					<div class="rcmm_list">
		               <h3><em class="snd_only">추천그룹 목록</em>나홀로 캠핑이 심심하신가요?</h3>
		               <ul>
		                  <c:forEach items="${grouplist }" begin="0" end="2" var="grouplist">
		                     <c:if test="${login ne null }">
		                        <li>
		                        	<c:choose>
		                        		<c:when test="${grouplist.grphoto eq null }">
				                           <a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
				                              <img src="${root}resources/images/thumb/no_profile.png" alt="${grouplist.grname } 그룹 썸네일">
				                           </a>
		                        		</c:when>
		                        		<c:otherwise>
				                           <a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
				                              <img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
				                           </a>
		                        		</c:otherwise>
		                        	</c:choose>
									<a class="rc_text" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}">
											<b class="rc_name">${grouplist.grname }</b>
											<span class="rc_intro">${grouplist.grintro }</span>
									</a>
								</li>
		                     </c:if>
		                     <c:if test="${login eq null }">
		                        <li>
		                        	<c:choose>
		                        		<c:when test="${grouplist.grphoto eq null }">
				                           <a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}">
				                              <img src="${root}resources/images/thumb/no_profile.png" alt="${grouplist.grname } 그룹 썸네일">
				                           </a>
		                        		</c:when>
		                        		<c:otherwise>
				                           <a class="rc_thumb" href="${root }group/?grnum=${grouplist.grnum}">
				                              <img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
				                           </a>
		                        		</c:otherwise>
		                        	</c:choose>
		                            <a class="rc_text" href="${root }group/?grnum=${grouplist.grnum}">
		                                <b class="rc_name">${grouplist.grname }</b>
		                                <span class="rc_intro">${grouplist.grintro }</span>
		                            </a>
		                        </li>
		                     </c:if>
		                  </c:forEach>
		               </ul>
		            </div>
		            <div class="rcmm_list">
		               <h3><em class="snd_only">추천캠핑장 목록</em>이 캠핑장에도 가보셨나요?</h3>
		               <ul>
							<c:forEach items="${camplist }" begin="0" end="2" var="camplist">
								<li>
								<c:if test="${!empty camplist.caphoto }">
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
								</a>
								</li>
							</c:forEach>
						</ul>
		            </div>
		         </section>
			<!-- } 우측 사이드영역 끝 -->
		</div>
	</div>
	<span class="snd_only">1</span>
	<!-- } 서브페이지 -->
	<div id="footer">
		<div class="container">
			<div class="img_box">
				<img src="${root}resources/images/ico/logo_w.png" alt="FESTA">
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
<!-- #댓글 초과팝업 { -->
<div id="excess_comm" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">댓글은 500자 이상 입력할수 없습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- #댓글 초과팝업 { -->
<div id="excess" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">게시글은 500자 이상 입력할수 없습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- #피드 삭제하기 { -->
<div id="delete_feed" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 피드를 삭제하시겠습니까?</h4>
		<input type="hidden" id="feednum" value="">
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="delete_btn_feed" class="comm_btn cfm">삭제하기</button></li>
			</ul>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- #댓글 삭제하기 { -->
<div id="delete_cmmt" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 댓글을 삭제하시겠습니까?</h4>
		<input type="hidden" id="cmmtnum" value="">
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="delete_btn_cmmt" class="comm_btn cfm">삭제하기</button></li>
			</ul>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- #팝업 처리완료 { -->
<div id="success" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close ok comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 삭제하기 -->
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
	btnPop('btn_pop2');
	feedType('feed_viewer');
</script>
</body>
</html>