package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.ProfileVo;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	SqlSession sqlSession;
	
	////////////////////////////////////////////////////////////
	///////////////////////로그인처리///////////////////////////
	//////////////////로그인 시 담을 데이터/////////////////////
	////////////////////////////////////////////////////////////
	
	//로그인처리 및 해당 회원정보출력
	@Override
	public ProfileVo login(LoginVo login) {
		return sqlSession.selectOne("member.login",login);
	}

	//로그인과 동시작업  계정 비활성화해제 업데이트(1=활성화, 2=비활성화)
	@Override
	public void inactiveUpdate(ProfileVo profile) {
		sqlSession.update("member.inactive",profile);
	}
	
	//로그인과 동시작업  정지,추방계정,관리자인지 체크
	@Override
	public MyAdminVo stopAndKickMember(ProfileVo profile) {
		return sqlSession.selectOne("member.stopAndKick",profile) ;
	}
	
	
	//그룹해체시 세션갱신
	@Override
	public List<JoinGroupVo> myJoinGroupSelectAll(int pronum) {
		return sqlSession.selectList("member.myJoinGroupList", pronum);
	}
	
	//로그인과 동시작업(로그인완료 되면)  해당회원의 가입그룹목록출력
	@Override
	public List<JoinGroupVo> myJoinGroupSelectAll(ProfileVo profile) {
		return sqlSession.selectList("member.myJoinGroupList", profile);
	}
	
	//로그인과 동시작업(로그인완료 되면)  해당회원의 북마크목록출력
	@Override
	public List<MyBookMarkVo> myBookMarkSelectAll(ProfileVo profile) {
		return sqlSession.selectList("member.myBookMarkList",profile);
	}

	//추천그룹리스트 출력
	@Override
	public List<GroupVo> goodGroupSelectAll() {
		return sqlSession.selectList("member.groupList");
	}

	//추천캠핑장리스트 출력
	@Override
	public List<CampVo> goodCampSelectAll() {
		return sqlSession.selectList("member.campList");
	}

	//내좋아요목록 출력
	@Override
	public List<MyGoodVo> myGoodSelectAll(ProfileVo profile) {
		return sqlSession.selectList("member.myGoodSelectAll",profile);
	}

	//내 팔로잉리스트 출력(세션에 값만 가지고있기)
	@Override
	public List<MyFollowingVo> myFollowingList(ProfileVo profile) {
		return sqlSession.selectList("member.myFollowing",profile);
	}
	
	////////////////////////////////////////////////////////////
	/////////////////////회원가입처리///////////////////////////
	////////////////////////////////////////////////////////////
	
	//회원가입 아이디중복처리
	@Override
	public int idDuplicate(LoginVo login) {
		return sqlSession.selectOne("member.idDuplicate",login);
	}
	
	//회원가입등록처리 - 일반
	@Override
	public void memberInsert_nomal(ProfileVo profile) {
		sqlSession.insert("member.memberInsert_nomal",profile);
	}

	//회원가입등록처리 - 소셜
	@Override
	public void memberInsert_social(ProfileVo profile) {
		sqlSession.insert("member.memberInsert_social",profile);
	}

	//회원가입한 유저 pronum받기
	@Override
	public ProfileVo find_pronum(ProfileVo profile) {
		return sqlSession.selectOne("member.find_pronum",profile);
	}
	
	//회원가입 성공시 내관리테이블 생성
	@Override
	public void myadminInsert(ProfileVo profile) {
		sqlSession.insert("member.myadminInsert",profile);
	}
	
	////////////////////////////////////////////////////////////
	///////////////////////아이디찾기///////////////////////////
	////////////////////////////////////////////////////////////
	
	//아이디찾기
	@Override
	public ProfileVo findId(LoginVo login) {
		return sqlSession.selectOne("member.findId",login);
	}
	
	////////////////////////////////////////////////////////////
	/////////////////////////비번찾기///////////////////////////
	////////////////////////////////////////////////////////////
	
	//비밀번호찾기
	@Override
	public ProfileVo findPw(LoginVo login) {
		return sqlSession.selectOne("member.findPw",login);
	}

	//비번찾기 후 비번설정
	@Override
	public int pwUpdate(ProfileVo profile) {
		return sqlSession.update("member.pwUpdate",profile);
	}


	//로그인유지
		@Override
		public ProfileVo loginCookie(LoginVo login) {
			
			return sqlSession.selectOne("member.loginCookie", login);
		}



	


}
