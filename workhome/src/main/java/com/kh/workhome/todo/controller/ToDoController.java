package com.kh.workhome.todo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ToDoController {
	
	@RequestMapping("todo.to")
	public String todoForm() {
		return "todo";
	}
	
	@RequestMapping("InsertToDo.to")
	@ResponseBody
	public void insertTodo() {
		
	}
	
	
}
