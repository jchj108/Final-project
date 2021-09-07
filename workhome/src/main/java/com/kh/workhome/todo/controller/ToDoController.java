package com.kh.workhome.todo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.workhome.employee.model.vo.Employee;
import com.kh.workhome.todo.model.service.ToDoService;
import com.kh.workhome.todo.model.vo.ToDo;

@Controller
public class ToDoController {

	@Autowired
	private ToDoService tService;

	@RequestMapping("todo.to")
	public String todoForm() {
		
		return "todo";
	}

	@RequestMapping(value = "insertTodo.to", method = RequestMethod.POST)
	public void insertTodo(@RequestBody ToDo toDo, HttpSession session, HttpServletResponse response) throws Exception {

		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();
		toDo.setEmpNo(empNo);

		System.out.println(toDo);

		int result = tService.insertToDo(toDo);
		
		Gson gson = new Gson();
		PrintWriter out = response.getWriter();
		if(result >= 1) {
			out.write("success");
		} else {
			out.write("fail");
		}
		out.flush();
		out.close();
	}
	
	@RequestMapping("getAllList.to")
	@ResponseBody
	public void getAllList(HttpSession session, HttpServletResponse response)  {
		String empNo = ((Employee) session.getAttribute("loginUser")).getEmpNo();

		ArrayList<ToDo> list = tService.getAllList(empNo);
		
		System.out.println(list);
		response.setContentType("application/json; charset=UTF-8");

		Gson gson = new GsonBuilder().setDateFormat("YYYY-MM-dd HH:mm").create();
		if(list != null) {
			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}
	}
}
