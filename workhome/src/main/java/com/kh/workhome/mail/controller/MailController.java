package com.kh.workhome.mail.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.mail.model.exception.MailException;
import com.kh.workhome.mail.model.service.MailService;
import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;

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

	@RequestMapping(value = "tmpInsert.mail")
	public String requestupload2(@ModelAttribute Mail m, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
        MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();
		
		Employee e = (Employee)mtpRequest.getSession().getAttribute("loginUser");
		String empNo = e.getEmpNo();
		
		m.setSenderMailId(m.getSenderMailId() + "@workhome.com");
		
		System.out.println(m);
		m.setEmpNo(empNo);
		int result = mService.insertMail(m);

		if(result <= 0) { // 메일 등록 취소 시 예외처리
			throw new MailException("메일 저장에 실패했습니다.");
		}
		boolean flag = false;
		
		if(!uploadFile.isEmpty()) {
			// 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			flag = true;
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				
				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath);
				
				mailFileList.add(mailfile);
			}
		}
		int result2 = mService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴
		
		if(result2 <= 0 && flag) {
			throw new MailException("파일 저장에 실패했습니다.");
		}
		
		return "redirect:mail.mail";
	}

	// 파일 저장용 메소드
	public String saveFile(MultipartHttpServletRequest mtpRequest, MultipartFile file) {
		// 서블릿 request는 여기까지 접근하기 위한 필수 객체
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
//		String savePath = root + "\\buploadFiles"; // \n : 줄바꿈 \t : 탭 \\ : \
		String savePath = root + "/mailUploadFiles";

		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		String originFileName = file.getOriginalFilename(); // 파일의 원래 이름 가져오기
		System.out.println(originFileName);
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
				+ originFileName.substring(originFileName.lastIndexOf(".") + 1); // 현재 시간에 대한 밀리세컨즈를 가져온다.
		String renamePath = folder + "\\" + renameFileName;

		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러");
			e.printStackTrace();
		}

		// 바뀐 이름이 필요하다.
		return renameFileName;
	}
}
