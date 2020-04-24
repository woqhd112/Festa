package com.fin.festa.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.CampDaoImpl;
import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.util.UploadPhoto;

@Service
public class CampServiceImpl implements CampService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	CampDaoImpl campDao;
	
	//신규캠핑장 목록 출력
	//전국캠핑장 목록 출력
	@Override
	public void campSelectAll(Model model) {
		model.addAttribute("newCampList", campDao.newCampSelectAll());
		model.addAttribute("campList", campDao.allLocationCamp());
	}

	//특정지역 캠핑장 목록 출력
	@Override
	public void campLocation(Model model, CampVo campVo) {
		model.addAttribute("campList", campDao.locationCamp(campVo));
	}
	
	//해당 캠핑장이 공식그룹이 있는지 체크
	//공식그룹이 있으면 공식그룹 데이터값 저장(모델에 담아두기)
	//해당 캠핑장 정보 출력
	//한줄평 갯수 출력
	//한줄평 출력
	//해당캠핑장과 같은지역의 캠핑장 목록 출력
	@Override
	public void campSelectOne(Model model, CampVo campVo) {
		model.addAttribute("ventureGroup", campDao.campVentureGroup(campVo));	// 공식그룹 데이터값 저장
		
		model.addAttribute("camp", campDao.campInfoSelectOne(campVo));			// 해당 캠핑장 정보 출력
		
		int campReviewCount = campDao.campReviewCount(campVo);
		if (campReviewCount > 0) {		
			model.addAttribute("campReviewCount", campReviewCount);					// 한줄평 갯수 출력
			if(campVo.getPageSearch() == null) {								// 한줄평 페이지 초기화 (첫 페이지)
				PageSearchVo page = new PageSearchVo();
				page.setPage2(1);
				campVo.setPageSearch(page);
			}
			campVo.getPageSearch().setTotalCount2(campReviewCount);				// 한줄평 페이지 총 로우갯수
			model.addAttribute("paging", campVo.getPageSearch());
			
			model.addAttribute("campReviewList", campDao.campReview(campVo));	// 한줄평 출력
		}
	}
	
	@Override
	public void sameLocation(Model model, CampVo campVo) {
		model.addAttribute("sameList", campDao.sameLocationCamp(campVo));
	}

	//캠핑장 좋아요등록
	//캠핑장 좋아요 갯수 업데이트
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		campDao.campLikeInsert(myGoodVo);
		
		CampVo camp = new CampVo();
		camp.setCanum(myGoodVo.getCanum());
		campDao.campLikeUpdate(camp);
		
		req.getSession().setAttribute("goodlist", campDao.myGoodRenewal(myGoodVo));
	}

	//캠핑장 좋아요해제
	//캠핑장 좋아요 갯수 업데이트
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		campDao.campLikeDelete(myGoodVo);
		
		CampVo camp = new CampVo();
		camp.setCanum(myGoodVo.getCanum());
		campDao.campLikeUpdate(camp);
		
		req.getSession().setAttribute("goodlist", campDao.myGoodRenewal(myGoodVo));
	}

	//캠핑장 북마크등록
	//내 북마크목록 갱신
	@Override
	public void bookInsertOne(HttpServletRequest req, MyBookMarkVo myBookMarkVo) {
		campDao.campBookMarkInsert(myBookMarkVo);
		req.getSession().setAttribute("bookMark", campDao.mybookRenewal(myBookMarkVo));
	}

	//캠핑장 북마크해제
	//내 북마크목록 갱신
	@Override
	public void bookDeleteOne(HttpServletRequest req, MyBookMarkVo myBookMarkVo) {
		campDao.campBookMarkDelete(myBookMarkVo);
		req.getSession().setAttribute("bookMark", campDao.mybookRenewal(myBookMarkVo));
	}

	//한줄평 등록
	//캠핑장 평점업데이트
	@Transactional
	@Override
	public void reviewInsertOne(HttpServletRequest req, CampReviewVo campReviewVo) {
		campDao.campReviewInsert(campReviewVo);
		campDao.campAvgUpdate(campReviewVo);
	}

	//한줄평 삭제
	//캠핑장 평점업데이트
	@Transactional
	@Override
	public void reviewDeleteOne(CampReviewVo campReviewVo) {
		campDao.campReviewDelete(campReviewVo);
		campDao.campAvgUpdate(campReviewVo);
	}

	//해당 캠핑장 신고
	//캠핑장주인 신고당한횟수 +1
	@Transactional
	@Override
	public void campReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo) {
		UploadPhoto up = new UploadPhoto();
		String rlphoto = up.upload(files, req, reportListVo);
		reportListVo.setRlphoto(rlphoto);
		
		//기타버튼눌렀다가 다른거 체크하고 넘어온경우 다른거 체크값으로 대체
		String rlreport = reportListVo.getRlreport();
		String[] report = rlreport.split(",");
		if(report.length>1) {
			if(report[0].equals("기타")) {
				rlreport = report[1];
			}else {
				rlreport = report[0];
			}
		}else {
			rlreport=rlreport.substring(0, rlreport.length()-1);
		}
		reportListVo.setRlreport(rlreport);
		
		campDao.campReport(reportListVo);
		campDao.campReportCountUpdate(reportListVo);
	}
}
