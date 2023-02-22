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
public class Code_skill implements Serializable {
	private static final long serialVersionUID = 533556159671373706L;
	private int skill_code;
	private String skill_name;
}
