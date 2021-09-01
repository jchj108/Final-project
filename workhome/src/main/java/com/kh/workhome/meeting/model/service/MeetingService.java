package com.kh.workhome.meeting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.meeting.model.vo.MeetingReservation;

public interface MeetingService {

	ArrayList<Employee> searchEmpList(String string);

	ArrayList<HashMap<Integer, String>> selectRoom();

	ArrayList<Employee> searchEmpList2(String result);

	int reInsert(MeetingReservation m);

	ArrayList<String> rSelectDate(HashMap<String, Object> map);

	ArrayList<MeetingReservation> selectAllReservation(String empNo);

}
