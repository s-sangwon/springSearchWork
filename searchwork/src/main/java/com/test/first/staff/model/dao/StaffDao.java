package com.test.first.staff.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.first.staff.model.vo.Code_department;
import com.test.first.staff.model.vo.Code_skill;
import com.test.first.staff.model.vo.Staff;
import com.test.first.staff.model.vo.Staff_skill;

@Repository("staffDao")
public class StaffDao {

	@Autowired
	private SqlSessionTemplate session;

	public int insertStaff(Staff staff) {
		return session.insert("staffMapper.insertStaff",staff);
	}

	public int insertSkill(Staff_skill staff_skill) {
		return session.insert("staffMapper.insertSkill", staff_skill);
	}

	public Staff selectStaffByNo(int staff_no) {
		return session.selectOne("staffMapper.selectStaffByNo", staff_no);
	}

	public int updateStaff(Staff staff) {
		return session.update("staffMapper.updateStaff", staff);
	}

	public int deleteStaffSkill(int staff_no) {
		return session.delete("staffMapper.deleteStaffSkillByNo", staff_no);
	}

	public int deleteStaff(int staff_no) {
		return session.delete("staffMapper.deleteStaff", staff_no);
	}

	public int searchStaffCount(Map<String, Object> map) {
		return session.selectOne("staffMapper.searchStaffCount", map);
	}

	public ArrayList<Staff> searchStaffList(Map<String, Object> map) {
		List<Staff> list = session.selectList("staffMapper.searchStaffList", map);
		return (ArrayList<Staff>) list;
	}

	public ArrayList<Code_department> getDepartment() {
		List<Code_department> list = session.selectList("departmentMapper.getDepartment");
		return (ArrayList<Code_department>)list;
	}

	public Code_skill searchSkillbynName(String skill) {
		return session.selectOne("skillMapper.searchSkillbynName",skill);
	}

	public int insertCodeSkill(Code_skill code_skill) {
		return session.insert("skillMapper.insertCodeSkill", code_skill);
	}

	public List<Code_skill> getCodeSkillList() {
		List<Code_skill> list = session.selectList("skillMapper.getCodeSkillList");
		return list;
	}
	
}
