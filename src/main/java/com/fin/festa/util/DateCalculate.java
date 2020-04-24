package com.fin.festa.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.UpdateWaitVo;

//날짜관련 계산
public class DateCalculate {

	//공용
	private Date today;			//시간 데이터에 쓰이는필드값
	
	//현재시각 뽑는데이터
	private String time1;		//현재 날짜
	
	//저번주 신규이용자정보출력 뽑는데이터
	private String time2;		//저번주 날짜
	private String monday;		//저번주기준 월요일 날짜
	private String tuesday;		//저번주기준 화요일 날짜
	private String wednesday;	//저번주기준 수요일 날짜
	private String thursday;	//저번주기준 목요일 날짜
	private String friday;		//저번주기준 금요일 날짜
	private String saturday;	//저번주기준 토요일 날짜
	private String sunday;		//저번주기준 일요일 날짜
	
	//이번주 신규진행현황정보출력 뽑는데이터
	private String startday;	//이번주기준 월요일 날짜
	private String endday;		//이번주기준 일요일 날짜
	
	
	
	public DateCalculate() {
		
	}
	
	//관리자 회원정보 생년월일포맷팅
	public List<ProfileVo> proidnumFormat(List<ProfileVo> profile){
		
		for(int i=0; i<profile.size(); i++) {
			String proidnum = profile.get(i).getProidnum();
			String proidnum1 = proidnum.replaceAll("년", "-");
			String proidnum2 = proidnum1.replaceAll("월", "-");
			String proidnum3 = proidnum2.replaceAll("일", "");
			String[] nums = proidnum3.split("-");
			int num1 = Integer.parseInt(nums[1]);
			int num2 = Integer.parseInt(nums[2]);
			if(num1<10) {
				nums[1] = "0" + Integer.toString(num1);
			}
			if(num2<10) {
				nums[2] = "0" + Integer.toString(num2);
			}
			proidnum3 = nums[0]+"-"+nums[1]+"-"+nums[2];
			profile.get(i).setProidnum(proidnum3);
		}
		
		return profile;
	}

	//가입신청부분 생년월일포멧팅
	public List<UpdateWaitVo> proidnumFormatt(List<UpdateWaitVo> profile){
		
		for(int i=0; i<profile.size(); i++) {
			String proidnum = profile.get(i).getProfile().getProidnum();
			String proidnum1 = proidnum.replaceAll("년", "-");
			String proidnum2 = proidnum1.replaceAll("월", "-");
			String proidnum3 = proidnum2.replaceAll("일", "");
			String[] nums = proidnum3.split("-");
			int num1 = Integer.parseInt(nums[1]);
			int num2 = Integer.parseInt(nums[2]);
			if(num1<10) {
				nums[1] = "0" + Integer.toString(num1);
			}
			if(num2<10) {
				nums[2] = "0" + Integer.toString(num2);
			}
			proidnum3 = nums[0]+"-"+nums[1]+"-"+nums[2];
			profile.get(i).getProfile().setProidnum(proidnum3);
		}
		
		return profile;
	}
	
	//그룹,개인피드 병합해서 날짜 정렬(뉴스피드출력에 쓰임)
	public List<FeedVo> VoDateReturn(List<FeedVo> groupFeedList, List<FeedVo> feedList) {
		
		List<FeedVo> list= new ArrayList<>();
		for(int i=0; i<groupFeedList.size(); i++) {
			list.add(groupFeedList.get(i));
		}
		
		for(int i=0; i<feedList.size(); i++) {
			list.add(feedList.get(i));
		}
		
		Collections.sort(list,new Comparator<FeedVo>() {
			
			@Override
			public int compare(FeedVo o1, FeedVo o2) {
				Timestamp v1 = o1.getDate();
				Timestamp v2 = o2.getDate();
				
				return v2.compareTo(v1);
			}
		});
		
		return list;
	}
	
	//그룹,개인피드 병합해서 날짜 2순위,좋아요 1순위 정렬(인기피드출력에 쓰임)
	public List<FeedVo> VoDateGoodReturn(List<FeedVo> groupFeedList, List<FeedVo> feedList) {
		
		List<FeedVo> list= new ArrayList<>();
		for(int i=0; i<groupFeedList.size(); i++) {
			list.add(groupFeedList.get(i));
		}
		
		for(int i=0; i<feedList.size(); i++) {
			list.add(feedList.get(i));
		}
		
		Collections.sort(list,new Comparator<FeedVo>() {

			@Override
			public int compare(FeedVo o1, FeedVo o2) {
				Timestamp v1 = o1.getDate();
				Timestamp v2 = o2.getDate();
				v2.compareTo(v1);
				Integer g1 = new Integer(o1.getGood());
				Integer g2 = new Integer(o2.getGood());
				
				return g2.compareTo(g1);
			}
		});
		
		return list;
	}
	
