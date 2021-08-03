package com.kh.workhome.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.employee.model.vo.Employee;

@Repository("dao")
public class EmployeeDAO {

	public int insertEmp(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.insert("employeeMapper.insertEmp", e);
	}

}
