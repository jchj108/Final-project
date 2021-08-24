package com.kh.workhome.meeting.model.vo;

import java.sql.Date;

public class MeetingReservation {

	private String rDate;
	private String rTime;
	private Date startTime; // 회의 시작 시간
	private Date endTime; // 회의 종료 시간
	private String mNo; // 회의실 번호
	private String joinEmp; // 참가인
	private String mTitle; // 제목
	private String mContent; // 내용
	private String rStatus; // 상태
	private String empNo; // 신청인
	
	public MeetingReservation() {}

	public MeetingReservation(String rDate, String rTime, Date startTime, Date endTime, String mNo, String joinEmp,
			String mTitle, String mContent, String rStatus, String empNo) {
		super();
		this.rDate = rDate;
		this.rTime = rTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.mNo = mNo;
		this.joinEmp = joinEmp;
		this.mTitle = mTitle;
		this.mContent = mContent;
		this.rStatus = rStatus;
		this.empNo = empNo;
	}

	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public String getrTime() {
		return rTime;
	}

	public void setrTime(String rTime) {
		this.rTime = rTime;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getmNo() {
		return mNo;
	}

	public void setmNo(String mNo) {
		this.mNo = mNo;
	}

	public String getJoinEmp() {
		return joinEmp;
	}

	public void setJoinEmp(String joinEmp) {
		this.joinEmp = joinEmp;
	}

	public String getmTitle() {
		return mTitle;
	}

	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}

	public String getmContent() {
		return mContent;
	}

	public void setmContent(String mContent) {
		this.mContent = mContent;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	@Override
	public String toString() {
		return "MeetingReservation [rDate=" + rDate + ", rTime=" + rTime + ", startTime=" + startTime + ", endTime="
				+ endTime + ", mNo=" + mNo + ", joinEmp=" + joinEmp + ", mTitle=" + mTitle + ", mContent=" + mContent
				+ ", rStatus=" + rStatus + ", empNo=" + empNo + "]";
	}



}	