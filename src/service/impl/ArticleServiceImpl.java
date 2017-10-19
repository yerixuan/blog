package service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import service.ArticleService;
import util.Pager;
import dao.ArticleDao;
import dao.NoticeDao;
import dao.UserDao;
import entity.Article;
import entity.ArticleReviewRecord;
import entity.Notice;
import entity.Report;
import entity.UserInfo;


@Repository("articleService")
public class ArticleServiceImpl implements ArticleService {

	//注入articleDao
	private ArticleDao articleDao;
	
    @Resource(name="articleDao")
	public void setArticleDao(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}
  
    private UserDao userDao;
    
    
    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

    private NoticeDao noticeDao;
    
    @Resource(name="noticeDao")
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}


	@Transactional
	public List<Article> getArticleByType(String classificationId,Pager pager ) {
		 
		
		    pager.setTotalCount(articleDao.getTotalListCount(classificationId));
		    pager.setStartItem((pager.getCurrPage()-1)*pager.getPageSize());
		    
		    // 计算总页数
		    if(pager.getTotalCount()%pager.getPageSize()==0)
	        {
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize());
	        }else{
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize()+1);
	        }
	 
		    List<Article> articleList=articleDao.getArticle(classificationId, pager);
		    
		  
		    
		return  articleList;
	}


	@Transactional
  public List<Article> getMyArticlByUserId(String classificationId ,String userid,Pager pager){
	  
		
		
		    pager.setTotalCount(articleDao.getMyArticleCount(userid));
		    pager.setStartItem((pager.getCurrPage()-1)*pager.getPageSize());
		    
		    // 计算总页数
		    if(pager.getTotalCount()%pager.getPageSize()==0)
	        {
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize());
	        }else{
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize()+1);
	        }
		
		
		return articleDao.getMyArticleByUserId(classificationId, userid ,pager);
  }


	@Transactional
	public boolean saveArticle(Article article) {
		 
		return articleDao.addArticle(article);
	}





     
	@Transactional
	public Article articleDetailById(String articleId) {
		 
		Article article =articleDao.getArticleById(articleId);
		
		// 访问该帖子 并将该帖子的访问量加一 
		article.setAccessCount(article.getAccessCount()+1);
		articleDao.updateArticle(article);
		
		return article;
	}





	@Transactional
	public boolean updateArticle(String id, String article_html ) {
		 
		String date= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		
		return articleDao.updateArticle(id, article_html,date);
	}




   /**
    * 获取待审核列表
    */
	@Transactional
	public List<Article> getReviewArticleList(Pager pager) {
		 
		
		   
		 
		    pager.setTotalCount(articleDao.getTotalListCount("shtz"));
	    
		    pager.setStartItem((pager.getCurrPage()-1)*pager.getPageSize());
		    
		    // 计算总页数
		    if(pager.getTotalCount()%pager.getPageSize()==0)
	        {
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize());
	        }else{
	            pager.setTotalPage(pager.getTotalCount()/pager.getPageSize()+1);
	        }
		
		
		return articleDao.getReviewArticleList(pager);
	}





	@Transactional
	public int addLike(String articleid,String userid,boolean needAddOne) {
	 
		Article article = articleDao.getArticleById(articleid);
		int new_likeNum=article.getLikeNum();
		
		if(needAddOne){
		
		// 需要加1 时才更新数据库	
		new_likeNum+=1;
		
		article.setLikeNum( new_likeNum);
		articleDao.addRecode(articleid, userid);
		articleDao.updateArticle(article);
		}
		
		return new_likeNum;
	}




  /**
   * 检测用户是否对该帖子点赞
   */
	@Transactional
	public boolean isClickLike(String articleid, String userid) {
		 
		
		
		return articleDao.isClickLike(articleid,userid);
	}





	@Transactional
    public boolean isReport(String articleid, String userid) {
	 
		
	
		return articleDao.checkReport(articleid, userid);
     }





	/**
	 * 添加举报数据到数据库
	 * @param articleid
	 * @param userid
	 * @param type
	 * @param reason
	 * @param status
	 * @return
	 */
	@Transactional
	public boolean addReport(String articleid, String userid, String type,
			String reason,   int status) {
		 
		String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
 	
		Report report=new Report(articleid,userid,type,reason,date,status);
		
		
		return articleDao.saveReport(report);
	}





	@Transactional
	public List<Article> getReviewList(String userid) {
		 
		
		return  null;
	}





 
	@Transactional
	public List<Report> getReportList(String articleid,Pager pager) {
		 
		
		int totalCount =articleDao.getReportListCount(articleid);
		int pageNum=0;
		if(totalCount%pager.getPageSize()==0)
			pageNum=totalCount/pager.getPageSize();
		else {
			  pageNum=totalCount/pager.getPageSize()+1;
		}
		
		pager.setTotalPage(pageNum);
		pager.setTotalCount(totalCount);
		pager.setStartItem((pager.getCurrPage()-1)*pager.getPageSize() );
		
		List<Report> list =articleDao.getReportListById(articleid,pager);
	   
		 
		
		return list;
	}

    
	@Transactional
	public boolean saveReviewResult(ArticleReviewRecord reviewResult,String title) {
		
		//保存审核结果
		articleDao.saveReviewResult(reviewResult);
		
		//给举报者发送公告
		String articleid=reviewResult.getArticleId();
	 
		String managerName=userDao.getUserNameById( reviewResult.getReviewUserid());
		
		int islegal =reviewResult.getFeedback();
		String content="";
		
		if(islegal==1){
			content="举报："+title   +" 不成功，审核结果为：  ";
		}else{
			
			content="举报："+title +" 成功，审核结果为：  ";
			//审核为非法帖子 ，应设置 Article的 flag属性为0，让其不显示
			articleDao.updateArticleStatus(articleid, 0);
		
			//发布非法帖子 扣除用户积分   一次扣 5分
			 //根据帖子id找到发帖者id
			
			 
			 String userid = articleDao.getUserIdByArticleId(articleid); 
		  
			 UserInfo user =	userDao.getUserInfo(userid);
		     user.setIntegral( user.getIntegral() -5 );   
		     
		     
			// 发送公告给发帖者 告知 所发的帖子 非法，并扣除了多少积分
		     String contnet_info="发布的帖子 "+title+"审核为违规帖子 扣除5个积分 ,原因："+reviewResult.getFeedbackReason()+"\n 审核者："+managerName+"  \n 时间："+reviewResult.getDate();
		     Notice info= new Notice("帖子违规",contnet_info,null,"系统发布",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			
		     noticeDao.saveNotice(info);
		     
		     String noticeid_info=info.getId();
		     
		     String noticeids=user.getNoticeId();
		     
		     if(noticeids==null||noticeids.matches("")){
		    	 noticeids=noticeid_info+",";
		          
		     }
		     else {
		    	 noticeids+= noticeid_info+",";
		          
		      }
		     //将公告列表设置回去
		     user.setNoticeId(noticeids);
		     //更新用户
		     userDao.updateUser(user);
		     
		     
		     
		}
		content+=reviewResult.getFeedbackReason()+"<br> 审核者："+managerName+"    时间："+reviewResult.getDate();
		 
		String date= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		
		//写公告
		Notice notice =new Notice("举报反馈",content,null,"系统发布",date);
	    noticeDao.saveNotice(notice);
	    
	    //返回的id 保存到所有举报用户的 公告列表字段中
	    String noticeid =notice.getId();
	   
	    //审核完成 ，将举报表中的 status 设置成已审核
	    articleDao.updateReportStatus(articleid);
	    
		boolean success= noticeDao.addNoticeToUser(articleid, noticeid);
	 
		return  success;
	    
		
	 
	}


	@Transactional
	public List<Article> getMyReviewList(String managerid,Pager pager) {
		 
		int totalCount=articleDao.getMyReviewListCount(managerid);
		int totalPageNum;
	     
		
		if(totalCount%pager.getPageSize()==0)
			totalPageNum=totalCount/pager.getPageSize();
		else 
			totalPageNum=totalCount/pager.getPageSize()+1;
		
		pager.setTotalCount(totalCount);
		pager.setTotalPage(totalPageNum);
		
	
		
		return articleDao.getMyReviewList(managerid,pager);
	}


	@Transactional
	public ArticleReviewRecord getReviewDetail(String articleid) {
		 
		
		
		return articleDao.getReviewDatail(articleid);
	}


 


}
