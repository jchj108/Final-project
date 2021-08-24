package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;

public interface MailService {
	
	int insertMailFile(List<MailFile> mailFileList);

	int insertMail(Mail m);

	int getTempListCount(String empNo);

	ArrayList<Mail> selectTempList(PageInfo pi, String empNo);

	Mail selectTempMail(int id);

	int updateMail(Mail m);

	int deleteMailFile(int mFileNo);

	MailFile selectMailFile(int mFileNo);

	int getReceiveListCount(Map<String, String> map);

	int insertTempMail(Mail m);

	ArrayList<Mail> selectReceiveList(PageInfo pi, Map<String, String> map);

	int getsendListCount(String empNo);

	ArrayList<Mail> selectSendList(PageInfo pi, String empNo);

	Mail selectMail(int id);

	Employee getMId(String mId);
}
