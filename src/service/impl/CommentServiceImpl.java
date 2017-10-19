package service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import service.CommentService;
import util.Pager;
import dao.CommentDao;
import entity.Comment;

@Repository("commentService")
public class CommentServiceImpl implements CommentService {

	private CommentDao commentDao ;
	
	
	
	@Resource(name="commentDao")
	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}
	
	





	@Transactional
	public boolean saveComment(Comment comment) {
		 

		
		return commentDao.saveComment(comment);
	}

	@Transactional
	public List<Comment> getCommentListByArticleId(String articleid ,Pager pager) {
		 
		 
		return  commentDao.CommentListByArticleId_pager(articleid, pager) ;
	}

	@Transactional
	public int getTotalCommentCountByArticleId(String articleid){
		
		
		return commentDao.getCommentCountByArticleID(articleid);
		
	}
	
}







