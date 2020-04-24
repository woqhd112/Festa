<%@page import="com.fin.festa.model.entity.FeedVo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root}resources/images/ico/logo.png">
	<script type="text/javascript" src="${root}resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root}resources/js/util.js"></script>
	<script type="text/javascript" src="${root}resources/js/site.js"></script>
	<link type="text/css" rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link type="text/css" rel="stylesheet" href="${root}resources/css/site.css">
	<link rel="shortcut icon" href="${root}resources/favicon.ico">
	<title>FESTA</title>
</head>
<body>
<div id="wrap">
<c:if test="${feedList ne null}">
<c:forEach items="${feedList}" var="feed">
	<c:set var="groupFeed" value="${feed.gpnum ne 0}" />
	<c:choose>
		<c:when test="${!groupFeed}">
			<c:set var="feedContent" value="${feed.mpcontent}" />
			<c:set var="feedImages" value="${feed.mpphoto}" />
			<c:set var="feedNum" value="${feed.mpnum}" />
			<c:set var="cmmtCount" value="${feed.mptotal}" />
			<c:set var="feedComment" value="${followComment}" />
		</c:when>
		<c:otherwise>
			<c:set var="feedContent" value="${feed.gpcontent}" />
			<c:set var="feedImages" value="${feed.gpphoto}" />
			<c:set var="feedNum" value="${feed.gpnum}" />
			<c:set var="cmmtCount" value="${feed.gptotal}" />
			<c:set var="feedComment" value="${groupComment}" />
		</c:otherwise>
	</c:choose>
	<div class="feed_viewer<c:if test="${!empty feedImages}"> half</c:if>" data-num="${feedNum}">
		<div class="tit box">
			<dl class="feed_inform">
				<dt>
					<a href="${root}user/?pronum=${feed.pronum}">
						<span class="pf_picture">
						<c:choose>
							<c:when test="${!empty feed.profile.prophoto}"><img src="${upload}/${feed.profile.prophoto}" alt="${feed.profile.proname}님의 프로필 썸네일" onload="squareTrim($(this), 55)"></c:when>
							<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${feed.profile.proname}님의 프로필 썸네일" width="55"></c:otherwise>
						</c:choose>
						</span>
						<span class="fd_name">${feed.profile.proname}</span>
					</a>
					<c:if test="${groupFeed}">
					<a href="${root}group/?grnum=${feed.grnum}&pronum=${login.pronum}"><span class="fd_group">${feed.group.grname}</span></a>
					</c:if>
				</dt>
				<dd>
					<span class="fd_date">${feed.date1}</span>
					<b class="fd_liked">${feed.good}</b>
				</dd>
			</dl>
			<ul class="feed_options">
				<li>
					<button class="btn_liked<c:forEach items="${goodlist}" var="good"><c:if test="${good.mpnum eq feedNum || good.gpnum eq feedNum}"> act</c:if></c:forEach>" onclick="liked($(this))"><em class="snd_only">하트</em></button>
				</li>
				<c:choose>
					<c:when test="${login.pronum eq feed.pronum}">
						<li><a href="${root}news/edit" class="btn_edit"><em class="snd_only">수정하기</em></a></li>
						<li><button class="btn_delete" data-num="${feedNum}" onclick="deleted($(this))"><em class="snd_only">삭제하기</em></button></li>
					</c:when>
					<c:otherwise>
						<li><a href="${root}news/report" class="btn_report"><em class="snd_only">신고하기</em></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div class="text box">
			<div class="scrBar">
				<div class="feed_content">
					<ul class="fd_hashtag">
						<c:if test="${!empty feed.httitle1}"><li><a href="${root}search/?keyword=${feed.httitle1}">${feed.httitle1}</a></li></c:if>
						<c:if test="${!empty feed.httitle2}"><li><a href="${root}search/?keyword=${feed.httitle2}">${feed.httitle2}</a></li></c:if>
						<c:if test="${!empty feed.httitle3}"><li><a href="${root}search/?keyword=${feed.httitle3}">${feed.httitle3}</a></li></c:if>
					</ul>
					<pre class="fd_content">${feedContent}</pre>
				</div>
				<ul class="comment_list">
					<c:set var="i" value="0" />
					<c:set var="doneLoop" value="false" />
					<c:forEach items="${feedComment}" var="comment">
					<c:if test="${not doneLoop}">
					<c:set var="groupCmmt" value="${feedComment eq groupComment}" />
					<c:choose>
						<c:when test="${!groupCmmt}">
							<c:set var="cmmtNum" value="${comment.mcnum}" />
							<c:set var="cmmtContent" value="${comment.mccontent}" />
							<c:set var="cmmtDate" value="${comment.mcdate1}" />
							<c:set var="myComment" value="${feed.mpnum eq comment.mpnum}"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="cmmtNum" value="${comment.gcnum}" />
							<c:set var="cmmtContent" value="${comment.gccontent}" />
							<c:set var="cmmtDate" value="${comment.gcdate1}" />
							<c:set var="gpComment" value="${feed.gpnum eq comment.gpnum}"></c:set>
						</c:otherwise>
					</c:choose>
					<c:if test="${myComment or gpComment}">
					<li>
						<a href="${root}user/?pronum=${comment.pronum}" class="pf_picture">
						<c:choose>
							<c:when test="${!empty comment.profile.prophoto}"><img src="${upload}/${comment.profile.prophoto}" alt="${comment.profile.proname}님의 프로필 썸네일" width="30"></c:when>
							<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="${feed.profile.proname}님의 프로필 썸네일" onload="squareTrim($(this), 30)"></c:otherwise>
						</c:choose>
						</a>
						<p class="cmt_content">
							<a href="${root}user/?pronum=${comment.pronum}" class="cmt_name">${comment.profile.proname}</a>
							&nbsp;${cmmtContent}
							<span class="cmt_date">${cmmtDate}</span>
							<c:if test="${login.pronum eq comment.pronum}"><button class="btn_delete" data-num="${cmmtNum}" onclick="deleted($(this))"><em class="snd_only">삭제하기</em></button></c:if>
						</p>
					</li>
					<c:set var="i" value="${i+1}" />
					<c:if test="${i eq 3 }"><c:set var="doneLoop" value="true" /></c:if>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
				<c:if test="${cmmtCount gt 3}">
					<button class="cmt_btn_more" onclick="moreComment($(this))"><span class="snd_only">1</span>댓글 더 보기</button>
				</c:if>
			</div>
			<form class="message_form" method="POST" action="${root}news/cmmtadd">
			<c:choose>
				<c:when test="${!groupFeed}">
					<c:set var="number" value="mpnum" />
					<c:set var="author" value="mcauthor" />
					<c:set var="content" value="mccontent" />
					<c:set var="sync" value="pronum_sync" />
					<c:set var="syncValue" value="${feed.pronum}" />
				</c:when>
				<c:otherwise>
					<c:set var="number" value="gpnum" />
					<c:set var="author" value="gcauthor" />
					<c:set var="content" value="gccontent" />
					<c:set var="sync" value="grnum" />
					<c:set var="syncValue" value="${feed.grnum}" />
				</c:otherwise>
			</c:choose>
				<a class="pf_picture" href="${root}user/?pronum=${login.pronum}">
				<c:choose>
					<c:when test="${!empty login.prophoto}"><img src="${upload}/${login.prophoto}" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)"></c:when>
					<c:otherwise><img src="${root}resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일" width="30"></c:otherwise>
				</c:choose>
				</a>
				<div class="msg_input">
					<input type="hidden" name="${number}" value="${feedNum}">
					<input type="hidden" name="pronum" value="${login.pronum}">
					<input type="hidden" name="${author}" value="${login.proname}">
					<input type="hidden" name="${sync}" value="${syncValue}">
					<input type="text" class="msg_txt" name="${content}" placeholder="메세지를 입력해주세요" required="required">
					<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>
				</div>
			</form>
		</div>
		<c:if test="${!empty feedImages}">
		<div class="img box">
			<div class="thumb_slide">
				<div class="swiper-wrapper">
				<c:forTokens items="${feedImages}" var="images" delims=",">
					<div class="swiper-slide"><img src="${upload}/${images}" alt="" onload="squareTrim($(this), 290)"></div>
				</c:forTokens>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
		</c:if>
	</div>
</c:forEach>
</c:if>
</div>
</body>
</html>