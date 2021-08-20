package com.kh.workhome.attendance.model.vo;

import java.sql.Date;

public class Attendance {
	private Date aDate;
	private String empNo;
	private Date attend;
	private Date leave;
	
	public Attendance() {}

	public Attendance(Date aDate, String empNo, Date attend, Date leave) {
		super();
		this.aDate = aDate;
		this.empNo = empNo;
		this.attend = attend;
		this.leave = leave;
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

	public Date getLeave() {
		return leave;
	}

	public void setLeave(Date leave) {
		this.leave = leave;
	}

	@Override
	public String toString() {
		return "Attandance [aDate=" + aDate + ", empNo=" + empNo + ", attend=" + attend + ", leave=" + leave + "]";
	}
	
}
