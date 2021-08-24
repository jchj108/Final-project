package com.kh.workhome.meeting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.workhome.employee.model.vo.Employee;

public interface MeetingService {

	ArrayList<Employee> searchEmpList(String string);

	ArrayList<HashMap<Integer, String>> selectRoom();

	ArrayList<Employee> searchEmpList2(String result);

}
