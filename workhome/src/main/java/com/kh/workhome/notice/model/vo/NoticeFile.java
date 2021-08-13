package com.kh.workhome.notice.model.vo;

public class NoticeFile {
	private int fileNo;
	private String originFileName;
	private String renameFileName;
	private int noticeNo;

	public NoticeFile() {}

	public NoticeFile(int fileNo, String originFileName, String renameFileName, int noticeNo) {
		super();
		this.fileNo = fileNo;
		this.originFileName = originFileName;
		this.renameFileName = renameFileName;
		this.noticeNo = noticeNo;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	@Override
	public String toString() {
		return "NoticeFile [fileNo=" + fileNo + ", originFileName=" + originFileName + ", renameFileName="
				+ renameFileName + ", noticeNo=" + noticeNo + "]";
	}
	
	
	
}
