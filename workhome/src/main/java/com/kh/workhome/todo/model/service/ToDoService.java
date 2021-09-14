package com.kh.workhome.todo.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.workhome.todo.model.vo.ToDo;

public interface ToDoService {

	int insertToDo(ToDo toDo);

	ArrayList<ToDo> getAllList(String empNo);

	int deleteToDo(Map map);

	int updateToDo(ToDo toDo);

	ArrayList<ToDo> getTodayScehdule(String empNo);

}
