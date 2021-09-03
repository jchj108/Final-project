package com.kh.workhome.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.workhome.common.PageInfo;
import com.kh.workhome.common.Pagination;
import com.kh.workhome.notice.model.exception.NoticeException;
import com.kh.workhome.notice.model.service.NoticeService;
import com.kh.workhome.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService nService;

	@RequestMapping("nlist.no")
	public ModelAndView noticeList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {

		// 페이징
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = nService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		// 게시글 전체 조회
		ArrayList<Notice> list = nService.selectList(pi);
		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi);
			mv.setViewName("noticeListView");
		} else {
			throw new NoticeException("게시글 전체 조회에 실패했습니다.");
		}
		return mv;
	}

	@RequestMapping("ninsertView.no")
	public String noticeInsertForm() {
		return "noticeInsertForm";
	}

	@RequestMapping("ninsert.no")
	public String insertNotice(@ModelAttribute Notice n, @RequestParam("uploadFile") MultipartFile uploadFile,
			HttpServletRequest request) {
		if (uploadFile != null && !uploadFile.isEmpty()) {
			String renameFileName = saveFile(uploadFile, request);
			if (renameFileName != null) {
				n.setOriginFileName(uploadFile.getOriginalFilename());
				n.setRenameFileName(renameFileName);
			}
		}
		int result = nService.insertNotice(n);
		if (result > 0) {
			return "redirect:nlist.no";
		} else {
			throw new NoticeException("공지사항 등록 실패");
		}

	}

	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/nuploadFiles";

		File folder = new File(savePath);

		if (!folder.exists()) {
			folder.mkdirs();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
				+ originFileName.substring(originFileName.lastIndexOf(".") + 1);
		String renamePath = folder + "\\" + renameFileName;

		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러");
			e.printStackTrace();
		}
		return renameFileName;
	}

	@RequestMapping("ndetail.no")
	public ModelAndView selectNotice(@RequestParam("nId") int nId, @RequestParam("page") int page, ModelAndView mv) {
		Notice notice = nService.selectNotice(nId, true);

		if (notice != null) {
			mv.addObject("notice", notice);
			mv.addObject("page", page);
			mv.setViewName("noticeDetailView");
		} else {
			throw new NoticeException("공지사항 상세보기 실패");
		}
		return mv;
	}

	@RequestMapping("nupView.no")
	public String noticeUpdateForm(@RequestParam("nId") int nId, @RequestParam("page") int page, Model model) {
		Notice notice = nService.selectNotice(nId, false);

		model.addAttribute("notice", notice).addAttribute("page", page);
		return "noticeUpdateForm";
	}

	@RequestMapping("nupdate.no")
	public ModelAndView updateNotice(@ModelAttribute Notice n, @RequestParam("page") int page,
			@RequestParam("reloadFile") MultipartFile reloadFile, HttpServletRequest request, ModelAndView mv) {

		if (reloadFile != null && !reloadFile.isEmpty()) {
			if (n.getRenameFileName() != null) {
				deleteFile(request, n);
			}

			String renameFileName = saveFile(reloadFile, request);
			if (renameFileName != null) {
				n.setOriginFileName(reloadFile.getOriginalFilename());
				n.setRenameFileName(renameFileName);
			}
		}

		int result = nService.updateNotice(n);
		if (result > 0) {
			Notice notice = nService.selectNotice(n.getNoticeNo(), false);
			mv.addObject("notice", notice);
			mv.addObject("page", page);
			mv.setViewName("noticeDetailView");
		} else {
			throw new NoticeException("공지사항 수정에 실패했습니다.");
		}

		return mv;
	}

	public void deleteFile(HttpServletRequest request, Notice n) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\nuploadFile";

		File f = new File(savePath + "\\" + n.getRenameFileName());
		if (f.exists()) {
			f.delete();
		}
	}

	@RequestMapping("ndelete.no")
	public String deleteNotice(@RequestParam("nId") int nId, HttpServletRequest request) {
		Notice notice = nService.selectNotice(nId, false);
		if (notice.getOriginFileName() != null) {
			deleteFile(request, notice);
		}

		int result = nService.deleteNotice(nId);
		if (result > 0) {
			return "redirect:nlist.no";
		} else {
			throw new NoticeException("공지사항 삭제에 실패했습니다.");
		}

	}

	@RequestMapping("topList.no")
	public void selectTopList(HttpServletResponse response) {
		ArrayList<Notice> list = nService.selectTopList();

		Gson gson = new GsonBuilder().create();
		response.setContentType("application/json; charset=UTF-8");
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("search.no")
	public ModelAndView searchNotice(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {
		// 검색어 받아오기
		String condition = request.getParameter("searchCondition");
		String value = request.getParameter("searchValue");

		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// 전체갯수 가져오기
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("value", value);

		int listCount = nService.getSearchResultListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Notice> list = nService.selectSearchResultList(map, pi);
		if (list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.addObject("searchCondition", condition);
			mv.addObject("searchValue", value);
			mv.setViewName("noticeListView");
		} else {
			throw new NoticeException("공지사항 검색에 실패했습니다.");
		}
		return mv;
	}
}
