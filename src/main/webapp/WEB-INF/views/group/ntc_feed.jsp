<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:url value="/resources/upload" var="upload"></c:url>
<c:url value="/" var="root" />
<!doctype html>
<!-- #팝업 피드 -->
<!-- #텍스트+썸네일 피드 시작 { -->
<script type="text/javascript">
	$(document).ready(function(){
		//댓글입력 버튼
		$('.message_form').on('submit', function(e) {

			var gnctest=$('#ntcaddmsg').val().length;
			if(gnctest>=500){
				openPop("ntccmmtfull");
				$('#ntccmmtfailed').on('click', function(){
					$('#ntcaddmsg').focus();					
				});
				return false;
			};
			
			e.preventDefault();	
			$.ajax({
		        type: 'post',
		        url: '${root}group/ntc_feed/cmmtadd',
		        data: {
		        	"gnccontent": $('#ntcaddmsg').val(),
		        	"gncauthor": $('#ntcaddName').val(),
		        	"gnnum": $('#ntcaddGn').val(),
		        	"pronum": $('#ntcaddPro').val(),
		        	"grnum": $('#ntcaddGr').val(),
		        },
		        success : function(data) {
	    			$.ajax({
	    			      url: "${root}group/ntc_feed?gnnum=${ntcDetail.gnnum}&grnum=${ntcDetail.grnum}",   
	    			      cache: false   
	    			}).done(function(html) {
	    			      $("#feed_viewerntc").replaceWith(html);
	    			      scrBar();
	    			      imageLoad(0);
	    			});  
		        }
		    });
		});

		//댓글삭제 버튼 클릭
		$(document).on('click', '.btn_delete.btn_pop.ntccmmtdel', function() {
			var gncnum = $(this).data('value');
			$('#ntccmtnum').val(gncnum);
		});
		
		//댓글삭제 버튼 클릭>확인시
		$('#delcmmt').on('click', function(){
			//ajax로 댓글삭제 전송
			$.ajax({
		        type: 'post',
		        url: '${root}group/ntc_feed/cmmtdel',
		        data: {
		        	"gncnum": $('#ntccmtnum').val()
		        },
		        //성공시 데이터 받음
		        success : function(data) {
	    			$.ajax({   
	    			    url: "${root}group/ntc_feed?gnnum=${ntcDetail.gnnum}&grnum=${ntcDetail.grnum}",   
	    			    cache: false
	    			}).done(function(html) {
	    				//현재 div에 받은 데이터 html 덮어씌우기
	    				openPop("ntcok");
    					$("#feed_viewerntc").replaceWith(html);   
	    			    scrBar();
	    			});
		        }
		    });
		});
		
		//공지삭제 버튼 클릭
		$('#deletentcfeed').on('click', function(){
			var gnnum = $(this).data('value');
			$('#ntcfenum').val(gnnum);
		});
		
		//공지삭제 버튼 클릭>확인시
		$('#delfeed').on('click', function(){
			$.ajax({
				type: 'post',
				url: '${root}group/ntc_feed/del',
				data: {
					"gnnum": $('#ntcfenum').val()
				},
				success: function(data){
					$.ajax({
						url:"${root}group/?grnum=${detail.grnum}&pronum=${login.pronum}"
					}).done(function(html){
						openPop("ntcokk");
					});
				}
			});
		});
		
		$('#delend2').on('click', function(){
			window.location.reload();
		});
		
		//댓글 더보기
		$(document).on('click', '.cmt_btn_more.ndt', function() {
			var btn = $(this);
			var pageTag = $(this).find('span');
			var myPage = pageTag.text();
			myPage++;
			pageTag.text(myPage);
			var feed = btn.parents('.feed_viewer');
			var comments = btn.siblings('.comment_list');
			var gnnum = feed.find('#cmmtGnnum').val();
			var del=$('#ntcaddPro').val();
			var del2=$('#del2').val();
			$.get('${root}group/ntc_feed/ntccmmt','gnnum='+gnnum+'&pageSearch.page4='+myPage,function(data){
				$(data).each(function(index){
					if(index==3){
						return false;
					}else if(data.length<4){
						btn.hide();
					}
					if(del==data[index].pronum || del==del2){
						comments.append('<li>'+
								'<a href="" class="pf_picture">'+
									'<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].gncauthor+'님의 프로필 썸네일"  onload="squareTrim($(this), 30)" >'+
								'</a><p class="cmt_content">'+
									'<a href="" class="cmt_name">'+data[index].gncauthor+'</a>&nbsp;&nbsp;'+data[index].gnccontent+
									'<span class="cmt_date">'+data[index].gncdate1+'</span>'+
									'<button class="btn_pop btn_delete btn_cmmt ntccmmtdel" data-layer="delete" data-value="'+data[index].gncnum+'"><em class="snd_only">삭제하기</em></button></p>'+
							'</li>');
					} else{
						comments.append('<li>'+
								'<a href="" class="pf_picture">'+
									'<img src="${upload}/'+data[index].profile.prophoto+'" alt="'+data[index].gncauthor+'님의 프로필 썸네일"  onload="squareTrim($(this), 30)" >'+
								'</a><p class="cmt_content">'+
									'<a href="" class="cmt_name">'+data[index].gncauthor+'</a>&nbsp;&nbsp;'+data[index].gnccontent+
									'<span class="cmt_date">'+data[index].gncdate1+'</span></li>'
									);
					}
				});//each문 end  
			});//ajax통신 end
		});//댓글더보기 end
		
		/*
		//공지사항 수정
		$('#ntcupdate_feed').on('submit', function(e){
			e.preventDefault();
			var gnccontent=$('#gpcontent1').val();
			console.log('??');
			if(gnccontent == '' || gnccontent == null){
				console.log('!!	');
				console.log(gnccontent);
				return false;
			}
			var files = new FormData($('#ntcupdate_feed')[0]);
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: '${root}group/ntc_maker',
				data: files,
				processData: false,
				contentType: false,
				cache: false,
		        success : function(data) {
	    			$.ajax({   
	    			      url: "${root}group/ntc_feed?gnnum=${ntcDetail.gnnum}&grnum=${ntcDetail.grnum}",   
	    			      cache: false   
	    			}).done(function(html) {
	    				$('#ntcmaker').bPopup().close();
	    				openPop('updateOk');
	    				$('#finish_update').on('click', function(){
	    					var content = $(html).children()[0];
	    					var edit = $(html).children()[1];
		    			    $('#feed_viewerntc').replaceWith(content);
		    			    console.log(edit);
		    			    $('#ntcmaker').replaceWith(edit);
		    			    imageLoad(150);
		    			    scrBar('.fstPop .scrBar');
	    				});
	    			});  
		        },
				error: function (e) { 
					openPop('fail');
				}
			});
		});
		*/
		
	});
	function popup(button) {
		var url = button.data('layer');
		openLayer('none', url);
	}
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/" var="root" />

