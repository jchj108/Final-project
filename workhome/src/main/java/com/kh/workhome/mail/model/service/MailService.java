package com.kh.workhome.mail.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;

public interface MailService {
	
	int insertMailFile(List<MailFile> mailFileList);

	int insertMail(Mail m);

	int getTempListCount();

	ArrayList<Mail> selectTempList(PageInfo pi, String empNo);

	Mail selectMail(int id);

	int updateMail(Mail m);

	int deleteMailFile(int mFileNo);

	MailFile selectMailFile(int mFileNo);

}
