package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

/**
 * 审核表
 * @author yezi
 *
 */
@Entity
public class ArticleReviewRecord {

	private String id ;
 
	
	private String articleId; // 被举报的文章id
	
	private String date; //审核时间
	
	private int feedback; // 记录是否举报成功，根据这个字段 发送 公告给举报用户 是否举报成功 
	
	private String feedbackReason; // 记录 举报成功/失败 的原因
	
	private String reviewUserid; // 审核者id

	
	public ArticleReviewRecord(){}
	
	public ArticleReviewRecord(String articleid ,String reviewUserid,int feedback ,String feedbackReason,String date){
		
		this.articleId=articleid;
		this.date=date;
		this.feedback=feedback;
		this.feedbackReason=feedbackReason;
		this.reviewUserid=reviewUserid;
		
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

 
	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getFeedback() {
		return feedback;
	}

	public void setFeedback(int feedback) {
		this.feedback = feedback;
	}

	public String getFeedbackReason() {
		return feedbackReason;
	}

	public void setFeedbackReason(String feedbackReason) {
		this.feedbackReason = feedbackReason;
	}

	public String getReviewUserid() {
		return reviewUserid;
	}

	public void setReviewUserid(String reviewUserid) {
		this.reviewUserid = reviewUserid;
	}
	
	
	
	
	
}
