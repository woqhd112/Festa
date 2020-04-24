<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	var url = window.location.href;
	if(url.indexOf('feed')>0){
		window.location.href='${root}empty';
	}
	
	$('.fstPop .btn_report').on('click',function(e){
		var url=$(this).attr('href');
		openLayer(e,url);
	});
	
	function liked(button) {
		var container = $('.fstPop .feed_inform');
		var pronum = $('#pronum').val();
		var num;
		var checking = !button.hasClass('act');
		var heart = container.find('.fd_liked');
		
		//좋아요 등록
		if(checking){
			//그 피드가 개인피드일때
			if(container.find('.fd_group').length==0){
				num = container.find('input[type=hidden]').eq(1).val();
				$.post('${root}search/feed/likeadd','pronum='+pronum+'&mpnum='+num,function(){
					console.log('개인',heart.text());
					heart.html(Number(heart.text())+1);
				});
			//그 피드가 그룹피드일때
			}else{
				num = container.find('input[type=hidden]').eq(1).val();
				$.post('${root}search/feed/likeadd','pronum='+pronum+'&gpnum='+num,function(){
					console.log('그룹',heart.text());
					heart.html(Number(heart.text())+1);
				});
			}
			
		//좋아요 해제
		}else{
			//그 피드가 개인피드일때
			if(container.find('.fd_group').length==0){
				num = container.find('input[type=hidden]').eq(1).val();
				$.post('${root}search/feed/likedel','pronum='+pronum+'&mpnum='+num,function(){
					console.log('개인',heart.text());
					heart.html(Number(heart.text())-1);
				});
			//그 피드가 그룹피드일때
			}else{
				num = container.find('input[type=hidden]').eq(1).val();
				$.post('${root}search/feed/likedel','pronum='+pronum+'&gpnum='+num,function(){
					console.log('그룹',heart.text());
					heart.html(Number(heart.text())-1);
				});
			}
		}
	}
	
	function mored(button){
		if(button.hasClass('gc')){
			var btn = button;
			var pageTag = button.find('span');
			var myPage = pageTag.text();
			myPage++;
			pageTag.text(myPage);
			var feed = btn.parents('.feed_viewer');
			var comments = btn.siblings('.comment_list');
			var gpnum = feed.find('input[type=hidden]').eq(1).val();
			console.log(gpnum);
			$.get('${root}search/feed/group_cmmt','gpnum='+gpnum+'&pageSearch.page4='+myPage,function(data){
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
							'<a href="${root }user/?pronum='+data[index].pronum+'" class="pf_picture">'+
							prophototag+
							'</a><p class="cmt_content">'+
								'<a href="${root }user/?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].gcauthor+'</a>&nbsp;'+
								data[index].gccontent+
								'<span class="cmt_date">'+data[index].gcdate1+'</span>'+
						'</li>');
				});//each문 end  
			});//ajax통신 end
			
		}else{
			var btn = button;
			var pageTag = button.find('span');
			var myPage = pageTag.text();
			myPage++;
			pageTag.text(myPage);
			var feed = btn.parents('.feed_viewer');
			var comments = btn.siblings('.comment_list');
			var mpnum = feed.find('input[type=hidden]').eq(1).val();
			console.log(mpnum);
			$.get('${root}search/feed/my_cmmt','mpnum='+mpnum+'&pageSearch.page4='+myPage,function(data){
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
							'<a href="${root }user/?pronum='+data[index].pronum+'" class="pf_picture">'+
							prophototag+
							'</a><p class="cmt_content">'+
								'<a href="${root }user/?pronum='+data[index].pronum+'" class="cmt_name">'+data[index].mcauthor+'</a>&nbsp;'+
								data[index].mccontent+
								'<span class="cmt_date">'+data[index].mcdate1+'</span>'+
						'</li>');
				});//each문 end  
			});//ajax통신 end
			
		}
	}
	
	$(document).ready(function(){
		setTimeout(function() {
			var scr = $('.text.box .scrBar');
			var slide = $('.feed_viewer .thumb_slide');
			var images = $('.feed_viewer .thumb_slide img');
			sliderLoad(slide);
			scrBar(scr);
			squareTrim(images, 290);
		}, 1000);
		//좋아요버튼 갯수조절
	    var good = $('.feed_viewer .feed_options');
		//로그인상태일때
		if($('#pronum').val()!=''){
			//빨간하트(이미 좋아요누름)을 가지고있지 않을때
	    	if(good.find('.btn_liked').hasClass('act')==false){
	         	good.prepend('<li><button class="btn_liked" onclick="liked($(this))"><em class="snd_only">하트</em></button></li>');
	        }
		}
		
		//댓글등록
		$('.message_form').on('submit',function(e){
			e.preventDefault();
			var sendBtn = $(this).find('.btn_send');
			var thisValues = sendBtn.parent().parent().parent().parent().find('.feed_inform');
			var pronum = $('#pronum').val();
			var pronum_sync = thisValues.find('input[type=hidden]').eq(0).val();
			var content = sendBtn.siblings('.msg_txt').val();
			var author = '${login.proname}';
			var thisnum = thisValues.find('input[type=hidden]').eq(1).val();
			var grnum = thisValues.find('input[type=hidden]').eq(2).val();
			if(content.length>=500){
				openPop('excess');
			}else{
				//개인피드 댓글등록
				if(thisValues.find('.fd_group').length==0){
					$.post('${root}search/feed/cmmtadd','mpnum='+thisnum+'&pronum='+pronum+'&pronum_sync='+pronum_sync+'&mcauthor='+author+'&mccontent='+content,function(){
						$.get('${root}search/feed','mpnum='+thisnum,function(){
							
						}).done(function(html){
							$('.feed_viewer').replaceWith(html);
							imageLoad(0);
							scrBar();
						});
					});
				//그룹피드 댓글등록
				}else{
					$.post('${root}search/feed/cmmtadd','gpnum='+thisnum+'&pronum='+pronum+'&grnum='+grnum+'&gcauthor='+author+'&gccontent='+content,function(){
						$.get('${root}search/feed','gpnum='+thisnum,function(){
							
						}).done(function(html){
							$('.feed_viewer').replaceWith(html);
							imageLoad(0);
							scrBar();
						});
					});
				}
			}
		});
		
		
	});
