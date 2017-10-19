package util;

/**
 * 页面转换 工具类
 * @author yezi
 *
 */
public class PageAjaxObject {

	private String status;
	
	private String message; 
	
	private int currentPage; // 当前页
	
	private int totalCount;// 总记录数
	
	private int pageCount;// 总页数

	private Object data; // 数据对象

	
	/**
     * @return the totalCount
     */
    public int getTotalCount() {
        return totalCount;
    }


    /**
     * @param totalCount the totalCount to set
     */
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }


    /**
     * @return the currentPage
     */
    public int getCurrentPage() {
        return currentPage;
    }


    /**
     * @param currentPage the currentPage to set
     */
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }


    /**
     * @return the pageCount
     */
    public int getPageCount() {
        return pageCount;
    }


    /**
     * @param pageCount the pageCount to set
     */
    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }


    public PageAjaxObject(String status, String message, int currentPage, int pageCount, int totalCount, Object data) {
		this.status = status;
		this.message = message;
		this.currentPage = currentPage;
		this.pageCount = pageCount;
		this.totalCount = totalCount;
		this.data = data;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public Object getData() {
		return data;
	}


	public void setData(Object data) {
		this.data = data;
	}

	
	
}
