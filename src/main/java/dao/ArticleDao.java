package dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import util.Pager;
import entity.Article;
import entity.ArticleReviewRecord;
import entity.Report;
import entity.User_like;

@Repository("articleDao")
public class ArticleDao {
	
	
	Logger log = LoggerFactory.getLogger(ArticleDao.class);
	
	SessionFactory sessionFactory;
    
	@Resource(name="sessionFactory")
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
      //获取我的帖子的数量
	 public int getMyArticleCount(String userid){
		 
		 Session session =sessionFactory.getCurrentSession();
		 
		 String hql = "from Article where userId = :userid";
		 
		 Query query= session.createQuery(hql);
		 
		 query.setParameter("userid", userid);
	 
		 return query.list().size();
	 }
	
	
	/* 根据菜单分类获取帖子列表
	 * @param: type: 文章类型
	 * @return: List<Article>
	 */
	public List<Article> getArticle(String classificationId,Pager pager){
		 
		Session session =sessionFactory.getCurrentSession();
		String hql ="from Article where flag!=0 and classificationId= :classificationId  ORDER BY  type";
		
		Query query=session.createQuery(hql);
		query.setParameter("classificationId", classificationId);
		query.setFirstResult( (pager.getCurrPage()-1)*pager.getPageSize()   );
		query.setMaxResults(pager.getPageSize());
	 
		return  query.list();
	  
	}
	
	
	/**
	 * 获取当前菜单类型文章 的总条数
	 * @param type
	 * @return
	 */
	public int getTotalListCount(String type){
		
		Session  session = sessionFactory.getCurrentSession();
		String hql="";
		
		if(type=="shtz" || type.equals("shtz")){
			
			hql="from Article where id in (select articleId from Report where status!=0 group by articleid )";
			
			
		}else{
			 hql ="from Article where  classificationId=:type and flag!=0";
		}
	
		Query query =session.createQuery(hql);
		
		if(type!="shtz" || !type.equals("shtz"))
		query.setParameter("type", type);
	 
		return query.list().size();
	}
	
	
	
	/*
	 * 添加帖子
	 * @param: Article 要插入的文章实体类
	 * @return: void 
	 * 
	 */
	public boolean addArticle(Article article){
		
		try{
		Session session =sessionFactory.getCurrentSession();
	 
		session.save(article);
	 
		}catch(Exception e){
 	
			log.error("增加Article 时 出现错误 错误信息如下："+e.getMessage());
			return false;		
		}
		return true;
		
	}
	
	/**
	 * 删除帖子
	 * @param id 文章id
	 * @return
	 */
	public boolean deleteArticle(String id){
		
		
		Session session =sessionFactory.getCurrentSession();
		
		// 这种写法不知道是否可行 待尝试
		String hql ="delete Article where  id="+id;
		try{
			
		session.createQuery(hql).executeUpdate();
		
		}catch(Exception e){
			log.error("删除Article时 出现错误 错误信息如下 ： "+e.getMessage());
			return false;
			
		}
		return true;
	}
	/**
	 * 
	 * @param article 更新后的Article 实体类
	 * @return
	 */
	public boolean updateArticle(Article article){
		
		 try{
		Session session =sessionFactory.getCurrentSession();
		session.update(article);
		 }catch(Exception e){
			 
			 log.error("更新Article时 出现 错误，信息如下 ： "+e.getMessage());
			 return false ;
			 
		 }
		
		return true;
		
	}
	
	
	public List<Article> getMyArticleByUserId(String classificationId, String  userId ,Pager pager){
		
		Session session = sessionFactory.getCurrentSession();
		
	 
		String hql ="from Article where  userId= :userid  " ;
		
		Query query = session.createQuery(hql);
		
		//query.setParameter("classificationId", classificationId);
		query.setParameter("userid", userId);
		query.setFirstResult( (pager.getCurrPage()-1)*pager.getPageSize()   );
		query.setMaxResults(pager.getPageSize());
 	
		return query.list() ;
	}
	

	
	public Article getArticleById(String articleid ){
		
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql ="from Article where id =:articleid" ;
		
		 
		Query query  = session.createQuery(hql);
		
		query.setParameter("articleid", articleid);
		 
		return (Article) query.uniqueResult();
	}
	
	
	public boolean updateArticle(String articleid, String article_html,String updateDate){
 
		 
		Session session =sessionFactory.getCurrentSession();
		String hql="update Article set html=:article_html ,updateDate=:updateDate where id=:articleid";
		Query query =session.createQuery(hql);
		
		query.setParameter("article_html", article_html);
		query.setParameter("articleid", articleid);
		query.setParameter("updateDate", updateDate);
		
    	int success = query.executeUpdate();
		
    	if(success > 0)
    		return true;
		
		return false;
	} 
	
