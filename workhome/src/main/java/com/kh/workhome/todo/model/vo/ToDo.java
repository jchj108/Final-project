package com.kh.workhome.todo.model.vo;

import java.sql.Timestamp;

public class ToDo {
	private String tNo;
	private Timestamp start;
	private String tContent;
	private Timestamp end;
	private String empNo;
	private String tTitle;
	private String tType;
	private String bgColor;
	private String allDay;
	private String textColor;

	public ToDo() {}
	
	public String gettNo() {
		return tNo;
	}

	public Timestamp getStart() {
		return start;
	}

	
	public void setStart(Timestamp start) {
		this.start = start;
	}

	public String gettContent() {
		return tContent;
	}

	public void settContent(String tContent) {
		this.tContent = tContent;
	}

	public Timestamp getEnd() {
		return end;
	}

	public void setEnd(Timestamp end) {
		this.end = end;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String gettTitle() {
		return tTitle;
	}

	public void settTitle(String tTitle) {
		this.tTitle = tTitle;
	}

	public String gettType() {
		return tType;
	}

	public void settType(String tType) {
		this.tType = tType;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}

	public String getAllDay() {
		return allDay;
	}

	public void setAllDay(String allDay) {
		this.allDay = allDay;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public void settNo(String tNo) {
		this.tNo = tNo;
	}

	@Override
	public String toString() {
		return "ToDo [tNo=" + tNo + ", start=" + start + ", tContent=" + tContent + ", end=" + end + ", empNo=" + empNo
				+ ", tTitle=" + tTitle + ", tType=" + tType + ", bgColor=" + bgColor + ", allDay=" + allDay
				+ ", textColor=" + textColor + "]";
	}

	public ToDo(String tNo, Timestamp start, String tContent, Timestamp end, String empNo, String tTitle, String tType,
			String bgColor, String allDay, String textColor) {
		super();
		this.tNo = tNo;
		this.start = start;
		this.tContent = tContent;
		this.end = end;
		this.empNo = empNo;
		this.tTitle = tTitle;
		this.tType = tType;
		this.bgColor = bgColor;
		this.allDay = allDay;
		this.textColor = textColor;
	}


}
