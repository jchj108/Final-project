package com.kh.workhome.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.notice.model.dao.NoticeDAO;
import com.kh.workhome.notice.model.vo.Notice;

@Service("nService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDAO nDAO;

	@Override
	public int getListCount() {
		return nDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return nDAO.selectList(sqlSession, pi);
	}

}
