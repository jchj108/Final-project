package com.kh.workhome.meeting.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.meeting.model.service.MeetingService;
import com.kh.workhome.meeting.model.vo.MeetingReservation;

@Controller
public class MeetingController {
	
	@Autowired
	private MeetingService meService;
	
	@Autowired
	private EmployeeService eService;
	
	@RequestMapping("meetReserv5.meet")
	public String meetingReserv5() {
		
		return "meetingReservation6";		
	}

		
	@RequestMapping("searchEmpList.meet")
	public void searchEmpList(HttpServletResponse response, HttpSession session,
							 @RequestParam("search")String search) throws IOException {
		
//		System.out.println("search : " + search);
		
		ArrayList<Employee>list = meService.searchEmpList("%"+search.trim()+"%");
//		System.out.println("list : " + list);
		ArrayList<String> resultList = new ArrayList<>();
			
//		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
//		System.out.println("loginEmp : " + loginEmp);
//		String myNo = loginEmp.getEmpNo();
		
		for(Employee emp :list) {
				String str = URLEncoder.encode("["+emp.getEmpNo()+"] "+ emp.getEmpName() +" - "+emp.getDeptName() ,"utf-8");
				resultList.add(str);
//				System.out.println("str : " + str);
//				System.out.println("resultList : " + resultList);				
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(resultList,response.getWriter());
	}

	// 예약하기
	@RequestMapping("reInsert.meet")
	@ResponseBody
	public String reInsert(
			  @RequestParam(value="rDate", required=false) String rDate,
			  @RequestParam("joinEmp") String joinEmp,
			  @RequestParam("mTitle") String mTitle,
			  @RequestParam("mContent") String mContent) {
		
		MeetingReservation m = new MeetingReservation();
		
		m.setrDate(rDate);
		m.setJoinEmp(joinEmp);
		m.setmTitle(mTitle);
		m.setmContent(mContent);
	
		System.out.println(m);
		
		int result = meService.reInsert(m);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
}
