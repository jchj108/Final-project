package com.kh.workhome.mail.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Repository;

public class Mail {

	private int number;
	private String recieveemp; // 받는 사람
	private String etype; // 외부, 내부
	private String etitle;
	private String econtent;
	private String estatus;
	private Date eRTime; // 읽은 시간
	private Date sDate; // 보낸 시간

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getRecieveemp() {
		return recieveemp;
	}

	public void setRecieveemp(String recieveemp) {
		this.recieveemp = recieveemp;
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

	@Override
	public String toString() {
		return "Mail [number=" + number + ", recieveemp=" + recieveemp + ", etype=" + etype + ", etitle=" + etitle
				+ ", econtent=" + econtent + ", estatus=" + estatus + ", eRTime=" + eRTime + ", sDate=" + sDate + "]";
	}

	public Mail() {

	}

	public Mail(int number, String recieveemp, String etype, String etitle, String econtent, String estatus,
			Date eRTime, Date sDate) {
		super();
		this.number = number;
		this.recieveemp = recieveemp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.eRTime = eRTime;
		this.sDate = sDate;
	}

}