<div id="ntcframe">
	<div class="feed_viewer<c:if test="${!empty ntcDetail.gnphoto}"> half</c:if>" id="feed_viewerntc">
		<div class="tit box">
			<dl class="feed_inform">
				<dt>
					<a href="" style="cursor: default; ">
						<input type="hidden" id="ntcaddName" value="${login.proname}" />
						<input type="hidden" id="ntcaddPro" value="${login.pronum}" />
						<input type="hidden" id="ntcaddGr" value="${ntcDetail.grnum}">
						<input type="hidden" id="ntcaddGn" value="${ntcDetail.gnnum}">
						<span class="pf_picture">
						<c:choose>
							<c:when test="${ntcDetail.profile.prophoto eq null }">
								<img src="${root}resources/images/thumb/no_profile.png" alt="${ntcDetail.gnauthor}님의 프로필 썸네일"  onload="squareTrim($(this), 60)">
							</c:when>
							<c:otherwise>
								<img src="${upload }/${ntcDetail.profile.prophoto}" alt="${ntcDetail.gnauthor}님의 프로필 썸네일"  onload="squareTrim($(this), 60)">
							</c:otherwise>
						</c:choose>
						</span>
						<span class="fd_name">[그룹장] ${ntcDetail.gnauthor}</span>
					</a>
					<a href="" style="cursor: default;">
						<span class="fd_group">${detail.grname } 공지사항</span>
					</a>
				</dt>
				<dd>
					<span class="fd_date">${ntcDetail.gndate1 }</span>
				</dd>
			</dl>
			<ul class="feed_options">
				<c:if test="${login.pronum ne detail.pronum }">
					<li><button type="button" class="btn_report ntc" data-layer="${root }group/ntc_report?gnnum=${ntcDetail.gnnum}&profile.pronum=${detail.profile.pronum}&profile.proname=${detail.profile.proname}&profile.proid=${detail.profile.proid}" onclick="popup($(this))"><em class="snd_only">신고하기</em></button></li>
				</c:if>
				<c:if test="${login.pronum eq detail.pronum}">
					<li><button type="button" class="btn_edit ntc" id="editntcfeed" data-layer="${root }group/ntc_maker?gnnum=${ntcDetail.gnnum}" onclick="popup($(this))"><em class="snd_only">수정하기</em></button></li>		
					<li><button class="btn_delete btn_pop ntc" id="deletentcfeed" data-layer="deletentcfe" data-value="${ntcDetail.gnnum }"><em class="snd_only">삭제하기</em></button></li>
				</c:if>
			</ul>
		</div>
		<div class="text box ntc">
			<div class="scrBar">
				<div class="feed_content">
					<pre class="fd_content">${ntcDetail.gncontent }</pre>
				</div>
				<ul class="comment_list ntc">
					<c:set var="i" value="0" />
					<c:set var="doneLoop" value="false" />
					<c:forEach items="${ntcCmmt }" var="ntcCmmt">
						<input type="hidden" id="del2" value="${detail.pronum }" />
						<input type="hidden" id="cmmtGnnum" value="${ntcCmmt.gnnum}" />
						<input type="hidden" id="cmmtGncnum" value="${ntcCmmt.gncnum}" />
						<c:if test="${ntcDetail.gnnum eq ntcCmmt.gnnum}">
							<c:if test="${not doneLoop }">
								<li>
									<c:choose>
										<c:when test="${ntcCmmt.profile.prophoto eq null }">
											<a href="${root }user/?pronum=${ntcCmmt.pronum}" class="pf_picture">
												<img src="${root}resources/images/thumb/no_profile.png" alt="${ntcCmmt.gncauthor }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
											</a>
										</c:when>
										<c:otherwise>
											<a href="${root }user/?pronum=${ntcCmmt.pronum}" class="pf_picture">
												<img src="${upload }/${ntcCmmt.profile.prophoto}" alt="${ntcCmmt.gncauthor }님의 프로필 썸네일" onload="squareTrim($(this), 30)">
											</a>
										</c:otherwise>
									</c:choose>
									<p class="cmt_content">
										<a href="${root }user/?pronum=${ntcCmmt.pronum}" class="cmt_name">${ntcCmmt.gncauthor }</a>&nbsp;&nbsp;${ntcCmmt.gnccontent }
										<span class="cmt_date">${ntcCmmt.gncdate1 }</span>
										<c:if test="${(login.pronum eq ntcCmmt.pronum) or (login.pronum eq detail.pronum)}">
											<button class="btn_delete btn_pop ntccmmtdel" data-layer="deletentc" data-value="${ntcCmmt.gncnum }"><em class="snd_only">삭제하기</em></button>
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
				<c:if test="${ntcDetail.gntotal gt 3 }">
					<button class="cmt_btn_more ndt"><span class="snd_only">1</span>댓글 더 보기</button>
				</c:if>
			</div>
			<form class="message_form" action="" method="post">
				<c:choose>
					<c:when test="${login.prophoto eq null}">
						<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
							<img src="${root}resources/images/thumb/no_profile.png" alt="${login.proname } 님의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</a>
					</c:when>
					<c:otherwise>
						<a class="pf_picture" href="${root }user/?pronum=${login.pronum}">
							<img src="${upload }/${login.prophoto }" alt="${login.proname } 님의 프로필 썸네일" onload="squareTrim($(this), 30)">
						</a>
					</c:otherwise>
				</c:choose>
				<p class="msg_input">
					<input type="text" class="msg_txt" id="ntcaddmsg" name="ntcaddmsg" placeholder="메세지를 입력해주세요" required="required">
					<button type="submit" class="btn_send ntccmmt"><em class="snd_only">전송</em></button>
				</p>
			</form>
		</div>
			<c:if test="${ntcDetail.gnphoto ne '' }">
				<!-- # 썸네일 영역 { -->
				<div class="img box">
					<div class="thumb_slide">
						<div class="swiper-wrapper">
							<c:set var="gnphoto" value="${ntcDetail.gnphoto }" />
							<c:forTokens items="${gnphoto }" delims="," var="items">
								<div class="swiper-slide">
									<img src="${upload }/${items }" alt="">
								</div>
							</c:forTokens>
						</div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
			</c:if>
		<!--  } # 썸네일 영역 -->
	</div>
