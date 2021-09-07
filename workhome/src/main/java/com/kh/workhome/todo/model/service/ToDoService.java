package com.kh.workhome.todo.model.service;

import java.util.ArrayList;

import com.kh.workhome.todo.model.vo.ToDo;

public interface ToDoService {

	int insertToDo(ToDo toDo);

	ArrayList<ToDo> getAllList(String empNo);

}
