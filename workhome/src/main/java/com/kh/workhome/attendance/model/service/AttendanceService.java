package com.kh.workhome.attendance.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.workhome.attendance.model.vo.Attendance;
import com.kh.workhome.common.PageInfo;

public interface AttendanceService{

	HashMap<String, String> selectCommute(HashMap<String, String> keys);

	int startwork(HashMap<String, String> map);

	int goHome(HashMap<String, String> keys);

	int getListCount();

	ArrayList<Attendance> selectList(PageInfo pi);

}
