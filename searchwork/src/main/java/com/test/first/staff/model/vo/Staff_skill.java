package com.test.first.staff.model.vo;

import java.io.Serializable;

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
public class Staff_skill implements Serializable{
	private static final long serialVersionUID = -7932592247577665317L;
	
	private int staff_skill_no;
	private int staff_no;
	private int skill_code;
}
