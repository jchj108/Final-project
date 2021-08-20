package com.kh.workhome.attendance.model.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository("atDAO")
public class AttendanceDAO {

	public HashMap<String, String> selectCommute(HashMap<String, String> keys, SqlSession sqlSession) {
		return sqlSession.selectOne("attendanceMapper.selectCommute",keys);
	}

	public int chulgun(HashMap<String, String> map, SqlSession sqlSession) {
		return sqlSession.insert("attendanceMapper.chulgun",map);
	}

}
