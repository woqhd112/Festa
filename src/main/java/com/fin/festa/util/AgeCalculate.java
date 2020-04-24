package com.fin.festa.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.fin.festa.model.entity.AgeCountVo;
import com.fin.festa.model.entity.ProfileVo;

//회원연령분포계산
public class AgeCalculate {

	public AgeCalculate() {
		// TODO Auto-generated constructor stub
	}
	
	//연령대 계산
	public AgeCountVo userAgeDistribution(List<ProfileVo> list) {
		
		Date today=new Date();
		int year=Integer.parseInt(new SimpleDateFormat("yyyy").format(today));
		
		String idnum=null;
		String proidnum=null;
		int proidnum1=0;
		int age=0;

		int a=0;
		int b=0;
		int c=0;
		int d=0;
		int e=0;
		double total=0;
		
		for(int i=0; i<list.size(); i++) {
			idnum=list.get(i).getProidnum();
			proidnum=idnum.substring(0,4);
			proidnum1=Integer.parseInt(proidnum);
			age=year-proidnum1+1;
			
			if(age>=10&&age<20) {
				age=10;
				a++;
			}else if(age>=20&&age<30) {
				age=20;
				b++;
			}else if(age>=30&&age<40) {
				age=30;
				c++;
			}else if(age>=40&&age<50) {
				age=40;
				d++;
			}else{
				age=50;
				e++;
			}
			
		}
		AgeCountVo ageCount=new AgeCountVo();
		total=a+b+c+d+e;
		ageCount.setAge10((int)Math.round((a/total)*100));
		ageCount.setAge20((int)Math.round((b/total)*100));
		ageCount.setAge30((int)Math.round((c/total)*100));
		ageCount.setAge40((int)Math.round((d/total)*100));
		ageCount.setAge50((int)Math.round((e/total)*100));
		
		return ageCount;
	}
	
}
