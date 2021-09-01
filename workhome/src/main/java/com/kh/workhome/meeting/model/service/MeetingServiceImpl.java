package com.kh.workhome.meeting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.meeting.model.dao.MeetingDAO;
import com.kh.workhome.meeting.model.vo.MeetingReservation;

@Service("meService")
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MeetingDAO meDAO;	
	
	@Override
	public ArrayList<Employee> searchEmpList(String string) {
		return meDAO.searchEmpList(sqlSession, string);
	}

	@Override
	public ArrayList<HashMap<Integer, String>> selectRoom() {
		return meDAO.selectRoom(sqlSession);
	}

	@Override
	public ArrayList<Employee> searchEmpList2(String result) {
		return meDAO.searchEmpList2(sqlSession, result);
	}

	@Override
	public int reInsert(MeetingReservation m) {
		return meDAO.reInsert(sqlSession, m);
	}

	@Override
	public ArrayList<String> rSelectDate(HashMap<String, Object> map) {
		return meDAO.rSelectDate(map, sqlSession);
	}

	@Override
	public ArrayList<MeetingReservation> selectAllReservation(String empNo) {
		return meDAO.selectAllReservation(empNo, sqlSession);
	}

}
