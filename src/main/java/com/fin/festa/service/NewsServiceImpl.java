package com.fin.festa.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.IndexDaoImpl;
import com.fin.festa.model.NewsDaoImpl;
import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.util.DateCalculate;
import com.fin.festa.util.UploadPhoto;

@Service
public class NewsServiceImpl implements NewsService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	NewsDaoImpl newsDao;
	
	@Autowired 
	IndexDaoImpl indexDao;
	
	//뉴스피드 출력(그룹피드,개인피드 합쳐서)
	@Override
	public void newsFeedSelectAll(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		PageSearchVo page = new PageSearchVo();
		page.setPage5(1);
		
		FeedVo feed = new FeedVo();
		List<FeedVo> followFeed = newsDao.followFeedSelectAll(myFollowingVo);
		List<FeedVo> groupFeed = newsDao.joinGroupFeedSelectAll(myFollowingVo);
		List<FeedVo> feedList = new ArrayList<>();
		
		// 그룹/개인피드 (날짜순 정렬)
		DateCalculate cal = new DateCalculate();
		List<FeedVo> sortList = cal.VoDateReturn(followFeed, groupFeed);
		
		if (sortList.size() != 0) {
			if(sortList.size()>=page.getEndnum()) {
				for(int i=page.getStartnum()-1; i<page.getEndnum(); i++) {
					feedList.add(sortList.get(i));
				}
				req.setAttribute("feedList", feedList);
				
				// 팔로우피드 댓글
				feed.setFeedList(followFeed);
				if (followFeed.size() != 0) req.setAttribute("followComment", newsDao.followCommentSelectAll(feed));
				
				// 그룹피드 댓글
				feed.setFeedList(groupFeed);
				if (groupFeed.size() != 0) req.setAttribute("groupComment", newsDao.joinGroupCommentSelectAll(feed));
			}
		}
		// 우측사이드바 (추천그룹, 추천캠핑장)
		req.setAttribute("grouplist", indexDao.addrGroupSelectAll((ProfileVo)req.getSession().getAttribute("login")));
		req.setAttribute("camplist", indexDao.veryHotCampSelectAll());
	}
	
	// 뉴스피드 출력 (피드 더보기)
	@Override
	public void newsFeedMore(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		FeedVo feed = new FeedVo();
		List<FeedVo> followFeed = newsDao.followFeedSelectAll(myFollowingVo);
		List<FeedVo> groupFeed = newsDao.joinGroupFeedSelectAll(myFollowingVo);
		List<FeedVo> feedList = new ArrayList<>();
		
		// 그룹/개인피드 (날짜순 정렬)
		DateCalculate cal = new DateCalculate();
		List<FeedVo> sortList = cal.VoDateReturn(followFeed, groupFeed);
		
		PageSearchVo page = myFollowingVo.getPageSearch();
		if (sortList.size() != 0) {
			if(sortList.size()>=page.getEndnum()) {
				for(int i=page.getStartnum()-1; i<page.getEndnum(); i++) {
					feedList.add(sortList.get(i));
				}
				req.setAttribute("feedList", feedList);
				
				// 팔로우피드 댓글
				feed.setFeedList(followFeed);
				if (followFeed.size() != 0) req.setAttribute("followComment", newsDao.followCommentSelectAll(feed));
				
				// 그룹피드 댓글
				feed.setFeedList(groupFeed);
				if (groupFeed.size() != 0) req.setAttribute("groupComment", newsDao.joinGroupCommentSelectAll(feed));
			}
		}
	}
	
	// 뉴스피드 출력 (댓글 더보기)
	@Override
	public List<MyCommentVo> newsFeedCommentMore(Model model, MyPostVo myPost) {
		return newsDao.followCommentMore(myPost);
	}
	
	@Override
	public List<GroupCommentVo> newsGroupCommentMore(Model model, GroupPostVo groupPost) {
		return newsDao.joingroupCmmtMore(groupPost);
	}

	//뉴스피드 댓글등록(그룹피드,개인피드 구별해서 등록)
	@Override
	public void newsFeedCmmtInsertOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo) {
		if (groupCommentVo.getGpnum() == 0) {
			newsDao.myFeedCmmtInsertOne(myCommentVo);
		} else {
			newsDao.groupFeedCmmtInsertOne(groupCommentVo);
		}
	}

	//뉴스피드 댓글삭제(그룹피드,개인피드 구별해서 삭제)
	@Override
	public void newsFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo) {
		if(groupCommentVo.getGcnum()==0) {
			newsDao.myFeedCmmtDeleteOne(myCommentVo);
		} else {
			newsDao.groupFeedCmmtDeleteOne(groupCommentVo);
		}
	}

	//뉴스피드 좋아요등록(그룹피드,개인피드 구별해서 좋아요등록)
	//뉴스피드 좋아요갯수 +1
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void newsLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		if(myGoodVo.getGpnum()==0) {
			// 개인피드
			newsDao.myFeedLikeInsertOne(myGoodVo);			// 뉴스피드 좋아요등록
		
			MyPostVo post = new MyPostVo();
			post.setMpnum(myGoodVo.getMpnum());
			newsDao.myFeedLikeUpdate(post);					// 뉴스피드 좋아요갯수 업데이트
		} else {
			// 그룹피드
			newsDao.groupFeedLikeInsertOne(myGoodVo);
			
			GroupPostVo post = new GroupPostVo();
			post.setGpnum(myGoodVo.getGpnum());
			newsDao.groupFeedLikeUpdate(post);
		}
		req.getSession().setAttribute("goodlist", newsDao.myGoodRenewal(myGoodVo));
	}
	
	//뉴스피드 좋아요해제(그룹피드,개인피드 구별해서 좋아요해제)
	//뉴스피드 좋아요갯수 -1
	//내 좋아요목록 갱신
	@Transactional
	@Override
	public void newsLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		if(myGoodVo.getGpnum()==0) {
			// 개인피드
			newsDao.myFeedLikeDeleteOne(myGoodVo);			// 뉴스피드 좋아요해제
		
			MyPostVo post = new MyPostVo();
			post.setMpnum(myGoodVo.getMpnum());
			newsDao.myFeedLikeUpdate(post);					// 뉴스피드 좋아요갯수 업데이트
		} else {
			// 그룹피드
			newsDao.groupFeedLikeDeleteOne(myGoodVo);
			
			GroupPostVo post = new GroupPostVo();
			post.setGpnum(myGoodVo.getGpnum());
			newsDao.groupFeedLikeUpdate(post);
		}
		req.getSession().setAttribute("goodlist", newsDao.myGoodRenewal(myGoodVo));
	}

	//뉴스피드 신고등록(그룹피드,개인피드 구별해서 신고등록)
	//신고당한유저 신고당한횟수 +1
	@Transactional
	@Override
	public void newsFeedReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo) {
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
		
		if(reportListVo.getGpnum()==0) {
			// 개인피드
			newsDao.myFeedReportInsertOne(reportListVo);
		} else {
			// 그룹피드
			newsDao.groupFeedReportInsertOne(reportListVo);
		}
		newsDao.feedReportCountUpdate(reportListVo);
	}
	
	// 뉴스피드 1개출력(그룹피드,개인피드 구별)
	@Override
	public void newsFeedSelectOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo) {
		if(groupPostVo.getGpnum()==0) {
			model.addAttribute("feed", newsDao.myFeedSelectOne(myPostVo));
		} else {
			model.addAttribute("feed", newsDao.groupFeedSelectOne(groupPostVo));
		}
	}
	
	//뉴스피드 수정(그룹피드,개인피드 구별해서 수정)
	@Override
	public void newsFeedUpdateOne(HttpServletRequest req, GroupPostVo groupPostVo, MyPostVo myPostVo, MultipartFile[] files) {
		UploadPhoto up = new UploadPhoto();
		//개인피드인지 그룹피드인지 체크
		if(groupPostVo.getGpnum()==0) {
			String mpphoto = up.upload(files, req, myPostVo);
			//기존에 있던사진이 존재할때
			if(myPostVo.getMpphoto()!=null) {
				//넘어온 첨부사진이 존재할때(사진을 새로 등록했을때)
				if(!mpphoto.equals("")) {
					mpphoto=myPostVo.getMpphoto()+","+mpphoto;
					myPostVo.setMpphoto(mpphoto);
				}
			//기존에 있던사진이 없을때
			}else {
				myPostVo.setMpphoto(mpphoto);
			}
			newsDao.myFeedUpdateOne(myPostVo);
		}else {
			String gpphoto = up.upload(files, req, groupPostVo);
			//기존에 있던사진이 존재할때
			if(groupPostVo.getGpphoto()!=null) {
				//넘어온 첨부사진이 존재할때(사진을 새로 등록했을때)
				if(!gpphoto.equals("")) {
					gpphoto=groupPostVo.getGpphoto()+","+gpphoto;
					groupPostVo.setGpphoto(gpphoto);
				}
			//기존에 있던사진이 없을때
			}else {
				groupPostVo.setGpphoto(gpphoto);
			}
			newsDao.groupFeedUpdateOne(groupPostVo);
		}
	}

	//뉴스피드 삭제(그룹피드,개인피드 구별해서 삭제)
	@Override
	public void newsFeedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo) {
		if(groupPostVo.getGpnum()==0) {
			newsDao.myFeedDeleteOne(myPostVo);
		} else {
			newsDao.groupFeedDeleteOne(groupPostVo);
		}
	}
}
