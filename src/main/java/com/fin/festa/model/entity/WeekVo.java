package com.fin.festa.model.entity;

public class WeekVo {			//저번주 신규가입자현황Vo

	private int monday;			//저번주 월요일신규가입자 수
	private int tuesday;		//저번주 화요일신규가입자 수
	private int wednesday;		//저번주 수요일신규가입자 수
	private int thursday;		//저번주 목요일신규가입자 수
	private int friday;			//저번주 금요일신규가입자 수
	private int saturday;		//저번주 토요일신규가입자 수
	private int sunday;			//저번주 일요일신규가입자 수
	
	@Override
	public String toString() {
		return "WeekVo [monday=" + monday + ", tuesday=" + tuesday + ", wednesday=" + wednesday + ", thursday="
				+ thursday + ", friday=" + friday + ", saturday=" + saturday + ", sunday=" + sunday + "]";
	}
	
	public WeekVo() {
		// TODO Auto-generated constructor stub
	}

	public WeekVo(int monday, int tuesday, int wednesday, int thursday, int friday, int saturday, int sunday) {
		super();
		this.monday = monday;
		this.tuesday = tuesday;
		this.wednesday = wednesday;
		this.thursday = thursday;
		this.friday = friday;
		this.saturday = saturday;
		this.sunday = sunday;
	}

	public int getMonday() {
		return monday;
	}

	public void setMonday(int monday) {
		this.monday = monday;
	}

	public int getTuesday() {
		return tuesday;
	}

	public void setTuesday(int tuesday) {
		this.tuesday = tuesday;
	}

	public int getWednesday() {
		return wednesday;
	}

	public void setWednesday(int wednesday) {
		this.wednesday = wednesday;
	}

	public int getThursday() {
		return thursday;
	}

	public void setThursday(int thursday) {
		this.thursday = thursday;
	}

	public int getFriday() {
		return friday;
	}

	public void setFriday(int friday) {
		this.friday = friday;
	}

	public int getSaturday() {
		return saturday;
	}

	public void setSaturday(int saturday) {
		this.saturday = saturday;
	}

	public int getSunday() {
		return sunday;
	}

	public void setSunday(int sunday) {
		this.sunday = sunday;
	}
	
}
