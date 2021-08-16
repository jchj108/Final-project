package com.kh.workhome.mail.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;

@Repository("mDAO")
public class MailDAO {

	public int insertMailFile(SqlSessionTemplate sqlSession, List<MailFile> mailFileList) {
		
		int result = 0;
		
		for(MailFile mf : mailFileList) {
			result += sqlSession.insert("mailMapper.insertMailFile", mf);
		}
		return result;
	}

	public int insertMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.insert("mailMapper.insertMail", m);
	}
}
