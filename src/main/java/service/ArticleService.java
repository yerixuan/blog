package service;

import java.util.List;

import util.Pager;
import entity.Article;
import entity.ArticleReviewRecord;
import entity.Report;

public interface ArticleService {
	
	
	public List<Article> getArticleByType(String type ,Pager pager);
	
	public boolean saveArticle(Article article);
	
	 public List<Article> getMyArticlByUserId(String type ,String userid,Pager pager);
 
	 public Article articleDetailById(String articleId); 

       /**
        * 更新帖子内容
        * @param id
        * @param article_html
        * @return
        */
	 public boolean updateArticle(String id ,String article_html);
	 
	 /**
	  * 获取待审核的帖子列表
	  * @return
	  */
	 public List< Article> getReviewArticleList(Pager pager);
	 
	 /**
	  * 帖子点赞
	  * @param articleid
	  * @return 当前帖子点赞数
	  */
	 public int addLike(String articleid,String userid,boolean needAddOne);
	 
	 /**
	  * 查看用户对该帖子是否已经点赞
	  * @param articleid
	  * @param userid
	  * @return
	  */
	 public boolean isClickLike(String articleid ,String userid);
	 
	 /**
	  * 检测该用户是否已经举报过该帖子
	  * @param articleid
	  * @param userid
	  * @return
	  */
	 public boolean isReport(String articleid ,String userid);
	 
	 /**
	  * 往数据库添加 举报数据
	  * @param articleid
	  * @param userid
	  * @param type
	  * @param reason
	  * @return
	  */
	 public boolean addReport(String articleid ,String userid ,String type ,String reason,int stauts);
	 
	 /**
	  * 根据用户id 获取用户审核过的帖子列表
	  * @param userid
	  * @return
	  */
	 public List<Article > getReviewList(String userid );
	 
	 /**
	  * 根据帖子id 从举报表中获取举报内容
	  * @param articleid
	  * @param pager
	  * @return
	  */
	 public List<Report> getReportList(String articleid,Pager pager);
	 
	 /**
	  * 保存审核结果 并将 审核的结果通过公告的形式告诉 举报人
	  * @param reviewResult
	  * @return
	  */
	 public boolean saveReviewResult(ArticleReviewRecord reviewResult,String title);
	 
	 
	 /**
	  * 根据管理员id 从审核表中查找 已审核列表
	  * @param managerid
	  * @return
	  */
	 public List<Article> getMyReviewList(String managerid,Pager pager); 
	 
	 public ArticleReviewRecord getReviewDetail(String articleid);
}
