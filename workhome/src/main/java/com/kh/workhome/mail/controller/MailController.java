package com.kh.workhome.mail.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.common.Pagination;
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

	@RequestMapping("readmail.mail")
	public ModelAndView selectMail(@RequestParam("mId") int id, @RequestParam("page") int page, ModelAndView mv) {
		Mail m = mService.selectMail(id);
		System.out.println(m);
		
		String mId = getMId(m.getReceiveEmp());
		Employee e = mService.getMId(mId); // 받는 사람 이름 구하는 메소드

		System.out.println(e);
		
		
		if (m != null) {
			if(e != null) {
				m.setReceiverName(e.getEmpName());
				System.out.println(m);
			}
			mv.addObject("mail", m);
			mv.addObject("page", page);
			mv.setViewName("mailread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}
		
		return mv;
	}
	@RequestMapping("readtemp.mail")
	public ModelAndView selectTempMail(@RequestParam("mId") int id, @RequestParam("page") int page, ModelAndView mv) {
		Mail m = mService.selectTempMail(id);
		System.out.println(m);

		if (m != null) {
			mv.addObject("mail", m);
			mv.addObject("page", page);
			mv.setViewName("tempread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}
		return mv;
	}

	@RequestMapping("sendlist.mail")
	public ModelAndView sendList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		int listCount = mService.getsendListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mService.selectSendList(pi, empNo);
		
		if(list != null) {
			mv.addObject("sendList", list).addObject("pi", pi);
			mv.setViewName("sendmaillist");
		} else {
			throw new MailException("보낸메일함 조회에 실패했습니다.");
		}
		
		return mv;
	}

	@RequestMapping("receivelist.mail") // 받은 메일함 조회
	public ModelAndView receivemaillist(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		if (request.getSession().getAttribute("loginUser") == null) {
			throw new MailException("로그인이 필요합니다.");
		}
		
		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mService.getReceiveListCount(empNo);
		System.out.println(listCount);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectReceiveList(pi, empNo);
		
		System.out.println(list);
		
		if (list != null) {
			mv.addObject("receiveList", list).addObject("pi", pi);
			mv.setViewName("receivemaillist");
		} else {
			throw new MailException("받은 메일함 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("templist.mail")
	public ModelAndView tempList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();

		if (empNo == null) {
			throw new MailException("로그인이 필요합니다.");
		}

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mService.getTempListCount(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectTempList(pi, empNo);

		if (list != null) {
			mv.addObject("tempList", list).addObject("pi", pi);
			mv.setViewName("tempmaillist");
		} else {
			throw new MailException("임시보관함 조회에 실패했습니다.");
		}

		return mv;
	}
	
	@RequestMapping("deletemail.mail") // 메일 삭제 (커맨드 패턴 적용)
	public String deleteMail(@RequestParam("check") int[] check, @RequestParam("command") String command) {
		System.out.println(command);
		int result = 0;
		
		for(int i = 0; i < check.length; i++) {
			int mNo = check[i];
			result += mService.deleteMail(mNo);
		}
		
		System.out.println(result);
		
		if(result > 0) {
			switch(command) {
			case "templist" : return "redirect:templist.mail";
			case "sendlist" : return "redirect:sendlist.mail";
			case "receivelist" : return "redirect:receivelist.mail";
			}
		} else {
			throw new MailException("메일 삭제에 실패했습니다.");
		}
		return null; 
	}
	
	@RequestMapping("deletelist.mail")
	public ModelAndView deleteList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {
		
		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		
		if (empNo == null) {
			throw new MailException("로그인이 필요합니다.");
		}
		
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mService.getTempListCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));
		
		ArrayList<Mail> list = mService.selectTempList(pi, empNo);
		
		if (list != null) {
			mv.addObject("tempList", list).addObject("pi", pi);
			mv.setViewName("deletemaillist");
		} else {
			throw new MailException("임시보관함 조회에 실패했습니다.");
		}
		
		return mv;
	}

	@RequestMapping(value = "tmpInsert.mail")
	public String tempInsert(@ModelAttribute Mail m, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();

		Employee e = (Employee) mtpRequest.getSession().getAttribute("loginUser");
		String empNo = e.getEmpNo();

		m.setEmpNo(empNo);

		System.out.println(m);
		int result1 = mService.insertTempMail(m);

		if (result1 <= 0) { // 메일 등록 취소 시 예외처리
			throw new MailException("메일 저장에 실패했습니다.");
		}

		if (!uploadFile.isEmpty()) { // 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath);

				mailFileList.add(mailfile);

				System.out.println(mailfile);
			}
			int result2 = mService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}

		return "redirect:templist.mail";
	}

	@RequestMapping(value = "mailInsert.mail")
	public String mailInsert(@ModelAttribute Mail m, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();

		if (isType(m)) {
			m.setEtype("Y"); // 사내메일
		} else {
			m.setEtype("N"); // 외부메일
		}

		Employee e = (Employee) mtpRequest.getSession().getAttribute("loginUser");
		String empNo = e.getEmpNo();

		m.setEmpNo(empNo);

		System.out.println(m);
		int result1 = mService.insertMail(m);

		if (result1 <= 0) { // 메일 등록 취소 시 예외처리
			throw new MailException("메일 저장에 실패했습니다.");
		}

		if (!uploadFile.isEmpty()) { // 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath);

				mailFileList.add(mailfile);
			}
			int result2 = mService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}
		
		int result3 = mService.insertMailSRReceiver(getMId(m.getReceiveEmp()));
		int result4 = mService.insertMailSRSender(m.getEmpNo()); // 보낸 메일함에 저장
		
		if(result3 <= 0 || result4 <= 0) {
			throw new MailException("메일 전송에 실패했습니다.");
		}
		
		return "redirect:sendlist.mail";
	}

	private boolean isType(Mail m) {
		String id = m.getReceiveEmp();
		int index = id.lastIndexOf('@');

		System.out.println(id.substring(index + 1));

		if (id.substring(index + 1).equals("workhome.com")) {
			return true; // true일 경우 사내메일
		} else {
			return false; // 외부메일
		}
	}

	@RequestMapping(value = "tmpUpdate.mail")
	public String updateTemp(@ModelAttribute Mail m, MultipartHttpServletRequest mtpRequest, ModelAndView mv)
			throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();
		Employee e = (Employee) mtpRequest.getSession().getAttribute("loginUser");
		String empNo = e.getEmpNo();

		m.setEmpNo(empNo);

		System.out.println(m);
		int result1 = mService.updateMail(m);

		if (result1 <= 0) {
			throw new MailException("메일 임시 저장에 실패했습니다.");
		}

		if (!uploadFile.isEmpty()) { // 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath, m.getMailNo());
				System.out.println(mailfile);
				mailFileList.add(mailfile);
			}
			int result2 = mService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}

		return "redirect:templist.mail";
	}

	@RequestMapping("fileDeleteAjax.mail")
	@ResponseBody
	public String deleteFileAjax(@RequestParam("mFileNo") int mFileNo, HttpServletRequest request) {

		MailFile mF = mService.selectMailFile(mFileNo);
		int result = mService.deleteMailFile(mFileNo);

		if (result > 0) {
			deleteFile(request, mF);
			return "success";
		} else {
			throw new MailException("파일 삭제에 실패했습니다.");
		}
	}

	// 파일 저장용 메소드
	public String saveFile(MultipartHttpServletRequest mtpRequest, MultipartFile file) {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
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

	// 파일 삭제용 메소드
	public void deleteFile(MultipartHttpServletRequest mtpRequest, MailFile mf) {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/mailUploadFiles";

		File f = new File(savePath + "/" + mf.getmChangeName());
		if (f.exists()) { // buploadFiles에 renameFileName이 존재하면 지우기
			f.delete();
		}
	}

	public void deleteFile(HttpServletRequest request, MailFile mf) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/mailUploadFiles";

		File f = new File(savePath + "/" + mf.getmChangeName());
		if (f.exists()) { // buploadFiles에 renameFileName이 존재하면 지우기
			f.delete();
		}
	}
	
	private String getMId(String email) {
		return email.substring(0, email.lastIndexOf('@'));
	}
}
