package service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import service.UserInfoService;
import util.MD5_Change;
import util.Pager;
import dao.NoticeDao;
import dao.UserDao;
import entity.UserInfo;
 /**
  * 
  * 处理用户各种操作 
  * @author yezi
  *
  */

@Repository("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
	
	Logger log = LoggerFactory.getLogger(UserInfoServiceImpl.class);
	
	private UserDao userDao;
	
	private NoticeDao noticeDao;

    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

    
    @Resource(name="noticeDao")
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}




	@Transactional
	public boolean addUser(UserInfo userInfo) {
		
		
		
		return false;
	}

    
	@Transactional
	public boolean isUserNameUnique(String userName) {
		 
		// 不是唯一的
		if(userDao.checkUserName(userName))
			return false;
		
		return true;
	}
	
	@Transactional
	public boolean register(String email ,String password,String userName , String phone,String schoolName, String descriptio,String department,String pictureurl){
		
		try {
		 
			password = MD5_Change.change(password);
		 
		} catch (Exception e) {
			e.printStackTrace();
			log.error("MD5密码转换失败 错误信息如下 ： " + e.getMessage());
			return false;

		}
		//默认用户初始有 15个积分
		int integral=15;
		UserInfo user=new UserInfo(email,password,userName,phone,schoolName,descriptio,department,integral,pictureurl);
		user.setCreateDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()) );
		
		boolean flag=userDao.saveUser(user);
	 
		userDao.writeJurisdiction(user.getId());
		
		
		return  flag;
 
	}


	@Transactional
	public String checkLogin(String email, String password,String role) {
		 
		try {
			  password=MD5_Change.change(password);
		} catch (Exception e) {
			 log.error("密码转换错误，信息如下：" +e.getMessage());
			e.printStackTrace();
		} 
		
		return userDao.isUserExits(email, password,role);
	}


	@Transactional
	public UserInfo getUserInfoById(String id) {
		 
		
		return userDao.getUserInfo(id);
	}


	@Transactional 
	public boolean updateUser(String id, String userName, String phone,
			String schoolName, String department, String description) {
		 
		UserInfo user =userDao.getUserInfo(id);
		
		user.setUserName(userName);
		user.setDepartment(department);
		user.setDescription(description);
		user.setPhone(phone);
		user.setSchoolName(schoolName);
		
		return	userDao.updateUser(user);
		
		   
	}


	@Transactional 
	public String  getNoticeIds(String userId) {
		 
		String noticeIds=noticeDao.getNoticeIds(userId);
		
		// 应该在 用户 调出 公告模态框的查看公告后  才将 公告 id 清除
       // userDao.updateNoticeIds(userId);
		
		return noticeIds;
	}


 

	@Transactional
	public List<UserInfo> getUserList(Pager pager,int role) {
	 

		 

		
		return userDao.getUserList(pager, role);
	}


	@Transactional
	public int getUserTotalCount(int role) {
		 
		
		
		
		return userDao.getUserCount(role);
	}


	@Transactional
	public boolean updateUserToManager(String userid,int flag) {
		 
		
		return userDao.updateUserToManager(userid ,flag);
	}


 
	 

}
