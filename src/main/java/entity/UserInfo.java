package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

 /*
  * �û�������Ϣ��
  * @author: YeZi 
  */
 
 

@Entity
public class UserInfo {

	 
	
	private String id ;
	
	private String userName;  // �û��ǳ�

	private String pictureurl; // ͷ��λ��
	
	private String email; // �ʺ�����  ���������¼
	
	private String password;// ��MD5 ת���洢
	
	private String phone; // �ֻ����� ѡ��
	
	private String schoolName; // ѧУ����   �ǲ������ɱ�׼��
	
	private String department; //����Ժϵ
	
	
	private int role;// ��ɫ   0 ��ͨ�û�   1 ��ͨ����Ա  2 �߼�����Ա
 	
	private String description;  // ��������
	
	private String noticeId;// ��¼δ������ id ,������ , ����
	
	private int integral; // ����
	
	private String createDate;// ����ʱ��
	
	
	public UserInfo(){}
	
	public UserInfo(String email ,String password,String userName , String phone,String schoolName, String description,String department,int integral  ,String pictureurl){
		
		this.department=department;
		this.password=password;
		this.description=description;
		this.email=email;
		this.phone=phone;
		this.schoolName=schoolName;
		this.userName=userName;
		this.integral=integral;
		this.pictureurl=pictureurl;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public String getPictureurl() {
		return pictureurl;
	}


	public void setPictureurl(String pictureurl) {
		this.pictureurl = pictureurl;
	}


	public int getIntegral() {
		return integral;
	}


	public void setIntegral(int integral) {
		this.integral = integral;
	}


	public String getNoticeId() {
		return noticeId;
	}


	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	
	
	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", userName=" + userName
				+ ", pictureurl=" + pictureurl + ", email=" + email
				+ ", password=" + password + ", phone=" + phone
				+ ", schoolName=" + schoolName + ", department=" + department
				+ ", role=" + role + ", description=" + description
				+ ", noticeId=" + noticeId + ", integral=" + integral + "]";
	}

	 
 
	
}
