package com.kh.workhome.mail.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.workhome.mail.model.service.MailService;
import com.kh.workhome.mail.model.vo.Mail;

@Controller
public class MailController {
	// 테스트입니다.
	@Autowired
	private MailService mService;
	
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
	
//	@RequestMapping("binsert.bo")
//	public String insertBoard(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile uploadFile,
//			HttpServletRequest request) {
//
//		// 파일 안 넣었을 때 => ""
//		// 파일 넣었을 때 => 파일 이름
//
//		// if(!uploadFile.getOriginalFilename().equals("")) {
//		if (uploadFile != null && !uploadFile.isEmpty()) { // 파일이 들어왔을 때
//			// 파일의 이름을 바꿔줘야 한다.
//			String renameFileName = saveFile(uploadFile, request);
//
//			if (renameFileName != null) {
//				b.setOriginalFileName(uploadFile.getOriginalFilename());
//				b.setRenameFileName(renameFileName);
//			}
//		}
//		int result = bService.insertBoard(b);
//		if (result > 0) {
//			return "redirect:blist.bo";
//		} else {
//			throw new BoardException("게시글 등록에 실패했습니다");
//		}
//
////		return "redirect:blist.bo";
//	}
	
	@RequestMapping("tmpInsert.mail")
	public String tmpInsert(@ModelAttribute Mail m, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		
//		if(uploadFile != null && !uploadFile.isEmpty()) {
////			String renameFileName = saveFile(uploadFile, request);
//				
////			if(renameFileName != null) {
//				
//			}
//		}
		
		
		return null;
	}
}