	/**
	 * 获取待审核帖子列表
	 * @return
	 */
	public List<Article> getReviewArticleList(Pager pager){
		
		Session session = sessionFactory.getCurrentSession();
		String hql="from Article where id in( SELECT articleId FROM  Report GROUP BY articleId)";
		Query query = session.createQuery(hql);
		
		 
		int pageSize=pager.getPageSize();
		int start= pager.getStartItem();
		
		query.setFirstResult(start);
		query.setMaxResults(pageSize);
 	
		return query.list();
	}
	
	
	public  boolean isClickLike(String articleid ,String userid){
 	
		Session session =sessionFactory.getCurrentSession();
		String hql ="from User_like where articleid=:articleid and userid=:userid";
		
		Query query =session.createQuery(hql);
		
		query.setParameter("articleid", articleid);
		query.setParameter("userid", userid);
		
		if(query.list().size()!=0)
			return true;

		return false;
	}

	/**
	 * 往 用户-点赞中间表添加记录
	 * @param articleid
	 * @param userid
	 */
	public void addRecode(String articleid ,String userid ){
		
		Session session  = sessionFactory.getCurrentSession();
		User_like user_like= new User_like();
		user_like.setArticleid(articleid);
		user_like.setUserid(userid);
		
		session.save(user_like);
		
		
	}
	
	public boolean checkReport(String articleid ,String userid){
		
		
		Session session =sessionFactory.getCurrentSession();
		
		String hql ="from Report where articleid=:articleid and reportUserId=:userid";
		Query query =session.createQuery(hql);
		
		query.setParameter("articleid", articleid);
		query.setParameter("userid", userid);
		
		//该用户已经举报过该帖子了
		if(query.list().size()!=0)
			return true;
		
		
		return false;
	}
	
	public boolean saveReport(Report report){
		
		
		Session session = sessionFactory.getCurrentSession();
		
		session.save(report);
		
		return true;
	}
	
	/**
	 * 获取用户已审核过的帖子列表
	 * @param reviewUserid
	 * @return
	 */
	public List<Article> getReviewList(String reviewUserid,Pager pager){
		
		Session session = sessionFactory.getCurrentSession();
		
		
		String hql ="from ArticleReviewRecord where reviewUserid=:reviewUserid ";
		
		Query query = session.createQuery(hql);
		
		query.setParameter("reviewUserid", reviewUserid);
		
		
		return query.list();
	}
	
	/**
	 * 获取举报内容列表
	 */
	 public List<Report> getReportListById(String articleid,Pager pager){
		 
		 Session session =sessionFactory.getCurrentSession();
		 
		 //根据时间顺序排序
		 String hql ="from Report where articleId=:articleid  and status!=0 ORDER BY date ";
		 
		 Query query =session.createQuery(hql);
		 query.setParameter("articleid", articleid);
		 int start =pager.getStartItem();
		 int pageSize= pager.getPageSize();
		 
		 //分页
		 query.setFirstResult(start);
		 query.setMaxResults(pageSize);
		 
		 
		 return query.list();
	 }
	
