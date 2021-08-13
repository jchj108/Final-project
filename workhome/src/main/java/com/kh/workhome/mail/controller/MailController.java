package com.kh.workhome.mail.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.workhome.mail.model.service.MailService;

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

//	@RequestMapping("tmpInsert.mail")
//	public String tmpInsert(@RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
//		System.out.println(uploadFile);
////		if(uploadFile != null && !uploadFile.isEmpty()) {
//////			String renameFileName = saveFile(uploadFile, request);
////				
//////			if(renameFileName != null) {
////				
////			}
////		}
	@RequestMapping(value = "tmpInsert.mail")
	public String requestupload2(MultipartHttpServletRequest mtfRequest) {
		List<MultipartFile> fileList = mtfRequest.getFiles("uploadFile");
		String uploadFile = mtfRequest.getParameter("uploadFile");
		System.out.println("src value : " + uploadFile);
		
		System.out.println(fileList.size());
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			long fileSize = mf.getSize(); // 파일 사이즈

			System.out.println("originFileName : " + originFileName);
			System.out.println("fileSize : " + fileSize);

		}

		return null;
	}
}
