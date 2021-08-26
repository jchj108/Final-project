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

	int insertTempMail(Mail m);

	int getsendListCount(String empNo);

	ArrayList<Mail> selectSendList(PageInfo pi, String empNo);

	Mail selectMail(int id);

	Employee getMId(String mId);

	int getReceiveListCount(String email);

	ArrayList<Mail> selectReceiveList(PageInfo pi, String email);

	int deleteMail(Map<String, Object> map);

	int insertMailSRReceiver(String mId);

	int insertMailSRSender(String empNo);

	int getDeleteListCount(String empNo);

	ArrayList<Mail> selectDeleteList(PageInfo pi, String empNo);

	ArrayList<Employee> searchEmp(String keyword);

	int updateRDate(int id);

}
