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
}
