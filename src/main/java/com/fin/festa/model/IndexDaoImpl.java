package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.ProfileVo;

@Repository
public class IndexDaoImpl implements IndexDao{

	@Autowired
	SqlSession sqlSession;
	
	//////////////////////////////////////////////////////////////////////
	//////////////////////////메인화면 출력///////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	
	//내 가입인원많은순 그룹출력 -비로그인
	@Override
	public List<GroupVo> totalGroupSelectAll() {
		
		return sqlSession.selectList("index.totalGroupList");
	}
	
	//가입하지않은 선호지역기반 그룹출력 -로그인
	@Override
	public List<GroupVo> addrGroupSelectAll(ProfileVo profile) {
		
		return sqlSession.selectList("index.addrGroupList",profile);
	}
	
	//좋아요 많은 캠핑장출력
	@Override
	public List<CampVo> veryHotCampSelectAll() {
		
		return sqlSession.selectList("index.campList");
	}

	
}
