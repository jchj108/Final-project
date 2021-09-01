package com.kh.workhome.attendance.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.attendance.model.dao.AttendanceDAO;
import com.kh.workhome.attendance.model.vo.Attendance;
import com.kh.workhome.common.PageInfo;

@Service("atService")
public class AttendanceServiceImpl implements AttendanceService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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

	@Override
	public int goHome(HashMap<String, String> keys) {
		return atDAO.goHome(keys, sqlSession);
	}

	@Override
	public int getListCount() {
		return atDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Attendance> selectList(PageInfo pi) {
		return atDAO.selectList(pi, sqlSession);
	}

}
