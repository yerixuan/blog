package service;

import java.util.List;

import entity.Notice;

public interface NoticeService {
	
	
	public List<Notice> getNoticList(String ids,String userId );
	 
	
	public Notice getNoticeByFlag(String falg);

	
	/**
	 * 添加公告
	 * @param title
	 * @param comment
	 * @param date
	 * @param userid
	 * @return
	 */
	public String addNotice(String title ,String comment ,String date ,String userid);
	
	
    public boolean addNoticeToAllUser(String noticeid);
	
}
