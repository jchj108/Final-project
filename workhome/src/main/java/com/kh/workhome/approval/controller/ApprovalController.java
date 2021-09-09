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
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.kh.workhome.employee.model.vo.Department;
import com.kh.workhome.employee.model.vo.Employee;

@Controller
public class ApprovalController {
	@Autowired
	ApprovalService apService;
	
	@Autowired
	private EmployeeService eService;
	
	// ******* 전자결재리스트 ********
	@RequestMapping("approvalView.ap")
	public ModelAndView approvalView(HttpSession session, ModelAndView mv) {
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		String loginUserNo = loginUser.getEmpNo();
		ArrayList<Approval> list = apService.selectApprovalList("%"+loginUserNo+"%");
		
		//기안문서-내가 올린문서 중 진행중 혹은 상신중인 문서
		ArrayList<Approval> myDraftList = new ArrayList<Approval>();
		//기안문서인데 결재완료됨
		ArrayList<Approval> myFinApList = new ArrayList<Approval>();
		//기안문서인데 중지
		ArrayList<Approval> myRejectedDraftList = new ArrayList<Approval>();
		
		//결재할문서 
		ArrayList<Approval> draftList = new ArrayList<Approval>();
		//결재한문서 
		ArrayList<Approval> approvedList = new ArrayList<Approval>();
		//(중지)반려문서(결재거절)
		ArrayList<Approval> rejectedList = new ArrayList<Approval>();
		// 종결문서
		ArrayList<Approval> finList = new ArrayList<Approval>();
		//참조문서
		ArrayList<Approval> refList = new ArrayList<Approval>();
		
		//각 list 기안번호(apNo)를 담을 map
		HashMap<String,ArrayList<String>> map = new HashMap<String,ArrayList<String>>();
		
		for(Approval ap : list) {
			ap.sethEmpStatus(ap.gethEmp());
			ap.setApprovalEmpStatus(ap.getApprovalEmp());
			if(ap.gethEmp()!= null) {
				ap.sethEmp(deleteStatus(ap.gethEmp()));
			}
			ap.setApprovalEmp(deleteStatus(ap.getApprovalEmp()));
			
			//출력용 기안자 만들기- 이름붙이기
			Employee e = new Employee();
			e.setEmpNo(ap.getEmpNo());
			e = eService.selectEmp(e);
			ap.setEmpNo("("+e.getEmpNo()+") "+e.getEmpName());
			if(ap.gethEmp()==null) {
				ap.sethEmp("");
			}
			if(ap.getRefEmp()==null) {
				ap.setRefEmp("");
			}
			
			// 기안문서 - 로그인 empno와 기안자와 사번이 일치한다면 기안문서로
			if(ap.getEmpNo().contains(loginUserNo)) {
				if(ap.getApStatus().contentEquals("R")) {
					//기안문서중 반려됨
					myRejectedDraftList.add(ap);
				}else if(ap.getApStatus().contentEquals("D")) {
					//기안문서중 종결됨
					myFinApList.add(ap);
				}else {
					//진행중임
					myDraftList.add(ap);
				}
				
			// 결재문서 && 합의문서
			}else if(ap.getApprovalEmp().contains(loginUserNo)||(ap.gethEmp().contains(loginUserNo))) {
				//1. 중지문서인가?
				if(ap.getApStatus().equals("R")) {
				//중지문서라면 중지문서에 넣음
					rejectedList.add(ap);
				}else if(ap.getApStatus().equals("D")){
				//2. 종결문서인가?
					finList.add(ap);
				}else{
				//3. 진행 혹은 상신문서 일 때 내가 결재를 했는가?
					boolean check = false;
					check = checkFile(ap.getApprovalEmpStatus(),loginUserNo);
					if(ap.gethEmpStatus()!=null) {
						check = checkFile(ap.gethEmpStatus(),loginUserNo);
					}
					if(check) {
						//결재를 해줬다면 결재한 문서에 추가
						approvedList.add(ap);
					}else {
						//아직 안해줬다면 결재 할 문서에 추가
						draftList.add(ap);
					}
				}
			//참조문서 - 참조자에 내 이름이 들어잇을때
			}else if(ap.getRefEmp().contains(loginUserNo)) {
				refList.add(ap);
			} 
		}
		
		//각 문서들 map에 담음
		map.put("myDraft", putIntheMap(myDraftList));
		map.put("myFinAp", putIntheMap(myFinApList));
		map.put("myRejectedDraft", putIntheMap(myRejectedDraftList));
		map.put("draft", putIntheMap(draftList));
		map.put("approved", putIntheMap(approvedList));
		map.put("rejected", putIntheMap(rejectedList));
		map.put("fin", putIntheMap(finList));
		map.put("ref", putIntheMap(refList));
		
		mv.addObject("map",map);
		mv.addObject("myDraftList", myDraftList);//기안문서-내가 올린문서 중 진행중 혹은 상신중인 문서
		mv.addObject("myFinApList", myFinApList);//기안문서인데 결재완료됨
		mv.addObject("myRejectedDraftList", myRejectedDraftList);//기안문서인데 중지(반려됨)
		
		mv.addObject("draftList", draftList);//결재할 문서(합의, 결재 통합)
		mv.addObject("approvedList", approvedList);//결재한 문서(합의, 결재 통합)
		mv.addObject("rejectedList", rejectedList);//중지문서
		mv.addObject("finList", finList);//종결문서
		mv.addObject("refList", refList);//참조문서 (내가 시행자인 문서
		mv.setViewName("approval");
		return mv;
	}
	
