package com.kh.workhome;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.workhome.attendance.model.service.AttendanceService;
import com.kh.workhome.employee.model.vo.Employee;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private AttendanceService atService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpSession session, ModelAndView mv) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
		
//		return "home";
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		keys.put("empNo", loginUser.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		
		HashMap<String,String> map = atService.selectCommute(keys);
		mv.addObject("map",map);
		System.out.println(map);

		mv.setViewName("home");
		return mv;
	}
	
	//출근
	@RequestMapping(value="workstart.do")
	@ResponseBody
	public String chulgun(HttpSession session) {
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		String EmpNo = loginUser.getEmpNo();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		
		HashMap<String,String> map = new HashMap<>();
		map.put("empNo", EmpNo);
		map.put("Date", strDate);
		
		int result = atService.chulgun(map);
		if(result>0) {
			return strDate;
		}else {
			return "fail";
		}
	}
	
	//퇴근
		@RequestMapping("goHome.do")
		@ResponseBody
		public void goHome(HttpSession session, HttpServletResponse response) throws JsonIOException, IOException {
			Employee loginUser = (Employee) session.getAttribute("loginUser");
			String EmpNo = loginUser.getEmpNo();
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			String strDate = dateFormat.format(Calendar.getInstance().getTime());
			String[] temp = strDate.split(" ");
			String startOfDate = temp[0]+" "+"00:00:00";
			
			HashMap<String,String> keys = new HashMap<>();
			keys.put("empNo", EmpNo);
			keys.put("date", strDate);
			keys.put("start", startOfDate);
			int result = atService.goHome(keys);
			
			HashMap<String,String> map = atService.selectCommute(keys);
		
			HashMap<String, Object> rMap = new HashMap<String, Object>();
			if(result > 0) {
				rMap.put("result","success");
				rMap.put("time", strDate);
				rMap.put("map", map);
			}else {
				rMap.put("result", "fail");
			}
			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd kk:mm:ss").create();
			gson.toJson(rMap,response.getWriter());
		}
	}
