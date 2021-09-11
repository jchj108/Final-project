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
	private boolean allDay;
	private String textColor;
	private String username;
	private String share;

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

	public boolean isAllDay() {
		return allDay;
	}

	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getshare() {
		return share;
	}

	public void setshare(String share) {
		this.share = share;
	}

	public ToDo(String tNo, Timestamp start, String description, Timestamp end, String empNo, String title, String type,
			String backgroundColor, boolean allDay, String textColor, String username, String share) {
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
		this.username = username;
		this.share = share;
	}

	@Override
	public String toString() {
		return "ToDo [tNo=" + tNo + ", start=" + start + ", description=" + description + ", end=" + end + ", empNo="
				+ empNo + ", title=" + title + ", type=" + type + ", backgroundColor=" + backgroundColor + ", allDay="
				+ allDay + ", textColor=" + textColor + ", username=" + username + ", share=" + share + "]";
	}
	
}
