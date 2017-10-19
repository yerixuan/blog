package entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;
import org.junit.Ignore;

/*
 * 
 * 评论表
 * @author: yezi
 */
@Entity
public class Comment {
	
	
	
	/*
	 *方法1 一张表 记录 评论和回复的信息  
	 *
	 *方法2  借鉴qq 空间那种 评论和回复（记录上 评论的id） 各一张表  即 评论实体类 包含 List<回复> 属性  
	 *         可能这种效果更好点
	 * 
	 * 
	 */
	private String id ;
	private String commentContent; // 评论内容
	private String FromUserId;  // 评论者id
	private String articleId; // 被评论的文章id
	private String commentDate;  // 评论时间
	private int secquence; // 记录评论顺序
	private String toUserId; //回复者id
 
	private List list;// 存放回复内容
	

    private String userpictureUrl; //用户头像
    
    private int userIntegral ; //用户积分
    
     
	
	 
	
	
	public Comment(){}
	
	public Comment(String userId ,String articleId ,String commentContent,String date ){
		
		this.FromUserId=userId;
		this.articleId=articleId;
		this.commentContent=commentContent;
		this.commentDate=date;
	}
	
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getFromUserId() {
		return FromUserId;
	}

	public void setFromUserId(String fromUserId) {
		FromUserId = fromUserId;
	}

	 
	public String getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public int getSecquence() {
		return secquence;
	}

	public void setSecquence(int secquence) {
		this.secquence = secquence;
	}

	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}

	public String getUserpictureUrl() {
		return userpictureUrl;
	}

	public void setUserpictureUrl(String userpictureUrl) {
		this.userpictureUrl = userpictureUrl;
	}

	public int getUserIntegral() {
		return userIntegral;
	}

	public void setUserIntegral(int userIntegral) {
		this.userIntegral = userIntegral;
	}
 
 
	
	
	
	
	
	
	
	
	
	
	
	

}
