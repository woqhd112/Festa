package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.ProfileVo;

public interface MemberDao {
	
	ProfileVo login(LoginVo login);
	
	void inactiveUpdate(ProfileVo profile);
	
	MyAdminVo stopAndKickMember(ProfileVo profile);

	List<JoinGroupVo> myJoinGroupSelectAll(int pronum);
	
	List<JoinGroupVo> myJoinGroupSelectAll(ProfileVo profile);
	
	List<MyBookMarkVo> myBookMarkSelectAll(ProfileVo profile);
	
	void memberInsert_nomal(ProfileVo profile);
	
	void memberInsert_social(ProfileVo profile);
	
	int idDuplicate(LoginVo login);
	
	ProfileVo findId(LoginVo login);
	
	ProfileVo findPw(LoginVo login);
	
	int pwUpdate(ProfileVo profile);
	
	List<GroupVo> goodGroupSelectAll();
	
	List<CampVo> goodCampSelectAll();
	
	List<MyGoodVo> myGoodSelectAll(ProfileVo profile);
	
	List<MyFollowingVo> myFollowingList(ProfileVo profile);
	
	void myadminInsert(ProfileVo profile);

	ProfileVo find_pronum(ProfileVo profile);

	ProfileVo loginCookie(LoginVo login);

}