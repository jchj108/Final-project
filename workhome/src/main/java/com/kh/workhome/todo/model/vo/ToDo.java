package com.kh.workhome.todo.model.vo;

import java.sql.Timestamp;

public class ToDo {
	private String tNo;
	private Timestamp start;
	private String description;
	private Timestamp end;
	private String empNo;
	private String title;
	private String type;
	private String backgroundColor;
	private String allDay;
	private String textColor;

	public ToDo() {}

	public String gettNo() {
		return tNo;
	}

	public void settNo(String tNo) {
		this.tNo = tNo;
	}

	public Timestamp getStart() {
		return start;
	}

	public void setStart(Timestamp start) {
		this.start = start;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
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

	@Override
	public String toString() {
		return "ToDo [tNo=" + tNo + ", start=" + start + ", description=" + description + ", end=" + end + ", empNo="
				+ empNo + ", title=" + title + ", type=" + type + ", backgroundColor=" + backgroundColor + ", allDay="
				+ allDay + ", textColor=" + textColor + "]";
	}

	public ToDo(String tNo, Timestamp start, String description, Timestamp end, String empNo, String title, String type,
			String backgroundColor, String allDay, String textColor) {
		super();
		this.tNo = tNo;
		this.start = start;
		this.description = description;
		this.end = end;
		this.empNo = empNo;
		this.title = title;
		this.type = type;
		this.backgroundColor = backgroundColor;
		this.allDay = allDay;
		this.textColor = textColor;
	}
	


}
