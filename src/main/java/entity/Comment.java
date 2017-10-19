package entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;
import org.junit.Ignore;

/*
 * 
 * ���۱�
 * @author: yezi
 */
@Entity
public class Comment {
	
	
	
	/*
	 *����1 һ�ű� ��¼ ���ۺͻظ�����Ϣ  
	 *
	 *����2  ���qq �ռ����� ���ۺͻظ�����¼�� ���۵�id�� ��һ�ű�  �� ����ʵ���� ���� List<�ظ�> ����  
	 *         ��������Ч�����õ�
	 * 
	 * 
	 */
	private String id ;
	private String commentContent; // ��������
	private String FromUserId;  // ������id
	private String articleId; // �����۵�����id
	private String commentDate;  // ����ʱ��
	private int secquence; // ��¼����˳��
	private String toUserId; //�ظ���id
 
	private List list;// ��Żظ�����
	

    private String userpictureUrl; //�û�ͷ��
    
    private int userIntegral ; //�û�����
    
     
	
	 
	
	
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
