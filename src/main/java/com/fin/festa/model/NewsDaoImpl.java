package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ReportListVo;

@Repository
public class NewsDaoImpl implements NewsDao{

	@Autowired
	SqlSession sqlSession;
	
	//////////////////////////////////////////////////////////////////////
	///////////////////////////화면출력///////////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//내팔로우의 피드글출력
	@Override
	public List<FeedVo> followFeedSelectAll(MyFollowingVo following) {
		return sqlSession.selectList("news.followingFeed", following);
	}
	
	//내팔로우의 피드글댓글출력
	@Override
	public List<MyCommentVo> followCommentSelectAll(FeedVo feed) {
		return sqlSession.selectList("news.followingCmmt", feed);
	}

	//내가입그룹의 피드글출력
	@Override
	public List<FeedVo> joinGroupFeedSelectAll(MyFollowingVo following) {
		return sqlSession.selectList("news.joingroupFeed", following);
	}

	//내가입그룹의 피드글댓글출력
	@Override
	public List<GroupCommentVo> joinGroupCommentSelectAll(FeedVo feed) {
		return sqlSession.selectList("news.joingroupCmmt", feed);
	}
	
	//내팔로우의 피드글댓글더보기
	@Override
	public List<MyCommentVo> followCommentMore(MyPostVo myPost) {
		return sqlSession.selectList("news.followingCmmtMore", myPost);
	}
	
	//내가입그룹의 피드글댓글더보기
	@Override
	public List<GroupCommentVo> joingroupCmmtMore(GroupPostVo groupPost) {
		return sqlSession.selectList("news.joingroupCmmtMore", groupPost);
	}
	
	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 수정,등록,삭제/////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//뉴스피드(유저피드) 1개출력
	public FeedVo myFeedSelectOne(MyPostVo post) {
		return sqlSession.selectOne("news.myFeedSelectOne", post);
	}
	
	//뉴스피드(그룹피드) 1개출력
	public FeedVo groupFeedSelectOne(GroupPostVo grouppost) {
		return sqlSession.selectOne("news.groupFeedSelectOne", grouppost);
	}
	
	//뉴스피드(유저피드) 댓글등록
	@Override
	public void myFeedCmmtInsertOne(MyCommentVo cmmt) {
		sqlSession.insert("news.myFeedCmmtInsert", cmmt);
	}

	//뉴스피드(그룹피드) 댓글등록
	@Override
	public void groupFeedCmmtInsertOne(GroupCommentVo groupcmmt) {
		sqlSession.insert("news.groupFeedCmmtInsert", groupcmmt);
	}

	//뉴스피드(유저피드) 댓글삭제
	@Override
	public int myFeedCmmtDeleteOne(MyCommentVo cmmt) {
		return sqlSession.delete("news.myFeedCmmtDelete", cmmt);
	}

	//뉴스피드(그룹피드) 댓글삭제
	@Override
	public int groupFeedCmmtDeleteOne(GroupCommentVo groupcmmt) {
		return sqlSession.delete("news.groupFeedCmmtDelete", groupcmmt);
	}
	
	//뉴스피드(유저피드) 삭제
	@Override
	public int myFeedDeleteOne(MyPostVo post) {
		return sqlSession.delete("news.myFeedDelete", post);
	}

	//뉴스피드(그룹피드) 삭제
	@Override
	public int groupFeedDeleteOne(GroupPostVo grouppost) {
		return sqlSession.delete("news.groupFeedDelete", grouppost);
	}
	
	//뉴스피드(유저피드) 수정
	@Override
	public int myFeedUpdateOne(MyPostVo post) {
		return sqlSession.update("news.myFeedUpdate", post);
	}
	
	//뉴스피드(그룹피드) 수정
	@Override
	public int groupFeedUpdateOne(GroupPostVo grouppost) {
		return sqlSession.update("news.groupFeedUpdate", grouppost);
	}
	
	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 좋아요등록,해제////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//뉴스피드(유저피드) 좋아요등록
	@Override
	public void myFeedLikeInsertOne(MyGoodVo myGoodVo) {
		sqlSession.insert("news.myFeedLikeInsert", myGoodVo);
	}

	//뉴스피드(그룹피드) 좋아요등록
	@Override
	public void groupFeedLikeInsertOne(MyGoodVo myGoodVo) {
		sqlSession.insert("news.groupFeedLikeInsert", myGoodVo);
	}

	//뉴스피드(유저피드) 좋아요해제
	@Override
	public int myFeedLikeDeleteOne(MyGoodVo myGoodVo) {
		return sqlSession.delete("news.myFeedLikeDelete", myGoodVo);
	}
	
	//뉴스피드(그룹피드) 좋아요해제
	@Override
	public int groupFeedLikeDeleteOne(MyGoodVo myGoodVo) {
		return sqlSession.delete("news.groupFeedLikeDelete", myGoodVo);
	}

	//뉴스피드(개인피드) 좋아요등록시 개인피드좋아요 갯수 업데이트
	@Override
	public int myFeedLikeUpdate(MyPostVo post) {
		return sqlSession.update("news.myFeedLikeUpdate", post);
	}

	//뉴스피드(그룹피드) 좋아요등록시 그룹피드좋아요 갯수 업데이트
	@Override
	public int groupFeedLikeUpdate(GroupPostVo grouppost) {
		return sqlSession.update("news.groupFeedLikeUpdate", grouppost);
	}

	//내 좋아요목록 갱신
	@Override
	public List<MyGoodVo> myGoodRenewal(MyGoodVo good) {
		return sqlSession.selectList("news.myGoodRenewal", good);
	}
	
	//////////////////////////////////////////////////////////////////////
	/////////////////////피드,댓글 신고등록///////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	//뉴스피드(유저피드) 신고등록
	@Override
	public void myFeedReportInsertOne(ReportListVo report) {
		sqlSession.insert("news.myFeedReportInsert", report);
	}

	//뉴스피드(그룹피드) 신고등록
	@Override
	public void groupFeedReportInsertOne(ReportListVo report) {
		sqlSession.insert("news.groupFeedReportInsert", report);
	}

	//신고당한유저 신고당한횟수 +1
	@Override
	public int feedReportCountUpdate(ReportListVo report) {
		return sqlSession.update("news.feedReportCountUpdate", report);
	}
}
