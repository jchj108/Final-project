package com.kh.workhome.mail.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Repository;

public class Mail {

	private int number;
	private String receiveEmp; // 받는 사람
	private String etype; // 외부, 내부
	private String etitle;
	private String econtent;
	private String estatus;
	private Date eRTime; // 읽은 시간
	private Date sDate; // 보낸 시간
	private String senderMailId; // 보낸 사람 메일 주소
	private String senderName; // 보낸 사람 이름

	public Mail() {
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
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

	public Mail(int number, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Date eRTime, Date sDate, String senderMailId, String senderName) {
		super();
		this.number = number;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.eRTime = eRTime;
		this.sDate = sDate;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
	}

	@Override
	public String toString() {
		return "Mail [number=" + number + ", receiveEmp=" + receiveEmp + ", etype=" + etype + ", etitle=" + etitle
				+ ", econtent=" + econtent + ", estatus=" + estatus + ", eRTime=" + eRTime + ", sDate=" + sDate
				+ ", senderMailId=" + senderMailId + ", senderName=" + senderName + "]";
	}


}
