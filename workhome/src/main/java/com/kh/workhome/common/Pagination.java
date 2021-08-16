package com.kh.workhome.common;

public class Pagination {
	
	public static PageInfo getPageInfo(int currentPage, int listCount) {
		int pageLimit=10;
		int boardLimit = 5;
		int maxPage= (int)Math.ceil((double)listCount / boardLimit);
		int startPage=  ((currentPage-1)/pageLimit) * pageLimit + 1;
		int endPage = startPage + pageLimit -1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		return pi;
	}
	
	public static PageInfo getPageInfo(int currentPage, int listCount, int boardLimit) { // 메일용 pagination
		int pageLimit=10;
		int maxPage= (int)Math.ceil((double)listCount / boardLimit);
		int startPage=  ((currentPage-1)/pageLimit) * pageLimit + 1;
		int endPage = startPage + pageLimit -1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		return pi;
	}
}
