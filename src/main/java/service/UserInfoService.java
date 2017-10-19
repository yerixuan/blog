package service;

import java.util.List;

import util.Pager;
import entity.UserInfo;


public interface  UserInfoService {
	
	/**
	 * 
	 * @param userInfo 添加用户
	 * @return
	 */
	public boolean addUser(UserInfo userInfo);
	
	/**
	 * 
	 * @param userName 查询用户名是否唯一
	 * @return
	 */
	public boolean isUserNameUnique(String userName);

	
	/**
	 * 
	 * @param email 登录邮箱
	 * @param userName  用户名
	 * @param phone  电话号码 
	 * @param schoolName  学校名称
	 * @param descriptio  个人描述
	 * @return
	 */
	public boolean register(String email ,String password,String userName , String phone,String schoolName, String descriptio,String department,String pictureurl);

  /**
   * 
   * @param email 登录邮箱
   * @param password 登录密码
   * @param role 0 普通用户 1 初级管理员 2 高级管理员
   * @return  用户id
   */
  public String checkLogin(String email,String password,String role);
  
//  /**
//   * 检测管理员登录
//   * @param email
//   * @param password
//   * @param role  0 普通用户 1 初级管理员   2最高管理员
//   * @return
//   */
//  public boolean checkManagerLogin(String email ,String password ,String role);
  
  /**
   * 
   * @param id 用户id 
   * @return 
   */
  public UserInfo getUserInfoById(String id);
	
	/**
	 *  更新用户信息
	 * @param id
	 * @param userName
	 * @param phone
	 * @param schoolName
	 * @param department
	 * @param description
	 * @return
	 */
  public boolean updateUser(String id ,String userName ,String phone ,String schoolName ,String department ,String description );

  /**
   * 获取用户未读公告
   * @param userId
   * @return
   */
  public String  getNoticeIds(String userId);
  
 /**
  * 获取当前角色用户列表
  * @param  pager 分页工具类
  * @param role  0: 普通用户 ， 1： 管理员
  * @return
  */
  public List<UserInfo> getUserList(Pager pager,int role); 
  
  
  
  /**
   * 获取当前角色用户总数
   * @param  role  0: 普通用户 ， 1： 管理员
   * @return
   */
  public int getUserTotalCount(int role );
  
  /**
   * 根据userid 将用户（管理员）升级/降级为管理员（普通用户）
   * @param userid
   * @param flag  0 :升级  1：降级
   * @return
   */
  public boolean updateUserToManager(String userid ,int flag);

}
