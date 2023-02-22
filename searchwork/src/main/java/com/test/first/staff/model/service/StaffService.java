package com.test.first.staff.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.test.first.staff.model.vo.Code_department;
import com.test.first.staff.model.vo.Code_skill;
import com.test.first.staff.model.vo.Staff;
import com.test.first.staff.model.vo.Staff_skill;

public interface StaffService {

	int insertStaff(Staff staff);
	int updateStaff(Staff staff);
	int deleteStaff(int staff_no);
	Staff selectStaffByNo(int staff_no);
	
	int searchStaffCount(Map<String, Object> map);
	ArrayList<Staff> searchStaffList(Map<String, Object> map);
	
	int insertSkill(Staff_skill staff_skill);
	int deleteStaffSkill(int staff_no);
	

	Code_skill searchSkillbynName(String skill);
	int insertCodeSkill(Code_skill code_skill);
	
	// select * from table
	List<Code_skill> getCodeSkillList(); 
	ArrayList<Code_department> getDepartment();
	
	

	

	

}
