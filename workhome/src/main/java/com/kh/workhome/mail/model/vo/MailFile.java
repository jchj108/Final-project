package com.kh.workhome.mail.model.vo;

import java.sql.Date;

public class MailFile {

	private int mFileNo;
	private String mOriginalName;
	private String mChangeName;
	private String mFilePath;
	private Date mUploadDate;
	private String mStatus;
	private int mailNo;

	public int getmFileNo() {
		return mFileNo;
	}

	public void setmFileNo(int mFileNo) {
		this.mFileNo = mFileNo;
	}

	public String getmOriginalName() {
		return mOriginalName;
	}

	public void setmOriginalName(String mOriginalName) {
		this.mOriginalName = mOriginalName;
	}

	public String getmChangeName() {
		return mChangeName;
	}

	public void setmChangeName(String mChangeName) {
		this.mChangeName = mChangeName;
	}

	public String getmFilePath() {
		return mFilePath;
	}

	public void setmFilePath(String mFilePath) {
		this.mFilePath = mFilePath;
	}

	public Date getmUploadDate() {
		return mUploadDate;
	}

	public void setmUploadDate(Date mUploadDate) {
		this.mUploadDate = mUploadDate;
	}

	public String getmStatus() {
		return mStatus;
	}

	public void setmStatus(String mStatus) {
		this.mStatus = mStatus;
	}

	public int getMailNo() {
		return mailNo;
	}

	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
	}

	public MailFile() {
	}

	public MailFile(int mFileNo, String mOriginalName, String mChangeName, String mFilePath, Date mUploadDate,
			String mStatus, int mailNo) {
		super();
		this.mFileNo = mFileNo;
		this.mOriginalName = mOriginalName;
		this.mChangeName = mChangeName;
		this.mFilePath = mFilePath;
		this.mUploadDate = mUploadDate;
		this.mStatus = mStatus;
		this.mailNo = mailNo;
	}

	@Override
	public String toString() {
		return "MailFile [mFileNo=" + mFileNo + ", mOriginalName=" + mOriginalName + ", mChangeName=" + mChangeName
				+ ", mFilePath=" + mFilePath + ", mUploadDate=" + mUploadDate + ", mStatus=" + mStatus + ", mailNo="
				+ mailNo + "]";
	}

	public MailFile(String mOriginalName, String mChangeName, String mFilePath, int mailNo) {
		super();
		this.mOriginalName = mOriginalName;
		this.mChangeName = mChangeName;
		this.mFilePath = mFilePath;
		this.mailNo = mailNo;
	}

	public MailFile(String mOriginalName, String mChangeName, String mFilePath) {
		super();
		this.mOriginalName = mOriginalName;
		this.mChangeName = mChangeName;
		this.mFilePath = mFilePath;
	}
}
