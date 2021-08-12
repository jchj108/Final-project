package com.kh.workhome.approval.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.workhome.approval.model.service.ApprovalService;
import com.kh.workhome.approval.model.vo.Approval;
import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;

@Controller
public class ApprovalController {
	@Autowired
	ApprovalService aService;
	
	@Autowired
	private EmployeeService eService;
	
	@RequestMapping("approvalView.ap")
	public ModelAndView approvalView(HttpSession session,ModelAndView mv) {
		
		return mv;
	}
	
}
