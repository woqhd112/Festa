package com.fin.festa.model;

import java.math.BigInteger;
import java.util.List;

import org.springframework.ui.Model;

import com.fin.festa.model.entity.CampVo;
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

public interface UserDao {
	
	ProfileVo myInfo(ProfileVo profile); 
	
	MyAdminVo adminCheck(ProfileVo profile);
	
	List<MyPostVo> myFeedSelectAll(ProfileVo profile);
	
	List<MyCommentVo> myFeedCmmtSelectAll(ProfileVo profile);
	
	int myFeedCount(ProfileVo profile);
	
	int myFollowerCount(ProfileVo profile);
	
	int myFollowingCount(ProfileVo profile);
	
	void myFeedInsertOne(MyPostVo post);
	
	int myFeedUpdateOne(MyPostVo post);
	
	int myFeedDeleteOne(MyPostVo post);
	
	void myFeedCmmtInsertOne(MyCommentVo cmmt);
	
	int myFeedCmmtDeleteOne(MyCommentVo cmmt);
	
	List<MyFollowerVo> myFollowerSelectAll(ProfileVo profile);
	
	List<MyFollowingVo> myFollowingSelectAll(ProfileVo profile);
	
	void myFollowingInsertOne(MyFollowingVo following);
	
	void yourFollowerInsertOne(MyFollowingVo following);
	
	int myFollowingDeleteOne(MyFollowingVo following);
	
	int yourFollowerDeleteOne(MyFollowingVo following);
	
	int groupCheck(ProfileVo profile);
	
	int ventureCheck(ProfileVo profile);
	
	int campCheck(MyVentureVo myVenture);
	
	int identify(LoginVo login);
	
	ProfileVo myProfile(ProfileVo profile);
	
	int myProfileUpdate(ProfileVo profile);
	
	ProfileVo joinInfo(ProfileVo profile);
	
	int joinInfoUpdate(ProfileVo profile);
	
	int userGoodBye(ProfileVo profile);
	
	void groupInsert(GroupVo group);
	
	void groupVentureInsert(GroupVo group);
	
	void ventureRequest(UpdateWaitVo updateWait);
	
	int ventureUpdate(MyVentureVo venture);
	
	CampVo myCampSelectOne(MyVentureVo venture);
	
	void campInsert(CampVo camp);
	
	int campUpdate(CampVo camp);
	
	void myFeedLikeInsertOne(MyGoodVo good);
	
	int myFeedLikeDeleteOne(MyGoodVo good);
	
	void myFeedReportInsertOne(ReportListVo report);
	
	void userReportInsertOne(ReportListVo report);
	
	int groupUserCount(GroupVo group);
	
	MyVentureVo myVentureInfo(ProfileVo profile);
	
	BigInteger myVentureRequestCheck(ProfileVo profile);
	
	List<MyGoodVo> myGoodRenewal(MyGoodVo good);
	
	List<MyFollowingVo> myFollowingRenewal(MyFollowingVo following);
	
	int campInfoUpdate(MyVentureVo venture);
	
	int userReportCountUpdate(ReportListVo report);
	
	int socialMemberCheck(ProfileVo profile);

	GroupVo groupmyGroup(ProfileVo profile);

	void myGroupJoin(GroupVo group);

	MyPostVo myFeedDetail(MyPostVo post);

	List<MyCommentVo> FeedDetailCmmt(Model model, MyPostVo mypost);

	int inactiveUpdate(MyAdminVo myAdminVo);

	CampVo myCampPage(MyVentureVo myVenture);

	int isFollow(MyFollowerVo myFollowerVo);

	int myFeedLikeOnePlus(MyGoodVo myGoodVo);

	int myFeedLikeOneMinus(MyGoodVo myGoodVo);
	
}