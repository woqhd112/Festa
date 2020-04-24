package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

@Repository
public class CampDaoImpl implements CampDao{

	@Autowired
	SqlSession sqlSession;

	///////////////////////////////////////////////////////////////
	////////////////////캠핑정보 화면출력//////////////////////////
	///////////////////////////////////////////////////////////////
	
	//신규캠핑장 목록 출력
	@Override
	public List<CampVo> newCampSelectAll() {
		return sqlSession.selectList("camp.newCampSelectAll");
	}

	//전국캠핑장 목록 출력
	@Override
	public List<CampVo> allLocationCamp() {
		return sqlSession.selectList("camp.allLocationCamp");
	}

	//해당지역캠핑장 목록 출력
	@Override
	public List<CampVo> locationCamp(CampVo campVo) {
		return sqlSession.selectList("camp.locationCamp", campVo);
	}

	///////////////////////////////////////////////////////////////
	////////////////캠핑장상세 공식그룹 체크///////////////////////
	///////////////////////////////////////////////////////////////
	
	//해당캠핑장에 공식그룹이 있는지 체크
	@Override
	public int ventureGroupCheck(CampVo campVo) {
		return sqlSession.selectOne("camp.ventureGroupCheck", campVo);
	}

	//공식그룹이 있을시에 공식그룹정보 출력
	@Override
	public GroupVo campVentureGroup(CampVo campVo) {
		return sqlSession.selectOne("camp.campVentureGroup", campVo);
	}

	///////////////////////////////////////////////////////////////
	///////////////////캠핑장상세 화면출력/////////////////////////
	///////////////////////////////////////////////////////////////
	
	//캠핑장정보 출력
	@Override
	public CampVo campInfoSelectOne(CampVo campVo) {
		return sqlSession.selectOne("camp.campInfoSelectOne", campVo);
	}
	
	//캠핑장 한줄평 총갯수
	@Override
	public int campReviewCount(CampVo campVo) {
		return sqlSession.selectOne("camp.campReviewCount", campVo);
	}
	
	//캠핑장 한줄평출력
	@Override
	public List<CampReviewVo> campReview(CampVo campVo) {
		return sqlSession.selectList("camp.campReview", campVo);
	}
	
	//해당캠핑장과 같은지역의 캠핑장목록 출력
	@Override
	public List<CampVo> sameLocationCamp(CampVo campVo) {
		return sqlSession.selectList("camp.sameLocationCamp", campVo);
	}

	///////////////////////////////////////////////////////////////
	/////////////////캠핑장한줄평 등록,삭제////////////////////////
	///////////////////////////////////////////////////////////////
	
	//캠핑장 한줄평등록
	@Override
	public void campReviewInsert(CampReviewVo campReviewVo) {
		sqlSession.insert("campReviewInsert", campReviewVo);
	}

	//캠핑장 한줄평 등록시 캠핑장평점 계산해서 업데이트
	@Override
	public int campAvgUpdate(CampReviewVo campReviewVo) {
		return sqlSession.update("camp.campAvgUpdate", campReviewVo);
	}

	//캠핑장 한줄평삭제
	@Override
	public int campReviewDelete(CampReviewVo campReviewVo) {
		return sqlSession.delete("camp.campReviewDelete", campReviewVo);
	}

	///////////////////////////////////////////////////////////////
	/////////////////캠핑장 좋아요등록,해제////////////////////////
	///////////////////////////////////////////////////////////////
	
	//캠핑장 좋아요등록
	@Override
	public void campLikeInsert(MyGoodVo myGoodVo) {
		sqlSession.insert("camp.campLikeInsert", myGoodVo);
	}

	//캠핑장 좋아요해제
	@Override
	public int campLikeDelete(MyGoodVo myGoodVo) {
		return sqlSession.delete("camp.campLikeDelete", myGoodVo);
	}
	
	//캠핑장 좋아요 갯수
	@Override
	public int campLikeUpdate(CampVo campVo) {
		return sqlSession.update("camp.campLikeUpdate", campVo);
	}

	//내 좋아요목록 갱신
	@Override
	public List<MyGoodVo> myGoodRenewal(MyGoodVo myGoodVo) {
		return sqlSession.selectList("camp.myGoodRenewal", myGoodVo);
	}

	///////////////////////////////////////////////////////////////
	////////////////////////캠핑장 신고등록////////////////////////
	///////////////////////////////////////////////////////////////
	
	//캠핑장 신고등록
	@Override
	public void campReport(ReportListVo reportListVo) {
		sqlSession.insert("camp.campReport", reportListVo);
	}

	//캠핑장주인 신고당한횟수 +1
	@Override
	public int campReportCountUpdate(ReportListVo reportListVo) {
		return sqlSession.update("camp.campReportCountUpdate", reportListVo);
	}

	///////////////////////////////////////////////////////////////
	///////////////////캠핑장 북마크등록,해제//////////////////////
	///////////////////////////////////////////////////////////////
	
	//캠핑장 북마크등록
	@Override
	public void campBookMarkInsert(MyBookMarkVo myBookMarkVo) {
		sqlSession.insert("camp.campBookMarkInsert", myBookMarkVo);
	}

	//캠핑장 북마크해제
	@Override
	public int campBookMarkDelete(MyBookMarkVo myBookMarkVo) {
		return sqlSession.delete("camp.campBookMarkDelete", myBookMarkVo);
	}

	//내 북마크목록 갱신
	@Override
	public List<MyBookMarkVo> mybookRenewal(MyBookMarkVo bookMarkVo) {
		return sqlSession.selectList("camp.mybookRenewal", bookMarkVo);
	}
}
