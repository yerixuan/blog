package dao;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import util.Pager;
import entity.UserInfo;
import entity.User_Menu;

/**
 * 
 * 
 * @author yezi
 *
 */

@Repository("userDao")
public class UserDao {

	Logger log = LoggerFactory.getLogger(UserDao.class);
	 
	SessionFactory sessionFactory;

	@Resource(name="sessionFactory")
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	public boolean checkUserName(String userName){
		
		
		Session session = sessionFactory.getCurrentSession();
		String hql ="from  UserInfo user where user.userName='" +userName+"'";
	 
		if(session.createQuery(hql).list().size()>0) return true ;
		
	    return false ;
	 
	}
	
	
	public boolean updateUser(UserInfo user){
		
		try{
		Session session =sessionFactory.getCurrentSession();
		session.update(user);
		}catch(Exception e){
			
			log.error(new Date()+" 更新用户失败 ,错误信息如下 ： "+e.getMessage());
			return false ;
		}
		
		return true ;
		
		
	}
	
	
	public boolean saveUser(UserInfo user){
		
		try{
		Session session =sessionFactory.getCurrentSession();
		
		session.save(user);
		
		}catch(Exception e){
			e.printStackTrace();
			log.error(new Date()+" 插入User失败 错误信息如下 ：  "+e.getMessage());
			return false;
		}
		
		return true ;
	}
	
	
	public String  isUserExits(String email ,String password,String role){
 	
		 Session session = sessionFactory.getCurrentSession();
		 String hql="from UserInfo where email=:email and password=:password and role >="+role+" and integral >=0";
		
 
		Query query = session.createQuery(hql);
	 	query.setParameter("email", email);
     	query.setParameter("password", password);
     	 
		UserInfo user=null ;
		if(query.list().size()!=0)
		  user=(UserInfo) query.list().get(0);
		
		String id="";
				
		  if(user!=null)
				id=user.getId();
	    
		return id;
		 
	}
	
	
	
	public boolean writeJurisdiction(String userid){
	 
		Session session =sessionFactory.getCurrentSession();
		
		String hql="select id from Menus where level= 0";
		
		List<String> list =session.createQuery(hql).list();
		
 
		for(int i=0;i<list.size();i++){
			
			User_Menu user_menu=new User_Menu();
			user_menu.setUserId(userid);
			user_menu.setMenuId(list.get(i));
			
			session.save(user_menu);
			
			
		}
		
		
		return true;
	}
	
	
	public String getUserNameById(String userId){
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="select userName  from UserInfo where id=:userId";
	 
		Query query =session.createQuery(hql);
		
		query.setParameter("userId", userId);
		
	 
		
		return (String) query.uniqueResult();
	}
	
	
	public UserInfo getUserInfo(String id)
	{
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="from UserInfo where id =:id";
		
		Query query = session.createQuery(hql);
		
		query.setParameter("id", id);
	 
		return (UserInfo) query.uniqueResult();
	}
	
	
	
	/**
	 * 用户查看公告后 清空 用户 为看 公告列表
	 * @param userId
	 */
	public void updateNoticeIds(String userId){
	 
		Session session = sessionFactory.getCurrentSession();
		String hql="update UserInfo set noticeId ='' where id=:id";
		
		Query query = session.createQuery(hql);
		query.setParameter("id", userId);
		query.executeUpdate();
		
		
		
	}
	
	
	public boolean isExitUserEmail(String email){
		
		
	 Session session = sessionFactory.getCurrentSession();
	 
	 String hql ="from UserInfo where email=:email";
	 
	 Query query = session.createQuery(hql);
	 
	 query.setParameter("email", email);
		
	 if(query.list().size()!=0)
		return true ;
	 
	 return false ;
	}
	


	// 将管理员发布的公告id 追加到所有用户的 公告列表后
	public boolean updateUserNotice(String noticeid){
 
		noticeid+=",";
		
		String sql="update userinfo set noticeId =CONCAT(noticeId,'" +  noticeid +  "')";
		
		try{
		Session session =sessionFactory.getCurrentSession();
		
	      SQLQuery query= session.createSQLQuery(sql);
	      
	       query.executeUpdate();
		}catch(Exception e){
			
			e.printStackTrace();
			log.error(new Date() +"  修改用户公告列表出错，请检查！");
			
			
			return false;
		} 
		
		return true;
	}
	
	
   
	public List<UserInfo> getUserList(Pager pager,int role){
		
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="from UserInfo where role=:role";
		
		Query query =session.createQuery(hql);
		
		query.setParameter("role", role);
		
		query.setMaxResults(pager.getPageSize());
		query.setFirstResult(pager.getStartItem());
		
		
		
		 return query.list();
		
		
	}
	
	 
	/**
	 * 返回当前 角色的用户的记录条数
	 * @param role
	 * @return
	 */
	public int getUserCount(int role){
		
		
		Session session =sessionFactory.getCurrentSession();
		
		String hql = "from UserInfo where role=:role";
		
		Query query =session.createQuery(hql);
		
		query.setParameter("role",role );
		
		
		
		return query.list().size();
		
		
		
	}
 
	public boolean updateUserToManager(String userid ,int flag){
 
		Session session  = sessionFactory.getCurrentSession();
		
		String hql ="update UserInfo set role =:flag where id=:userid";
		
		Query query =session.createQuery(hql);
 	
		query.setParameter("flag", flag);
		query.setParameter("userid", userid);
		
		int excute_count=query.executeUpdate();
		
		
		if(excute_count==0)
			 return false;
		return true;
	}
	
	
}
