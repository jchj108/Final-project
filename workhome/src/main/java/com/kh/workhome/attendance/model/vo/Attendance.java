package com.kh.workhome.attendance.model.vo;

import java.sql.Date;

public class Attendance {
	private Date aDate;
	private String empNo;
	private Date attend;
	private Date goHome;
	
	public Attendance() {}

	public Attendance(Date aDate, String empNo, Date attend, Date goHome) {
		super();
		this.aDate = aDate;
		this.empNo = empNo;
		this.attend = attend;
		this.goHome = goHome;
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

	public Date getAttend() {
		return attend;
	}

	public void setAttend(Date attend) {
		this.attend = attend;
	}

	public Date getGoHome() {
		return goHome;
	}

	public void setGoHome(Date goHome) {
		this.goHome = goHome;
	}

	@Override
	public String toString() {
		return "Attendance [aDate=" + aDate + ", empNo=" + empNo + ", attend=" + attend + ", goHome=" + goHome + "]";
	}

	
	
}
