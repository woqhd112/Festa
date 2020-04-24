package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.ProfileVo;

public interface IndexDao {
	
	List<GroupVo> totalGroupSelectAll();
	
	List<GroupVo> addrGroupSelectAll(ProfileVo profile);
	
	List<CampVo> veryHotCampSelectAll();
}