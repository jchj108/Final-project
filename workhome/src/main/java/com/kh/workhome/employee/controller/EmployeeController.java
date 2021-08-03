package com.kh.workhome.employee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	// 회원가입 페이지 이동
	@RequestMapping("signUpForm.emp")
	public String signUpForm() {
		return "signUp";
	}
	
	// 회원가입
	@RequestMapping("insert.emp")
	public String insertEmp(@ModelAttribute Employee e) {
		
		e.setPassword(bcrypt.encode(e.getPassword()));
		
		int result = service.insertEmp(e);
		
		if(result > 0) {
			return "../../../index"; // 로그인 화면으로 이동
		} else {
			return "redirect:signFormUp.emp";
		}
	}
	
	// 로그인 
	@RequestMapping("login.emp")
	public String login() {
		return "signUp";
	}
}
