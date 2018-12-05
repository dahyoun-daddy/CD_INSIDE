package com.sist.cd.common;

public class DTO {
	private int no;
	private int totalCnt;
	private int	page_size       ;
	private int	page_num        ;
	private String	search_word ;
	private String	search_div  ;
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	
	/**
	 * @return the no
	 */
	public int getNo() {
		return no;
	}
	
	@Override
	public String toString() {
		return "DTO [no=" + no + ", totalCnt=" + totalCnt + ", page_size=" + page_size + ", page_num=" + page_num
				+ ", search_word=" + search_word + ", search_div=" + search_div + "]";
	}


	/**
	 * @param no the no to set
	 */
	public void setNo(int no) {
		this.no = no;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getPage_size() {
		return page_size;
	}
	public void setPage_size(int page_size) {
		this.page_size = page_size;
	}
	public int getPage_num() {
		return page_num;
	}
	public void setPage_num(int page_num) {
		this.page_num = page_num;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getSearch_div() {
		return search_div;
	}
	public void setSearch_div(String search_div) {
		this.search_div = search_div;
	}
	
	

}
