package com.kh.workhome.attendance.model.vo;

import java.sql.Date;

public class Attendance {
	private Date aDate;
	private String empNo;
	private String attend;
	private String goHome;
	private String workTime;
	
	public Attendance() {}

	public Attendance(Date aDate, String empNo, String attend, String goHome, String workTime) {
		super();
		this.aDate = aDate;
		this.empNo = empNo;
		this.attend = attend;
		this.goHome = goHome;
		this.workTime = workTime;
	}


	public Date getaDate() {
		return aDate;
	}

	public void setaDate(Date aDate) {
		this.aDate = aDate;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getAttend() {
		return attend;
	}

	public void setAttend(String attend) {
		this.attend = attend;
	}

	public String getGoHome() {
		return goHome;
	}

	public void setGoHome(String goHome) {
		this.goHome = goHome;
	}
	
	public String getWorkTime() {
		return workTime;
	}

	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}

	@Override
	public String toString() {
		return "Attendance [aDate=" + aDate + ", empNo=" + empNo + ", attend=" + attend + ", goHome=" + goHome
				+ ", workTime=" + workTime + "]";
	}

	


	

	
	
}
