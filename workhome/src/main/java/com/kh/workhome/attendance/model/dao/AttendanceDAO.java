package com.kh.workhome.attendance.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.attendance.model.vo.Attendance;
import com.kh.workhome.common.PageInfo;

@Repository("atDAO")
public class AttendanceDAO {

	public HashMap<String, String> selectCommute(HashMap<String, String> keys, SqlSession sqlSession) {
		return sqlSession.selectOne("attendanceMapper.selectCommute",keys);
	}

	public int chulgun(HashMap<String, String> map, SqlSession sqlSession) {
		return sqlSession.insert("attendanceMapper.chulgun",map);
	}

	public int goHome(HashMap<String, String> keys, SqlSession sqlSession) {
		return sqlSession.update("attendanceMapper.goHome",keys);
	}

	public int getListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("attendanceMapper.getListCount");
	}

	public ArrayList<Attendance> selectList(PageInfo pi, SqlSessionTemplate sqlSession) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectList", null, rowBounds);
	}

}
