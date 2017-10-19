package service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import service.NoticeService;
import dao.NoticeDao;
import dao.UserDao;
import entity.Notice;

@Repository("noticeService")
public class NoticeServiceImpl  implements NoticeService{

	
	private NoticeDao noticeDao;
	
	private UserDao userDao;
	
	@Resource(name="noticeDao") 
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}





	@Transactional
	public List<Notice> getNoticList(String ids,String userId) {
		 
		
		 
		
		 userDao.updateNoticeIds(userId );
		
		return noticeDao.getNoticeListById(ids);
	}

	@Transactional
	public Notice getNoticeByFlag(String flag) {
		 
		return noticeDao.getNoticeByflag(flag);
	}

	
	
	@Transactional
	public String  addNotice(String title, String content, String date,
			String userid) {
		 
		
		Notice notice =new Notice();
		
		notice.setContent(content);
		notice.setDate(date);
		notice.setTitle(title);
		notice.setPublisherId(userid);
		
	    noticeDao.saveNotice(notice);
	   
	    
		
		return notice.getId();
	}

	
	@Transactional
	public boolean addNoticeToAllUser(String noticeid){
		

		
		return  userDao.updateUserNotice(noticeid);
	}
	
	
	
}
