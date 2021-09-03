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
	

	// 회의 예약하기 페이지 호출
	@RequestMapping("meetReserv.meet")
	public String meetingReserv() {
		
		return "meetingReservation";		
	}

	
	
	

	// 자동 완성 참여 사원 검색하기
	@RequestMapping("searchEmpList.meet")
	public void searchEmpList(HttpServletResponse response, HttpSession session,
							 @RequestParam("search")String search, HttpServletRequest request) throws IOException {
		
//		System.out.println("search : " + search);
		
		ArrayList<Employee>list = meService.searchEmpList("%"+search.trim()+"%");
//		System.out.println("list : " + list);
		ArrayList<String> resultList = new ArrayList<>();
		
		
		String myNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		
//		System.out.println("empNo : " + empNo);

		
		// 로그인한 사원은 뜨지 않도록 하기		
		for(Employee emp :list) {
			if(emp.getEmpNo().equals(myNo)) {
			}else {
				String str = URLEncoder.encode("["+emp.getEmpNo()+"] "+ emp.getEmpName() +" - "+emp.getDeptName() ,"utf-8");
				resultList.add(str);
//				System.out.println("str : " + str);
//				System.out.println("resultList : " + resultList);
			}
		}
		
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(resultList,response.getWriter());
	}

	
	
	
	// 예약하기
	@RequestMapping("reInsert.meet")
	@ResponseBody
	public String reInsert(HttpSession session, HttpServletRequest request,
			  @RequestParam(value="rDate", required=false) String rDate,
			  @RequestParam("joinEmp") String joinEmp,
			  @RequestParam("mTitle") String mTitle,
			  @RequestParam("mContent") String mContent,
			  @RequestParam("empNo") String empNo,
			  @RequestParam("mNo") String mNo) {
		
		MeetingReservation m = new MeetingReservation();
		
		m.setrDate(rDate);
		m.setJoinEmp(joinEmp);
		m.setmTitle(mTitle);
		m.setmContent(mContent);
		m.setEmpNo(empNo);
		m.setmNo(mNo);
	
//		System.out.println(m);
		
		
			// 알람 추가하기
			Employee loginEmp = ((Employee) request.getSession().getAttribute("loginUser"));
			HashMap<String, Object> map = new HashMap<>();
			
			int countMTitle = mTitle.length();
			
			if(countMTitle > 5) {
				String editTitle = mTitle.substring(0, 4);
				mTitle = editTitle + "…";
				
				System.out.println("수정된 mTitle : " + mTitle);
			} 
			
			
			
			map.put("aContents", loginEmp.getEmpName()+"님이  '" + mTitle + "' 미팅을 공유했습니다.");
			map.put("aType", "meeting");
			
			ArrayList<String> emp = new ArrayList<>();
			String sepaEmp = joinEmp.substring(0, joinEmp.length()-1); // 제일 뒤에 붙는 ; 없애기
			
			System.out.println("sepaEmp : " + sepaEmp); 
			System.out.println("map : " + map);
			
			
			//사번만 뽑아내기
			if(sepaEmp.contains(";")) { 
				String[] tempEmp = sepaEmp.split(";");
				System.out.println("tempEmp : " + tempEmp);
				for(int i = 0 ; i < tempEmp.length ; i++) {
					emp.add(tempEmp[i].substring(tempEmp[i].indexOf("[")+1, tempEmp[i].indexOf("]")).trim());

				}
			} else {
				emp.add(sepaEmp.substring(sepaEmp.indexOf("[")+1, sepaEmp.indexOf("]")).trim());

			}
			map.put("empNo", emp);
			
			System.out.println("emp : " + emp);
		
		
			
		
		int result = meService.reInsert(m);
		
		eService.insertAlert(map);
		
		if(result > 0) {
			return "success";

		}else {
			return "fail";
		}
		
	}
	
	
	
	
	
	// 날짜와 회의실을 받아 예약 가능 시간 비교하기
	@RequestMapping("rSelectDate.meet")
	public void rSelectDate(HttpServletResponse response, @RequestParam("date")String date,@RequestParam("mNo") String mNo) throws IOException {
		HashMap<String,Object> map= new HashMap<>();
		map.put("date", date+"%");
		map.put("mNo", mNo);
		ArrayList<String> list = meService.rSelectDate(map);
		String result = "";
		
//		System.out.println("selectDateList : " + list); // 그 날짜의 그 회의실에 회의가 있으면 list에 담긴다
		
		if(list!=null) { // list {[2021-07-07;3,4,5], [2021-07-07;6,7]
			for(String str : list ) {
				String resultStr = str.substring(str.indexOf(";")+1, str.length()); // ;이후부터 가져와서 저장하기 ex) 6,7
				if(resultStr.contains(",")) {
					String[] resultArr = resultStr.split(","); // ,로 쪼개서 배열로 담기 [6], [7]
					for(int i = 0 ; i <resultArr.length; i++) {
						result += resultArr[i]+","; // result에 String으로 담기 6,7,
					}
				}else { // 7만 있으면
					result += str+","; //7,
				}
//				System.out.println("result : " + result);
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(result,response.getWriter());
	}
	
	
	
	
	// 회의 내역 불러오기	
	@RequestMapping("rList.meet")
	public ModelAndView rList(ModelAndView mv, HttpSession session, HttpServletRequest request) {
		Employee loginEmp = ((Employee) request.getSession().getAttribute("loginUser"));
		
//		System.out.println("loginEmp : " + loginEmp);
		
		ArrayList<MeetingReservation> list =  meService.selectAllReservation("%"+loginEmp.getEmpNo()+"%");
		
//		System.out.println("list : " + list);
		
		ArrayList<MeetingReservation> mine = new ArrayList<>();// 내가 예약한 회의
		ArrayList<MeetingReservation> join = new ArrayList<>();// 내가 참여할 회의 


		for(MeetingReservation r : list) {
			Employee e = new Employee();
			e.setEmpNo(r.getEmpNo());
			Employee getEmp = eService.selectEmp(e);
			r.setEmpNo("["+getEmp.getEmpNo()+"] " + getEmp.getEmpName()+" - "+getEmp.getDeptName());
			
//			System.out.println("getrDate : " + r.getrDate());
			
			String[] temp = r.getrDate().split(";");

			r.setrDate(temp[0]);
			r.setrTime(temp[1]);
			
			if(r.getEmpNo().contains(loginEmp.getEmpNo())){
				mine.add(r);
//				System.out.println("내가 예약한 회의 : " + mine);
			}else {
				join.add(r);
//				System.out.println("내가 참여할 회의 : " + join);
			}
									
		}
		
		mv.addObject("mine",mine);// 내가 예약한 회의
		mv.addObject("join",join);// 내가 참여할 회의 
		mv.setViewName("meetingReservationList");
		return mv;
	}
	
	
	
	
	
	// 회의 취소 또는 불참	
	@RequestMapping("rCancle.meet")
	@ResponseBody
	public String rUpdate(@RequestParam("id") String id, @RequestParam("rStatus") String rStatus, @RequestParam("joinEmp") String joinEmp) {
		
		MeetingReservation r = new MeetingReservation();
		String[] array = id.split(";");
		
		r.setrDate(array[0]+";"+array[1]);
		r.setmNo((array[2]));
		r.setrStatus(rStatus);
		r.setJoinEmp(joinEmp);
		
		int result = meService.rCancle(r);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
}
