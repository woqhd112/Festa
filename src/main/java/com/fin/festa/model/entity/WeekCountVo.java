package com.fin.festa.model.entity;

public class WeekCountVo {		//이번주 신규진행현황출력Vo

	private int userCount;		//이번주 신규가입자 수  
	private int groupCount;		//이번주 그룹생성 수
	private int ventureCount;	//이번주 사업자신청 수
	private int campCount;		//이번주 캠핑장등록 수
	private int reportCount;	//이번주 신고등록 수
	
	@Override
	public String toString() {
		return "WeekCountVo [userCount=" + userCount + ", groupCount=" + groupCount + ", ventureCount=" + ventureCount
				+ ", campCount=" + campCount + ", reportCount=" + reportCount + "]";
	}
	
	public WeekCountVo() {
		// TODO Auto-generated constructor stub
	}

	public WeekCountVo(int userCount, int groupCount, int ventureCount, int campCount, int reportCount) {
		super();
		this.userCount = userCount;
		this.groupCount = groupCount;
		this.ventureCount = ventureCount;
		this.campCount = campCount;
		this.reportCount = reportCount;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public int getGroupCount() {
		return groupCount;
	}

	public void setGroupCount(int groupCount) {
		this.groupCount = groupCount;
	}

	public int getVentureCount() {
		return ventureCount;
	}

	public void setVentureCount(int ventureCount) {
		this.ventureCount = ventureCount;
	}

	public int getCampCount() {
		return campCount;
	}

	public void setCampCount(int campCount) {
		this.campCount = campCount;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	
	
}
