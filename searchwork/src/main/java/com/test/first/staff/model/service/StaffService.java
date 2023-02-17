package com.test.first.staff.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.test.first.staff.model.vo.Code_department;
import com.test.first.staff.model.vo.Staff;
import com.test.first.staff.model.vo.Staff_skill;

public interface StaffService {

	int insertStaff(Staff staff);

	int insertSkill(Staff_skill staff_skill);

	Staff selectStaffByNo(int staff_no);

	int updateStaff(Staff staff);

	int deleteStaffSkill(int staff_no);

	int deleteStaff(int staff_no);

	int searchStaffCount(Map<String, Object> map);

	ArrayList<Staff> searchStaffList(Map<String, Object> map);

	ArrayList<Code_department> getDepartment();

}
