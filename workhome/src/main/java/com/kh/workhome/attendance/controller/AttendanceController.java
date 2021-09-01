package com.kh.workhome.attendance.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.workhome.attendance.model.service.AttendanceService;
import com.kh.workhome.attendance.model.vo.Attendance;
import com.kh.workhome.common.PageInfo;
import com.kh.workhome.common.Pagination;
import com.kh.workhome.employee.model.vo.Employee;

@Controller
public class AttendanceController {
	
	@Autowired
	private AttendanceService atService;
	
	@RequestMapping("alist.ao")
	public ModelAndView attendanceList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv, HttpSession session, HttpServletResponse response) throws JsonIOException, IOException {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = atService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		//날짜만 가져옴 + 페이징처리
		ArrayList<Attendance> list = atService.selectList(pi);
		System.out.println("출퇴근 기록 : "+list);
		if(list != null) {
			mv.addObject("list",list).addObject("pi",pi);
			mv.setViewName("attendanceView");
		}
		return mv;
	}
	
	
}
