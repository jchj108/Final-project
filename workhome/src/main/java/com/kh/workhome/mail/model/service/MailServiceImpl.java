package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	public int getTempListCount(String empNo) {
		return mDAO.getTempListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectTempList(PageInfo pi, String empNo) {
		return mDAO.selectTempList(sqlSession, pi, empNo);
	}

	@Override
	public Mail selectTempMail(int id) {
		return mDAO.selectTempMail(sqlSession, id);
	}

	@Override
	public int updateMail(Mail m) {
		return mDAO.updateMail(sqlSession, m);
	}

	@Override
	public int deleteMailFile(int mFileNo) {
		return mDAO.deleteMailFile(sqlSession, mFileNo);
	}

	@Override
	public MailFile selectMailFile(int mFileNo) {
		return mDAO.selectMailFile(sqlSession, mFileNo);
	}

	@Override
	public int getReceiveListCount(Map<String, String> map) {
		return mDAO.getReceiveListCount(sqlSession, map);
	}

	@Override
	public int insertTempMail(Mail m) {
		return mDAO.insertTempMail(sqlSession, m);
	}

	@Override
	public ArrayList<Mail> selectReceiveList(PageInfo pi, Map<String, String> map) {
		return null;
	}
}
