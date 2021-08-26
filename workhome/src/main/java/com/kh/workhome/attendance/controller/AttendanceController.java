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
		System.out.println("?????????" +list);
		if(list != null) {
			mv.addObject("list",list).addObject("pi",pi);
			mv.setViewName("attendanceView");
		} 
		return mv;
		
		
//		Employee loginUser = (Employee) session.getAttribute("loginUser");
//		String empNo = loginUser.getEmpNo();
		
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss"); 
//		String strDate = dateFormat.format(Calendar.getInstance().getTime()); 
//		String[] temp = strDate.split(" ");
//		String startOfDate = temp[0]+" "+"00:00:00";
//
//		HashMap<String,String> keys = new HashMap<>();
//		keys.put("empNo", empNo);
//		keys.put("date", strDate);
//		keys.put("start", startOfDate);
//		int result = atService.goHome(keys);
		
//		HashMap<String,String> map = atService.selectCommute(keys);
//		System.out.println("keys : " + keys); // {date=2021-08-26 17:37:04, start=2021-08-26 00:00:00, empNo=BSC0010}
		
		
//		HashMap<String, Object> rMap = new HashMap<String, Object>();
		
//		if(result > 0) {
//			rMap.put("result","success");
//			rMap.put("time", strDate);
//			rMap.put("map", map);
//		} 	else {
//			rMap.put("result","fail");
//		}
		
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd kk:mm:ss").create();
//		gson.toJson(rMap,response.getWriter());
		
		
	}
	
	
}
