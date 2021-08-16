package com.kh.workhome.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.notice.model.vo.Notice;
import com.kh.workhome.notice.model.vo.NoticeFile;

@Repository("nDAO")
public class NoticeDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.getListCount");
	}

	public ArrayList<Notice> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1); 
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit()); 
		return (ArrayList)sqlSession.selectList("noticeMapper.selectList", null, rowBounds);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice",n);
	}

}
