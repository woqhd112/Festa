<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="523392531637-h589a81n8ni7bgln4dc5ot68904e6p4g.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#btn_submit2').on("click", function() {
					$.post('${root}member/login', 'id=' + $('#id').val() + '&pw='+ $('#pw').val(), function(data) {
						if (data.prorn == '0') {
							location.href = "${root}user/?pronum="+data.pronum;
						} else if (data.prorn == '1') {
							location.href = "${root}member/stop?pronum="+data.pronum;
						} else if (data.prorn == '2') {
							location.href = "${root}member/kick?pronum="+data.pronum;
						} else if (data.prorn == '3') {
							location.href = "${root}admin/";
						} else if (data.prorn == '4') {
							var url = window.location.href;
							if(url.indexOf('login')>0)
								location.href='${root}empty';
								$('#check').show();
						}
					});
					return false;
				});
		
		//아이디찾기 유효성
		$('#id_find').on('propertychange change keyup paste input',function(e){
			var pw_find = $('#pw_find').val();
			if($('#pw_find').val()!='' && pw_find.length ==8 && $('#id_find').val()!=''){
				$('#btn_check').prop('type','submit');
			}
			else{
				$('#btn_check').prop('type','button');
			}
		});
		
		$('#pw_find').on('propertychange change keyup paste input',function(e){
			var pw_find = $('#pw_find').val();
			if(pw_find.length ==8 && $('#id_find').val()!='' && $('#pw_find').val()!=''){
					$('#btn_check').prop('type','submit');
			}
			else{
				$('#btn_check').prop('type','button');
			}
		});
		
		$('#idForm').on("submit",function(e){
			e.preventDefault();
				$.post('${root}member/find_id','proname='+$('#id_find').val()+'&proidnum='+$('#pw_find').val(),function(data){
					if(data.proid != null && data.prodate != null){
						var id = data.proid;
						var time = new Date(data.prodate);
		                var year = time.getFullYear();
		                var month;
		                if(time.getMonth()+1<10){
		                   month = '0'+(time.getMonth()+1);
		                }else {
		                   month = time.getMonth()+1;
		                }
		                var date = year+"년"+month+"월"+time.getDate()+"일";
		                $('#check_proid').html("아이디 : "+ id);
						$('#check_prodate').html("가입일 : "+date);	
						}
					else{
						$('#find_id_result').html("일치하는 아이디가 없습니다.");
						$('#check_proid').html("아이디 : ");
						$('#check_prodate').html("가입일 : ");
					}
					openPop('findId');
				});
			
		});//아이디찾기유효성 종료
		
		//비밀번호 찾기 유효성
		$('#find_pw_check_id').on('propertychange change keyup paste input',function(e){
			var find_pw_check_date = $('#find_pw_check_date').val();
			if($('#find_pw_check_date').val()!="" && find_pw_check_date.length==8 && $('#find_pw_check_id').val()!=""){
				$('#find_pw').prop('type','submit');
			}
			else{
				$('#find_pw').prop('type','button');
			}
		});
		
		$('#find_pw_check_date').on('propertychange change keyup paste input',function(e){
			var find_pw_check_date = $('#find_pw_check_date').val();
			if($('#find_pw_check_id').val()!="" && find_pw_check_date.length==8 && $('#find_pw_check_date').val()!=""){
				$('#find_pw').prop('type','submit');
			}
			else{
				$('#find_pw').prop('type','button');
			}
		});
		var pronum;
		$('#findpwForm').on("submit",function(e){
			e.preventDefault();
			$.post('${root}member/find_pw','id='+$('#find_pw_check_id').val()+'&proidnum='+$('#find_pw_check_date').val(),function(data){
				console.log(data.proid!=null);
				if(data.proid!=null){
					$('#emailCheck_result').html($('#find_pw_check_id').val()+" 으로 이메일을 보냈습니다.");
					openPop('emailCheck');
					$.post('${root}member/emailCheck','id='+$('#find_pw_check_id').val()+'&proidnum='+$('#find_pw_check_date').val(),function(data){
						var proid = data.proid;
						var proidnum = data.proidnum;
						pronum = data.pronum;
						var tmp = $('#find_pw_check_date').val();
						var editProidnum = tmp.slice(0, 4) + '년' + tmp.slice(4, 6) + '월' + tmp.slice(6,8)+'일';
						var find_pw_check_id = $('#find_pw_check_id').val();
						var find_pw_check_date = $('#find_pw_check_date').val();
						console.log(find_pw_check_id);
						console.log(find_pw_check_date);
						console.log(proid);
						console.log(proidnum);
						if(proid == find_pw_check_id  && proidnum ==editProidnum ){
							console.log("id "+proid);

						} else{
							openPop('nok');
						}
					});
				}
				else{
					$('#nok_p').html('해당 회원이 존재하지 않습니다.');
					openPop('nok');
				}
			});
			
		});
		
		$('#check_email').on("click",function(){
			$.post("${root}member/dice",function(data){
				var dice = data;
				var email_chk = $('#email_chk').val();
				if(dice==email_chk){
					openPop('resetPw');
				}
				else{
					openPop('nok');
				}
			});
		});
		
		function noResult() {
			var text = $('.confirm_wrap .pop_tit');
			text.text('인증번호가 일치하지 않습니다.');
		}
		
		//비밀번호변경 유효성 검사
		$("#propw").on('propertychange change keyup paste input',function() {
        	if($('#propw_check').val() != ""){
	            var regExp = /^[A-Za-z0-9+]{8,13}$/;
	            var propw = $("#propw").val();
	            var propwCheck = $("#propw_check").val();
	            var pw_num = propw.search(/[0-9]/g);
	            var pw_eng = propw.search(/[a-z]/gi);
	            var pwchk_num = propwCheck.search(/[0-9]/g);
	            var pwchk_eng = propwCheck.search(/[a-z]/gi);
	            if (regExp.test(propw) && regExp.test(propwCheck)) {
	               if (pw_num >= 0 && pw_eng >= 0 && pwchk_num >= 0 && pwchk_eng >= 0) {
	                  if (propw != propwCheck) {
	                     $("#pwfail").show();
	                     $("#pwok").hide();
	                     $("#pwif").hide();
	                  } else if (propw == propwCheck) {
	                     $("#pwfail").hide();
	                     $("#pwok").show();
	                     $("#pwif").hide();
	                  }
	               } else {
	                  $("#pwfail").hide();
	                  $("#pwok").hide();
	                  $("#pwif").show();
	               }
	            } else {
	               $("#pwfail").hide();
	               $("#pwok").hide();
	               $("#pwif").show();
	            }
        	}
		});
		
		$("#propw_check").on('propertychange change keyup paste input',function() {
       	 	if($('#propw').val() != ""){
	            var regExp = /^[A-Za-z0-9+]{8,13}$/;
	            var propw = $("#propw").val();
	            var propwCheck = $("#propw_check").val();
	            var pw_num = propw.search(/[0-9]/g);
	            var pw_eng = propw.search(/[a-z]/gi);
	            var pwchk_num = propwCheck.search(/[0-9]/g);
	            var pwchk_eng = propwCheck.search(/[a-z]/gi);
	            if (regExp.test(propw) && regExp.test(propwCheck)) {
	               if (pw_num >= 0 && pw_eng >= 0   && pwchk_num >= 0 && pwchk_eng >= 0) {
	                  if (propw != propwCheck) {
	                     $("#pwfail").show();
	                     $("#pwok").hide();
	                     $("#pwif").hide();
	                  } else if (propw == propwCheck) {
	                     $("#pwfail").hide();
	                     $("#pwok").show();
	                     $("#pwif").hide();
	                  }
	               } else {
	                  $("#pwfail").hide();
	                  $("#pwok").hide();
	                  $("#pwif").show();
	               }
	            } else {
	               $("#pwfail").hide();
	               $("#pwok").hide();
	               $("#pwif").show();
	            }
	            if($('#pwok').attr("style")=="display: block;"){
	            	$('#change_pw').prop('type','submit');
	            }
	            else{
	            	$('#change_pw').prop('type','button');
	            }
       	 	}
		});
		$('#change_pwForm').on("submit",function(e){
			e.preventDefault();
			$.post('${root}member/update_pw','propw='+$('#propw').val()+'&pronum='+pronum,function(){
				openPop("ok")
			});
		});
		
		$('#change_ok').on('click',function(){
			window.location.reload();
		})//비밀번호변경 유효성 종료
		
		$('#googleLogin').on("click",function(){
			console.log("클릭");
		});
	});
