package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

@Repository
public class SearchDaoImpl implements SearchDao{

	@Autowired
	SqlSession sqlSession;

	/////////////////////////////////////////////////////////
	///////////////////검색페이지 출력///////////////////////
	/////////////////////////////////////////////////////////
	
	//검색했을시 캠핑장정보 출력
	@Override
	public List<CampVo> searchCampSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("search.searchCampSelectAll", search);
	}

	//검색했을시 그룹정보 출력
	@Override
	public List<GroupVo> searchGroupSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("search.searchGroupSelectAll", search);
	}

	//검색그룹정보의 토탈카운트갯수
	@Override
	public int searchGroupCount(PageSearchVo search) {
		
		return sqlSession.selectOne("search.searchGroupCount", search);
	}

	//검색했을시 내피드정보 출력
	@Override
	public List<FeedVo> searchMyFeedSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("search.searchMyFeedSelectAll", search);
	}

	//검색했을시 그룹피드정보 출력
	@Override
	public List<FeedVo> searchGroupFeedSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("search.searchGroupFeedSelectAll", search);
	}

	/////////////////////////////////////////////////////////
	/////////////////피드상세페이지 출력/////////////////////
	/////////////////////////////////////////////////////////
	
	//개인피드 상세페이지
	@Override
	public FeedVo myFeedDetail(MyPostVo post) {
		
		return sqlSession.selectOne("search.myFeedDetail", post);
	}

	//그룹피드 상세페이지
	@Override
	public FeedVo groupFeedDetail(GroupPostVo grouppost) {
		
		return sqlSession.selectOne("search.groupFeedDetail", grouppost);
	}

	//내피드 댓글출력
	@Override
	public List<MyCommentVo> myFeedCmmtSelectAll(FeedVo feed) {
		
		return sqlSession.selectList("search.myFeedCmmtSelectAll", feed);
	}

	//그룹피드 댓글출력
	@Override
	public List<GroupCommentVo> groupFeedCmmtSelectAll(FeedVo feed) {
		
		return sqlSession.selectList("search.groupFeedCmmtSelectAll", feed);
	}

	//그룹피드 댓글더보기 비동기
	@Override
	public List<GroupCommentVo> searchGroupCmmt(GroupCommentVo groupCommentVo) {
		
		return sqlSession.selectList("search.searchGroupCmmt", groupCommentVo);
	}

	//개인피드 댓글더보기 비동기
	@Override
	public List<MyCommentVo> searchMyCmmt(MyCommentVo myCommentVo) {
		
		return sqlSession.selectList("search.searchMyCmmt", myCommentVo);
	}


	/////////////////////////////////////////////////////////
	///////////////피드,댓글 등록,수정,삭제//////////////////
	/////////////////////////////////////////////////////////
	
	//내피드 댓글등록
	@Override
	public void myFeedCmmtInsertOne(MyCommentVo cmmt) {

		sqlSession.insert("search.myFeedCmmtInsertOne", cmmt);
	}
	
	//그룹피드 댓글등록
	@Override
	public void groupFeedCmmtInsertOne(GroupCommentVo groupcmmt) {

		sqlSession.insert("search.groupFeedCmmtInsertOne", groupcmmt);
	}
	
	//내피드수정
	@Override
	public int myFeedUpdateOne(MyPostVo post) {
		// TODO Auto-generated method stub
		return 0;
	}

	//그룹피드수정
	@Override
	public int groupFeedUpdateOne(GroupPostVo grouppost) {
		// TODO Auto-generated method stub
		return 0;
	}

	//내피드삭제
	@Override
	public int myFeedDeleteOne(MyPostVo post) {
		// TODO Auto-generated method stub
		return 0;
	}

	//그룹피드삭제
	@Override
	public int groupFeedDeleteOne(GroupPostVo grouppost) {
		// TODO Auto-generated method stub
		return 0;
	}

	//내피드 댓글삭제
	@Override
	public int myFeedCmmtDeleteOne(MyCommentVo cmmt) {
		// TODO Auto-generated method stub
		return 0;
	}

	//그룹피드 댓글삭제
	@Override
	public int groupFeedCmmtDeleteOne(GroupCommentVo groupcmmt) {
		// TODO Auto-generated method stub
		return 0;
	}

	/////////////////////////////////////////////////////////
	/////////////////피드 좋아요등록,해제////////////////////
	/////////////////////////////////////////////////////////
	
	//내피드 좋아요등록
	@Override
	public void myFeedLikeInsertOne(MyGoodVo good) {
		
		sqlSession.insert("search.myFeedLikeInsertOne", good);
	}

	//그룹피드 좋아요등록
	@Override
	public void groupFeedLikeInsertOne(MyGoodVo good) {
		
		sqlSession.insert("search.groupFeedLikeInsertOne", good);
	}

	//내피드 좋아요해제
	@Override
	public int myFeedLikeDeleteOne(MyGoodVo good) {
		
		return sqlSession.delete("search.myFeedLikeDeleteOne", good);
	}

	//그룹피드 좋아요해제
	@Override
	public int groupFeedLikeDeleteOne(MyGoodVo good) {
		
		return sqlSession.delete("search.groupFeedLikeDeleteOne", good);
	}

	//내피드 좋아요등록시 피드좋아요 갯수+1
	@Override
	public int myFeedLikePlusOne(MyGoodVo good) {
		
		return sqlSession.update("search.myFeedLikePlusOne", good);
	}

	//그룹피드 좋아요등록시 피드좋아요 갯수+1
	@Override
	public int groupFeedLikePlusOne(MyGoodVo good) {
		
		return sqlSession.update("search.groupFeedLikePlusOne", good);
	}

	//내피드 좋아요해제시 피드좋아요 갯수-1
	@Override
	public int myFeedLikeMinusOne(MyGoodVo good) {
		
		return sqlSession.update("search.myFeedLikeMinusOne", good);
	}

	//그룹피드 좋아요해제시 피드좋아요 갯수-1
	@Override
	public int groupFeedLikeMinusOne(MyGoodVo good) {
		
		return sqlSession.update("search.groupFeedLikeMinusOne", good);
	}

	//내 좋아요목록 갱신
	@Override
	public List<MyGoodVo> myGoodRenewal(MyGoodVo good) {
		
		return sqlSession.selectList("search.myGoodRenewal", good);
	}

	/////////////////////////////////////////////////////////
	////////////////////피드 신고등록////////////////////////
	/////////////////////////////////////////////////////////
	
	//내피드신고등록
	@Override
	public void myFeedReportInsertOne(ReportListVo report) {

		sqlSession.insert("search.myFeedReportInsertOne", report);
	}

	//그룹피드신고등록
	@Override
	public void groupFeedReportInsertOne(ReportListVo report) {

		sqlSession.insert("search.groupFeedReportInsertOne", report);
	}
	
	//피드신고등록시 신고당한사람 신고당한횟수 +1
	@Override
	public int feedUserReportCountUpdate(ReportListVo report) {
		
		return sqlSession.update("search.feedUserReportCountUpdate", report);
	}

}