	// 목록 페이지로 이동
	@RequestMapping("aplist.ap")
	public void apList(HttpServletResponse response, @RequestParam("map") String map) throws IOException {
		map = map.substring(1, map.length() - 1);
		String array[] = map.split(", ");
		ArrayList<Approval> list = apService.selectApListByAr(array);

		for (Approval ap : list) {
			Employee e = new Employee();
			e.setEmpNo(ap.getEmpNo());
			e = eService.selectEmp(e);
			ap.setEmpNo("(" + e.getEmpNo() + ") " + e.getEmpName());

			ap.setEmpNo(URLEncoder.encode(ap.getEmpNo(), "utf-8"));
			ap.setApTitle(URLEncoder.encode(ap.getApTitle(), "utf-8"));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(list, response.getWriter());
	}
	
	// 불러올때 결재, 합의의 경우 결재 상태로 따로 넘겨줌
	public String deleteStatus(String emp) {
		if (!emp.equals("") && emp.contains(";")) {
			String array1[] = emp.split(";");
			emp = "";
			for (int i = 0; i < array1.length; i++) {
				String array2[] = array1[i].split(",");
				array1[i] = array2[0];
				if (i != array1.length - 1) {
					emp += array1[i] + ", ";
				} else {
					emp += array1[i];
				}
			}
		} else {
			String array2[] = emp.split(",");
			emp = array2[0];
		}
		return emp;
	}

	// 결재 처리 여부
	public boolean checkFile(String emp, String loginUserNo) {
		boolean check = false;
		// 결재를 해줬다면 바로 종결
		if (!check) {
			if (emp.contains(",")) {        
				String array[] = emp.split(",");
				for (int i = 0; i < array.length; i++) {
					String array2[] = array[i].split("-");
					if (array2[0].contains(loginUserNo) && !array2[1].equals("N")) {
						// 내 사번에, 승인 또는 거절을 했다면
						check = true;
					}
				}
			}  
		}
		return check;
	}

	// 맵에 담기위해 ApNo만 list로 만듬
	public ArrayList<String> putIntheMap(ArrayList<Approval> inputlist) {
		ArrayList<String> outputlist = new ArrayList<String>();
		for (Approval ap : inputlist) {
			outputlist.add(ap.getApNo());
		}
		return outputlist;
	}

	// ********** 기안하기 ***********
	// 결재선 지정 페이지
	@RequestMapping("apporvalInsertView.ap")
	public ModelAndView apporvalinsertView(ModelAndView mv, @RequestParam(value = "tag", required = false) String tag) {
		ArrayList<Department> list = eService.selectDeptList();
		ArrayList<Department> deptlist = new ArrayList<Department>();
		ArrayList<Department> teamlist = new ArrayList<Department>();
		
		for (Department d : list) {
			if (d.getDeptNo().length() == 2) {
				deptlist.add(d);
			} else {
				teamlist.add(d);
			}
		}
		
		mv.addObject("deptlist", deptlist);
		mv.addObject("teamlist", teamlist);
		mv.addObject("tag", tag);
		mv.setViewName("approvalInsertView");
		return mv;
	}

	@RequestMapping("nextPage.ap")
	public ModelAndView apporvalWriteView(ModelAndView mv,
						@RequestParam("hEmp") String hEmp, @RequestParam("approvalEmp") String approvalEmp,
						@RequestParam("refEmp") String refEmp, @RequestParam("tag") String tag) {
		hEmp = cuttingFun(hEmp);
		approvalEmp = cuttingFun(approvalEmp);
		refEmp = cuttingFun(refEmp);
		
		mv.addObject("hEmp", hEmp);
		mv.addObject("approvalEmp", approvalEmp);
		mv.addObject("refEmp", refEmp);
		mv.addObject("tag", tag);
		mv.setViewName("approvalWrite");
		return mv;
	}

	// 마지막 ', '구분자 제거 메소드
	public String cuttingFun(String str) {
		if (!str.equals("")) {
			str = str.substring(0, str.length() - 2);
		}
		return str;
	}

	@RequestMapping("insertApproval.ap")
	@ResponseBody
	public ModelAndView insertApproval(@ModelAttribute Approval ap, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
										HttpServletRequest request, HttpSession session, ModelAndView mv) {
		// 기안자 
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        ap.setEmpNo(loginUser.getEmpNo());

       // 합의자와 결재자 상태 초기화
        if (!ap.gethEmp().equals("")) {                                   
        	ap.sethEmp(initApStatus(ap.gethEmp()));    
	    } 
        ap.setApprovalEmp(initApStatus(ap.getApprovalEmp()));         

		if (uploadFile != null && !uploadFile.isEmpty()) {
			String renameFileName = saveFile(uploadFile, request);
			if (renameFileName != null) {
				ap.setOriginalFile(uploadFile.getOriginalFilename());
				ap.setRenameFile(renameFileName);
			}
		}
		
		apService.insertApproval(ap);
		
		// 알림 전송
		HashMap<String, Object> map = new HashMap<>();
		map.put("aContents", loginUser.getEmpName() + "님이 새로운 기안을 올렸습니다.");
		map.put("aType", "ap");
		
		ArrayList<String> emp = new ArrayList<String>();
		emp = splitEmp1(ap.gethEmp(), emp);
		emp = splitEmp1(ap.getApprovalEmp(), emp);
		emp = splitEmp1(ap.getRefEmp(), emp);
		map.put("empNo", emp);
		eService.insertAlert(map);

		mv.setViewName("redirect:approvalView.ap");
		return mv;
	}
	
	// 사원별 결재상태 초기화
	public String initApStatus(String emps) {
		String array[] = emps.split(", ");
		emps = "";
		for (int i = 0; i < array.length; i++) {
			if (i != array.length - 1) {
				emps += array[i] + "-N, ";
			} else {
				emps += array[i] + "-N";
			}
		}
		return emps;
	}
	
	// 파일 rename
	@RequestMapping("saveFile.ap")
	@ResponseBody
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		
		File folder = new File(savePath);
		if (!folder.exists()) { // 지정된 경로에 파일이 없다면 만듦
			folder.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
				+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		// 확장자 빼고
		String renamePath = folder + "\\" + renameFileName;
		try {
			file.transferTo(new File(renamePath));// 전달받은 file이 rename명으로 저장
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return renameFileName;
	}
	
	// 알람 insert용 사원 끊기 
	public ArrayList<String> splitEmp1(String str, ArrayList<String> emp) {
		if (!str.equals("")) {
			if (str.contains(",")) {
				String[] temp = str.split(",");
				for (int i = 0; i < temp.length; i++) {
					emp.add(temp[i].substring(temp[i].indexOf("(") + 1, temp[i].indexOf(")")));
				}
			} else {
				emp.add(str.substring(str.indexOf("(") + 1, str.indexOf(")")));
			}
		}
		return emp;
	}

	@RequestMapping("apDetail.ap")
	public ModelAndView apDetail(ModelAndView mv, @RequestParam("apNo") String apNo, @RequestParam(value="tag", required=false) String tag) {
		Approval ap = apService.selectApprovalDetail(apNo);
		// 출력용 기안자 만들기- 이름붙이기
		Employee e = new Employee();
		e.setEmpNo(ap.getEmpNo());
		e = eService.selectEmp(e);
		ap.setEmpNo("(" + e.getEmpNo() + ") " + e.getEmpName());
		mv.addObject("ap", ap);
		mv.addObject("tag", tag);
		mv.setViewName("approvalDetail");
		return mv;
	}

	@RequestMapping("updateAp.ap")
	@ResponseBody
	public String updateAp(@RequestParam("apNo") String apNo, @RequestParam("cate") String cate,
			@RequestParam("agree") String agree, @RequestParam("loginUser") String loginUser,
			@RequestParam("status") String status, @RequestParam("plusStatus") String plusStatus) {
		Approval ap = new Approval();
		ap.setApNo(apNo);
		if (agree.equals("R")) {
			ap.setApStatus("R");
		} else {
			ap.setApStatus("Y");
		}
		status = updateApMethod(loginUser, status, agree);

		if (cate.equals("h")) {
			ap.sethEmp(status);
			ap.setApprovalEmp(plusStatus);
		} else if (cate.equals("g")) {
			ap.setApprovalEmp(status);
			ap.sethEmp(plusStatus);
		}

		if (!status.contains("N") && !plusStatus.contains("N") && !plusStatus.contains("R") && !status.contains("R")) {
			ap.setApStatus("D");
		}

		int result = apService.updateAp(ap);

		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	public String updateApMethod(String loginUser, String status, String agree) {
		String array[] = status.split(";");
		status = "";
		for (int i = 0; i < array.length; i++) {
			if (array[i].contains(loginUser)) {
				String array2[] = array[i].split(",");
				array[i] = array2[0] + "," + agree;
			}
			status += array[i] + ";";
			if (i == array.length - 1) {
				status = status.substring(0, status.length() - 1);
			}
		}
		return status;
	}

	@RequestMapping("deleteAp.ap")
	@ResponseBody
	public String deleteAp(@RequestParam("apNo") String apNo) {
		int result = apService.deleteAp(apNo);
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
}
