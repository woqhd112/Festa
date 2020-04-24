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
   <meta property="og:image" content="${root }resources/images/ico/logo.png">
   <script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
   <script type="text/javascript" src="${root }resources/js/util.js"></script>
   <script type="text/javascript" src="${root }resources/js/site.js"></script>
   <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
   <link rel="stylesheet" href="${root }resources/css/site.css">
   <link rel="shortcut icon" href="${root }resources/favicon.ico">
   <title>FESTA</title>
   <script type="text/javascript">
      $(document).ready(function(){ 
        
         //parameter 추출
            $.urlParam = function(name){
                var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
                
                if (results==null){
                   return null;
                }
                else{
                   return results[1] || 0;
                }
            }
            var proid =$.urlParam("proid");
         var proname = decodeURI($.urlParam("proname"));
            var proprovide =$.urlParam("proprovide");
            
            if(proprovide==1){
               $('#proid').siblings('.comm_label').addClass('size_s');
                $('#proid').val(proid);
               $('#proname').val(proname);
               $('#proname').siblings('.comm_label').addClass('size_s');
                $('#proprovide').val(proprovide);
               $('#proid').attr("readonly",true);
               $('#propwCheck').val('123123123a');
               $('#propw').val('123123123a');
               $('#propwCheck').hide();
               $('#propw').hide();
                $('#festa3').hide();
                $('#festa4').hide();
                $('#namefail').attr('style',"display: none;");
            }
            else{
               $('#proprovide').val(0);
            }
            if($('#propw').val()=='123123123a'){
               $('#pwok').text('');
               $('#pwok').show();
            } 
            
         //이메일 형식 유효성 검사
         $('#email_check').on('click',function(){
            var id = $('#proid').val();
            var regExp = /^[0-9a-zA-Z]([a-zA-Z0-9_\-])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            
            if(id.match(regExp)!=null){ 
               $.post('${root}member/join/idcheck','id='+id,function(data){
                   if(data == '0'){
                     $("#idok").show();
                     $("#idfail").hide();
                     $("#idFormError").hide();
                     $('#proid').attr('readonly','readonly');
                     $('#email_check').css('background-color','#bbb');
                     //$('#email_check').attr('disalbed','disabled');
                  }
                   else{
                     $("#idfail").show();
                     $("#idok").hide();
                     $("#idFormError").hide();
                   }
                   return false;
               });
            }
            else{
               $("#idFormError").show();
               $("#idfail").hide();
               $("#idok").hide();
            }
            if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                  $('#joinBtn').prop('type','submit');
               }
               else{
                  $('#joinBtn').prop('type','button');
               }
         });//아이디 유효성 검사 끝
         
         //이름 유효성 검사
         $('#proname').on('propertychange change keyup paste input',function() {
            if($('#proname').val().length>5){
            $('#namefail').show();
            $('#joinBtn').prop('type','button');
            }
            else{
               $('#namefail').hide();
               if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                  $('#joinBtn').prop('type','submit');
               }
            }
         });
         //이름 유효성 검사 종료
         
         //비밀번호 형식 유효성 검사
         $("#propwCheck").on('propertychange change keyup paste input',function() {
            if($('#propw').val() != ""){
               var regExp = /^[A-Za-z0-9+]{8,13}$/;
               var propw = $("#propw").val();
               var propwCheck = $("#propwCheck").val();
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
            }
            if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                   $('#joinBtn').prop('type','submit');
               }
               else{
                   $('#joinBtn').prop('type','button');
               }
         });

         $("#propw").on('propertychange change keyup paste input',function() {
               var regExp = /^[A-Za-z0-9+]{8,13}$/;
               var propw = $("#propw").val();
               var propwCheck = $("#propwCheck").val();
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
               if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                  $('#joinBtn').prop('type','submit');
           }
           else{
               $('#joinBtn').prop('type','button');
           }
         });//비밀번호 유효성 검사 끝
         
         
         //생년월일 유효성
         $('#proidnum').on('propertychange change keyup paste input',function(){
            var tmp =$(this).val($(this).val().replace(/[^0-9]/gi,""));
            var proidnum = $(this).val();
            var year = Number(proidnum.substr(0,4));
            var month = Number(proidnum.substr(4,2));
            var day = Number(proidnum.substr(6,2));
            var today = new Date();
            var yearNow = today.getFullYear();
            var adultYear = yearNow-20;
            if(proidnum.length != 0){
            if(proidnum.length != 8){
                $('#datefail').text('생년월일이 8자리여야 합니다.');
                     $('#datefail').show();
            }
            else  if (month < 1 || month > 12) { 
                  $('#datefail').text('1월에서 12월 사이의 달을 입력하세요.');
                     $('#datefail').show();
                   return false;
              }
              else if (day < 1 || day > 31) {
                  $('#datefail').text('1일에서 31일 사이의 일을 입력하세요.'); 
                  $('#datefail').show();
                  return false;
              }
              else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
                   $('#datefail').text(month+'월은 31일이 없습니다.');
                   $('#datefail').show();
                    return false;
              }
              else if (month == 2) {
                    var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                    if (day>29 || (day==29 && !isleap)) {
                         $('#datefail').text(year+'년 2월은 '+day+"일이 없습니다."); 
                          $('#datefail').show();
                        return false;
                   }
              }
              else{
                   $('#datefail').hide();
              }
            if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                     $('#joinBtn').prop('type','submit');
                  }
                  else{
                     $('#joinBtn').prop('type','button');
                  }
                return true;
            }
         });//생년월일 유효성 종료
         
         //관심지역 유효성 검사
         $('#proaddr').change(function(){
            if($('#proaddr option:selected').val() ==""){
               $('#selectfail').show();
            }
            else{
               $('#selectfail').hide();
            }
            if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                   $('#joinBtn').prop('type','submit');
               }
               else{
                  $('#joinBtn').prop('type','button');
               }
         });//관심지역 유효성 검사 종료
         
         //전체 체크했는지 혹은 필수 항목 입력했는지
         $('#festa10').on('change',function(){
            if($("input:checkbox[id='festa11']").is(":checked")==false && $("input:checkbox[id='festa12']").is(":checked")==false){
               $('#festa10').prop('checked','');
            }
              //id유효성 체크 && 이름 유효성 체크 && 비밀번호 유효성 체크 && 생년월일 유효성 체크 && 성별 유효성 && 전체동의 , 이용약관 , 개인정보 체크 여부
              if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                    $('#joinBtn').prop('type','submit');
                }
                else{
                    $('#joinBtn').prop('type','button');
                }
         });
         
         $('#festa11').on('change',function(){
              if($("input:checkbox[id='festa11']").is(":checked") && $("input:checkbox[id='festa12']").is(":checked")){
                 $("#festa10").prop('checked','checked');
              }
               //id유효성 체크 && 이름 유효성 체크 && 비밀번호 유효성 체크 && 생년월일 유효성 체크 && 성별 유효성 && 전체동의 , 이용약관 , 개인정보 체크 여부
               if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                    $('#joinBtn').prop('type','submit');
                }
                else{
                    $('#joinBtn').prop('type','button');
                } 
          });
         
         $('#festa12').on('change',function(){
               if($("input:checkbox[id='festa11']").is(":checked") && $("input:checkbox[id='festa12']").is(":checked")){
                 $("#festa10").prop('checked','checked');
              }
               //id유효성 체크 && 이름 유효성 체크 && 비밀번호 유효성 체크 && 생년월일 유효성 체크 && 성별 유효성 && 전체동의 , 이용약관 , 개인정보 체크 여부 && 관심지역 체크
               if($('#proid').attr("readonly")=="readonly" && $('#proname').val() != "" && $('#pwok').attr("style")=="display: block;"  && $('#datefail').attr("style")=="display: none;" && $('input:radio[name=projender]').is(':checked') ==true &&   $('input:checkbox[id=festa10]').is(':checked')==true && $('input:checkbox[id=festa11]').is(':checked')==true && $('input:checkbox[id=festa12]').is(':checked')==true && $('#proaddr').val() != "관심지역" && $('#namefail').attr("style")=="display: none;"){
                    $('#joinBtn').prop('type','submit');
                }
                else{
                   $('#joinBtn').prop('type','button');
                } 
          });
      });
   </script>
