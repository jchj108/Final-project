package com.kh.workhome.meeting.vo;

public class MeetingRoom {
	private String MNo; // 회의실 번호
	private String MName; // 회의실 명
	public MeetingRoom(String mNo, String mName) {
		super();
		MNo = mNo;
		MName = mName;
	}
	public String getMNo() {
		return MNo;
	}
	public void setMNo(String mNo) {
		MNo = mNo;
	}
	public String getMName() {
		return MName;
	}
	public void setMName(String mName) {
		MName = mName;
	}
	@Override
	public String toString() {
		return "MeetingRoom [MNo=" + MNo + ", MName=" + MName + "]";
	}
	
}
