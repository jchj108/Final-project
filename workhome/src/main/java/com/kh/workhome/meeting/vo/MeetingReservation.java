package com.kh.workhome.meeting.vo;

import java.sql.Date;

public class MeetingReservation {
	
	private Date StartTime; // 회의 시작 시간
	private Date EndTime; // 회의 종료 시간
	private String MNo; // 회의실 번호
	private String JoinEmp; // 참가인
	private String MTitle; // 제목
	private String MContent; // 내용
	private String RStatus; // 상태
	private String EmpNo; // 신청인
	
	public MeetingReservation() {}

	public MeetingReservation(Date startTime, Date endTime, String mNo, String joinEmp, String mTitle, String mContent,
			String rStatus, String empNo) {
		super();
		StartTime = startTime;
		EndTime = endTime;
		MNo = mNo;
		JoinEmp = joinEmp;
		MTitle = mTitle;
		MContent = mContent;
		RStatus = rStatus;
		EmpNo = empNo;
	}

	public Date getStartTime() {
		return StartTime;
	}

	public void setStartTime(Date startTime) {
		StartTime = startTime;
	}

	public Date getEndTime() {
		return EndTime;
	}

	public void setEndTime(Date endTime) {
		EndTime = endTime;
	}

	public String getMNo() {
		return MNo;
	}

	public void setMNo(String mNo) {
		MNo = mNo;
	}

	public String getJoinEmp() {
		return JoinEmp;
	}

	public void setJoinEmp(String joinEmp) {
		JoinEmp = joinEmp;
	}

	public String getMTitle() {
		return MTitle;
	}

	public void setMTitle(String mTitle) {
		MTitle = mTitle;
	}

	public String getMContent() {
		return MContent;
	}

	public void setMContent(String mContent) {
		MContent = mContent;
	}

	public String getRStatus() {
		return RStatus;
	}

	public void setRStatus(String rStatus) {
		RStatus = rStatus;
	}

	public String getEmpNo() {
		return EmpNo;
	}

	public void setEmpNo(String empNo) {
		EmpNo = empNo;
	}

	@Override
	public String toString() {
		return "MeetingReservation [StartTime=" + StartTime + ", EndTime=" + EndTime + ", MNo=" + MNo + ", JoinEmp="
				+ JoinEmp + ", MTitle=" + MTitle + ", MContent=" + MContent + ", RStatus=" + RStatus + ", EmpNo="
				+ EmpNo + "]";
	}

	
}