</script>
<!-- #팝업 피드 -->
<!-- #텍스트+썸네일 피드 시작 { -->
<input type="hidden" id="pronum" value="${login.pronum }">
<c:choose>
	<c:when test="${feedDetail.gpnum eq 0 }">
		<div class="feed_viewer<c:if test="${feedDetail.mpphoto ne '' }"> half</c:if>">
			<div class="tit box">
				<dl class="feed_inform">
					<dt>
						<a href="${root }user/?pronum${feedDetail.pronum}">
							<input type="hidden" name="pronum" value="${feedDetail.pronum }">
							<input type="hidden" name="mpnum" value="${feedDetail.mpnum }">
							<c:if test="${!empty feedDetail.profile.prophoto }">
								<span class="pf_picture"><img src="${upload }/${feedDetail.profile.prophoto}" alt="${feedDetail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
							</c:if>
							<c:if test="${empty feedDetail.profile.prophoto }">
								<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${feedDetail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
							</c:if>
							<span class="fd_name">${feedDetail.profile.proname }</span>
						</a>
					</dt>
					<dd>
						<span class="fd_date">${feedDetail.date1 }</span>
						<b class="fd_liked">${feedDetail.good }</b>
					</dd>
				</dl>
				<ul class="feed_options">
					<c:if test="${login ne null }">
						<c:forEach items="${goodlist }" var="goodlist">
							<c:if test="${goodlist.mpnum eq feedDetail.mpnum }">
								<li><button class="btn_liked act" onclick="liked($(this))"><em class="snd_only">하트</em></button></li>
							</c:if>
						</c:forEach>
						<c:if test="${login.pronum ne feedDetail.pronum }">
							<li><a href="${root }search/feed/report?mpnum=${feedDetail.mpnum}&profile.pronum=${feedDetail.pronum}&profile.proname=${feedDetail.profile.proname}&profile.proid=${feedDetail.profile.proid}" class="btn_report"><em class="snd_only">신고하기</em></a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
			<div class="text box">
				<div class="scrBar">
					<div class="feed_content">
						<ul class="fd_hashtag">
							<c:choose>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle2 && empty feedDetail.httitle3}">
								</c:when>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle2}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when
									test="${empty feedDetail.httitle2 && empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
								</c:when>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle1}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle2}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
						<p class="fd_content">${feedDetail.mpcontent }</p>
					</div>
					<ul class="comment_list">
						<c:set var="i" value="0" />
						<c:set var="doneLoop" value="false" />
						<c:forEach items="${feedCmmt }" var="feedCmmt">
							<c:if test="${not doneLoop }">
							<li>
								<!-- # 프로필 이미지 없음 { -->
								<a href="${root }user/?pronum=${feedCmmt.pronum}" class="pf_picture">
								<c:if test="${!empty feedCmmt.profile.prophoto }">
									<img src="${upload }/${feedCmmt.profile.prophoto}" alt="${feedCmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
								</c:if>
								<c:if test="${empty feedCmmt.profile.prophoto }">
									<img src="${root }resources/images/thumb/no_profile.png" alt="${feedCmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
								</c:if>
								</a>
								<!-- } # 프로필 이미지 없음 -->
								<p class="cmt_content">
									<a href="${root }user/?pronum=${feedCmmt.pronum}" class="cmt_name" onclick="loginPop()">${feedCmmt.profile.proname }</a>
									${feedCmmt.mccontent }
									<span class="cmt_date">${feedCmmt.mcdate1 }</span>
									<button class="cmt_btn_option"><em class="snd_only">댓글 옵션</em></button>
								</p>
							</li>
								<c:set var="i" value="${i+1 }" />
								<c:if test="${i eq 3 }">
									<c:set var="doneLoop" value="true" />
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
					<c:if test="${feedDetail.mptotal gt 3 }">
						<button class="cmt_btn_more mc" onclick="mored($(this))"><span class="snd_only">1</span>댓글 더 보기</button>
					</c:if>
				</div>
				<c:if test="${login ne null }">
					<form class="message_form">
						<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
						<c:if test="${!empty login.prophoto }">
							<img src="${upload }/${login.prophoto}" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</c:if>
						<c:if test="${empty login.prophoto }">
							<img src="${root }resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</c:if>
						</a>
						<p class="msg_input">
							<input type="text" class="msg_txt" name="mccontent" placeholder="메세지를 입력해주세요" required="required">
							<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
						</p>
					</form>
				</c:if>
			</div>
			<!-- # 썸네일 영역 { -->
			<input type="hidden" value="${feedDetail.mpphoto }">
			<c:if test="${feedDetail.mpphoto ne '' }">
				<!-- # 썸네일 영역 { -->
				<div class="img box">
					<div class="thumb_slide commSlider">
						<div class="swiper-wrapper">
							<c:set var="feedphoto" value="${feedDetail.mpphoto }" />
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
			<!--  } # 썸네일 영역 -->
		</div>
	</c:when>
	<c:otherwise>
		<div class="feed_viewer<c:if test="${feedDetail.gpphoto ne '' }"> half</c:if>">
			<div class="tit box">
				<dl class="feed_inform">
					<dt>
						<a href="${root }user/?pronum${feedDetail.pronum}">
							<input type="hidden" name="pronum" value="${feedDetail.pronum }">
							<input type="hidden" name="gpnum" value="${feedDetail.gpnum }">
							<input type="hidden" name="grnum" value="${feedDetail.grnum }">
							<c:if test="${!empty feedDetail.profile.prophoto }">
								<span class="pf_picture"><img src="${upload }/${feedDetail.profile.prophoto}" alt="${feedDetail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
							</c:if>
							<c:if test="${empty feedDetail.profile.prophoto }">
								<span class="pf_picture"><img src="${root }resources/images/thumb/no_profile.png" alt="${feedDetail.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)"></span>
							</c:if>
							<span class="fd_name">${feedDetail.profile.proname }</span>
						</a>
						<c:if test="${login ne null }">
							<a href="${root }group/?grnum=${feedDetail.grnum}&pronum=${login.pronum}">
								<span class="fd_group">${feedDetail.group.grname }</span>
							</a>
						</c:if>
						<c:if test="${login eq null }">
							<a href="${root }group/?grnum=${feedDetail.grnum}">
								<span class="fd_group">${feedDetail.group.grname }</span>
							</a>
						</c:if>
					</dt>
					<dd>
						<span class="fd_date">${feedDetail.date1 }</span>
						<b class="fd_liked">${feedDetail.good }</b>
					</dd>
				</dl>
				<ul class="feed_options">
					<c:if test="${login ne null }">
						<c:forEach items="${goodlist }" var="goodlist">
							<c:if test="${goodlist.gpnum eq feedDetail.gpnum }">
								<li><button class="btn_liked act" onclick="liked($(this))"><em class="snd_only">하트</em></button></li>
							</c:if>
						</c:forEach>
						<c:if test="${login.pronum ne feedDetail.pronum }">
							<li><a href="${root }search/feed/report?gpnum=${feedDetail.gpnum}&profile.pronum=${feedDetail.pronum}&profile.proname=${feedDetail.profile.proname}&profile.proid=${feedDetail.profile.proid}" class="btn_report"><em class="snd_only">신고하기</em></a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
			<div class="text box">
				<div class="scrBar">
					<div class="feed_content">
						<ul class="fd_hashtag">
							<c:choose>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle2 && empty feedDetail.httitle3}">
								</c:when>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle2}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when
									test="${empty feedDetail.httitle2 && empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
								</c:when>
								<c:when
									test="${empty feedDetail.httitle1 && empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle1}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle2}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty feedDetail.httitle3}">
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${root }search/?keyword=${feedDetail.httitle1}">${feedDetail.httitle1}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle2}">${feedDetail.httitle2}</a></li>
									<li><a href="${root }search/?keyword=${feedDetail.httitle3}">${feedDetail.httitle3}</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
						<p class="fd_content">${feedDetail.gpcontent }</p>
					</div>
					<ul class="comment_list">
						<c:set var="i" value="0" />
						<c:set var="doneLoop" value="false" />
						<c:forEach items="${feedCmmt }" var="feedCmmt">
							<c:if test="${not doneLoop }">
							<li>
								<!-- # 프로필 이미지 없음 { -->
								<a href="${root }user/?pronum=${feedCmmt.pronum}" class="pf_picture">
								<c:if test="${!empty feedCmmt.profile.prophoto }">
									<img src="${upload }/${feedCmmt.profile.prophoto}" alt="${feedCmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
								</c:if>
								<c:if test="${empty feedCmmt.profile.prophoto }">
									<img src="${root }resources/images/thumb/no_profile.png" alt="${feedCmmt.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
								</c:if>
								</a>
								<!-- } # 프로필 이미지 없음 -->
								<p class="cmt_content">
									<a href="${root }user/?pronum=${feedCmmt.pronum}" class="cmt_name" onclick="loginPop()">${feedCmmt.profile.proname }</a>
									${feedCmmt.gccontent }
									<span class="cmt_date">${feedCmmt.gcdate1 }</span>
									<button class="cmt_btn_option"><em class="snd_only">댓글 옵션</em></button>
								</p>
							</li>
								<c:set var="i" value="${i+1 }" />
								<c:if test="${i eq 3 }">
									<c:set var="doneLoop" value="true" />
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
					<c:if test="${feedDetail.gptotal gt 3 }">
						<button class="cmt_btn_more gc" onclick="mored($(this))"><span class="snd_only">1</span>댓글 더 보기</button>
					</c:if>
				</div>
				<c:if test="${login ne null }">
					<form class="message_form">
						<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
						<c:if test="${!empty login.prophoto }">
							<img src="${upload }/${login.prophoto}" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</c:if>
						<c:if test="${empty login.prophoto }">
							<img src="${root }resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</c:if>
						</a>
						<p class="msg_input">
							<input type="text" class="msg_txt" name="gccontent" placeholder="메세지를 입력해주세요" required="required">
							<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
						</p>
					</form>
				</c:if>
			</div>
			<!-- # 썸네일 영역 { -->
			<input type="hidden" value="${feedDetail.gpphoto }">
			<c:if test="${feedDetail.gpphoto ne '' }">
				<!-- # 썸네일 영역 { -->
				<div class="img box">
					<div class="thumb_slide">
						<div class="swiper-wrapper">
							<c:set var="feedphoto" value="${feedDetail.gpphoto }" />
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
			<!--  } # 썸네일 영역 -->
		</div>
	</c:otherwise>
</c:choose>
<!-- } #텍스트+썸네일 피드 끝 -->
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<!-- #댓글 초과팝업 { -->
<div id="excess" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">댓글은 500자 이상 입력할수 없습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- #팝업 처리완료 { -->
<div id="login1" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">로그인이 필요한 서비스입니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
			<li><button type="button" id="btnLogin1" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
</html>