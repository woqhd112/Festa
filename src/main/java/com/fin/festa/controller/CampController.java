package com.fin.festa.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.service.CampService;

@Controller
@RequestMapping("/camp/")
public class CampController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////캠핑장 관련//////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	@Autowired
	private CampService campService;
	
	//캠핑장 리스트
	//캠핑장 지역별 리스트
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String campSelectAll(Model model, CampVo campVo) {
		String caaddrsel = campVo.getCaaddrsel();
		if (caaddrsel == null) {		// 첫 페이지 초기화
			campVo.setCaaddrsel("");
		}
		campService.campSelectAll(model);
		campService.campLocation(model, campVo);
		return "camp/index";
	}
	
	//캠핑장 상세페이지
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String campSelectOne(HttpServletRequest req, Model model, CampVo campVo) {
		campService.campSelectOne(model, campVo);
		campService.sameLocation(model, campVo);
		return "camp/detail/index";
	}
	
	//캠핑장 좋아요
	@RequestMapping(value = "detail/likeadd", method = RequestMethod.POST)
	public String likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		campService.likeInsertOne(req, myGoodVo);
		return "camp/detail/index";
	}
	
	//캠핑장 좋아요 취소
	@RequestMapping(value = "detail/likedel", method = RequestMethod.POST)
	public String likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		campService.likeDeleteOne(req, myGoodVo);
		return "camp/detail/index";
	}
	
	//캠핑장 북마크
	@RequestMapping(value = "detail/bookadd", method = RequestMethod.POST)
	public String bookInsertOne(HttpServletRequest req, MyBookMarkVo myBookMarkVo) {
		campService.bookInsertOne(req, myBookMarkVo);
		return "camp/detail/index";
	}
	
	//캠핑장 북마크 취소
	@RequestMapping(value = "detail/bookdel", method = RequestMethod.POST)
	public String bookDeleteOne(HttpServletRequest req, MyBookMarkVo myBookMarkVo) {
		campService.bookDeleteOne(req, myBookMarkVo);
		return "camp/detail/index";
	}
	
	//캠핑장 한줄평 입력
	@RequestMapping(value = "detail/revadd", method = RequestMethod.POST)
	public String reviewInsertOne(HttpServletRequest req, CampReviewVo campReviewVo) {
		campService.reviewInsertOne(req, campReviewVo);
		return "camp/detail/index";
	}
	
	//캠핑장 한줄평 삭제 (내부팝업 기능)
	@RequestMapping(value = "detail/revdel", method = RequestMethod.POST)
	public String reviewDeleteOne(CampReviewVo campReviewVo) {
		campService.reviewDeleteOne(campReviewVo);
		return "camp/detail/index";
	}

	//캠핑장 신고 (팝업)
	@RequestMapping(value = "detail/report", method = RequestMethod.GET)
	public String campReport(Model model, CampVo campVo) {
		model.addAttribute("campReport", campVo);
		return "camp/detail/report";
	}
	
	//캠핑장 신고 (팝업>팝업 내 기능)
	@RequestMapping(value = "detail/report", method = RequestMethod.POST)
	public String campReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo) {
		campService.campReport(req, files, reportListVo);
		return "camp/detail/index";
	}
}
