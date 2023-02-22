package com.test.first.staff.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.first.staff.model.service.StaffService;
import com.test.first.staff.model.vo.Code_department;
import com.test.first.staff.model.vo.Code_skill;
import com.test.first.staff.model.vo.Staff;
import com.test.first.staff.model.vo.Staff_skill;

import lombok.extern.java.Log;

@Log
@Controller
public class StaffController {
	
	@Autowired
	private StaffService staffService;
	
	@PostMapping("input.do")
	public String staffInputMehotd(Staff staff,@RequestParam(required = false) List<String> skills ,Model model){
		log.info(staff.toString());
		//staff 입력후 staff_skill 입력
		
		if (staffService.insertStaff(staff) <= 0) {

			model.addAttribute("message", "staff 등록 실패!");
			return "common/error";
	
		} 
		
		for(String skill :staff.getSkill_code()) {
			if( staffService.insertSkill( new Staff_skill(0, staff.getStaff_no(), Integer.parseInt(skill)) ) > 0 ) {
				log.info(skill + "staff_skill 입력성공");
			}
			else {
				model.addAttribute("message", "staff skill등록 실패!");
				return "common/error";
			}
		}

		if( skills != null && skills.size() > 0) {
		for(String skill : skills) {
			// skill이  있는지 code_skill에서 찾음
			skill = skill.toLowerCase().trim();
			Code_skill code_skill= staffService.searchSkillbynName(skill);
			// 있으면 해당 skill_code 가져와서 staff_skill에 입력
			if( code_skill != null) {
				if( staffService.insertSkill( new Staff_skill(0, staff.getStaff_no(), code_skill.getSkill_code()) ) > 0 ) {
					log.info(skill + "staff_skill 입력성공");
				}
				else {
					model.addAttribute("message", "staff skill등록 실패!");
					return "common/error";
				}
			} else { // 없으면 추가후 skill_code 가져와서 staff_skill에 입력
				code_skill = new Code_skill(0, skill);
				if( staffService.insertCodeSkill( code_skill ) < 0) {
					model.addAttribute("message", "code_skill등록 실패!");
					return "common/error";
				}
				
				if( staffService.insertSkill( new Staff_skill(0, staff.getStaff_no(), code_skill.getSkill_code()) ) > 0 ) {
					log.info(skill + "코드추가후 스태프기술 입력성공!");
				}
				else {
					model.addAttribute("message", "staff skill등록 실패!");
					return "common/error";
				}
			}
			
			
		}
		}
		
		return "../../staff_search_form";
	}
	
	@GetMapping("staffDetail.do/{staff_no}")
	public String staffDetailMethod(@PathVariable("staff_no") int staff_no,Model model) {
		
		Staff s = staffService.selectStaffByNo(staff_no);
		log.info(s.toString());
		
		model.addAttribute("staff",s);
		
		return "../../staff_updel_form";
	}
	
	@PostMapping("update.do")
	public String staffUpdateMethod(Staff staff,@RequestParam(required = false) List<String> skills,  Model model) {
		
		log.info(staff.toString());
		
		int no = staff.getStaff_no();
		
		if( staffService.updateStaff(staff) <= 0 ) {
			model.addAttribute("message", "staff 수정 실패!");
			return "common/error";
		}
		
		if( staffService.deleteStaffSkill(no) < 0) {
			model.addAttribute("message", "staff_skill 삭제 실패!");
			return "common/error";
		}
		
		
		for(String skill :staff.getSkill_code()) {
			if( staffService.insertSkill( new Staff_skill(0, no, Integer.parseInt(skill)) ) > 0 ) {
				log.info(skill + "staff_skill 입력성공");
			}
			else {
				model.addAttribute("message", "staff skill등록 실패!");
				return "common/error";
			}
		}

		
		if( skills != null && skills.size() > 0) {
		for(String skill : skills) {
			// skill이  있는지 code_skill에서 찾음
			skill = skill.toLowerCase().trim();
			Code_skill code_skill= staffService.searchSkillbynName(skill);
			// 있으면 해당 skill_code 가져와서 staff_skill에 입력
			if( code_skill != null) {
				if( staffService.insertSkill( new Staff_skill(0, staff.getStaff_no(), code_skill.getSkill_code()) ) > 0 ) {
					log.info(skill + "staff_skill 입력성공");
				}
				else {
					model.addAttribute("message", "staff skill등록 실패!");
					return "common/error";
				}
			} else { // 없으면 추가후 skill_code 가져와서 staff_skill에 입력
				code_skill = new Code_skill(0, skill);
				if( staffService.insertCodeSkill( code_skill ) < 0) {
					model.addAttribute("message", "code_skill등록 실패!");
					return "common/error";
				}
				
				if( staffService.insertSkill( new Staff_skill(0, staff.getStaff_no(), code_skill.getSkill_code()) ) > 0 ) {
					log.info(skill + "코드추가후 스태프기술 입력성공!");
				}
				else {
					model.addAttribute("message", "staff skill등록 실패!");
					return "common/error";
				}
			}
			
			
		}
		}
//		return "redirect:staffDetail.do/"+no;
		return "../../staff_search_form";
	}
	
