package com.fin.festa.model.entity;

public class PageSearchVo {		//검색 & 페이지 

	private String search;		//조건 검색
	private String keyword;		//해당 검색어
	private String category;	//관리자페이지 신고쪽에 하위메뉴(그룹,캠핑장,내피드,그룹피드,공지피드,유저)
	private int check;			//관리자페이지 신고쪽 분류(접수중=1,처리완료=2)
	private int startnum;		//한페이지 게시글 개수(시작)
	private int endnum;			//한페이지 게시글 개수(끝)
	
	private int page;			//현재 페이지 디폴트1  (10개 로우를 조회할때 쓰는 페이지)  
	private int page2;			//현재 페이지 디폴트1  (5개 로우를 조회할때 쓰는 페이지)
	private int page3;			//현재 페이지 디폴트1  (6개 로우를 조회할때 쓰는 페이지)
	private int page4;			//피드댓글 출력할때 쓰는 페이지
	private int page5;			//피드스크롤더보기 출력할때 쓰는 페이지
	private int displayRow=10;	//한 페이지에 row갯수
	private int totalCount;		//전체 게시글수
	private int beginPage;		//한화면에 보이는 첫페이지
	private int endPage;		//한화면에 보이는 마지막페이지
	private int displayRow2=5;	//한 페이지에 row갯수
	private int displayRow3=6;	//한 페이지에 row갯수
	private int displayPage=5;	//한화면에 보이는 총 페이지갯수
	private int displayPage2=6;	//한화면에 보이는 총 페이지갯수
	boolean prev;				//prev 버튼 활성화
	boolean next;				//next 버튼 활성화
	private int totalPage;
	


	//파라미터로 페이지값 가져올때 자동적으로 로우갯수 설정 10개로우검색
	public void setPage(int page) {
		this.page = page;
		startnum=(page-1)*10+1;
		endnum=page*10;
	}
	
	//파라미터로 페이지값 가져올때 자동적으로 로우갯수 설정 5개로우검색
	public void setPage2(int page2) {
		this.page2 = page2;
		startnum=(page2-1)*5+1;
		endnum=page2*5;
	}
	
	//파라미터로 페이지값 가져올때 자동적으로 로우갯수 설정 6개로우검색
	public void setPage3(int page3) {
		this.page3 = page3;
		startnum=(page3-1)*6+1;
		endnum=page3*6;
	}

	//파라미터로 피드댓글 페이지값 가져올때 자동적으로 로우갯수 설정(피드댓글더보기)
	public void setPage4(int page4) {
		this.page4 = page4;
		startnum=page4*3-2;
		endnum=page4*3;
	}

	//파라미터로 피드 페이지값 가져올때 자동적으로 로우갯수 설정(피드스크롤더보기)
	public void setPage5(int page5) {
		this.page5 = page5;
		startnum=page5*2-1;
		endnum=page5*2;
	}

	
	//테이블 로우갯수를 넣고 페이지기능 구현  (10개 로우를 조회할때 쓰는 기능)
	public void setTotalCount(int totalCount){
		
		this.totalCount=totalCount;
		paging();
	}
	
	//테이블 로우갯수를 넣고 페이지기능 구현  (5개의 로우를 조회할때 쓰는 기능)
	public void setTotalCount2(int totalCount){
		
		this.totalCount=totalCount;
		paging2();
	}
	
	//테이블 로우갯수를 넣고 페이지기능 구현  (5개의 로우를 조회할때 쓰는 기능)
	public void setTotalCount3(int totalCount){
		
		this.totalCount=totalCount;
		paging3();
	}

	private void paging(){
		totalPage=totalCount/displayRow;
		
		//맥스페이지 갯수 조건
		System.out.println("다음페이지 유뮤 : "+(totalCount%displayRow!=0));
		if(totalCount%displayRow!=0){
			totalPage+=1;
		}
		//prev,next,beginPage,endPage를 계산
		endPage = ((page+(displayPage-1))/displayPage)*displayPage;
		beginPage = endPage - (displayPage-1);
		
		if(totalPage<endPage&&totalPage==page){
			endPage=totalPage;
			next=false;
		}else if(totalPage<endPage&&totalPage>page) {
			endPage=totalPage;
			next=true;
		}else if(totalPage==endPage&&totalPage==page){
			next=false;
		}else {
			next=true;
		}
		if(beginPage==1){
			prev=false;
		}else{
			prev=true;
		}
		//prev=(beginPage==1)?false:true;
	}
	
