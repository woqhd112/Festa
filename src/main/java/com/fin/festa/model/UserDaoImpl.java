package com.fin.festa.model;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowerVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;

@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	SqlSession sqlSession;
	
	////////////////////////////////////////////////////////////
	///////////////////마이페이지 화면출력//////////////////////
	////////////////////////////////////////////////////////////
	
	//내계정 비활성화,정지,추방 체크
	@Override
	public MyAdminVo adminCheck(ProfileVo profile) {
		return sqlSession.selectOne("user.inactiveAndStopAndKick",profile);
	}
	
	//내피드정보출력
	@Override
	public ProfileVo myInfo(ProfileVo profile) {
		return sqlSession.selectOne("user.myInfo",profile);
	}

	//내피드리스트 출력
	@Override
	public List<MyPostVo> myFeedSelectAll(ProfileVo profile) {
		return sqlSession.selectList("user.myFeedSelectAll",profile);
	}

	//내피드 댓글리스트 출력
	@Override
	public List<MyCommentVo> myFeedCmmtSelectAll(ProfileVo profile) {
		return sqlSession.selectList("user.myFeedCmmtSelectAll",profile);
	}

	//피드댓글 더보기 비동기
	@Override
	public List<MyCommentVo> FeedDetailCmmt(Model model, MyPostVo mypost) {
		return sqlSession.selectList("user.FeedDetailCmmt",mypost);
	}
	
	//내피드갯수 출력
	@Override
	public int myFeedCount(ProfileVo profile) {
		return sqlSession.selectOne("user.myFeedCount",profile);
	}

	//내팔로워갯수 출력
	@Override
	public int myFollowerCount(ProfileVo profile) {
		return sqlSession.selectOne("user.myFollowerCount",profile);
	}

	//내팔로잉갯수 출력
	@Override
	public int myFollowingCount(ProfileVo profile) {
		return sqlSession.selectOne("user.myFollowingCount",profile);
	}

	//내팔로워목록 출력
	@Override
	public List<MyFollowerVo> myFollowerSelectAll(ProfileVo profile) {
		return sqlSession.selectList("user.myFollowerList",profile);
	}

	//내팔로잉목록 출력
	@Override
	public List<MyFollowingVo> myFollowingSelectAll(ProfileVo profile) {
		return sqlSession.selectList("user.myFollowingList",profile);
	}

	////////////////////////////////////////////////////////////
	////////////////피드,댓글 등록,수정,삭제////////////////////
	////////////////////////////////////////////////////////////	
	
	//내피드 등록
	@Override
	public void myFeedInsertOne(MyPostVo post) {
		sqlSession.insert("user.myFeedInsert",post);
	}
	
	//내피드 디테일
	@Override
	public MyPostVo myFeedDetail(MyPostVo post) {
		return sqlSession.selectOne("user.myFeedDetail",post);
	}
	
	//내피드 수정
	@Override
	public int myFeedUpdateOne(MyPostVo post) {
		return sqlSession.update("user.myFeedUpdate",post);
	}

	//내피드 삭제
	@Override
	public int myFeedDeleteOne(MyPostVo post) {
		return sqlSession.delete("user.myFeedDelete",post);
	}

	//내피드댓글 등록
	@Override
	public void myFeedCmmtInsertOne(MyCommentVo cmmt) {
		sqlSession.insert("user.myFeedCmmtInsert",cmmt);
	}

	//내피드댓글 삭제
	@Override
	public int myFeedCmmtDeleteOne(MyCommentVo cmmt) {
		return sqlSession.delete("user.myFeedCmmtDelete",cmmt);
	}

	////////////////////////////////////////////////////////////
	/////////////////////팔로우 등록,해제///////////////////////
	////////////////////////////////////////////////////////////	
	
	//내팔로잉 등록
	@Override
	public void myFollowingInsertOne(MyFollowingVo following) {
		sqlSession.insert("user.myFollowingInsert",following);
	}

	//상대방팔로워 등록
	@Override
	public void yourFollowerInsertOne(MyFollowingVo following) {
		sqlSession.insert("user.yourFollowerInsert",following);
	}

	//내팔로잉 삭제 
	@Override
	public int myFollowingDeleteOne(MyFollowingVo following) {
		return sqlSession.delete("user.myFollowingDelete",following);
	}

	//상대방팔로워 삭제
	@Override
	public int yourFollowerDeleteOne(MyFollowingVo following) {
		return sqlSession.delete("user.yourFollowerDelete",following);
	}

	//내 팔로잉목록 갱신
	@Override
	public List<MyFollowingVo> myFollowingRenewal(MyFollowingVo following) {
		return sqlSession.selectList("user.myFollowingRenewal",following);
	}

	//팔로우하고 있는지 확인
	@Override
	public int isFollow(MyFollowerVo myFollowerVo) {
		return sqlSession.selectOne("user.isFollow",myFollowerVo);
	}
	
	////////////////////////////////////////////////////////////
	//////////////////피드좋아요 등록,해제//////////////////////
	////////////////////////////////////////////////////////////	

	//내피드 좋아요등록
	@Override
	public void myFeedLikeInsertOne(MyGoodVo good) {
		sqlSession.insert("user.myFeedLikeInsert",good);
	}

	//내피드 좋아요해제
	@Override
	public int myFeedLikeDeleteOne(MyGoodVo good) {
		return sqlSession.delete("user.myFeedLikeDelete",good);
	}

	//내피드 좋아요갯수 +1
	@Override
	public int myFeedLikeOnePlus(MyGoodVo myGoodVo) {
		return sqlSession.update("user.myFeedLikeOnePlus",myGoodVo);
	}

	//내피드 좋아요갯수 -1
	@Override
	public int myFeedLikeOneMinus(MyGoodVo myGoodVo) {
		return sqlSession.update("user.myFeedLikeOneMinus",myGoodVo);
	}

	//내 좋아요 목록 갱신
	@Override
	public List<MyGoodVo> myGoodRenewal(MyGoodVo good) {
		return sqlSession.selectList("user.myGoodRenewal",good);
	}

	////////////////////////////////////////////////////////////
	//////////////////유저,피드 신고등록////////////////////////
	////////////////////////////////////////////////////////////	

	//내피드 신고등록
	@Override
	public void myFeedReportInsertOne(ReportListVo report) {
		sqlSession.insert("user.myFeedReport",report);
	}

	//유저신고등록
	@Override
	public void userReportInsertOne(ReportListVo report) {
		sqlSession.insert("user.userReport",report);
	}

	//신고당한유저 신고당한횟수+1
	@Override
	public int userReportCountUpdate(ReportListVo report) {
		return sqlSession.update("user.userReportCountUpdate",report);
	}

	////////////////////////////////////////////////////////////
	//////////////////프로필정보 출력,수정//////////////////////
	////////////////////////////////////////////////////////////	

	//내그룹 존재유무 체크
	@Override
	public int groupCheck(ProfileVo profile) {
		return sqlSession.selectOne("user.myGroupCheck",profile);
	}

	//내사업자 존재유무 체크
	@Override
	public int ventureCheck(ProfileVo profile) {
		return sqlSession.selectOne("user.myVentureCheck",profile);
	}

	//사업자정보 존재 시 사업자정보값 담아두기
	@Override
	public MyVentureVo myVentureInfo(ProfileVo profile) {
		return sqlSession.selectOne("user.myVentureInfo",profile);
	}

	//사업자정보 미존재 시 등록유무 체크 (값이 null 이면 없는거)
	@Override
	public BigInteger myVentureRequestCheck(ProfileVo profile) {
		return sqlSession.selectOne("user.myVentureRequestCheck",profile);
	}

	//내캠핑장 존재유무 체크
	@Override
	public int campCheck(MyVentureVo myVenture) {
		return sqlSession.selectOne("user.myCampCheck",myVenture);
	}

	//가입정보 본인확인
	@Override
	public int identify(LoginVo login) {
		return sqlSession.selectOne("user.identify",login);
	}

	//내프로필정보 출력
	@Override
	public ProfileVo myProfile(ProfileVo profile) {
		return sqlSession.selectOne("user.myProfileInfo",profile);
	}

	//내프로필정보 수정
	@Override
	public int myProfileUpdate(ProfileVo profile) {
		return sqlSession.update("user.myProfileUpdate",profile);
	}

	////////////////////////////////////////////////////////////
	//////////////////내가입정보 출력,수정//////////////////////
	////////////////////////////////////////////////////////////	
	
	//소셜로그인 유무 체크
	@Override
	public int socialMemberCheck(ProfileVo profile) {
		return sqlSession.selectOne("user.socialMemberCheck",profile);
	}
	
	//내 가입정보 출력
	@Override
	public ProfileVo joinInfo(ProfileVo profile) {
		return sqlSession.selectOne("user.myJoinInfo",profile);
	}

	//내 가입정보 수정
	@Override
	public int joinInfoUpdate(ProfileVo profile) {
		return sqlSession.update("user.myJoinUpdate",profile);
	}

	////////////////////////////////////////////////////////////
	/////////////////계정비활성화,탈퇴처리//////////////////////
	////////////////////////////////////////////////////////////	
	
	//계정 비활성화처리
	@Override
	public int inactiveUpdate(MyAdminVo myAdminVo) {
		return sqlSession.update("user.inactiveUpdate",myAdminVo);
	}

	//계정탈퇴처리
	@Override
	public int userGoodBye(ProfileVo profile) {
		return sqlSession.delete("user.userGoodBye",profile);
	}

	//내그룹에 가입된 인원수 체크
	@Override
	public int groupUserCount(GroupVo group) {
		return sqlSession.selectOne("user.myGroupUserCount",group);
	}

	////////////////////////////////////////////////////////////
	///////////////////////그룹등록처리/////////////////////////
	////////////////////////////////////////////////////////////	
	
	//그룹등록처리 (비공식)
	@Override
	public void groupInsert(GroupVo group) {
		sqlSession.insert("user.myGroupInsert",group);
	}

	//그룹등록처리 (공식)
	@Override
	public void groupVentureInsert(GroupVo group) {
		sqlSession.insert("user.myVentureGroupInsert",group);
	}
	
	//그룹번호
	@Override
	public GroupVo groupmyGroup(ProfileVo profile) {
		return sqlSession.selectOne("user.myGroup",profile);
	}
	
	//그룹장 가입처리
	@Override
	public void myGroupJoin(GroupVo group) {
		sqlSession.insert("user.myGroupJoin", group);
	}


	////////////////////////////////////////////////////////////
	///////////////////////사업자관리///////////////////////////
	///////////////////////사업자등록///////////////////////////
	////////////////////////////////////////////////////////////	
	//사업자등록 신청
	@Override
	public void ventureRequest(UpdateWaitVo updateWait) {
		sqlSession.insert("user.myVentureRequest",updateWait);
	}

	////////////////////////////////////////////////////////////
	///////////////////////사업자관리///////////////////////////
	////////////////////////////////////////////////////////////	
	
	//사업자정보 수정
	@Override
	public int ventureUpdate(MyVentureVo venture) {
		return sqlSession.update("user.myVentureUpdate",venture);
	}

	//사업자정보 수정시 캠핑장정보도 수정(캠핑장이름, 지역권)
	@Override
	public int campInfoUpdate(MyVentureVo venture) {
		return sqlSession.update("user.campInfoUpdate",venture);
	}


	////////////////////////////////////////////////////////////
	///////////////////////캠핑장관리///////////////////////////
	///////////////////////캠핑장등록///////////////////////////
	////////////////////////////////////////////////////////////	
	
	//캠핑장등록
	@Override
	public void campInsert(CampVo camp) {
		sqlSession.insert("user.myCampInsert",camp);
	}
	
	//캠핑장 등록시 내 캠핑페이지 이동
	@Override
	public CampVo myCampPage(MyVentureVo myVenture) {
		return sqlSession.selectOne("user.myCampPage",myVenture);
	}

	////////////////////////////////////////////////////////////
	///////////////////////캠핑장관리///////////////////////////
	////////////////////////////////////////////////////////////	
	
	//내캠핑장정보 출력
	@Override
	public CampVo myCampSelectOne(MyVentureVo venture) {
		return sqlSession.selectOne("user.myCampSelectOne",venture);
	}
	
	//캠핑장정보 수정
	@Override
	public int campUpdate(CampVo camp) {
		return sqlSession.update("user.myCampUpdate",camp);
	}



}	
