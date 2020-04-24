package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

@Repository
public class FeedDaoImpl implements FeedDao{

	@Autowired
	SqlSession sqlSession;
	
	//////////////////////////////////////////////////////////////////////
	///////////////////////////화면출력///////////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//인기그룹피드 출력
	@Override
	public List<FeedVo> hotGroupFeedSelectAll(PageSearchVo page) {
		
		return sqlSession.selectList("feed.hotGroupFeedList", page);
	}

	//인기그룹피드 댓글출력
	@Override
	public List<GroupCommentVo> hotGroupCommentSelectAll(FeedVo feed) {

		return sqlSession.selectList("feed.hotGroupCommentList", feed);
	}
	
	//인기개인피드 출력
	@Override
	public List<FeedVo> hotMyFeedSelectAll(PageSearchVo page) {
		
		return sqlSession.selectList("feed.hotMyFeedList", page);
	}
	
	//인기개인피드 댓글출력
	@Override
	public List<MyCommentVo> hotMyCommentSelectAll(FeedVo feed) {
		
		return sqlSession.selectList("feed.hotMyCommentList", feed);
	}

	//인기그룹피드 댓글더보기
	@Override
	public List<GroupCommentVo> groupFeedCmmtMore(GroupPostVo grouppost) {
		
		return sqlSession.selectList("feed.groupFeedCmmtMore", grouppost);
	}

	//인기개인피드 댓글더보기
	@Override
	public List<MyCommentVo> myFeedCmmtMore(MyPostVo mypost) {
		
		return sqlSession.selectList("feed.myFeedCmmtMore", mypost);
	}

	//인기그룹피드 수정팝업 상세출력
	@Override
	public FeedVo groupFeedSelectOne(GroupPostVo grouppost) {

		return sqlSession.selectOne("feed.groupFeedSelectOne", grouppost);
	}

	//인기개인피드 수정팝업 상세출력
	@Override
	public FeedVo myFeedSelectOne(MyPostVo mypost) {

		return sqlSession.selectOne("feed.myFeedSelectOne", mypost);
	}

	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 수정,등록,삭제/////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//인기개인피드 댓글등록
	@Override
	public void myFeedCmmtInsertOne(MyCommentVo cmmt) {

		sqlSession.insert("feed.myFeedCmmtInsert", cmmt);
	}

	//인기그룹피드 댓글등록
	@Override
	public void groupFeedCmmtInsertOne(GroupCommentVo groupcmmt) {

		sqlSession.insert("feed.groupFeedCmmtInsert", groupcmmt);
	}

	//인기개인피드 댓글삭제
	@Override
	public int myFeedCmmtDeleteOne(MyCommentVo cmmt) {
		
		return sqlSession.delete("feed.myFeedCmmtDelete", cmmt);
	}

	//인기그룹피드 댓글삭제
	@Override
	public int groupFeedCmmtDeleteOne(GroupCommentVo groupcmmt) {
		
		return sqlSession.delete("feed.groupFeedCmmtDelete", groupcmmt);
	}
	
	//인기개인피드 삭제
	@Override
	public int myFeedDeleteOne(MyPostVo post) {
		
		return sqlSession.delete("feed.myFeedDelete", post);
	}

	//인기그룹피드 삭제
	@Override
	public int GroupFeedDeleteOne(GroupPostVo grouppost) {
		
		return sqlSession.delete("feed.groupFeedDelete", grouppost);
	}

	//인기개인피드 수정
	@Override
	public int myFeedUpdateOne(MyPostVo post) {
		
		return sqlSession.update("feed.myFeedUpdate", post);
	}

	//인기그룹피드 수정
	@Override
	public int groupFeedUpdateOne(GroupPostVo grouppost) {
		
		return sqlSession.update("feed.groupFeedUpdate", grouppost);
	}

	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 좋아요등록,해제////////////////////////
	//////////////////////////////////////////////////////////////////////

	//인기개인피드 좋아요등록
	@Override
	public void myFeedLikeInsertOne(MyGoodVo good) {

		sqlSession.insert("feed.myFeedLikeInsert", good);
	}
	
	//인기그룹피드 좋아요등록
	@Override
	public void groupFeedLikeInsertOne(MyGoodVo good) {

		sqlSession.insert("feed.groupFeedLikeInsert", good);
	}

	//인기개인피드 좋아요해제
	@Override
	public int myFeedLikeDeleteOne(MyGoodVo good) {
		
		return sqlSession.delete("feed.myFeedLikeDelete", good);
	}
	
	//인기그룹피드 좋아요해제
	@Override
	public int groupFeedLikeDeleteOne(MyGoodVo good) {
		
		return sqlSession.delete("feed.groupFeedLikeDelete", good);
	}
	
	//인기개인피드 좋아요등록시 개인피드좋아요 갯수 +1
	@Override
	public int myFeedLikeOnePlus(MyPostVo post) {

		return sqlSession.update("feed.myFeedLikeOnePlus", post);
	}

	//인기그룹피드 좋아요등록시 그룹피드좋아요 갯수+1
	@Override
	public int groupFeedLikeOnePlus(GroupPostVo grouppost) {
		
		return sqlSession.update("feed.groupFeedLikeOnePlus", grouppost);
	}

	//인기개인피드 좋아요해제시 개인피드좋아요 갯수 -1
	@Override
	public int myFeedLikeOneMinus(MyPostVo post) {
		
		return sqlSession.update("feed.myFeedLikeOneMinus", post);
	}

	//인기그룹피드 좋아요해제시 그룹피드좋아요 갯수 -1
	@Override
	public int groupFeedLikeOneMinus(GroupPostVo grouppost) {
		
		return sqlSession.update("feed.groupFeedLikeOneMinus", grouppost);
	}

	//내 좋아요목록 갱신
	@Override
	public List<MyGoodVo> myGoodRenewal(MyGoodVo good) {
		
		return sqlSession.selectList("feed.myGoodRenewal", good);
	}
	
	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 신고등록///////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//인기개인피드 신고등록
	@Override
	public void myFeedReportInsertOne(ReportListVo report) {

		sqlSession.insert("feed.myFeedReportInsert", report);
	}
	
	//인기그룹피드 신고등록
	@Override
	public void groupFeedReportInsertOne(ReportListVo report) {

		sqlSession.insert("feed.groupFeedReportInsert", report);
	}

	//해당 신고당한유저 신고당한횟수 +1
	@Override
	public int feedReportCountUpdate(ReportListVo report) {

		return sqlSession.update("feed.feedReportCountUpdate", report);
	}

	

}