</head>
<body>
<div id="wrap">
   <div id="header">
      <div class="scrX">
         <div class="container">
            <h1>
               <a href="${root }"><em class="snd_only">FESTA</em></a>
            </h1>
            <form class="search_box">
               <input type="text" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
               <button type="submit"><img src="${root }resources/images/ico/btn_search.png" alt="검색"></button>
            </form>
            <ul id="gnb">
               <li><a href="${root}camp/">캠핑정보</a></li>
                  <li><a href="${root}hot/">인기피드</a></li>
                  <li><a href="${root}news/?pronum=${login.pronum}">뉴스피드</a></li>
               <li><a href="${root }member/login" class="btn_pop">로그인</a></li>
            </ul>
            <button type="button" id="btnTop"><em class="snd_only">맨 위로</em></button>
         </div>
      </div>
   </div>
   <!-- #회원가입 -->
   <!-- 서브페이지 시작 { -->
   <div id="container" class="join_wrap">
      <!-- 컨텐츠영역 시작 { -->
      <section class="title_area">
         <div class="container">
            <div>
               <h2 class="comm_tit">회원가입</h2>
               <p>페스타에 오신 것을 환영합니다.<br>로그인하시면 더 많은 서비스를 이용하실 수 있습니다.</p>
            </div>
         </div>
      </section>
      <section class="form_area">
         <div class="container">
            <form action="${root }member/join" method="post" class="comm_form">
               <input type="hidden" id="proprovide" name="proprovide" value="0"/>
               <div class="input_wrap">
                  <div>
                     <div class="ip_id ip_box">
                        <input type="email" id="proid" name="proid" required="required" >
                        <label for="festa1" class="comm_label">아이디<span> (이메일)</span></label>
                        <button type="button" id="email_check" class="btn_id">중복확인</button>
                        <!-- 유효성검사 후 메세지 출력 { -->
                        <p class="f_message"></p>
                        <p hidden="hidden" id="idFormError" class="f_message rst">이메일 형식을 입력하세요.</p>
                        <p hidden="hidden" id="idfail" class="f_message rst">이미 사용중이거나 탈퇴한 아이디입니다.</p>
                        <p hidden="hidden" id="idok" class="f_message ok rst">사용가능한 아이디입니다.</p>
                        <!-- } 유효성검사 후 메세지 출력 -->
                     </div>
                     <div class="ip_box">
                        <input type="text" id="proname" name="proname" required="required">
                        <label for="festa2" class="comm_label">이름</label>
                        <p hidden="hidden" id="namefail"
                              class="f_message rst">5자 이내로 입력하세요.</p>
                     </div>
                        <div class="ip_box">
                           <input type="password" id="propw" name="propw"
                              required="required"> <label for="festa3" id="festa3"
                              class="comm_label">비밀번호<span> 8~13자 이내,
                                 영문(대소문자)+숫자 조합</span></label>
                           <p class="f_message"></p>
                           <p hidden="hidden" id="pwif" class="f_message rst">비밀번호는
                              8~13자 영문,숫자 조합이어야 합니다.</p>
                           <p hidden="hidden" id="pwfail"
                              class="f_message rst">비밀번호가 일치하지 않습니다.</p>
                           <p hidden="hidden" id="pwok"
                              class="f_message ok rst">비밀번호가 일치합니다.</p>
                        </div>
                        <div class="ip_box">
                        <input type="password" id="propwCheck" name="propwCheck" required="required">
                        <label for="festa4" id="festa4" class="comm_label">비밀번호 확인</label>
                        <p class="f_message"></p>
                     </div>
                  </div>
                  <div>
                     <div class="ip_box">
                        <input type="text" id="proidnum" name="proidnum" required="required" numberonly="true">
                        <label for="festa5" class="comm_label">생년월일<span>을 입력해주세요 (예: 19940415)</span></label>
                        <p hidden="hidden" id="datefail"
                              class="f_message rst">생년월일을 양식에 맞게 입력해주세요.</p>
                     </div>
                     <div class="sel_box">
                        <select class="comm_sel" id="proaddr" name="proaddr" required="required">
                           <option value="">관심지역</option>
                           <option value="서울">서울</option>
                           <option value="경기도">경기도</option>
                           <option value="강원도">강원도</option>
                           <option value="충청도">충청도</option>
                           <option value="전라도">전라도</option>
                           <option value="경상도">경상도</option>
                           <option value="제주도">제주도</option>
                           <option value="인천">인천</option>
                           <option value="세종">세종</option>
                           <option value="대구">대구</option>
                           <option value="울산">울산</option>
                           <option value="광주">광주</option>
                           <option value="대전">대전</option>
                        </select>
                        <label for="festa6" class="comm_label">관심지역</label>
                        <!-- 셀렉트박스 선택값 출력 { -->
                        <p class="comm_sel_label"></p>
                        <!-- } 셀렉트박스 선택값 출력 -->
                        <p class="f_message"></p>
                        <p hidden="hidden" id="selectfail"
                              class="f_message rst">관심지역을 다시 설정하세요.</p>
                     </div>
                     <div class="sel_box">
                        <select class="comm_sel" id="projob" name="projob">
                           <option value="">(선택) 직종</option>
                           <option value="경영·사무">경영·사무</option>
                           <option value="영업·고객상담">영업·고객상담</option>
                           <option value="IT·인터넷">IT·인터넷</option>
                           <option value="디자인">디자인</option>
                           <option value="서비스">서비스</option>
                           <option value="전문직">전문직</option>
                           <option value="의료">의료</option>
                           <option value="생산·제조">생산·제조</option>
                           <option value="건설">건설</option>
                           <option value="유통·무역">유통·무역</option>
                           <option value="미디어">미디어</option>
                           <option value="교육">교육</option>
                           <option value="특수계층·공공">특수계층·공공</option>
                           <option value="학생">학생</option>
                           <option value="기타">기타</option>
                        </select>
                        <label for="festa7" class="comm_label"><span>(선택) </span>직종</label>
                        <!-- 셀렉트박스 선택값 출력 { -->
                        <p class="comm_sel_label"></p>
                        <!-- } 셀렉트박스 선택값 출력 -->
                     </div>
                     <div class="rdo_gnd rdo_box">
                        <dl>
                           <dt>성별</dt>
                           <dd>
                              <input type="radio" class="comm_rdo" id="projender1" name="projender" value="남성" checked="checked">
                              <label for="projender1">남성</label>
                           </dd>
                           <dd>
                              <input type="radio" class="comm_rdo" id="projender2" name="projender" value="여성">
                              <label for="projender2">여성</label>
                           </dd>
                        </dl>
                        <p class="f_message"></p>
                     </div>
                  </div>
               </div>
               <div class="check_wrap">
                  <dl>
                     <dt>
                        <input type="checkbox" class="comm_chk" id="festa10" name="allChecked">
                        <label for="festa10">전체 동의</label>
                     </dt>
                     <dd>
                        <input type="checkbox" class="comm_chk" id="festa11" name="serviceCheck">
                        <label for="festa11">페스타 이용약관 동의</label>
                        <div class="scrBar">
                           여러분을 환영합니다.
페스타 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다.<br> 본 약관은 다양한 페스타 서비스의 이용과 관련하여 페스타 서비스를 제공하는 페스타 주식회사(이하 ‘페스타’)와 이를 이용하는 페스타 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 
<br>아울러 여러분의 페스타 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
<br>페스타 서비스를 이용하시거나 페스타 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 
<br>잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.<br>
<br><b>여러분이 제공한 콘텐츠를 소중히 다룰 것입니다.</b><br>
<br>페스타는 여러분이 게재한 게시물이 페스타는 서비스를 통해 다른 이용자들에게 전달되어 우리 모두의 삶을 더욱 풍요롭게 해줄 것을 기대합니다.
<br>게시물은 여러분이 타인 또는 자신이 보게 할 목적으로 페스타는 서비스 상에 게재한 부호, 문자, 음성, 음향, 그림, 사진, 동영상, 링크 등으로 구성된 각종 콘텐츠 자체 또는 파일을 말합니다.
                        </div>
                     </dd>
                     <dd>
                        <input type="checkbox" class="comm_chk" id="festa12" name="privacyCheck">
                        <label for="festa12">개인정보 수집 및 이용에 동의</label>
                        <div class="scrBar">
                           정보통신망법 규정에 따라 페스타에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.<br>
<br>
1. 수집하는 개인정보<br>
<br>이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 페스타 서비스를 회원과 동일하게 이용할 수 있습니다. 
<br>이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 페스타 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
                        </div>
                     </dd>
                  </dl>
               </div>
               <button type="button" id="joinBtn" class="comm_btn sbm">가입하기</button>
               <!-- 유효성검사 충족 시 버튼타입 변경 {
               <button type="submit" class="comm_btn sbm">가입하기</button>
               } 유효성검사 충족 시 버튼타입 변경 -->
            </form>
         </div>
      </section>
      <!-- } 컨텐츠영역 끝 -->
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
</html>