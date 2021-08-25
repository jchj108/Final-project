package com.kh.workhome.mail.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.employee.model.vo.Employee;
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
	
	public int getTempListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("mailMapper.getTempListCount", empNo);
	}

	public ArrayList<Mail> selectTempList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo) {
		
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		// offSet : cp가 10일 때 15 * 9 = 125, 125개 게시물 건너뛰기, cp가 1일 떄는 15 * 0이므로 0개 게시물 건너뛰기
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectTempList", empNo, rowBounds);
	}

	public Mail selectTempMail(SqlSessionTemplate sqlSession, int id) {
		return sqlSession.selectOne("mailMapper.selectTempMail", id);
	}

	public int updateMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.update("mailMapper.updateMail", m);
	}

	public int deleteMailFile(SqlSessionTemplate sqlSession, int mFileNo) {
		return sqlSession.delete("mailMapper.deleteMailFile", mFileNo);
	}

	public MailFile selectMailFile(SqlSessionTemplate sqlSession, int mFileNo) {
		return sqlSession.selectOne("mailMapper.selectMailFile", mFileNo);
	}

	public int getReceiveListCount(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("mailMapper.getReceiveListCount", email);
	}

	public int insertTempMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.insert("mailMapper.insertTempMail", m);
	}

	public int getSendListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("mailMapper.getSendListCount", empNo);
	}

	public ArrayList<Mail> selectSendList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectSendList", empNo, rowBounds);
	}

	public Mail selectMail(SqlSessionTemplate sqlSession, int id) {
		return sqlSession.selectOne("mailMapper.selectMail", id);
	}

	public Employee getMId(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("mailMapper.getMId", mId);
	}

	public ArrayList<Mail> selectReceiveList(SqlSessionTemplate sqlSession, PageInfo pi, String email) {
		
		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectReceiveList", email, rowBounds);
	}

	public int deleteMail(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("mailMapper.deleteMail", map);
	}

	public int insertMailSRReceiver(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.insert("mailMapper.insertMailSRReceiver", mId);
	}

	public int insertMailSRSender(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.insert("mailMapper.insertMailSRSender", empNo);
	}

	public int getDeleteListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("mailMapper.getDeleteListCount", empNo);
	}

	public ArrayList<Mail> selectDeleteList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo) {

		int offset = pi.getBoardLimit() * (pi.getCurrentPage()-1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectDeleteList", empNo, rowBounds);
	}
}
