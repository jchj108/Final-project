package com.kh.workhome.mail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.workhome.mail.model.service.MailService;

@Controller
public class MailController {
	// 테스트입니다.
	@Autowired
	private MailService service;
	
	@RequestMapping("mail.mail")
	public String mailBoxForm() {
		return "mailbox";
	}
	@RequestMapping("send.mail")
	public String mailSendForm() {
		return "mailsend";
	}
	@RequestMapping("read.mail")
	public String mailReadForm() {
		return "mailread";
	}
	@RequestMapping("templist.mail")
	public String tempList() {
		return "tempmaillist";
	}
	
	@RequestMapping("tmpInsert.mail")
	public String tmpInsert() {
		
		
		
		return null;
	}
}
