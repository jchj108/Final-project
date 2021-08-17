package com.kh.workhome.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.workhome.common.PageInfo;
import com.kh.workhome.common.Pagination;
import com.kh.workhome.notice.model.exception.NoticeException;
import com.kh.workhome.notice.model.service.NoticeService;
import com.kh.workhome.notice.model.vo.Notice;
import com.kh.workhome.notice.model.vo.NoticeFile;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService nService;
	
	@RequestMapping("nlist.no")
	public ModelAndView noticeList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = nService.getListCount();
//		System.out.println(listCount);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Notice> list = nService.selectList(pi);
		System.out.println(list);
		if(list != null) {
			mv.addObject("list",list).addObject("pi", pi);
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
	public String insertNotice(@ModelAttribute Notice n, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request ) {
//		System.out.println(uploadFile.getOriginalFilename());
		
		if(uploadFile != null && !uploadFile.isEmpty()) {
			String renameFileName = saveFile(uploadFile, request);
			if(renameFileName != null) {
				n.setOriginFileName(uploadFile.getOriginalFilename());
				n.setRenameFileName(renameFileName);
			}
		}
		int result = nService.insertNotice(n);
		if(result > 0) {
			return "redirect:nlist.no";
		} else {
			throw new NoticeException("공지사항 등록 실패");
		}
		
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/nuploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
						+originFileName.substring(originFileName.lastIndexOf(".")+1);
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
		Notice notice = nService.selectNotice(nId,true);
		
		if(notice != null) {
			mv.addObject("notice",notice);
			mv.addObject("page",page);
			mv.setViewName("noticeDetailView");
		} else {
			throw new NoticeException("공지사항 상세보기 실패");
		}
		return mv;
	}
	
	
}
