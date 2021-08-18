package com.kh.workhome.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.notice.model.dao.NoticeDAO;
import com.kh.workhome.notice.model.vo.Notice;
import com.kh.workhome.notice.model.vo.NoticeFile;

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

	@Override
	public int insertNotice(Notice n) {
		return nDAO.insertNotice(sqlSession,n);
	}

	@Override
	@Transactional
	public Notice selectNotice(int nId, boolean check) {
		int result = 0;
		Notice n = null;
		
		if(check) {
			result = nDAO.addReadCount(sqlSession,nId);
			
			if(result > 0) {
				n = nDAO.selectNotice(sqlSession,nId);
			}
			
		} else {
			n = nDAO.selectNotice(sqlSession,nId);
		}
		
		return n;
	}

	@Override
	public int updateNotice(Notice n) {
		return nDAO.updateNotice(sqlSession,n);
	}

}