</script>
	<!-- #1단계팝업 로그인 -->
	<div class="login_wrap pop_wrap">
		<h2>
			<img src="${root }resources/images/ico/logo.png" alt="FESTA">
		</h2>
		<!-- 로그인 { -->
		<section id="log1" class="login_area act">
			<div>
				<h3 class="snd_only">로그인</h3>
				<form id="loginForm" name="loginForm" action="${root }member/login"
					method="post" class="comm_form">
					<div class="ip_box">
						<input id="id" name="id" type="email"
							placeholder="email@address.com">
					</div>
					<div class="ip_box">
						<input id="pw" name="pw" type="password" placeholder="password">
					</div>
					<p id="check" hidden="hidden" class="f_message rst">아이디 혹은 비밀번호를 다시 확인해주세요.</p>
					<button type="submit" name="btn_submit2" id="btn_submit2"
						class="comm_btn sbm">로그인</button>
				</form>
				<dl class="lg_sns">
					<dt>SNS계정 간편 로그인</dt>
					<dd>
						<div class="g-signin2" id="googleLogin" data-onsuccess="onSignIn" data-theme="dark"></div>
						<script>
						      function onSignIn(googleUser) {
						        // Useful data for your client-side scripts:
						        	
						        var auth2 = gapi.auth2.getAuthInstance();
						        auth2.disconnect();

								setTimeout(function(){
									
								},1000);
						        
						        var profile = googleUser.getBasicProfile();
								$.get("${root}member/socialJoin?id="+profile.getEmail()+"&proname="+profile.getName()+"&proprovide=1",function(data){
									if(data.prorn==0){
										location.href="${root}user/?pronum="+data.pronum;
										
									}else{
										location.href="${root}member/join?proid="+profile.getEmail()+"&proname="+profile.getName()+"&proprovide=1"
									}
								});
						        // The ID token you need to pass to your backend:
						        var id_token = googleUser.getAuthResponse().id_token;
								
      							}
  					  </script>
					</dd>
				</dl>
				<ul class="lg_find">
					<li><a href="${root }member/join">회원가입</a></li>
					<li>
						<button type="button" class="btn_move" data-layer="log2">아이디</button>
						/
						<button type="button" class="btn_move" data-layer="log3">비밀번호</button>
						찾기
					</li>
				</ul>
			</div>
		</section>
		<!-- } #1단계팝업 로그인 -->
		<!-- #1단계팝업 아이디 찾기 { -->
		<section id="log2" class="find_area">
			<div>
			<h3 class="pop_tit">아이디 찾기</h3>
			<form id="idForm" class="comm_form">
				<div class="ip_box">
					<input type="text" id="id_find" name="id_find" required="required">
					<label for="festaFid1" class="comm_label">이름</label>
				</div>
				<div class="ip_btd ip_box">
					<input type="text" id="pw_find" name="pw_find" required="required">
					<label for="festaFid2" class="comm_label">생년월일<span>을
							입력해주세요 (예: 19940415)</span></label>
				</div>
				<p class="f_message rst">
					<!-- 일치하는 회원정보가 없습니다. -->
				</p>
				<ul class="comm_buttons">
					<li><button type="button" class="btn_move comm_btn cnc">취소</button></li>
					<li><button type="button" class="comm_btn sbm"
							name="btn_check" id="btn_check">확인</button></li>
				</ul>
			</form>
		</div>
		</section>
		<!-- } #1단계팝업 아이디찾기 -->
		<!-- #1단계팝업 비밀번호찾기 { -->
		<section id="log3" class="find_area">
			<div>
			<h3 class="pop_tit">비밀번호 찾기</h3>
			<form id="findpwForm" class="comm_form">
				<div class="ip_box">
					<input type="email" id="find_pw_check_id" name="find_pw_check_id" required="required">
					<label for="festaFpw1" class="comm_label">아이디<span>(이메일)</span></label>
				</div>
				<div class="ip_btd ip_box">
					<input type="text" id="find_pw_check_date" name="find_pw_check_date" required="required">
					<label for="festaFpw2" class="comm_label">생년월일<span>을
							입력해주세요 (예: 19940415)</span></label>
				</div>
				<p class="f_message rst">
					<!-- 일치하는 회원정보가 없습니다. -->
				</p>
				<ul class="comm_buttons">
					<li><button type="button" class="btn_move comm_btn cnc">취소</button></li>
					<li><button type="button" class="comm_btn sbm btn_pop2" id="find_pw" name="find_pw"
							>확인</button></li>
				</ul>
			</form>
		</div>
		</section>
		<!-- } #1단계팝업 비밀번호 찾기 -->
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	<!-- #2단계팝업 아이디찾기 결과 { -->
	<div id="findId" class="fstPop">
		<div class="id_wrap pop_wrap">
			<h3 class="pop_tit">비밀번호 변경</h3>
			<div class="info_box">
				<p id="find_id_result">회원님의 정보와 일치하는 아이디는 다음과 같습니다.</p>
				<ul>
					<li><span id="check_proid">아이디 :</span> </li>
					<li><span id="check_prodate">가입일 :</span></li>
				</ul>
			</div>
			<ul class="comm_buttons">
				<li><button type="button"
						class="btn_move comm_btn btn_close btn_move cnc">확인</button></li>
				<li><button type="button"
						class="comm_btn btn_close btn_move cfm" data-layer="log3">비밀번호
						찾기</button></li>
			</ul>
		</div>
	</div>
	<!-- #이메일 인증 { -->
	<div id="emailCheck" class="fstPop">
		<div class="id_wrap pop_wrap">
			<h3 class="pop_tit">이메일 인증</h3>
			<form class="comm_form">
				<p id="emailCheck_result">${email.proid }로 이메일을 보냈습니다.</p>
				<div class="ip_box">
					<input type="text" id="email_chk" placeholder="인증번호를 입력해주세요." />
				</div>
			</form>
			<ul class="comm_buttons">
				<li><button type="button" id="check_email"
							class="comm_btn cfm btn_move">확인</button></li>
			</ul>
		</div>
		
	</div>
	<!-- } #2단계팝업 아이디찾기 결과 -->
	<!-- #2단계팝업 비밀번호 변경 { -->
	<div id="resetPw" class="fstPop">
		<div class="pw_wrap pop_wrap">
			<h3 class="pop_tit">비밀번호 변경</h3>
			<div class="info_box">
				<p>새로운 비밀번호를 설정해주세요.</p>
			</div>
			<form id="change_pwForm"class="comm_form">
				<div class="ip_box">
					<input type="password" id="propw" name="propw" required="required">
					<label for="festa3" id="festa3" class="comm_label">비밀번호<span> 8~13자 이내, 영문(대소문자)+숫자 조합</span></label>
					<p hidden="hidden" id="pwif" class="f_message rst">비밀번호는
                              8~13자 영문,숫자 조합이어야 합니다.</p>
                    <p hidden="hidden" id="pwfail"
                              class="f_message rst">비밀번호가 일치하지 않습니다.</p>
                     <p hidden="hidden" id="pwok"
                              class="f_message ok rst">비밀번호가 일치합니다.</p>
				</div>
				<div class="ip_box">
					<input type="password" id="propw_check" name="propw_check" required="required">
					<label for="festaFpw4" class="comm_label" >비밀번호 확인</label>
					<p class="f_message">
						<!-- 비밀번호 확인 검사 -->
					</p>
				</div>
				<p class="f_message rst">
					<!-- 일치하는 회원정보가 없습니다. -->
				</p>
				<ul class="comm_buttons">
					<li><button type="button" class="comm_btn sbm btn_pop2" id="change_pw" name="change_pw"
							>확인</button></li>
				</ul>
			</form>
		</div>
	</div>
	<!-- #2단계팝업 비밀번호 변경 { -->
	<!-- #3단계팝업 처리완료 { -->
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cfm" id="change_ok" name="change_ok">확인</button></li>
			</ul>
		</div>
	</div>
		<!-- #3단계팝업 처리완료 { -->
	<div id="nok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p id="nok_p" class="pop_tit">인증번호가 일치하지 않습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">확인</button></li>
			</ul>
		</div>
	</div>
	<!-- } #3단계팝업 처리완료 -->
	<script type="text/javascript">
		loginMove();
		btnPop('btn_pop2');
		formTagCss();
	</script>
</html>