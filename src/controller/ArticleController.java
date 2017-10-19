package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ArticleService;
import util.AjaxObject;
import util.PageAjaxObject;
import util.Pager;
import dao.UserDao;
import entity.Article;
import entity.ArticleReviewRecord;
import entity.Report;
import entity.UserInfo;

/**
 * 
 * 帖子控制类
 * @author yezi
 *
 */

@Controller
public class ArticleController {

	//注入 ArticleService
	private ArticleService articleService;
	//注入userDao
	private UserDao userDao;
 
    @Resource(name="articleService")
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
    
	 
    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
    
    //帖子分页请求
    @RequestMapping(value="/getArticleListByPager" ,method=RequestMethod.POST)
    @ResponseBody
	public PageAjaxObject getArticleBytype(String  channelId, int currentPage ,int pageSize ,String userid){
		
		
    	Pager pager =new Pager(currentPage,pageSize);
    	List<Article> articleList ;
 
		// 我的帖子 文章列表 单独获取
		if (channelId.equals("wdtz") && !userid.equals("")) {
			
			articleList = articleService.getMyArticlByUserId(channelId, userid,
					pager);
		}else if(channelId.equals("shtz")|| channelId=="shtz"){
			
			//获取待审核的帖子
			articleList=articleService.getReviewArticleList(pager);
			
		}else if(channelId.equals("ystz")|| channelId=="ystz"){
			//从审核表中 获取 已审核的帖子
			articleList=articleService.getMyReviewList(userid,pager);
	
			
		}  
		 
		else {
			
			articleList = articleService.getArticleByType(channelId, pager );
		
		}

    	//根据帖子中记录的 用户id 获取 用户名 传到 Article userId 中显示
    	 for(Article article :articleList){
		     
		    	article.setUserId(userDao.getUserNameById(article.getUserId()));
		    	
		    }
    	
    	
    	if(articleList.size()==0) 
            return new PageAjaxObject("400", "当前栏无帖子", 0, 0, 0, null);
 	
    	if(channelId.equals("wdtz") && !userid.equals(""))
     	return new PageAjaxObject("200" ,"帖子获取成功" ,pager.getCurrPage(),pager.getTotalPage(),pager.getTotalCount(),articleList);
    	else{
    		return  new PageAjaxObject("201" ,"帖子获取成功" ,pager.getCurrPage(),pager.getTotalPage(),pager.getTotalCount(),articleList);
    	}
    	
	
	}
	
	
    //获取帖子详情
    @RequestMapping(value="articleDetail",method=RequestMethod.GET)
    public String getArticleDetail(String articleId,String userid,HttpServletResponse response, Model model ){
    	
    	
    	Article article = articleService.articleDetailById(articleId);
     
    	UserInfo user= userDao.getUserInfo(userid);

    	model.addAttribute("user", user);
    	
    	model.addAttribute("userid", userid);
    	
    	model.addAttribute("article", article);
    
    	return   "article/articleDetail";
    }
	
    
    
    //获取我的帖子详情
    @RequestMapping(value="myArticleDetail",method=RequestMethod.GET)
    public String getMyArticleDetail(String articleId,String userid,HttpServletResponse response, Model model ){
     
    	Article article = articleService.articleDetailById(articleId);

    	model.addAttribute("userid", userid);
    	
    	model.addAttribute("article", article);
     
    	return   "article/myArticle";
    }
    
 
    
   /* @RequestMapping(value="/testArticle")
    public String testArticle(){
     
    	return "demo";
    }*/
   
    //处理添加帖子
    @RequestMapping(value="/addArticle",method=RequestMethod.POST )
    @ResponseBody
    public AjaxObject addArticle(String userid ,String title ,String type ,String articleHtml ,String classificationId){
  	
    	SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
    	String date  =sdf.format(new Date());
    	
    	Article article =new Article(userid,title,type,articleHtml,classificationId ,date,1);
    	
    	//帖子 初始编辑时间为 插入时间
    	article.setUpdateDate(date);
   
    	boolean saveSuccess=  articleService.saveArticle(article);
    	
    	if(saveSuccess)
    	return new AjaxObject("200" , "帖子保存成功 " ,null);
    	
    	 return new AjaxObject("401" ,"保存失败" ,null);
    	
    }
    
