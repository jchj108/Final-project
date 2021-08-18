package com.kh.workhome.meeting.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MeetingController {

	@RequestMapping("meetReserv.meet")
	public String meetingReserv() {
		
		return "meetingReservation";

	}
	
	@RequestMapping("meetReserv2.meet")
	public String meetingReserv2() {
		
		return "meetingReservation2";
		
	}
}
