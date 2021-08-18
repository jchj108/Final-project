package com.kh.workhome.notice.model.service;

import java.util.ArrayList;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.notice.model.vo.Notice;
import com.kh.workhome.notice.model.vo.NoticeFile;

public interface NoticeService {

	int getListCount();

	ArrayList<Notice> selectList(PageInfo pi);

	int insertNotice(Notice n);

	Notice selectNotice(int nId, boolean check);

	int updateNotice(Notice n);

	int deleteNotice(int nId);

}