	//그룹,개인피드 병합해서 좋아요 정렬(검색결과출력에 쓰임)
	public List<FeedVo> VoGoodReturn(List<FeedVo> groupFeedList, List<FeedVo> feedList) {
		
		List<FeedVo> list= new ArrayList<>();
		for(int i=0; i<groupFeedList.size(); i++) {
			list.add(groupFeedList.get(i));
		}
		
		for(int i=0; i<feedList.size(); i++) {
			list.add(feedList.get(i));
		}
		
		Collections.sort(list,new Comparator<FeedVo>() {
			
			@Override
			public int compare(FeedVo o1, FeedVo o2) {
				Integer g1 = new Integer(o1.getGood());
				Integer g2 = new Integer(o2.getGood());
				
				return g2.compareTo(g1);
			}
		});
		
		return list;
	}
	
	
	//날짜 포맷팅
	public String dateFormat(Timestamp date) {
		time1=this.getTime();
		int today1=Integer.parseInt(time1);
		
		SimpleDateFormat fomat=null;
		fomat=new SimpleDateFormat("yyyyMMdd");
		time1=fomat.format(date);
		int thisDay=Integer.parseInt(time1);
		
		if(today1==thisDay) {
			fomat=new SimpleDateFormat("a hh시 mm분 ss초");
			time1=fomat.format(date);
		}else {
			fomat=new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
			time1=fomat.format(date);
		}
		return time1;
	}
	
	//현재시각 리턴
	public String getTime(){
		
		today=new Date();
		time1=new SimpleDateFormat("yyyyMMdd").format(today);
		
		return time1;
	}
	
	//어제시각 리턴
	public String yesterday() {
		
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		today=calendar.getTime();
		time2=new SimpleDateFormat("yyyy-MM-dd").format(today);
		
		return time2;
	}
	
	//공용으로 쓰이는메소드
	public String returnTime(Calendar calendar) {
		
		today=calendar.getTime();
		time2=new SimpleDateFormat("yyyy-MM-dd").format(today);
		return time2;
	}
	
	//저번주 신규이용자정보출력
	public DateCalculate lastWeekNewUser() {
		
		Calendar calendar = Calendar.getInstance();
		int yoil=calendar.get(Calendar.DAY_OF_WEEK);
		
		if(yoil==1) {				//오늘기준 -7이 일요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -13);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==2) {			//오늘기준 -7이 월요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -7);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==3) {			//오늘기준 -7이 화요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -8);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==4) {			//오늘기준 -7이 수요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -9);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==5) {			//오늘기준 -7이 목요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -10);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==6) {			//오늘기준 -7이 금요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -11);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}else if(yoil==7) {			//오늘기준 -7이 토요일일때
			//월요일
			calendar.add(Calendar.DAY_OF_MONTH, -12);
			monday=returnTime(calendar);
			//화요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			tuesday=returnTime(calendar);
			//수요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			wednesday=returnTime(calendar);
			//목요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			thursday=returnTime(calendar);
			//금요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			friday=returnTime(calendar);
			//토요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			saturday=returnTime(calendar);
			//일요일
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			sunday=returnTime(calendar);
		}
		return this;
		
	}
	
	//이번주 신규진행현황정보 출력
	public DateCalculate weekNewUser() {
		
		Calendar calendar = Calendar.getInstance();
		int yoil=calendar.get(Calendar.DAY_OF_WEEK);
		
		
		//마지막날 값이 해당일 00시00분기준으로 측정되므로 그다음날 00시00분으로 처리
		if(yoil==1) {				//오늘이 일요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -6);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==2) {			//오늘이 월요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, 0);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==3) {			//오늘이 화요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -1);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==4) {			//오늘이 수요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -2);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==5) {			//오늘이 목요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -3);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==6) {			//오늘이 금요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -4);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}else if(yoil==7) {			//오늘이 토요일일때
			//이번주 시작일
			calendar.add(Calendar.DAY_OF_MONTH, -5);
			startday=returnTime(calendar);
			//이번주 마지막일
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			endday=returnTime(calendar);
		}
		
		return this;
	}
	
	@Override
	public String toString() {
		return "DateCalculate [monday=" + monday + ", tuesday=" + tuesday + ", wednesday=" + wednesday + ", thursday="
				+ thursday + ", friday=" + friday + ", saturday=" + saturday + ", sunday=" + sunday + ", startday="
				+ startday + ", endday=" + endday + "]";
	}

	public String getMonday() {
		return monday;
	}

	public void setMonday(String monday) {
		this.monday = monday;
	}

	public String getTuesday() {
		return tuesday;
	}

	public void setTuesday(String tuesday) {
		this.tuesday = tuesday;
	}

	public String getWednesday() {
		return wednesday;
	}

	public void setWednesday(String wednesday) {
		this.wednesday = wednesday;
	}

	public String getThursday() {
		return thursday;
	}

	public void setThursday(String thursday) {
		this.thursday = thursday;
	}

	public String getFriday() {
		return friday;
	}

	public void setFriday(String friday) {
		this.friday = friday;
	}

	public String getSaturday() {
		return saturday;
	}

	public void setSaturday(String saturday) {
		this.saturday = saturday;
	}

	public String getSunday() {
		return sunday;
	}

	public void setSunday(String sunday) {
		this.sunday = sunday;
	}

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
		this.endday = endday;
	}
	
	
}
