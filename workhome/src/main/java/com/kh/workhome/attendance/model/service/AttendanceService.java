package com.kh.workhome.attendance.model.service;

import java.util.HashMap;

public interface AttendanceService{

	HashMap<String, String> selectCommute(HashMap<String, String> keys);

	int chulgun(HashMap<String, String> map);

}
