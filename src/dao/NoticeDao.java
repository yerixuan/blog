package dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import entity.Notice;


@Repository("noticeDao")
public class NoticeDao {

	
	SessionFactory sessionFactory ;

	@Resource(name="sessionFactory") 
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	

	public String getNoticeIds(String userId){
		
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="Select noticeId From UserInfo  where id =:id";
	 
		Query query =session.createQuery(hql);
		 
		query.setParameter("id", userId);
		
	  
		return (String) query.uniqueResult();
		
	}
	
	
	public List<Notice> getNoticeListById(String ids){
 
		
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Notice where id in( :ids)";

		List list = new ArrayList();
		int length = ids.split(",").length;
		String[] id = ids.split(",");
		
		for (int i = 0; i < length; i++) {

			if(!id[i].matches(""))
			list.add(id[i]);

		}

		Query query = session.createQuery(hql);
		query.setParameterList("ids", list);

		return query.list();
	}
	
	public Notice getNoticeByflag(String flag){
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="from Notice where flag=:flag";
		
		Query query = session.createQuery(hql);
		
		query.setParameter("flag", flag);
		
	 
		return (Notice) query.uniqueResult();
	}
	
	public boolean saveNotice(Notice notice){
		
		Session session =sessionFactory.getCurrentSession();
		
		session.save(notice);
		
		return true;
	}
	
	/**
	 * 将举报结果反馈给用户
	 * @param articleid
	 * @param noticeid
	 * @return
	 */
	public boolean addNoticeToUser(String articleid ,String noticeid){
		
		
		// 看看为什么 没有发送公告给举报用户
		
 		Session session =sessionFactory.getCurrentSession();
		noticeid=noticeid+",";
		String sql ="update userinfo set noticeid=CONCAT(noticeid,'" + noticeid  + "') where id in(  SELECT DISTINCT reportUserId FROM report where articleId='"+articleid+"')";
		
		
		
		SQLQuery query =session.createSQLQuery(sql);
	 
		 int success= query.executeUpdate();
	 	 
		 if(success>0) return true;
 	
		return false;
	}
	
	
	 
	
	
//	public static void main(String[] args) {
//		
//	 String a="8a95c70358d7eaf30158d7f219a60004,8a95c70358d7eaf30158d7f232f50007,";
//    
//	 String aa[] = a.split(",");
// 
//	 for(int i=0 ;i<aa.length ;i++)
//		 System.out.println(aa[i]);
//		
//	}
	
	
	 
	
	
}
