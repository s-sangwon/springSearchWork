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
public class Code_school implements Serializable{
	private static final long serialVersionUID = -3178301002395480457L;
	private int school_code;
	private String school_name;
}
