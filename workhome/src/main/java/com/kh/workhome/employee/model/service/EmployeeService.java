package com.kh.workhome.employee.model.service;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.employee.model.dao.EmployeeDAO;
import com.kh.workhome.employee.model.vo.Employee;

@Service("service")
public class EmployeeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private EmployeeDAO dao;

	public int dupEmail(String email) {
		return dao.dupEmail(sqlSession, email);
	}
	
	public int insertEmp(Employee e) {
		return dao.insertEmp(sqlSession, e);
	}

	public Employee login(Employee e) {
		return dao.login(sqlSession, e);
	}

	public int updatePwd(HashMap<String, String> map) {
		return dao.updatePwd(sqlSession, map);
	}

}
