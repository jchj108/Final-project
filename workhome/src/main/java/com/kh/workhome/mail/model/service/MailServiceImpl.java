package com.kh.workhome.mail.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.mail.model.dao.MailDAO;
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
	
}