	 /**
	  * 获取 帖子举报记录的长度
	  * @param articleid
	  * @return
	  */
	 public int getReportListCount(String articleid){
		 
		 Session session = sessionFactory.getCurrentSession();
		 
		 String hql ="from Report where articleid=:articleid and status!=0";
		 
		 Query query = session.createQuery(hql);
		 
		 query.setParameter("articleid", articleid);
		 
		 return query.list().size();
	 }
	 
	 
	 public boolean saveReviewResult(ArticleReviewRecord reviewResult){
		 
		 Session session =sessionFactory.getCurrentSession();
		 
		 session.save(reviewResult);
		  
		 return true;
	 }
	 
	 /**
	  * 更新帖子的状态，如果被举报成功的话 帖子应该设置成无效帖子，不显示
	  * @param articleid
	  * @param status
	  * @return
	  */
	 public boolean updateArticleStatus(String articleid ,int status){
		 
		 Session session =sessionFactory.getCurrentSession();
		 
		 String hql ="update Article set flag=:status where id=:articleid" ;
		 
		 Query query =session.createQuery(hql);
		 
		 query.setParameter("status", status);
		 query.setParameter("articleid", articleid);
		 
		 int success = query.executeUpdate();
		 
		 
		 return true;
	 }
	 
	 /**
	  * 帖子审核完毕 要设置举报表中 该帖子的状态为已审核
	  * @param articleid
	  * @return
	  */
	 public boolean updateReportStatus(String articleid){
		 
		 Session session =sessionFactory.getCurrentSession();
		 
		 String hql ="update Report set status=0 where articleid=:articleid";
		 
		 Query query =session.createQuery(hql);
		 
		 query.setParameter("articleid", articleid);
		 
		  query.executeUpdate();
		 
		 
		 return true;
	 }
	 
	 public String getUserIdByArticleId(String articleid){
		 
		 
		 Session session =sessionFactory.getCurrentSession();
		 String sql =" select  userId from Article where id=:articleid";
		 
		
		 Query query = session.createQuery(sql);
		
		 query.setParameter("articleid", articleid);
		 
		
		 return (String) query.uniqueResult();
		 
	 }
	 
	 /**
	  * 获取已审核帖子列表
	  * @param managerid
	  * @return
	  */
	 public List<Article> getMyReviewList(String managerid,Pager pager){
		 
		 int start =(pager.getCurrPage()-1)*pager.getPageSize();
		 
		 
	  	 Session session = sessionFactory.getCurrentSession();
	  	 
	  	 String hql ="from Article where id in( select articleId from ArticleReviewRecord where  reviewUserid=:managerid  )" ;
	  	 
	  	 Query query =session.createQuery(hql);
	  	 
	  	 
	  	 query.setParameter("managerid", managerid);
	  	 
	  	 query.setFirstResult(start);
	  	 query.setMaxResults(pager.getPageSize());
	  	 
		 return query.list();
		 
		 
	 }
	 
	 
	 public int getMyReviewListCount(String managerid){
		 
		 
         Session session = sessionFactory.getCurrentSession();
	  	 
	  	 String hql ="from Article where id in( select articleId from ArticleReviewRecord where  reviewUserid=:managerid  )" ;
	  	 
	  	 Query query =session.createQuery(hql);
	  	 
	  	 query.setParameter("managerid", managerid);
	  	 
	  	 
	  	 return query.list().size();
		 
	 }
	 
	 public ArticleReviewRecord getReviewDatail(String articleid){
		 
		 Session session = sessionFactory.getCurrentSession();
		 
		 String hql ="From ArticleReviewRecord where articleid=:articleid";
		 
		 Query query =session.createQuery(hql);
		 
		 query.setParameter("articleid", articleid);
		 
		 return (ArticleReviewRecord) query.uniqueResult();
		 
		 
	 }
	 
	 
}
