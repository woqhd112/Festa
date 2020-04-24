<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload"></c:url>
<!doctype html>
<html>
<head>
<script type="text/javascript">
   $(document).ready(function(){
      
      //팔로우 등록,해제
      $(document).on('click','.btn_follow',function(){
         var mfgname = $(this).siblings('a').find('.fw_name').text();
         var mfrname = $('.follow_wrap>input[type=hidden]').eq(1).val();
         var pronum_sync = $(this).siblings('a').find('input[type=hidden]').val();
         var pronum = $('.follow_wrap>input[type=hidden]').eq(0).val();
         console.log(mfgname,pronum_sync,pronum);
         
         var unFollow = $(this).hasClass('act');
         //팔로우 해제
         if (unFollow) {
            
            $.post('${root}group/follow','pronum='+pronum+'&mfgname='+mfgname+'&pronum_sync='+pronum_sync+'&myFollower.mfrname='+mfrname);
            
         //팔로우 등록
         } else {
            
            $.post('${root}group/unfollow','pronum='+pronum+'&mfgname='+mfgname+'&pronum_sync='+pronum_sync);
         }
         
      });
      
      //팔로우버튼 갯수조절
      var listSize = $('.follow_wrap .scrBar li').length;
      for(var i = 0; i< listSize; i++){
         if($('.follow_wrap .scrBar li').eq(i).find('.btn_follow').hasClass('act')==false){
            var userNum = $('.follow_wrap .scrBar li').eq(i).find('input[type=hidden]').val();
            var myNum = $('.follow_wrap input[type=hidden]').eq(0).val();
            if(userNum != myNum){
               $('.follow_wrap .scrBar li').eq(i).append('<button class="btn_follow">팔로우</button>');
            }
         }
      }
   });
</script>
</head>
<!-- #그룹멤버 팝업 -->
<div class="follow_wrap pop_wrap">
	<input type="hidden" value="${login.pronum }"> <input
		type="hidden" value="${login.proname }">
	<h3 class="pop_tit">
		<span>그룹 멤버</span>
	</h3>
	<div class="scrBar">
		<ul>
			<c:choose>
				<c:when test="${detail.grtotal ne 0}">
					<c:forEach items="${member }" var="member">
						<li><a href="${root }user/?pronum=${member.profile.pronum}"> <span class="pf_picture">
							<c:if test="${!empty member.profile.prophoto }">
								<img src="${upload }/${member.profile.prophoto}" alt="${member.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 50)">
							</c:if>
							<c:if test="${empty member.profile.prophoto }">
								<img src="${root }resources/images/thumb/no_profile.png" alt="${member.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 50)">
							</c:if>
							</span> <input type="hidden" value="${member.profile.pronum }">
								<b class="fw_name">${member.profile.proname }</b> <span
								class="fw_intro">${member.profile.prointro }</span>
						</a> <c:forEach items="${followlist}" var="followlist">
								<c:choose>
									<c:when
										test="${member.profile.pronum eq followlist.pronum_sync}">
										<button class="btn_follow act following">팔로잉</button>
									</c:when>
									<%-- <c:otherwise>
                                 <button class="btn_follow">팔로우</button>
                              </c:otherwise> --%>
								</c:choose>
							</c:forEach></li>
					</c:forEach>
				</c:when>
			</c:choose>
		</ul>
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
   scrBar();
   btnFollow();
</script>
</html>