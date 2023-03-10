package com.test.first.staff.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.first.staff.model.dao.StaffDao;
import com.test.first.staff.model.vo.Code_department;
import com.test.first.staff.model.vo.Code_skill;
import com.test.first.staff.model.vo.Staff;
import com.test.first.staff.model.vo.Staff_skill;

@Service("staffService")
public class StaffServiceImpl implements StaffService {

	@Autowired
	private StaffDao staffDao;
	
	@Override
	public int insertStaff(Staff staff) {

		return staffDao.insertStaff(staff);
	}

	@Override
	public int insertSkill(Staff_skill staff_skill) {
		return staffDao.insertSkill(staff_skill);
	}

	@Override
	public Staff selectStaffByNo(int staff_no) {
		return staffDao.selectStaffByNo(staff_no);
	}

	@Override
	public int updateStaff(Staff staff) {
		return staffDao.updateStaff(staff);
	}

	@Override
	public int deleteStaffSkill(int staff_no) {
		return staffDao.deleteStaffSkill(staff_no);
	}

	@Override
	public int deleteStaff(int staff_no) {
		return staffDao.deleteStaff(staff_no);
	}

	@Override
	public int searchStaffCount(Map<String, Object> map) {
		return staffDao.searchStaffCount(map);
	}

	@Override
	public ArrayList<Staff> searchStaffList(Map<String, Object> map) {
		return staffDao.searchStaffList(map);
	}

	@Override
	public ArrayList<Code_department> getDepartment() {
		return staffDao.getDepartment();
	}

	@Override
	public Code_skill searchSkillbynName(String skill) {
		return staffDao.searchSkillbynName(skill);
	}

	@Override
	public int insertCodeSkill(Code_skill code_skill) {
		return staffDao.insertCodeSkill(code_skill);
	}

	@Override
	public List<Code_skill> getCodeSkillList() {
		return staffDao.getCodeSkillList();
	}

}
