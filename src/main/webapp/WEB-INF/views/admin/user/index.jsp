<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			
			// 셀렉트박스 값이 바뀔때 통신
			var check='${paging.category}';
			console.log(check);
			$('#select').change(function(){
				var selected=$('#select').val();
				var keyword=$('#keyword').val();
				var category=$('#select').val();
				location.href='${root }admin/user?page2=1&keyword='+keyword+'&category='+category;
			}); 
			if(check=='정지 중'){
				$('#select>option').removeProp('selected');
				$('#select>option').eq(1).prop('selected','selected');
				var label = $('#select').siblings('.comm_sel_label');
				var value = $('#select').val();
				label.text(value);
			}else{
				$('#select>option').removeProp('selected');
				$('#select>option').eq(0).prop('selected','selected');
				var label = $('#select').siblings('.comm_sel_label');
				var value = $('#select').val();
				label.text(value);
			}
			
			//정지버튼눌렀을때 팝업에 pronum값 전달
			$('.btn_stop').click(function(){
			   var value = $(this).data('value');
			   $('#pronum').val(value);
			});
			
			//추방버튼눌렀을때 팝업에 pronum값 전달
			$('.btn_kick').click(function(){
				var value = $(this).data('value');
			    $('#pronum1').val(value);
			});
			
			var stoplv;
			var stopresult;
			var pronum;
			
			//정지하기 버튼눌렀을때 처리
			$('#stopbtn').on('click',function(){
				if($('input[type=radio]:checked').val()==undefined){
					openPop('choice');
				}else if($('#stopresult').val()==''){
					openPop('fail');
				}else{
					stoplv=$('input[type=radio]:checked').val();
					stopresult=$('#stopresult').val();
					pronum=$('#pronum').val();
					$.post('${root}admin/user/stop','pronum='+pronum+'&stopresult='+stopresult+'&stoplv='+stoplv,function(){
						$('#stop').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close').click(function(){
							location.reload();
						});
						
					});					
				}
			});
			
			//추방하기 버튼눌렀을때 처리
			$('#kickbtn').on('click',function(){
				if($('#kickresult').val()==''){
					openPop('fail');
				}else{
					stopresult=$('#kickresult').val();
					pronum=$('#pronum1').val();
					$.post('${root}admin/user/kick','pronum='+pronum+'&stopresult='+stopresult,function(){
						$('#kick').find('.comm_buttons .btn_close').click();
						openPop('success');
						$('.btn_close').click(function(){
							location.reload();
						});
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
					<li><a href="${root }admin/user" class="act">회원 관리</a></li>
					<li><a href="${root }admin/group">그룹 관리</a></li>
					<li><a href="${root }admin/camp">캠핑장 관리</a></li>
					<li><a href="${root }admin/venture">사업자 계정 관리</a></li>
					<li><a href="${root }admin/report">신고 관리</a></li>
				</ul>
			</section>
			<!-- } 좌측 사이드메뉴 시작 -->
			<!-- 컨텐츠영역 시작 { -->
			<section class="content_area">
				<h2 class="set_tit">회원 관리</h2>
				<div class="table_options">
					<form class="search_form">
						<input type="text" id="keyword" name="keyword" value="${paging.keyword }" placeholder="이름을 입력해주세요">
						<button type="submit"><i class="xi-search"></i></button>
					</form>
					<div class="sort_select">
						<select class="comm_sel" id="select" name="category">
							<option value="전체">전체</option>
							<option value="정지 중">정지 중</option>
						</select>
						<p class="comm_sel_label">전체</p>
					</div>
				</div>
				<form class="set_form">
					<table class="adm us_table two">
						<caption class="snd_only">회원 목록</caption>
						<thead>
							<tr>
								<th class="w60" rowspan="2">No</th>
								<th>이름</th>
								<th class="w120">생년월일</th>
								<th class="w120">성별</th>
								<th class="w100">정지 횟수</th>
								<th class="w100" rowspan="2">관리</th>
							</tr>
							<tr>
								<th>아이디</th>
								<th>관심지역</th>
								<th>직종</th>
								<th>신고 횟수</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${paging.totalCount ne 0 }">
						<c:forEach items="${userlist }" varStatus="status" var="userlist">
							<tr>
								<td rowspan="2">${userlist.prorn }</td>
								<td>
									<p>
										<a href="${root }admin/user/detail?pronum=${userlist.pronum}" target="_blank">${userlist.proname }</a>
										<input type="hidden" class="pronum" name="pronum" value="${userlist.pronum }">
									</p>
								</td>
								<td>${userlist.proidnum }</td>
								<td>${userlist.projender }</td>
								<td>${userlist.myAdmin.stoptotal }</td>
								<td rowspan="2">
									<ul class="comm_buttons_s">
										<c:choose>
											<c:when test="${userlist.myAdmin.stoplv eq 0 }">
												<li><button type="button" class="comm_btn btn_pop btn_stop" data-layer="stop" data-value="${userlist.pronum }">정지</button></li>
											</c:when>
											<c:otherwise>
												<li><button type="button" class="comm_btn sbm">정지 중</button></li>
											</c:otherwise>
										</c:choose>
										<li><button type="button" class="comm_btn btn_pop btn_kick" data-layer="kick" data-value="${userlist.pronum }">추방</button></li>
									</ul>
								</td>
							</tr>
							<tr>
								<td><p>${userlist.proid }</p></td>
								<td>${userlist.proaddr }</td>
								<td>${userlist.projob }</td>
								<td>${userlist.myAdmin.reporttotal }</td>
							</tr>
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
				</form>
				<div class="fstPage">
					<ul>
					<c:if test="${paging.totalCount ne 0 }">
						<c:choose>
							<c:when test="${paging.page2 eq 1 }">
								<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>
								<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>
							</c:when>
							<c:otherwise>
								<c:if test="${paging.beginPage eq 1 }">
									<li><a class="pg_start" href="${root }admin/user?page2=${paging.beginPage}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<c:if test="${paging.beginPage ne 1 }">
									<li><a class="pg_start" href="${root }admin/user?page2=${paging.beginPage-1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 앞으로</em></a></li>
								</c:if>
								<li><a class="pg_prev" href="${root }admin/user?page2=${paging.page2-1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">이전 페이지</em></a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${paging.beginPage }" varStatus="status"  end="${paging.endPage }">
							<c:choose>
								<c:when test="${paging.page2 == status.index}">
								<li><b>${status.index }</b></li>
								</c:when>
								<c:otherwise>
								<li><a href="${root }admin/user?page2=${status.index}&keyword=${paging.keyword}&category=${paging.category}">${status.index }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${paging.next eq true }">
								<li><a class="pg_next" href="${root }admin/user?page2=${paging.page2+1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">다음 페이지</em></a></li>
								<c:if test="${paging.totalPage eq paging.endPage }">
									<li><a class="pg_end" href="${root }admin/user?page2=${paging.endPage}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 끝으로</em></a></li>
								</c:if>
								<c:if test="${paging.totalPage ne paging.endPage }">
									<li><a class="pg_end" href="${root }admin/user?page2=${paging.endPage+1}&keyword=${paging.keyword}&category=${paging.category}"><em class="snd_only">맨 끝으로</em></a></li>
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
<!-- #팝업 정지하기 { -->
<div id="stop" class="fstPop">
	<div class="stop_wrap pop_wrap">
		<h4 class="pop_tit">해당 회원의 페스타 이용을 정지하시겠습니까?</h4>
		<form>
			<dl class="rdo_list">
				<dt>
					정지 기간
					<input type="hidden" id="pronum" value="">
				</dt>
				<dd>
					<input type="radio" class="comm_rdo" id="festaSt1" name="festaStop1" value="3">
					<label for="festaSt1">3일</label>
				</dd>
				<dd>
					<input type="radio" class="comm_rdo" id="festaSt2" name="festaStop1" value="7">
					<label for="festaSt2">7일</label>
				</dd>
				<dd>
					<input type="radio" class="comm_rdo" id="festaSt3" name="festaStop1" value="15">
					<label for="festaSt3">15일</label>
				</dd>
				<dd>
					<input type="radio" class="comm_rdo" id="festaSt4" name="festaStop1" value="30">
					<label for="festaSt4">30일</label>
				</dd>
				<dd>
					<input type="radio" class="comm_rdo" id="festaSt5" name="festaStop1" value="90">
					<label for="festaSt5">90일</label>
				</dd>
			</dl>
			<dl class="txt_box">
				<dt>정지 사유</dt>
				<dd>
					<textarea id="stopresult" name="stopresult"></textarea>
				</dd>
			</dl>
			<div class="btn_box">
				<p>회원 제재 시 신중히 확인 바랍니다.</p>
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
					<li><button id="stopbtn" type="button" class="comm_btn cfm">정지하기</button></li>
				</ul>
			</div>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- } #팝업 정지하기 -->
<!-- #팝업 추방하기 { -->
<div id="kick" class="fstPop">
	<div class="kick_wrap pop_wrap">
		<h4 class="pop_tit">해당 회원을 영구적으로 추방하시겠습니까?</h4>
		<form>
		<input type="hidden" id="pronum1" value="">
			<dl class="txt_box">
				<dt>추방 사유</dt>
				<dd>
					<textarea id="kickresult" name="stopresult"></textarea>
				</dd>
			</dl>
			<div class="btn_box">
				<p>회원 제재 시 신중히 확인 바랍니다.</p>
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
					<li><button type="button" id="kickbtn" class="comm_btn cfm">추방하기</button></li>
				</ul>
			</div>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- } #팝업 추방하기 -->
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
<div id="choice" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">정지기간을 선택해 주세요.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<!-- } #팝업 체크된값없음 -->
<!-- #팝업 체크된값없음 { -->
<div id="fail" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">사유를 입력 해주세요.</p>
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