package dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import util.Pager;
import entity.Comment;

@Repository("commentDao")
public class CommentDao {

	
	SessionFactory sessionFactory;
	
	@Resource(name="sessionFactory")
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}


  /*
   * 获取该 文章 所有评论数 用于分页显示数目 
   */
	public int  getCommentCountByArticleID(String articleId){
		
		Session session = sessionFactory.getCurrentSession();
		
		String hql="from Comment where articleId=:articleId";
		
		Query query = session.createQuery(hql);
		
		query.setParameter("articleId", articleId);
		 
		return query.list().size();
	}
	
	
	//分页查询评论
	public List<Comment> CommentListByArticleId_pager(String articleId ,Pager pager){
		
		
		Session session =sessionFactory.getCurrentSession();
		
		String hql = "from Comment where articleId=:articleId  order by commentDate  " ;
		
		Query query = session.createQuery(hql);
		
		query.setParameter("articleId", articleId);
		query.setFirstResult(pager.getStartItem());
		query.setMaxResults(pager.getPageSize());
		
		return query.list();
	}
	
	
	
	
	
	
	public boolean saveComment(Comment comment){
		
		
		Session session = sessionFactory.getCurrentSession();
		
		session.save(comment);
		
		
		return true ;
		
	}
	
}
