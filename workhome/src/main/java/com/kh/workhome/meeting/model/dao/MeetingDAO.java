package com.kh.workhome.meeting.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.employee.model.vo.Employee;

@Repository("meDAO")
public class MeetingDAO {

	public ArrayList<Employee> searchEmpList(SqlSessionTemplate sqlSession, String string) {
		return (ArrayList)sqlSession.selectList("meetingMapper.searchEmpList", string);
	}

	public ArrayList<HashMap<Integer, String>> selectRoom(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("meetingMapper.selectRoom");
	}

	public ArrayList<Employee> searchEmpList2(SqlSessionTemplate sqlSession, String result) {
		return (ArrayList)sqlSession.selectList("meetingMapper.searchEmpList2", result);
	}


}