	private void paging2(){
		totalPage=totalCount/displayRow2;
		
		//맥스페이지 갯수 조건
		System.out.println("다음페이지 유뮤 : "+(totalCount%displayRow2!=0));
		if(totalCount%displayRow2!=0){
			totalPage+=1;
		}
		//prev,next,beginPage,endPage를 계산
		endPage = ((page2+(displayPage-1))/displayPage)*displayPage;
		beginPage = endPage - (displayPage-1);
		
		if(totalPage<endPage&&totalPage==page2){
			endPage=totalPage;
			next=false;
		}else if(totalPage<endPage&&totalPage>page2) {
			endPage=totalPage;
			next=true;
		}else if(totalPage==endPage&&totalPage==page2){
			next=false;
		}else {
			next=true;
		}
		if(beginPage==1){
			prev=false;
		}else{
			prev=true;
		}
		//prev=(beginPage==1)?false:true;
	}
	
	private void paging3(){
		totalPage=totalCount/displayRow3;
		
		//맥스페이지 갯수 조건
		System.out.println("다음페이지 유뮤 : "+(totalCount%displayRow3!=0));
		if(totalCount%displayRow3!=0){
			totalPage+=1;
		}
		//prev,next,beginPage,endPage를 계산
		endPage = ((page3+(displayPage2-1))/displayPage2)*displayPage2;
		beginPage = endPage - (displayPage2-1);
		
		if(totalPage<endPage&&totalPage==page3){
			endPage=totalPage;
			next=false;
		}else if(totalPage<endPage&&totalPage>page3) {
			endPage=totalPage;
			next=true;
		}else if(totalPage==endPage&&totalPage==page3){
			next=false;
		}else {
			next=true;
		}
		if(beginPage==1){
			prev=false;
		}else{
			prev=true;
		}
		//prev=(beginPage==1)?false:true;
	}

	@Override
	public String toString() {
		return "PageSearchVo [search=" + search + ", keyword=" + keyword + ", startnum=" + startnum + ", endnum="
				+ endnum + ", page=" + page + ", page2=" + page2 + ", page3=" + page3 + ", page4=" + page4 + ", page5=" + page5 + ", displayRow=" + displayRow + ", totalCount="
				+ totalCount + ", beginPage=" + beginPage + ", endPage=" + endPage + ", displayRow2=" + displayRow2
				+ ", displayPage=" + displayPage +", desplayPage2=" + displayPage2 + ", prev=" + prev + ", next=" + next + ", category="+ category + ", check="+ check
				+ ",totalPage=" + totalPage +"]";
	}
	
	public PageSearchVo() {
		// TODO Auto-generated constructor stub
	}
	
	

	public PageSearchVo(String search, String keyword, int startnum, int endnum, int page, int page2, int page3, int page4, int page5, int displayRow,
			int totalCount, int beginPage, int endPage, int displayRow2, int displayPage, int displayPage2, boolean prev, boolean next, String category,
			int check, int totalPage) {
		super();
		this.search = search;
		this.keyword = keyword;
		this.startnum = startnum;
		this.endnum = endnum;
		this.page = page;
		this.page2 = page2;
		this.displayRow = displayRow;
		this.totalCount = totalCount;
		this.beginPage = beginPage;
		this.endPage = endPage;
		this.displayRow2 = displayRow2;
		this.displayPage = displayPage;
		this.prev = prev;
		this.next = next;
		this.category = category;
		this.check = check;
		this.totalPage = totalPage;
		this.page3 = page3;
		this.page4 = page4;
		this.displayPage2 = displayPage2;
		this.page5 = page5;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getStartnum() {
		return startnum;
	}

	public void setStartnum(int startnum) {
		this.startnum = startnum;
	}

	public int getEndnum() {
		return endnum;
	}

	public void setEndnum(int endnum) {
		this.endnum = endnum;
	}

	public int getPage() {
		return page;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getDisplayRow2() {
		return displayRow2;
	}

	public void setDisplayRow2(int displayRow2) {
		this.displayRow2 = displayRow2;
	}

	public int getDisplayRow() {
		return displayRow;
	}

	public void setDisplayRow(int displayRow) {
		this.displayRow = displayRow;
	}

	public int getDisplayPage() {
		return displayPage;
	}

	public void setDisplayPage(int displayPage) {
		this.displayPage = displayPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getPage2() {
		return page2;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getCheck() {
		return check;
	}

	public void setCheck(int check) {
		this.check = check;
	}
	
	public int getPage3() {
		return page3;
	}

	public int getDisplayRow3() {
		return displayRow3;
	}

	public void setDisplayRow3(int displayRow3) {
		this.displayRow3 = displayRow3;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPage4() {
		return page4;
	}

	public int getDisplayPage2() {
		return displayPage2;
	}

	public void setDisplayPage2(int displayPage2) {
		this.displayPage2 = displayPage2;
	}

	public int getPage5() {
		return page5;
	}

	
	
}
