package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.SearchDaoImpl;
import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.util.DateCalculate;
import com.fin.festa.util.UploadPhoto;

@Service
public class SearchServiceImpl implements SearchService{

	//쿼리문 다시 손볼것
	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	SearchDaoImpl searchDao;
	
	//검색조건으로 캠핑장, 그룹, 피드출력 (정렬순 좋아요)
	//캠핑장 - 캠핑장이름으로 출력
	//그룹 - 그룹명으로 출력
	//피드(개인,그룹) - 해시태그로 출력
	@Override
	public void search(HttpServletRequest req, PageSearchVo pageSearchVo) {

		//그룹첫페이지값 저장
		if(pageSearchVo.getPage3()==0) {
			pageSearchVo.setPage3(1);
		}
		pageSearchVo.setTotalCount3(searchDao.searchGroupCount(pageSearchVo));
		
		//피드스크롤더보기 페이지값 저장
		if(pageSearchVo.getPage5()==0) {
			pageSearchVo.setPage5(1);
		}
		
		
		DateCalculate cal=new DateCalculate();
		List<FeedVo> myFeedList = searchDao.searchMyFeedSelectAll(pageSearchVo);
		List<FeedVo> groupFeedList = searchDao.searchGroupFeedSelectAll(pageSearchVo);
		
		//피드 날짜순 정렬
		req.setAttribute("searchFeed", cal.VoGoodReturn(groupFeedList, myFeedList));
		
		System.out.println(pageSearchVo);
		req.setAttribute("searchCamp", searchDao.searchCampSelectAll(pageSearchVo));
		req.setAttribute("searchGroup", searchDao.searchGroupSelectAll(pageSearchVo));
		req.setAttribute("paging", pageSearchVo);
		
	}

	//검색피드 스크롤더보기
	@Override
	public List<FeedVo> searchScroll(HttpServletRequest req, PageSearchVo pageSearchVo) {

		DateCalculate cal=new DateCalculate();
		List<FeedVo> myFeedList = searchDao.searchMyFeedSelectAll(pageSearchVo);
		List<FeedVo> groupFeedList = searchDao.searchGroupFeedSelectAll(pageSearchVo);
		return cal.VoGoodReturn(groupFeedList, myFeedList);
	}

	//피드상세페이지 출력(그룹피드,개인피드 구분) 
	@Override
	public void searchFeedDetail(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {

		//검색피드 상세페이지 그룹,개인피드 구분
		//개인피드일때
		FeedVo feed = null;
		if(groupPostVo.getGpnum()==0) {
			feed = searchDao.myFeedDetail(myPostVo);
			model.addAttribute("feedDetail", feed);
			model.addAttribute("feedCmmt", searchDao.myFeedCmmtSelectAll(feed));
		//그룹피드일때
		}else {
			feed = searchDao.groupFeedDetail(groupPostVo);
			model.addAttribute("feedDetail", feed);
			model.addAttribute("feedCmmt", searchDao.groupFeedCmmtSelectAll(feed));
		}
	}

	//그룹피드 댓글더보기 비동기
	@Override
	public List<GroupCommentVo> searchGroupCmmt(Model model, GroupCommentVo groupCommentVo) {
		
		return searchDao.searchGroupCmmt(groupCommentVo);
	}

	//개인피드 댓글더보기 비동기
	@Override
	public List<MyCommentVo> searchMyCmmt(Model model, MyCommentVo myCommentVo) {
		
		return searchDao.searchMyCmmt(myCommentVo);
	}

	//피드수정(내피드,그룹피드 구분)
	@Override
	public void searchFeedUpdateOne(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		// TODO Auto-generated method stub
		
	}

	//피드삭제(내피드,그룹피드 구분)
	@Override
	public void searchFeedDeleteOne(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		// TODO Auto-generated method stub
		
	}

	//피드댓글삭제(내피드,그룹피드 구분)
	@Override
	public void searchFeedCmmtDeletetOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo) {
		// TODO Auto-generated method stub
		
	}
	
	//피드댓글등록(내피드,그룹피드 구분)
	@Override
	public void searchFeedCmmtInsertOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo) {

		//개인피드 댓글등록
		if(groupCommentVo.getGpnum()==0) {
			searchDao.myFeedCmmtInsertOne(myCommentVo);
		//그룹피드 댓글등록
		}else {
			searchDao.groupFeedCmmtInsertOne(groupCommentVo);
		}
	}

	//피드신고(내피드,그룹피드 구분)
	//신고당한사람 신고당한횟수 +1
	@Transactional
	@Override
	public void searchFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {

		UploadPhoto up = new UploadPhoto();
		String rlphoto = up.upload(files, req, reportListVo);
		reportListVo.setRlphoto(rlphoto);
		
		//기타버튼눌렀다가 다른거체크하고 넘어온경우 다른거체크값으로 대체
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
		
		//개인피드인지 그룹피드인지 체크
		if(reportListVo.getGpnum()==0) {
			searchDao.myFeedReportInsertOne(reportListVo);
		}else {
			searchDao.groupFeedReportInsertOne(reportListVo);
		}
		
		searchDao.feedUserReportCountUpdate(reportListVo);
	}

	//피드좋아요등록(내피드,그룹피드 구분)
	//해당피드 좋아요 갯수 +1
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void searchFeedLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {

		//개인피드일때
		if(myGoodVo.getGpnum()==0) {
			searchDao.myFeedLikeInsertOne(myGoodVo);
			searchDao.myFeedLikePlusOne(myGoodVo);
		//그룹피드일때
		}else {
			searchDao.groupFeedLikeInsertOne(myGoodVo);
			searchDao.groupFeedLikePlusOne(myGoodVo);
		}
		req.getSession().setAttribute("goodlist", searchDao.myGoodRenewal(myGoodVo));
	}

	//피드좋아요해제(내피드,그룹피드 구분)
	//해당피드 좋아요 갯수 -1
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void searchFeedLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		
		//개인피드일때
		if(myGoodVo.getGpnum()==0) {
			searchDao.myFeedLikeDeleteOne(myGoodVo);
			searchDao.myFeedLikeMinusOne(myGoodVo);
		//그룹피드일때
		}else {
			searchDao.groupFeedLikeDeleteOne(myGoodVo);
			searchDao.groupFeedLikeMinusOne(myGoodVo);
		}
		req.getSession().setAttribute("goodlist", searchDao.myGoodRenewal(myGoodVo));
		
	}

	

}
