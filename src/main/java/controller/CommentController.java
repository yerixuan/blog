package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.CommentService;
import service.UserInfoService;
import service.impl.UserInfoServiceImpl;
import util.AjaxObject;
import util.PageAjaxObject;
import util.Pager;
import dao.UserDao;
import entity.Comment;
import entity.UserInfo;
/**
 *  对评论请求处理
 * @author yezi
 *
 */

@Controller
public class CommentController {

	
	private CommentService commentService;
	private UserDao userDao;
	
	
	
	
	@Resource(name="commentService")
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	
	
	
	
    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
  
    private UserInfoService userInfoService;
	
    @Resource(name="userInfoService")
	public void setUserInfoService(UserInfoServiceImpl userInfoService) {
		this.userInfoService = userInfoService;
	}
    
    

	@RequestMapping(value="/addComment" ,method=RequestMethod.POST)
	@ResponseBody
	public  AjaxObject addComment(String userid ,String articleid ,String commentConnent)
	{
		
		
		
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		
		Comment comment =new Comment(userid,articleid ,commentConnent,date);
		
		// 将 评论表中的 用户id 转换成 用户名 显示
		String userName = userDao.getUserNameById(userid);
	
		boolean saveComment= commentService.saveComment(comment);
		
		comment.setFromUserId(userName);
		
		if(saveComment) 
			return new AjaxObject("200" ,"保存评论成功"  ,comment);
		
		return new AjaxObject("500" ,"评论保存失败" ,null);
	}
	
	
	@RequestMapping(value="/commentList" ,method=RequestMethod.POST)
	@ResponseBody
	public PageAjaxObject getCommentList(String articleid,int page_num){
		
		
		
		//设置 分页工具类  默认 每页十条 
		int pageSize=10;
		Pager pager = new Pager(page_num, pageSize);
		
		pager.setCurrPage(page_num);
		pager.setPageSize(pageSize);
		pager.setStartItem( (pager.getCurrPage()-1 ) * pager.getPageSize()); // 开始查询点
		pager.setTotalCount( commentService.getTotalCommentCountByArticleId(articleid) );
		
		
		
		
		//计算 总页数
		if(pager.getTotalCount()% pageSize!=0){
			pager.setTotalPage( (pager.getTotalCount()/ pageSize)+1 );
		}else {
			pager.setTotalPage( (pager.getTotalCount()/ pageSize) );
		}
		
		
		// 直接获取最后一页的数据  (用户评论完后 直接到评论末尾看)
        if(page_num==0) {
			
        	pager.setStartItem( (pager.getTotalPage()-1 )*10);
			
		}
		
		
		List<Comment> commentList = commentService.getCommentListByArticleId(articleid ,pager);
		
	 
		
		// 将所有 评论 中 userid的值换成　对应　userName 用于页面显示
		for(Comment comment :commentList){
	
			UserInfo user =userDao.getUserInfo(comment.getFromUserId().replace(" ", ""));
			
			comment.setFromUserId( user.getUserName());
			comment.setUserIntegral(user.getIntegral());
			comment.setUserpictureUrl(user.getPictureurl());
	
		}
		
		
		

		
		if(commentList.size()==0) 
			return  new PageAjaxObject("500" ,"当前帖子没有评论" ,1,1,0,null);
		
		else return  new PageAjaxObject("200" ,"查询成功" ,pager.getCurrPage(),pager.getTotalPage(),pager.getTotalCount(),commentList);
		 
	}
	
	
	
}
