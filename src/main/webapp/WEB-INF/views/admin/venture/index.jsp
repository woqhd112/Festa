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
			
			// 셀렉트박스 값이 바뀔때 해당 셀렉트박스 selected
			var check='${paging.category}';
			if(check=='캠핑장명'){
				$('#category>option').removeProp('selected');
				$('#category>option').eq(0).prop('selected','selected');
				var label = $('#category').siblings('.comm_sel_label');
				var value = $('#category').val();
				label.text(value);
			}else{
				$('#category>option').removeProp('selected');
				$('#category>option').eq(1).prop('selected','selected');
				var label = $('#category').siblings('.comm_sel_label');
				var value = $('#category').val();
				label.text(value);
			} 
			
			var parameter;
			var mvnum;
			var pronum;
			var checking;
			//삭제버튼 클릭했을시
			$(document).on('click', '.btn_del', function() {
				if($('tbody input[type=checkbox]:checked').length==0){
					openPop('fail');
				}else{
					openPop('delete');
				}
				//체킹된 데이터잡아주는곳
				$('tbody input[type=checkbox]:checked').each(function(index){
					mvnum=$(this).parent().find('input[type=hidden]').eq(0).val();
					pronum=$(this).parent().find('input[type=hidden]').eq(1).val();
					$(this).attr('name','ventureList['+index+']');
					checking=$(this).attr('name');
					if(index==0){
						parameter=checking+".mvnum="+mvnum+"&"+checking+".pronum="+pronum;
					}else if(index>0){
						parameter=parameter+"&"+checking+".mvnum="+mvnum+"&"+checking+".pronum="+pronum;
					}
				});
				console.log(parameter);
			});
			
			//삭제하기버튼 클릭시 데이터삭제
			$(document).on('click', '.venture_delete', function() {
				$.post('${root}admin/venture/out',parameter,function(){
					$('#delete').find('.comm_buttons .btn_close').click();
					openPop('success');
					$('.btn_close').click(function(){
						location.reload();
					});
				});
			});
			
			//사업자번호 클릭시 이미지 넣기
			$('.venture_img').on('click',function(){
				var mvphoto = $(this).data('value');
				console.log(mvphoto);
				$('#ventureImage>.confirm_wrap img').attr('src','${upload}/'+mvphoto);
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
<div id="wrap">
	<div id="header">
		<div class="scrX">
			<div class="container">
				<h1>
					<a href="${root }admin/"><em class="snd_only">FESTA</em></a>
				</h1>
				<ul id="gnb">
					<li><a href="${root }admin/"><b>관리자</b></a></li>
					<li><a href="${root }member/logout" class="btn_pop">로그아웃</a></li>
				</ul>
				<button type="button" id="btnTop"><em class="snd_only">맨 위로</em></button>
			</div>
		</div>
	</div>
	<!-- #관리자 -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="setting_wrap">
		<!-- 관리자 상단배너 시작 { -->
		<section class="banner_area">
			<div class="container">
				<dl>
					<dt><span>관리자페이지 이용 시 주의사항</span></dt>
					<dd>회원 징계 시 다시 한번 확인하고 처리할 것 / 모든 삭제 기능 처리 시 신중하게 처리할 것</dd>
				</dl>
			</div>
		</section>
		<!-- } 관리자 상단배너 끝 -->
			<div class="container">
			<!-- 좌측 사이드메뉴 시작 { -->
			<section class="side_area">
				<ul class="lnb_list">
					<li><a href="${root }admin/">관리자 홈</a></li>
					<li><a href="${root }admin/user">회원 관리</a></li>
					<li><a href="${root }admin/group">그룹 관리</a></li>
					<li><a href="${root }admin/camp">캠핑장 관리</a></li>
					<li>
						<a href="${root }admin/venture/" class="act">사업자 계정 관리</a>
						<ul>
							<li><a href="${root }admin/venture" class="act">사업자계정 관리</a></li>
							<li><a href="${root }admin/venture/req">사업자계정 신청 조회</a></li>
						</ul>
					</li>
					<li><a href="${root }admin/report">신고 관리</a></li>
				</ul>
			</section>
			<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">사업자계정 관리</h2>
				<div class="table_options">
					<form class="search_form">
						<select class="comm_sel" id="category" name="category">
							<option value="캠핑장명">캠핑장명</option>
							<option value="사업자등록번호">사업자등록번호</option>
						</select>
						<p class="comm_sel_label">캠핑장명</p>
						<input type="text" id="keyword" name="keyword" value="${paging.keyword }" placeholder="검색어를 입력해주세요">
						<button type="submit"><i class="xi-search"></i></button>
					</form>
				</div>
				<form class="set_form">
					<table class="adm vt_table one">
						<caption class="snd_only">사업자계정 목록</caption>
						<thead>
							<tr>
								<th class="tb_chk">
									<input type="checkbox" class="comm_chk" name="allChecked" id="allChecked">
									<label for="allChecked"><em class="snd_only">전체선택</em></label>
								</th>
								<th class="w60">No</th>
								<th class="w120">사업자 등록번호</th>
								<th>캠핑장명</th>
								<th class="w100">대표자</th>
								<th class="w120">등록일</th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="10"/>
						<c:choose>
							<c:when test="${paging.totalCount ne 0 }">
								<c:forEach items="${venture }" var="venture">
									<tr>
										<td class="tb_chk">
											<input type="hidden" name="mvnum" value="${venture.mvnum }">
											<input type="hidden" name="pronum" value="${venture.pronum }">
											<input type="checkbox" class="comm_chk" name="" id="festaTbl${i }">
											<label for="festaTbl${i }"><em class="snd_only">선택</em></label>
										</td>
										<td>${venture.mvrn }</td>
										<td><button type="button" class="btn_pop venture_img" data-layer="ventureImage" data-value="${venture.mvphoto }">${venture.mvnumber }</button></td>
										<td>
											<p>
												<c:if test="${venture.camp ne null }">
													<a href="${root }admin/camp/detail?canum=${venture.camp.canum}" target="_blank">${venture.mvname }</a>
												</c:if>
												<c:if test="${venture.camp eq null }">
													${venture.mvname }
												</c:if>
											</p>
										</td>
										<td>${venture.proname }</td>
										<td>${venture.mvdate }</td>
									</tr>
									<c:set var="i" value="${i-1 }"/>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="fstEmpty">검색한 결과가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
					<div class="table_options">
						<ul class="comm_buttons_s">
							<li><button type="button" class="comm_btn btn_pop btn_del">삭제</button></li>
						</ul>
					</div>
				</form>
				<div class="fstPage">
					<ul>
						<c:if test="${paging.totalCount ne 0 }">
						<c:choose>
							<c:when test="${paging.page eq 1 }">
								<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>
								<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>
							</c:when>
							<c:otherwise>
								<c:if test="${paging.beginPage eq 1 }">
									<li><a class="pg_start" href="${root }admin/venture?page=${paging.beginPage}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<c:if test="${paging.beginPage ne 1 }">
									<li><a class="pg_start" href="${root }admin/venture?page=${paging.beginPage-1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<li><a class="pg_prev" href="${root }admin/venture?page=${paging.page-1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">이전 페이지</em></a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${paging.beginPage }" varStatus="status"  end="${paging.endPage }">
							<c:choose>
								<c:when test="${paging.page == status.index}">
								<li><b>${status.index }</b></li>
								</c:when>
								<c:otherwise>
								<li><a href="${root }admin/venture?page=${status.index}&keyword=${paging.keyword}&category=${paging.category}">${status.index }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${paging.next eq true }">
								<li><a class="pg_next" href="${root }admin/venture?page=${paging.page+1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">다음 페이지</em></a></li>
								<c:if test="${paging.totalPage eq paging.endPage }">
									<li><a class="pg_end" href="${root }admin/venture?page=${paging.endPage}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 끝으로</em></a></li>
								</c:if>
								<c:if test="${paging.totalPage ne paging.endPage }">
									<li><a class="pg_end" href="${root }admin/venture?page=${paging.endPage+1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 끝으로</em></a></li>
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
<!-- #팝업 삭제하기 { -->
<div id="delete" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 사업자 계정을 삭제하시겠습니까?</h4>
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" class="comm_btn cfm venture_delete">삭제하기</button></li>
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
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- #사업자등록증 { -->
<div id="ventureImage" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">사업자등록증 사진</p>
		<div class="scrBar">
			<img>
		</div>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
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
<!-- } #팝업 체크된값없음 -->
<!-- } #팝업 처리완료 -->
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