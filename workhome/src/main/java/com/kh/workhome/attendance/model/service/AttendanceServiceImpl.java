package com.kh.workhome.attendance.model.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.attendance.model.dao.AttendanceDAO;

@Service("atService")
public class AttendanceServiceImpl implements AttendanceService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AttendanceDAO atDAO;

	@Override
	public HashMap<String, String> selectCommute(HashMap<String, String> keys) {
		return atDAO.selectCommute(keys, sqlSession);
	}

	@Override
	public int chulgun(HashMap<String, String> map) {
		return atDAO.chulgun(map, sqlSession);
	}

}
