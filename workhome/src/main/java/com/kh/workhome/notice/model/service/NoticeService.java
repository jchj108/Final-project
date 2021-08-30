package com.kh.workhome.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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

	ArrayList<Notice> selectTopList();

	int getSearchResultListCount(HashMap<String, String> map);

	ArrayList<Notice> selectSearchResultList(HashMap<String, String> map, PageInfo pi);

}