</div>

<button type="button" id="ntcclosed" class="btn_close"><em class="snd_only">창 닫기</em></button>

	<div id="deletentc" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">댓글을 삭제하시겠습니까?</h3>
			<input type="hidden" id="ntccmtnum" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" id="clocmmt" class="btn_close comm_btn cnc cmmt">취소</button></li>
					<li><button type="button" id="delcmmt" class="btn_close comm_btn cfm">확인</button></li>	<!--  data-layer="ntcok" -->
				</ul>
			</div>
		</div>
	</div>
	
	<div id="deletentcfe" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">피드를 삭제하시겠습니까?</h3>
			<input type="hidden" id="ntcfenum" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" id="clofeed" class="btn_close comm_btn cnc feed">취소</button></li>
					<li><button type="button" id="delfeed" class="btn_close comm_btn cfm ntc">확인</button></li>
				</ul>
			</div>
		</div>
	</div>
	
		<!-- #팝업 처리완료 { -->
	<div id="ntcok" class="fstPop">
		<div class="confirm_wrap pop_wrap"> 
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="delend" class="btn_close ok comm_btn cfm ntc">확인</button></li>
			</ul>
		</div>
	</div>
	
		<!-- #팝업 처리완료 { -->
	<div id="ntcokk" class="fstPop">
		<div class="confirm_wrap pop_wrap"> 
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="delend2" class="btn_close ok comm_btn cfm ntc">확인</button></li>
			</ul>
		</div>
	</div>
	
	
	<!-- #댓글 초과 -->
	<div id="ntccmmtfull" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">댓글은 500자 이상 입력할 수 없습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="ntccmmtfailed" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
<script type="text/javascript">
	btnToggle('btn_liked');
</script>