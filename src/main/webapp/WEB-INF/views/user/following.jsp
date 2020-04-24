<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<script type="text/javascript">
var url = window.location.href;
if(url.indexOf('following')>0){
	window.location.href='${root}empty';
}
	$(document).ready(function(){
		console.log("접속");
		//팔로우 등록,해제
		$(document).on('click','.btn_follow',function(){
			var mfgname = $(this).siblings('a').find('.fw_name').text();
			var mfrname = $('.follow_wrap>input[type=hidden]').eq(1).val();
			var pronum_sync = $(this).siblings('a').find('input[type=hidden]').val();
			var pronum = $('.follow_wrap>input[type=hidden]').eq(0).val();
			var unFollow = $(this).hasClass('act');
			console.log(mfgname,pronum_sync,pronum);
			//팔로우 등록
			if(unFollow){
				console.log('등록');
				$.post('${root}user/follow','pronum='+pronum+'&mfgname='+mfgname+'&pronum_sync='+pronum_sync+'&myFollower.mfrname='+mfrname,function(){
					var follow = $('#myFollowingCount');
					follow.text(Number(follow.text())+1);
					console.log(follow.text());
				});
			}
			//팔로우 해제
			else{
				console.log('해제');
				$.post('${root}user/unfollow','pronum='+pronum+'&mfgname='+mfgname+'&pronum_sync='+pronum_sync,function(){
					var follow = $('#myFollowingCount');
					follow.text(Number(follow.text())-1);
					console.log(follow.text());
				});
			}
		});
		
		 var listSize = $('.follow_wrap .scrBar li').length;
	      for(var i = 0; i< listSize; i++){
	    	  if(listSize!=1){
	    	  	if($('.follow_wrap .scrBar li').eq(i).find('.btn_follow').hasClass('act')==false){
	               $('.follow_wrap .scrBar li').eq(i).append('<button class="btn_follow">팔로우</button>');            
		         }
	    	  }
	      } 
	});
</script>
<!-- #팔로워/팔로우 팝업 -->
<div class="follow_wrap pop_wrap">
	<input type="hidden" value="${login.pronum}"/>
	<input type="hidden" value="${login.proname}"/>
	<h3 class="pop_tit"><span>팔로우</span></h3>
	<div class="scrBar">
		<ul>
			<c:if test="${fn:length(following) > 0}">
				<c:forEach items="${following }" var="following">
						<li>
							<a href="${root }user/?pronum=${following.profile.pronum}">
								<span class="pf_picture">
									<c:if test="${!empty following.profile.prophoto}">
											<img src="${upload }/${following.profile.prophoto}" alt="${following.profile.prophoto }님의 프로필 썸네일" onload="squareTrim($(this), 50)">
										</c:if>
										<c:if test="${empty following.profile.prophoto}">
											<img src="${root }resources/upload/thumb/no_profile.png" alt="${following.profile.prophoto}님의 프로필 썸네일" onload="squareTrim($(this), 50)">										
										</c:if>
								</span>
								<input type="hidden" value="${following.profile.pronum }"/>
								<b class="fw_name">${following.profile.proname }</b>
								<span class="fw_intro">${following.profile.prointro }</span>
							</a>
							<button class="btn_follow act following">팔로잉</button>
							
						</li>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(following) == 0}">
				<li class="fstEmpty">팔로우하는 사람이 없습니다.</li>
			</c:if>
		</ul>
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	scrBar();
	btnFollow();
</script>