	@GetMapping("delete.do/{staff_no}")
	public String staffDeleteMethod(@PathVariable int staff_no, Model model ) {
		
/*		if staffService.deleteStaffSkill(staff_no) <= 0 ) {
			model.addAttribute("message", "staff_skill 삭제 실패!");
			return "common/error";
		}*/
		
		if( staffService.deleteStaff(staff_no) <= 0 ) {
			model.addAttribute("message", "staff 삭제 실패!");
			return "common/error";
		}
		
		return "../../staff_search_form";
	}
	
	@GetMapping("ajaxSearch.do")
	public String ajaxSearchMethod(			
			@RequestParam(required = false) String page,
			@RequestParam(required = false) String staff_keyword,
			@RequestParam(required = false) String gender[],
			@RequestParam(required = false) String school_code[],
			@RequestParam(required = false) String skill_code[],
			@RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate,
			@RequestParam(required = false, defaultValue = "0") String department_code,
			@RequestParam(required = false, defaultValue = "s.staff_no desc") String sort,
			@RequestParam(required = false) List<String> skills,
			Model model) {

		log.info(page);
		if (staff_keyword == null || staff_keyword.equals(""))
			staff_keyword = null;
		log.info(staff_keyword); // default = ""
		if(gender == null || gender.length == 0) {
			gender = null;
			//log.info(gender.toString()); // default = NULL
		}
		if(school_code == null || school_code.length == 0) {
			school_code = null;
			//log.info(school_code.toString()); // default = NULL
		}
		if(skill_code == null || skill_code.length == 0) {
			skill_code = null;
			//log.info(skill_code.toString()); // default = NULL
		} else {
			log.info(skill_code + "" + skill_code.length +"");
		}
		if(department_code.equals("0"))
			department_code = null;
		log.info(department_code); //default 0
		
		
		if( startDate==null || startDate.equals("-00-00")) {
			startDate = null;
			endDate = null;
		}
		
		log.info(startDate); // -00-00
		log.info(endDate); // -00-00
		
		List<String> otherSkills = null;
		if(skills != null && skills.size() > 0) {
			otherSkills = new ArrayList<String>();
			for(String skill : skills) {
				Code_skill code_skill= staffService.searchSkillbynName(skill);
				if( code_skill == null) {
					otherSkills.add("0"); // 존재하지 않으면 0넣어서 검색결과 안나오게함.
					continue;
				}
				otherSkills.add( String.valueOf(code_skill.getSkill_code())  );
			}
		}
		
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		log.info("소트값 확인");
		log.info(sort);
		map.put("staff_keyword",staff_keyword);
		map.put("gender",gender);
		map.put("school_code",school_code);
		map.put("skill_code",skill_code);
		map.put("startDate",startDate);
		map.put("endDate",endDate);
		map.put("department_code", department_code);
		map.put("sort", sort);
		map.put("otherSkills", otherSkills);
		
		// 페이징 계산
		int listCount=0;
		int limit = 5; 
		listCount = staffService.searchStaffCount(map);
		//listCount= qnaService.selectMyListCount(userid);
		log.info("검색건수 : " + listCount);
		// 페이징 계산
		int maxPage = (int)((double)listCount / limit + 0.9);

		int endPage = (int)(Math.ceil(currentPage / (double)limit)) * limit;
		int startPage = endPage-limit+1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		//페이징 계산 처리 끝 ---------------------------------------
		ArrayList<Staff> list = null;
		list = staffService.searchStaffList(map);
		if( list != null && list.size() < 0) {
			model.addAttribute("message", "검색실패");
			return "common/error";
		}
		
		ArrayList<Code_department> dlist = staffService.getDepartment();
		Map<Integer,String> dmap = new HashMap<Integer,String>();
		
		for( Code_department d : dlist ) {
			dmap.put( d.getDepartment_code(), d.getDepartment_name());
		}
		model.addAttribute("dlist", dlist);
		model.addAttribute("dmap", dmap);
	

		
		model.addAttribute("list", list);
		model.addAttribute("listCount", listCount);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("limit", limit);
		
		//검색유지 인데 ajax사용해서 필요없음.
//		model.addAttribute("staff_keyword", staff_keyword);
//		model.addAttribute("gender", gender);
//		model.addAttribute("school_code", school_code);
//		model.addAttribute("skill_code", skill_code);
//		model.addAttribute("startDate", startDate);
//		model.addAttribute("endDate", endDate);
//		model.addAttribute("department_code", department_code);
		model.addAttribute("sort", sort);  // 소트로 오름 내림차순 바운스 필요
//		model.addAttribute("otherSkills", otherSkills);
		return "ajax/staffList";
	}
	
	@ResponseBody
	@PostMapping("getCodeSkillList.do")
	public HashMap<String,String> getCodeSkillListMethod() {
		List<Code_skill> list = staffService.getCodeSkillList();
		HashMap<String,String> map = new HashMap<String,String>();
		
		for(Code_skill s : list ) {
			map.put(String.valueOf(s.getSkill_code()) , s.getSkill_name());
		}
		
		return map;
	}
	
}
