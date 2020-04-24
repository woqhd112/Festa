<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<!-- #팔로워/팔로우 팝업 -->
<html>
<script type="text/javascript">
var url = window.location.href;
if(url.indexOf('following')>0){
	window.location.href='${root}empty';
}
</script>
<div class="follow_wrap pop_wrap">
	<h3 class="pop_tit"><span>팔로우</span></h3>
	<div class="scrBar">
		<ul>
			<c:forEach items="${myfollowing }" var="myfollowing">
			<li>
				<a href="${root }admin/user/detail?pronum=${myfollowing.profile.pronum}">
					<span class="pf_picture">
					<c:if test="${!empty myfollowing.profile.prophoto }">
						<img src="${upload }/${myfollowing.profile.prophoto}" alt="${myfollowing.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 50)">
					</c:if>
					<c:if test="${empty myfollowing.profile.prophoto }">
						<img src="${root }resources/images/thumb/no_profile.png" alt="${myfollowing.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 50)">
					</c:if>
					</span>
					<b class="fw_name">${myfollowing.profile.proname }</b>
					<span class="fw_intro">${myfollowing.profile.prointro }</span>
				</a>
			</li>
			</c:forEach>
			<c:if test="${empty myfollowing }">
				<li class="fstEmpty">내가 팔로우 한 사람이 없습니다.</li>
			</c:if>
		</ul>
	</div>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	scrBar();
</script>
</html>