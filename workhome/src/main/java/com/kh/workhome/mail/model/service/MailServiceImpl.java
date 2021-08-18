package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.mail.model.dao.MailDAO;
import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;

@Service("mService")
public class MailServiceImpl implements MailService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MailDAO mDAO;
	
	@Override
	public int insertMailFile(List<MailFile> mailFileList) {
		
		return mDAO.insertMailFile(sqlSession, mailFileList);
	}

	@Override
	public int insertMail(Mail m) {
		return mDAO.insertMail(sqlSession, m);
	}

	@Override
	public int getTempListCount() {
		return mDAO.getTempListCount(sqlSession);
	}

	@Override
	public ArrayList<Mail> selectTempList(PageInfo pi) {
		return mDAO.selectTempList(sqlSession, pi);
	}

	@Override
	public Mail selectMail(int id) {
		return mDAO.selectMail(sqlSession, id);
	}
}
