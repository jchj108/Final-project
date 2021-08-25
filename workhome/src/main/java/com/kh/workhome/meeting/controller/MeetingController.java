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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.meeting.model.service.MeetingService;

@Controller
public class MeetingController {
	
	@Autowired
	private MeetingService meService;
	
	@Autowired
	private EmployeeService eService;

	@RequestMapping("meetReserv.meet")
	public String meetingReserv() {
		
		return "meetingReservation";
	}
	
	@RequestMapping("meetReserv2.meet")
	public String meetingReserv2() {
		
		return "meetingReservation2";		
	}
	
	@RequestMapping("meetReserv3.meet")
	public String meetingReserv3() {
		
		return "meetingReservation3";		
	}
	
	@RequestMapping("meetReserv5.meet")
	public String meetingReserv5() {
		
		return "meetingReservation6";		
	}

	
	
		
	@RequestMapping("meetReserv4.meet")
	public ModelAndView rInsertView(ModelAndView mv) {
		ArrayList<HashMap<Integer,String>> roomList = meService.selectRoom();
		mv.addObject("roomList",roomList);
		mv.setViewName("meetingReservation4");
		return mv;
	}	

		
	@RequestMapping("searchEmpList.meet")
	public void searchEmpList(HttpServletResponse response, HttpSession session,
							 @RequestParam("search")String search) throws IOException {
		
		System.out.println("search : " + search);
		
		ArrayList<Employee>list = meService.searchEmpList("%"+search.trim()+"%");
		System.out.println("list : " + list);
		ArrayList<String> resultList = new ArrayList<>();
			
//		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
//		System.out.println("loginEmp : " + loginEmp);
//		String myNo = loginEmp.getEmpNo();
		
		for(Employee emp :list) {
				String str = URLEncoder.encode("( "+emp.getEmpNo()+" ) "+ emp.getEmpName() +" - "+emp.getDeptName() ,"utf-8");
				resultList.add(str);
				System.out.println("str : " + str);
				System.out.println("resultList : " + resultList);				
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(resultList,response.getWriter());
	}
	
//	
//	@RequestMapping(value = "searchEmp.meet", method = RequestMethod.POST)
//	 public void AutoTest(Locale locale, Model model, HttpServletRequest request,
//			 HttpServletResponse response) throws IOException {
//	 
//	 String result = request.getParameter("term");
//	 
//	 ArrayList<Employee>list = meService.searchEmpList2(result); //result값이 포함되어 있는 emp테이블의 네임을 리턴
//	 
//	 System.out.println(result);
//	 
//	 JSONArray ja = new JSONArray();
//	 for (int i = 0; i < list.size(); i++) {
//		 ja.add(list.get(i).getEmpName());
//	 }
//	 
//	 System.out.println(list);
//	 
//	 PrintWriter out = response.getWriter();
//	 
//	 out.print(ja.toString());
//	 
//	 }

	
}
