package com.kh.workhome.employee.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.employee.model.vo.Department;
import com.kh.workhome.employee.model.vo.Employee;

@Repository("eDao")
public class EmployeeDAO {

	public int dupEmail(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("employeeMapper.dupEmail", email);
	}
	
	public int insertEmp(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.insert("employeeMapper.insertEmp", e);
	}

	public Employee login(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.selectOne("employeeMapper.login", e);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("employeeMapper.updatePwd", map);
	}
	
	public Employee selectEmp(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.selectOne("employeeMapper.selectEmp", e);
	}

	public ArrayList<Department> selectDeptList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("employeeMapper.selectDeptList");
	}

	public ArrayList<Employee> getEmployee(SqlSessionTemplate sqlSession, String deptNo) {
		return (ArrayList)sqlSession.selectList("employeeMapper.getEmployee", deptNo);
	}

	public int insertAlert(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		
		if(map.get("empNo") instanceof String) {
			return sqlSession.insert("employeeMapper.insertAlert", map);
		} else {
		ArrayList<String> emps = (ArrayList)map.get("empNo");
		int result = 0;
		for(int i = 0 ; i < emps.size() ; i++) {
			map.put("empNo", emps.get(i));
			result += sqlSession.insert("employeeMapper.insertAlert", map);
		}
		return result;
		}
	}
	
	public ArrayList<HashMap<String, Object>> selectAlertList(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList) sqlSession.selectList("employeeMapper.selectAlertList", empNo);
	}

	public int deleteAlert(SqlSessionTemplate sqlSession, String alertNo) {
		return sqlSession.update("employeeMapper.deleteAlert", alertNo);
	}

	public int deletAllAlerts(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("employeeMapper.deletAllAlerts",map);
	}
}
