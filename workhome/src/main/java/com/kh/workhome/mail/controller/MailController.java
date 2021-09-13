package com.kh.workhome.mail.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.kh.workhome.common.PageInfo;
import com.kh.workhome.common.Pagination;
import com.kh.workhome.employee.model.service.EmployeeService;
import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.mail.model.exception.MailException;
import com.kh.workhome.mail.model.service.MailService;
import com.kh.workhome.mail.model.vo.Mail;
import com.kh.workhome.mail.model.vo.MailFile;
import com.kh.workhome.mail.model.vo.MailSR;

@Controller
public class MailController {
	// 테스트입니다.
	@Autowired
	private MailService mService;

	@Autowired
	private EmployeeService eService;

	@RequestMapping("send.mail")
	public ModelAndView mailSendForm(ModelAndView mv, HttpSession session) {
		
		String empNo = ((Employee)session.getAttribute("loginUser")).getEmpNo();
		
		int count = mService.selectCountNotRead(empNo);
		
		mv.addObject("count", count);
		mv.setViewName("mailsend");
		
		return mv;
	}

	@RequestMapping("read.mail")
	public String mailReadForm() {
		return "mailread";
	}

	@RequestMapping("search.mail")
	public ModelAndView searchMail(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam("command") String command, @RequestParam("searchValue") String searchValue,
			HttpSession session, ModelAndView mv) {

		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("searchValue", searchValue);
		map.put("command", command);
		map.put("empNo", empNo);

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mService.getSearchListCount(map);
		System.out.println("listcount : " + listCount);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mService.searchList(pi, map);
		int count = mService.selectCountNotRead(empNo); // 읽지 않은 메일 개수 가져오기
		System.out.println("count : " + count);
		System.out.println("list  :" + list);

		mv.addObject("list", list).addObject("page", page).addObject("count", count).addObject("pi", pi)
				.addObject("searchValue", searchValue);
		mv.setViewName(command);

		return mv;
	}

