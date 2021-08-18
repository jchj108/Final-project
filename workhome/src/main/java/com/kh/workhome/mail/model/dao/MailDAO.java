package com.kh.workhome.mail.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.common.PageInfo;
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
	
	public int getTempListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mailMapper.getTempListCount");
	}

	public ArrayList<Mail> selectTempList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		// offSet : cp가 10일 때 15 * 9 = 125, 125개 게시물 건너뛰기, cp가 1일 떄는 15 * 0이므로 0개 게시물 건너뛰기
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectTempList", null, rowBounds);
	}

	public Mail selectMail(SqlSessionTemplate sqlSession, int id) {
		return sqlSession.selectOne("mailMapper.selectMail", id);
	}

	public int updateMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.update("mailMapper.updateMail", m);
	}
}
