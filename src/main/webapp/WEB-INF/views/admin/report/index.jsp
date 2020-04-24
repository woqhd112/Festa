<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/" var="root"></c:url>
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
			
			var parameter;
			var rlnum;
			var checking;
			//처리버튼 클릭했을시
			$(document).on('click', '.btn_status', function() {
				if($('tbody input[type=checkbox]:checked').length==0){
					openPop('fail');
				}else{
					openPop('status');
				}
				//체킹된 데이터잡아주는곳
				$('tbody input[type=checkbox]:checked').each(function(index){
					rlnum=$(this).parent().find('input[type=hidden]').val();
					$(this).attr('name','reportList['+index+'].rlnum');
					checking=$(this).attr('name');
					if(index==0){
						parameter=checking+"="+rlnum;
					}else if(index>0){
						parameter=parameter+"&"+checking+"="+rlnum
					}
				});
			});
			
			//처리하기버튼 클릭시 데이터처리
			$(document).on('click', '.report_status', function() {
				$.post('${root}admin/report/complate',parameter,function(){
					$('#status').find('.comm_buttons .btn_close').click();
					openPop('success');
					$('.btn_close').click(function(){
						location.reload();
					});
				});
			});
			
			// 셀렉트박스 값이 바뀔때 해당 셀렉트박스 selected
			var check='${paging.search}'
			$('#search').change(function(){
				var page='${paging.page}';
				var search=$('#search').val();
				var category='${paging.category}';
				location.href='${root }admin/report?page='+page+'&category='+category+'&search='+search;
			}); 
			if(check==2){
				$('#search>option').removeProp('selected');
				$('#search>option').eq(2).prop('selected','selected');
				var label = $('#search').siblings('.comm_sel_label');
				var value = $('#search').val();
				label.text(value);
			}else if(check==1){
				$('#search>option').removeProp('selected');
				$('#search>option').eq(1).prop('selected','selected');
				var label = $('#search').siblings('.comm_sel_label');
				var value = $('#search').val();
				label.text(value);
			}else{
				$('#search>option').removeProp('selected');
				$('#search>option').eq(0).prop('selected','selected');
				var label = $('#search').siblings('.comm_sel_label');
				var value = $('#search').val();
				label.text(value);
			}
			
			//전체선택 체크박스 눌렀을때 처리완료 활성화or비활성화 처리
			$('#allChecked').change(function(){
				$('.btn_status').attr('disabled',false);
				$('.btn_status').removeClass('sbm');
				$('tbody input[type=checkbox]:checked').each(function(index){
					if($('tbody input[type=checkbox]:checked').parent('.tb_chk').parent('tr').find('a').hasClass('cnc')){
						$('.btn_status').attr('disabled',true);
						$('.btn_status').addClass('sbm');
					}else{
						$('.btn_status').attr('disabled',false);
						$('.btn_status').removeClass('sbm');
					}
				});
			});
			
			//해당 체크박스 눌렀을때 처리완료 활성화or비활성화 처리
			$('tbody input[type=checkbox]').change(function(){
				$('.btn_status').attr('disabled',false);
				$('.btn_status').removeClass('sbm');
				$('tbody input[type=checkbox]:checked').each(function(index){
					if($('tbody input[type=checkbox]:checked').parent('.tb_chk').parent('tr').find('a').hasClass('cnc')){
						$('.btn_status').attr('disabled',true);
						$('.btn_status').addClass('sbm');
					}else{
						$('.btn_status').attr('disabled',false);
						$('.btn_status').removeClass('sbm');
					}
				});
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
					<a href="${root }"><em class="snd_only">FESTA</em></a>
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
					<li><a href="${root }admin/venture">사업자 계정 관리</a></li>
					<li><a href="${root }admin/report" class="act">신고 관리</a></li>
				</ul>
			</section>
			<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">신고 관리</h2>
				<div class="table_options">
					<ul class="sub_nav">
						<c:if test="${paging.category eq '' or paging.category eq '전체' }">
							<li><a href="${root }admin/report?page=1" class="act">전체</a></li>
							<li><a href="${root }admin/report?page=1&category=그룹">그룹</a></li>
							<li><a href="${root }admin/report?page=1&category=캠핑장">캠핑장</a></li>
							<li><a href="${root }admin/report?page=1&category=피드">피드</a></li>
						</c:if>
						<c:if test="${paging.category eq '그룹' }">
							<li><a href="${root }admin/report?page=1">전체</a></li>
							<li><a href="${root }admin/report?page=1&category=그룹" class="act">그룹</a></li>
							<li><a href="${root }admin/report?page=1&category=캠핑장">캠핑장</a></li>
							<li><a href="${root }admin/report?page=1&category=피드">피드</a></li>
						</c:if>
						<c:if test="${paging.category eq '캠핑장' }">
							<li><a href="${root }admin/report?page=1">전체</a></li>
							<li><a href="${root }admin/report?page=1&category=그룹">그룹</a></li>
							<li><a href="${root }admin/report?page=1&category=캠핑장" class="act">캠핑장</a></li>
							<li><a href="${root }admin/report?page=1&category=피드">피드</a></li>
						</c:if>
						<c:if test="${paging.category eq '피드' }">
							<li><a href="${root }admin/report?page=1">전체</a></li>
							<li><a href="${root }admin/report?page=1&category=그룹">그룹</a></li>
							<li><a href="${root }admin/report?page=1&category=캠핑장">캠핑장</a></li>
							<li><a href="${root }admin/report?page=1&category=피드" class="act">피드</a></li>
						</c:if>
					</ul>
					<div class="sort_select">
						<select class="comm_sel" id="search" name="search">
							<option value="전체">전체</option>
							<option value="접수">접수</option>
							<option value="처리완료">처리완료</option>
						</select>
						<p class="comm_sel_label">전체</p>
					</div>
				</div>
				<form class="set_form">
					<table class="adm rp_table one">
						<caption class="snd_only">신고 목록</caption>
						<thead>
							<tr>
								<th class="tb_chk">
									<input type="checkbox" class="comm_chk" name="allChecked" id="allChecked">
									<label for="allChecked"><em class="snd_only">전체선택</em></label>
								</th>
								<th class="w60">No</th>
								<th class="w110">분류</th>
								<th class="w110">신고자</th>
								<th class="w110">신고대상</th>
								<th class="w120">접수일</th>
								<th class="w100">상태</th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="10"/>
						<c:choose>
							<c:when test="${paging.totalCount ne 0 }">
								<c:forEach items="${reportlist }" var="reportlist">
									<tr>
										<td class="tb_chk">
											<input type="hidden" value="${reportlist.rlnum }">
											<input type="checkbox" class="comm_chk" name="" id="festaTbl${i }">
											<label for="festaTbl${i }"><em class="snd_only">선택</em></label>
										</td>
										<td>${reportlist.rlrn }</td>
										<c:choose>
											<c:when test="${reportlist.rlcategory eq '내피드' or reportlist.rlcategory eq '그룹피드' or reportlist.rlcategory eq '공지피드' }">
												<td>피드</td>
											</c:when>
											<c:otherwise>
												<td>${reportlist.rlcategory }</td>
											</c:otherwise>
										</c:choose>
										<td>${reportlist.rlreporter }</td>
										<td>${reportlist.rltarget }</td>
										<td>${reportlist.rldate }</td>		
										<c:if test="${reportlist.rlstatus eq 2 }">
											<td>
												<a class="comm_btn btn_pop cnc" href="${root }admin/report/detail?rlnum=${reportlist.rlnum}">처리 완료</a>
											</td>
										</c:if>				
										<c:if test="${reportlist.rlstatus eq 1 }">
											<td>
												<a class="comm_btn btn_pop" href="${root }admin/report/detail?rlnum=${reportlist.rlnum}">접수</a>
											</td>
										</c:if>		
									</tr>
									<c:set var="i" value="${i-1 }"/>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="7" class="fstEmpty">접수된 신고가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
					<div class="table_options">
						<ul class="comm_buttons_s">
							<li><button type="button" class="comm_btn btn_status">처리 완료</button></li>
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
									<li><a class="pg_start" href="${root }admin/report?page=${paging.beginPage}&category=${paging.category}&search=${paging.search}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<c:if test="${paging.beginPage ne 1 }">
									<li><a class="pg_start" href="${root }admin/report?page=${paging.beginPage-1}&category=${paging.category}&search=${paging.search}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<li><a class="pg_prev" href="${root }admin/report?page=${paging.page-1}&category=${paging.category}&search=${paging.search}"><em class="snd_only">이전 페이지</em></a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${paging.beginPage }" varStatus="status"  end="${paging.endPage }">
							<c:choose>
								<c:when test="${paging.page == status.index}">
								<li><b>${status.index }</b></li>
								</c:when>
								<c:otherwise>
								<li><a href="${root }admin/report?page=${status.index}&category=${paging.category}&search=${paging.search}">${status.index }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${paging.next eq true }">
								<li><a class="pg_next" href="${root }admin/report?page=${paging.page+1}&category=${paging.category}&search=${paging.search}"><em class="snd_only">다음 페이지</em></a></li>
								<c:if test="${paging.totalPage eq paging.endPage }">
									<li><a class="pg_end" href="${root }admin/report?page=${paging.endPage}&category=${paging.category}&search=${paging.search}"><em class="snd_only">맨 끝으로</em></a></li>
								</c:if>
								<c:if test="${paging.totalPage ne paging.endPage }">
									<li><a class="pg_end" href="${root }admin/report?page=${paging.endPage+1}&category=${paging.category}&search=${paging.search}"><em class="snd_only">맨 끝으로</em></a></li>
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
<div id="status" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">선택하신 신고를 처리하시겠습니까?</h4>
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" class="comm_btn cfm report_status">처리하기</button></li>
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
<!-- } #팝업 처리완료 -->
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