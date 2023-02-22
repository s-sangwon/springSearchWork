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
	private int staff_no;
	private String staff_name;
	private String jumin_no;
	private int school_code;
	private int department_code;
	private String graduate_day;
	
	private List<String> skill_code;
}
