package com.fin.festa.util;

import java.util.ArrayList;
import java.util.List;

import com.fin.festa.model.entity.ProfileVo;

//하루마다 정지기간 처리
public class StopUser {

	//정지유저 기간 1일씩 감소
	public Object[] StopUserCount(List<ProfileVo> list) {
		
		Object[] obj= null;
		List<ProfileVo> stoplv_zero = new ArrayList<>();	//정지기간이 0일인사람을 담는리스트
		List<ProfileVo> stoplv_over = new ArrayList<>();	//정지기간이 남아있는사람을 담는리스트
		int stoplv=0;
		
		for(int i=0; i<list.size(); i++) {
			
			stoplv=list.get(i).getMyAdmin().getStoplv();
			stoplv--;
			
			//정지기간이 0일인 사람리스트에 값을 담음
			if(stoplv == 0) {
				list.get(i).getMyAdmin().setStoplv(stoplv);
				stoplv_zero.add(list.get(i));
			//정지기간이 남아있는 사람리스트에 값을 담음
			}else {
				list.get(i).getMyAdmin().setStoplv(stoplv);
				stoplv_over.add(list.get(i));
			}
			
		}
		
		obj=new Object[] {stoplv_zero, stoplv_over};
		
		return obj;
	}
	
}
