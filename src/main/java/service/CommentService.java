package service;

import java.util.List;

import util.Pager;
import entity.Comment;

public interface CommentService {

	
	public boolean saveComment(Comment comment);
	
	
	public List<Comment> getCommentListByArticleId(String articleid,Pager pager);
	
	public int getTotalCommentCountByArticleId(String articleid);
}
