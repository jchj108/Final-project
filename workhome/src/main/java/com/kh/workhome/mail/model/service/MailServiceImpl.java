package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;
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
	public Mail selectMail(Map<String, Object> map) {
		return mDAO.selectMail(sqlSession, map);
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
	public int deleteMail(Map<String, Object> map) {
		return mDAO.deleteMail(sqlSession, map);
	}

	@Override
	public int insertMailSRReceiver(String mId) {
		return mDAO.insertMailSRReceiver(sqlSession, mId);
	}

	@Override
	public int insertMailSRSender(String empNo) {
		return mDAO.insertMailSRSender(sqlSession, empNo);
	}

	@Override
	public int getDeleteListCount(String empNo) {
		return mDAO.getDeleteListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectDeleteList(PageInfo pi, String empNo) {
		return mDAO.selectDeleteList(sqlSession, pi, empNo);
	}

	@Override
	public ArrayList<Employee> searchEmp(String keyword) {
		return mDAO.searchEmp(sqlSession, keyword);
	}

	@Override
	public int updateRDate(Map<String, Object> map) {
		return mDAO.updateRDate(sqlSession, map);
	}

	@Override
	public int updateFavorites(Map<String, Object> map) {
		return mDAO.updateFavorites(sqlSession, map);
	}

	@Override
	public int getAllListCount(String empNo) {
		return mDAO.getAllListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectAllList(PageInfo pi, String empNo) {
		return mDAO.selectAllList(sqlSession, pi, empNo);
	}

	@Override
	public int selectCountNotRead(String empNo) {
		return mDAO.selectCountNotRead(sqlSession, empNo);
	}

	@Override
	public int getFavoritesListCount(String empNo) {
		return mDAO.getFavoritesListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectFavoritesList(PageInfo pi, String empNo) {
		return mDAO.selectFavoritesList(sqlSession, pi, empNo);
	}

	@Override
	public int getSearchListCount(Map<String, Object> map) {
		return mDAO.getSearchListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Mail> searchList(PageInfo pi, Map<String, Object> map) {
		return mDAO.searchList(sqlSession, pi, map);
	}
}
