package com.fin.festa.util;

import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;

//캠핑장 별점계산
public class CampAvg {

	public CampReviewVo avgCalculate(CampReviewVo campReviewVo) {
		
		double crgood=campReviewVo.getCrgood();
		double caavg=campReviewVo.getCamp().getCaavg();
		int catotal=campReviewVo.getCamp().getCatotal();
		
		caavg=(Math.round(((caavg*catotal)+crgood)*10)/(catotal+1))/10.0;
		campReviewVo.getCamp().setCaavg(caavg);
		
		return campReviewVo;
	}
}
