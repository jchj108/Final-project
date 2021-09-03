package com.kh.workhome.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.employee.model.dao.EmployeeDAO;
import com.kh.workhome.employee.model.vo.Department;
import com.kh.workhome.employee.model.vo.Employee;

@Service("eService")
public class EmployeeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private EmployeeDAO eDao;

	public int dupEmail(String email) {
		return eDao.dupEmail(sqlSession, email);
	}
	
	public int insertEmp(Employee e) {
		return eDao.insertEmp(sqlSession, e);
	}

	public Employee login(Employee e) {
		return eDao.login(sqlSession, e);
	}

	public int updatePwd(HashMap<String, String> map) {
		return eDao.updatePwd(sqlSession, map);
	}
	
	public Employee selectEmp(Employee e) {
		return eDao.selectEmp(sqlSession, e);
	}
	
	public ArrayList<Department> selectDeptList() {
		return eDao.selectDeptList(sqlSession);
	}

	public ArrayList<Employee> getEmployee(String deptNo) {
		return eDao.getEmployee(sqlSession, deptNo);
	}

	public int insertAlert(HashMap<String, Object> map) {
		return eDao.insertAlert(sqlSession, map);
	}
	
	public ArrayList<HashMap<String, Object>> selectAlertList(String empNo) {
		return eDao.selectAlertList(sqlSession, empNo);
	}
	
	public int deleteAlert(String alertNo) {
		return eDao.deleteAlert(sqlSession, alertNo);
	}

	public int deletAllAlerts(HashMap<String, String> map) {
		return eDao.deletAllAlerts(sqlSession, map);
	}

}