    //更新帖子
    @RequestMapping(value="/updateArticle" , method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject updateMyArticle(String articleid , String article_html){
    	
    	boolean success=articleService.updateArticle(articleid, article_html);
    	
    	if(success)
    		return new AjaxObject("200","帖子更新成功",1);
     
    	return new  AjaxObject("200","未找到该帖子",0);
    }
    
    //管理员审核帖子
    @RequestMapping(value="/reviewArticle",method=RequestMethod.GET )
    public String reviewArticle(String articleId,String userid,Model model){
 
    	Article article = articleService.articleDetailById(articleId);
    	
    	model.addAttribute("managerid", userid);
    	model.addAttribute("article", article);
    		 
    	
    	return "article/reviewArticle";
    }
    
    //处理用户点赞
    @RequestMapping(value="/addLike" ,method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject addLike(String articleid,String userid){
    	
    	
    	// 控制是否需要对帖子的点赞数加上1
    	boolean isClickLike=articleService.isClickLike(articleid, userid);
    
    	int likeNum=articleService.addLike(articleid,userid,!isClickLike);
  
    	return new AjaxObject("200","点赞操作成功",likeNum);
    }
    
    //查看用户是否已经举报过该帖子
    @RequestMapping(value="/isReport" ,method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject checkUserIsReport(String articleid ,String userid){
    	
    boolean isReport=articleService.isReport(articleid, userid);
    
    //已经举报过
    if(isReport){
    	return new AjaxObject("201","已经举报过该帖子了",null);
    }
     
    	return new AjaxObject("200" ,"未举报过，可以举报" ,null);
    }
    
    //用户举报帖子
    @RequestMapping(value="/addReport" ,method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject addReport(String articleid ,String userid ,String type ,String reason,int status){
    	
    	//status 1:表示未审核  0表示已审核过
    	boolean success=articleService.addReport(articleid, userid, type, reason, status);
    	
    	if(success)
    	return new AjaxObject("200","举报成功，等待审核",null) ;
    	
    	return new AjaxObject("201","举报失败",null) ;
    }
	
    //获取举报列表 并将其显示到 管理员审核帖子的页面中
    @RequestMapping(value="/getReportList",method=RequestMethod.POST)
    @ResponseBody
    public PageAjaxObject getReportList(String articleid,int currentpage,int pageSize){
    	
    	//将页面信息 和 举报内容放到 pageAjaxObject 里面
    	 
    	 Pager pager=new Pager(currentpage,pageSize);
    	 
    	 List<Report> list = articleService.getReportList(articleid,pager);
    	 
    	  //将举报人id 转换为用户名
			for(int i=0 ;i<list.size();i++){
				Report report=list.get(i);
				report.setReportUserId(userDao.getUserNameById(report.getReportUserId()));	 
			}
    	 
    	 return  new PageAjaxObject("200","获取举报列表成功" ,currentpage,pager.getTotalPage(),pager.getTotalCount(),list);
    	 
    	 
    
    }
    
    //管理员审核帖子 并提交审核结果
    @RequestMapping(value="/submit_review_result",method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject submitReviewResult(String articleid ,int islegal ,String reason,String managerid,String title){
    	
    	//islegal  1: 帖子合法  0 ： 帖子不合法
    	
    	String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    	
    	//将审核结果保存到 审核表中 然后发送公告给 所有举报该帖子的用户
    	ArticleReviewRecord articleReview =new ArticleReviewRecord(articleid,managerid,islegal,reason,date);
    
        boolean success=	articleService.saveReviewResult(articleReview,title);
    	
    	return new AjaxObject("200","审核帖子成功", null);
    }
  
    /**
     * 根据帖子id 获取审核结果详情
     * @param articleid
     * @return
     */
    @RequestMapping(value="/reviewDetail",method=RequestMethod.POST)
    @ResponseBody
    public AjaxObject getReviewDetail(String articleid ){
    
    	return new AjaxObject("200" ,"获取审核结果成功 ",articleService.getReviewDetail(articleid));
    }
    
    
}













