package com.test.first.staff.model.vo;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class Staff implements Serializable{
	private static final long serialVersionUID = 6262288493452704401L;
	int staff_no;
	String staff_name;
	String jumin_no;
	int school_code;
	int department_code;
	String graduate_day;
	
	List<String> skill_code;
}