	@RequestMapping("readmail.mail")
	public ModelAndView selectMail(@RequestParam("mId") int id,
			@RequestParam(value = "page", required = false) Integer page, ModelAndView mv, HttpSession session) {

		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("empNo", empNo);

		System.out.println(id);
		System.out.println(empNo);

		Mail m = mService.selectMail(map);
		System.out.println(m);
		// R_date가 null이면 읽은 시간 추가(읽음 표시)
		ArrayList<MailSR> list = m.getMailSRList();

		if (list.get(0).getRDate() == null) {
			System.out.println("업데이트");
			int result = mService.updateRDate(map);
		}

		int count = mService.selectCountNotRead(empNo);
		String mId = getMId(m.getReceiveEmp());
		Employee e = mService.getMId(mId); // 받는 사람 이름 구하는 메소드

		System.out.println(e);

		if (m != null) {
			if (e != null) {
				m.setReceiverName(e.getEmpName());
				System.out.println(m);
			}
			mv.addObject("mail", m);
			mv.addObject("page", page);
			mv.addObject("count", count);
			mv.setViewName("mailread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("readtemp.mail")
	public ModelAndView selectTempMail(@RequestParam("mId") int id,
			@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {
		Mail m = mService.selectTempMail(id);
		System.out.println("selectTempMail : " + m);

		if (m != null) {
			mv.addObject("mail", m);
			mv.addObject("page", page);
			mv.setViewName("tempread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}
		return mv;
	}

	@RequestMapping("updateFavorites.mail") // 메일 즐겨찾기 추가
	@ResponseBody
	public void updateFavorites(@RequestParam("mNo") int mNo, HttpSession session, HttpServletResponse response)
			throws IOException {
		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("id", mNo);

		Mail m = mService.selectMail(map);
		System.out.println(m);

		if (m.getMailSRList().get(0).getFavorites() == null) {
			map.put("favorites", "Y");
		} else {
			if (m.getMailSRList().get(0).getFavorites().equals("N") || m.getMailSRList().get(0).getFavorites() == "N") {
				map.put("favorites", "Y");
			} else {
				map.put("favorites", "N");
			}
		}

		// mail의 favorites가 null이거나 n 이면 y, n이면 y로
		int result = mService.updateFavorites(map);

		if (result > 0) {
			response.getWriter().append("success");
		}
	}

	@RequestMapping("alllist.mail")
	public ModelAndView alllist(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		int listCount = mService.getAllListCount(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mService.selectAllList(pi, empNo);

		int count = mService.selectCountNotRead(empNo); // 읽지 않은 메일 개수 가져오기

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("allmaillist");
		} else {
			throw new MailException("전체메일함 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("favoriteslist.mail")
	public ModelAndView FavoriteList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String empNo = ((Employee) request.getSession().getAttribute("loginUser")).getEmpNo();
		int listCount = mService.getFavoritesListCount(empNo);
		System.out.println("favorites listcount : " + listCount);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mService.selectFavoritesList(pi, empNo);

		int count = mService.selectCountNotRead(empNo); // 읽지 않은 메일 개수 가져오기

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("favoritesmaillist");
		} else {
			throw new MailException("즐겨찾기 조회에 실패했습니다.");
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
		int count = mService.selectCountNotRead(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mService.selectSendList(pi, empNo);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("sendmaillist");
		} else {
			throw new MailException("보낸메일함 조회에 실패했습니다.");
		}

		return mv;
	}
	
	@RequestMapping("checkReadTime.mail")
	public ModelAndView checkReadTime(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
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
		int listCount = mService.getsendListCount(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectSendList(pi, empNo);
		ArrayList<Mail> rList = mService.selectCheckList(empNo);
		
		for(Mail m : list) {
			for(int i = 0; i < rList.size(); i++) {
				if(rList.get(i).getMailNo() == m.getMailNo()) {
					m.setReceiverRTime(rList.get(i).getMailSRList().get(0).getRDate());
				}
			}
		}
		
		System.out.println("추가 후 메일리스트 : " + list);
		
		int count = mService.selectCountNotRead(empNo);

		System.out.println(list);
		System.out.println(rList);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("checkReadTime");
		} else {
			throw new MailException("받은 메일함 조회에 실패했습니다.");
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

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectReceiveList(pi, empNo);

		int count = mService.selectCountNotRead(empNo);

		System.out.println(list);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
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
		int count = mService.selectCountNotRead(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectTempList(pi, empNo);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("tempmaillist");
		} else {
			throw new MailException("임시보관함 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("searchemp.mail") // 메일 보내기 사원 자동완성
	@ResponseBody
	public void searchEmp(HttpServletResponse response, @RequestParam("keyword") String keyword)
			throws JsonIOException, IOException {
		response.setContentType("application/json; charset=UTF-8");

		ArrayList<Employee> list = mService.searchEmp(keyword);

		Gson gson = new Gson();
		gson.toJson(list, response.getWriter());
	}

	@RequestMapping("deletemail.mail") // 메일 삭제 (커맨드 패턴 적용)
	public String deleteMail(@RequestParam("check") int[] check, @RequestParam("command") String command,
			HttpSession session) {
		System.out.println("command :" + command);

		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();

		int result = 0;

		for (int i = 0; i < check.length; i++) {
			int mNo = check[i];
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("empNo", empNo);
			System.out.println("empNo : " + empNo);
			map.put("mNo", mNo);
			System.out.println("mNo : " + mNo);
			map.put("command", command);
			result += mService.deleteMail(map);
		}

		System.out.println(result);

		if (result > 0) {
			switch (command) {
			case "alllist":
				return "redirect:alllist.mail";
			case "templist":
				return "redirect:templist.mail";
			case "sendlist":
				return "redirect:sendlist.mail";
			case "receivelist":
				return "redirect:receivelist.mail";
			case "favoriteslist":
				return "redirect:favoriteslist.mail";
			case "deletelist":
				return "redirect:deletelist.mail";
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
		int listCount = mService.getDeleteListCount(empNo);
		int count = mService.selectCountNotRead(empNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mService.selectDeleteList(pi, empNo);

		System.out.println(list);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
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
	

	@RequestMapping("mailInsert.mail")
	public String mailInsert(@ModelAttribute Mail m, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();
		int result1 = 0;
		
		Employee e = (Employee) mtpRequest.getSession().getAttribute("loginUser");
		String empNo = e.getEmpNo();
				
		// 메일에 mailNo가 있을 경우 임시메일 삭제 (임시메일에서 메일전송시 임시보관함에서 메일 삭제)
		if(m.getMailNo() != 0) {
			boolean flag = true;
			m = mService.selectTempMail(m.getMailNo());
			System.out.println("임시보관함 메일파일 : " + m);
			for(MailFile mf : m.getMailFileList()) {
				mf.setMailNo(0);
				if(mf.getmOriginalName() == null) {
					flag = false;
				}
			}
			mService.insertMail(m);
			if(flag) {
				mService.insertMailFile(m.getMailFileList());
			}
			
//			Map map = new HashMap<String, Object>();
//			map.put("empNo", empNo);
//			map.put("mNo", m.getMailNo());
//			map.put("command", "templist");
//			
//			mService.deleteMail(map);
		} else {
			m.setEmpNo(empNo);
			mService.insertMail(m);
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

		if (result3 <= 0 || result4 <= 0) {
			throw new MailException("메일 전송에 실패했습니다.");
		} else { // 알림 등록
			HashMap<String, Object> map = new HashMap<>();
			map.put("aContents", e.getEmpName() + "님으로부터 메일이 도착했습니다.");
			map.put("aType", "mail");
			map.put("empNo", getMId(m.getReceiveEmp())); // 알림 보내는 사람이 아니라 받는 사람의 empNo 넣기
			eService.insertAlert(map);
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
