package com.kh.workhome.mail.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class Mail {

	private int mailNo;
	private String receiveEmp; // 받는 사람
	private String etype; // 외부, 내부
	private String etitle;
	private String econtent;
	private String estatus;
	private Date eRTime; // 읽은 시간
	private Date sDate; // 보낸 시간
	private String empNo;
	private String senderMailId; // 보낸 사람 메일 주소
	private String senderName;
	private ArrayList<MailFile> mailFileList;
	
	public Mail() {}
	
	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Date eRTime, Date sDate, String senderMailId, String senderName, ArrayList<MailFile> mailFileList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.eRTime = eRTime;
		this.sDate = sDate;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.mailFileList = mailFileList;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	
	

	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Date eRTime, Date sDate, String empNo, String senderMailId, String senderName,
			ArrayList<MailFile> mailFileList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.eRTime = eRTime;
		this.sDate = sDate;
		this.empNo = empNo;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.mailFileList = mailFileList;
	}

	public int getMailNo() {
		return mailNo;
	}
	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
	}
	public String getReceiveEmp() {
		return receiveEmp;
	}
	public void setReceiveEmp(String receiveEmp) {
		this.receiveEmp = receiveEmp;
	}
	public String getEtype() {
		return etype;
	}
	public void setEtype(String etype) {
		this.etype = etype;
	}
	public String getEtitle() {
		return etitle;
	}
	public void setEtitle(String etitle) {
		this.etitle = etitle;
	}
	public String getEcontent() {
		return econtent;
	}
	public void setEcontent(String econtent) {
		this.econtent = econtent;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public Date geteRTime() {
		return eRTime;
	}
	public void seteRTime(Date eRTime) {
		this.eRTime = eRTime;
	}
	public Date getsDate() {
		return sDate;
	}
	public void setsDate(Date sDate) {
		this.sDate = sDate;
	}
	public String getSenderMailId() {
		return senderMailId;
	}
	public void setSenderMailId(String senderMailId) {
		this.senderMailId = senderMailId;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public ArrayList<MailFile> getMailFileList() {
		return mailFileList;
	}
	public void setMailFileList(ArrayList<MailFile> mailFileList) {
		this.mailFileList = mailFileList;
	}

}
