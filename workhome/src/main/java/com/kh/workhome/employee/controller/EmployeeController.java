package com.kh.workhome.employee.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private JavaMailSenderImpl mailSender;

	// 회원가입 페이지 이동
	@RequestMapping("signUpForm.emp")
	public String signUpForm() {
		return "signUp";
	}
	
	// 이메일 중복 체크
	@RequestMapping("dupEmail.emp")
	public void dupEmail(@RequestParam("email") String email, HttpServletResponse response) {
		int result = eService.dupEmail(email);
		boolean bool = result == 0 ? true : false;
		try {
			response.getWriter().println(bool);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 이메일 인증
	@RequestMapping("authEmail.emp")
	public void authEmail(@RequestParam("email") String email, HttpSession session) {
		// ******* 임시 코드 생성 *******
		String authCode = getRandomCode();
		session.setAttribute("authCode", authCode);

		// ******* 메일 전송 *******
		String from = "workhome0215@gmail.com";
		String to = email;
		String subject = "[WorkHome]이메일 인증을 완료해주세요.";
		String text = "<div style='color: #0080FF; font-weight:bold; font-size: 21px;'> WorkHome </div>"
				+ "이메일 인증을 위해 발급된 아래의 코드를 회원가입창에서 입력해주세요. <br> 발급된 임시 코드는 영문 대/소문자를 구분하여 입력하셔야 합니다.<br><br>"
				+ "<div style='border: 1px solid lightgray; width: 450px; height: 70px; font-size: 25px; font-weight: bold; color: #0080FF; text-align: center; line-height: 70px;'>"
				+ authCode + "</div><br><br><hr>"
				+ "<div style='color: #808080;'> © 2021. WorkHome, Inc. All rights reserved.</div>";

		sendMail(from, to, subject, text);
	}

	@RequestMapping("checkCode.emp")
	public void checkEmail(@RequestParam("checkCode") String checkCode, HttpSession session, HttpServletResponse response) {
		boolean bool = false;
		if(session.getAttribute("authCode").equals(checkCode)) {
			bool = true;
		} 
		
		try {
			response.getWriter().println(bool);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 회원가입
	@RequestMapping("insert.emp")
	public String insertEmp(@ModelAttribute Employee e) {
		e.setPassword(bcrypt.encode(e.getPassword()));
		
		int result = eService.insertEmp(e);
		if(result > 0) {
			return "redirect:loginForm.emp";  
		} else {
			return "redirect:signUpForm.emp";
		}
	}
	
	// 로그인 페이지 이동
	@RequestMapping("loginForm.emp")
	public String loginForm() {
		return "login";
	}
	
	// 로그인 
	@RequestMapping("login.emp")
	public String login(@ModelAttribute Employee e, @RequestParam(value="remember", required=false) String remember, 
						Model model, HttpSession session) {

		Employee loginUser = eService.login(e);

		boolean match = false;
		if(loginUser != null) {	// 존재하는 이메일이라면 비밀번호가 일치하는지 확인
			match = bcrypt.matches(e.getPassword(), loginUser.getPassword());
		}
		
		if(match) {				//이메일과 비빌번호 모두 일치할 경우
			session.setAttribute("loginUser", loginUser);
			if(remember != null) {
				// 로그인 유지 O (일주일)
				session.setMaxInactiveInterval(604800);
			} else {
				// 로그인 유지 X (1시간)
				session.setMaxInactiveInterval(3600);
			}
			return "redirect: home.do";			 
		} else {
			model.addAttribute("msg", "로그인 실패");
			return "../../../index";				
		}
	}
	
	// 로그아웃
	@RequestMapping("logout.emp")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:loginForm.emp";
	}
	
	// 비밀번호 찾기 페이지 이동
	@RequestMapping("findPwdForm.emp")
	public String findPwdForm() {
		return "findPwd";
	}
	
	// 비밀번호 찾기
	@RequestMapping("findPwd.emp")
	public String findPwd(@RequestParam String email, Model model) {
		int result = eService.dupEmail(email);
		
		boolean bool = false;
		if(result > 0) {
			// ******* 임시 비밀번호 생성 ******* 
			String rawPassword = getRandomCode();
			String password = bcrypt.encode(rawPassword);	// 암호화
			
			// ******* 임시 비밀번호 DB에 업데이트 *******  
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("email", email);
			map.put("password", password);
			eService.updatePwd(map);
			
			// ******* 메일 전송  *******  
			String from = "workhome0215@gmail.com";
			String to = email;
			String subject = "[WorkHome]개인정보 보호를 위해 임시 비밀번호가 발급되었습니다.";
			String text = "<div style='color: #0080FF; font-weight:bold; font-size: 21px;'> WorkHome </div>"
							+ "개인정보 보호를 위해 임시 비밀번호가 발급되었습니다. <br> 발급된 임시 비밀번호는 영문 대/소문자를 구분하여 입력하셔야 합니다. <br> 재로그인 후에 반드시 비밀번호를 변경해주세요.<br><br>"
							+ "<div style='border: 1px solid lightgray; width: 450px; height: 70px; font-size: 25px; font-weight: bold; color: #0080FF; text-align: center; line-height: 70px;'>" + rawPassword + "</div><br><br><hr>"	
							+"<div style='color: #808080;'> © 2021. WorkHome, Inc. All rights reserved.</div>";
			
			sendMail(from, to, subject, text);
			
			model.addAttribute("msg", "임시비밀번호를 이메일(" + email + ")로 보내드렸습니다.");
			
		} else {
			bool = false;
			model.addAttribute("msg", "일치하는 이메일이 없습니다.");
		}
		return "findPwd";
	}
	
	// 랜덤코드 생성
	public String getRandomCode() {
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		for(int i = 0; i < 4; i++) {
			sb.append((char)(r.nextInt(26)+'A')+""); // 대문자
			sb.append((char)(r.nextInt(26)+'a')+""); // 소문자
			sb.append((char)(r.nextInt(10)+'0')+""); // 숫자
		}
		
		final String randomCode = sb.toString();
		return randomCode;
	}
	
	// 메일 전송
	public void sendMail(String from, String to, String subject, String text) {
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper helper;
			
			helper = new MimeMessageHelper(mail,true,"UTF-8");
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			
			helper.setText(text, true);
			
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	// 부서별 사원 목록 
	@RequestMapping("selectEmpList.emp")
	public void selectEmpList(HttpServletResponse response, @RequestParam("deptNo") String deptNo) throws IOException {
		ArrayList<Employee> eList = eService.selectEmpList(deptNo);
//		for (Employee e : eList) {
//			e.setEmpName(URLEncoder.encode(e.getEmpName(), "utf-8"));
//			e.setDeptName(URLEncoder.encode(e.getDeptName(), "utf-8"));
//		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		response.setContentType("application/json; charset=UTF-8");
		gson.toJson(eList, response.getWriter());
	}
	
	// 알림 불러오기
	@RequestMapping(value="selectAlertList.emp")
	public void selectAlertList(HttpSession session, HttpServletResponse response) throws IOException {
		String empNo = ((Employee)session.getAttribute("loginUser")).getEmpNo();
		
		ArrayList<HashMap<String,Object>> list = eService.selectAlertList(empNo);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	    gson.toJson(list, response.getWriter());
	}
	
	//알림 하나 삭제 
	@RequestMapping("deleteAlert.emp")
	@ResponseBody
	public String deleteAlert(@RequestParam("alertNo") String alertNo) {
		int result = eService.deleteAlert(alertNo);
		
		if(result>0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	//알림 전체삭제
	@RequestMapping("deletAllAlerts.emp")
	@ResponseBody
	public String deletAllAlerts(@RequestParam("empNo")String empNo, @RequestParam("aType")String aType) {
		
		HashMap<String,String> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("aType", aType);
		int result = eService.deletAllAlerts(map);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
}
