package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.employee.model.vo.Employee;
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
	public int insertTempMail(Mail m) {
		return mDAO.insertTempMail(sqlSession, m);
	}

	@Override
	public int getsendListCount(String empNo) {
		return mDAO.getSendListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectSendList(PageInfo pi, String empNo) {
		return mDAO.selectSendList(sqlSession, pi, empNo);
	}

	@Override
	public Mail selectMail(int id) {
		return mDAO.selectMail(sqlSession, id);
	}

	@Override
	public Employee getMId(String mId) {
		return mDAO.getMId(sqlSession, mId);
	}

	@Override
	public int getReceiveListCount(String email) {
		return mDAO.getReceiveListCount(sqlSession, email);
	}

	@Override
	public ArrayList<Mail> selectReceiveList(PageInfo pi, String email) {
		return mDAO.selectReceiveList(sqlSession, pi, email);
	}

	@Override
	public int deleteMail(int mNo) {
		return mDAO.deleteMail(sqlSession, mNo);
	}
}
