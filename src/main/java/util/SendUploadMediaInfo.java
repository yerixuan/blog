package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

 

/**
 * 用jdbc 操作 发送 上传文件 成功与否信息 公告给用户
 * @author yezi
 *
 */
public class SendUploadMediaInfo {

	/**
	 * 
	 * @param title
	 * @param connent
	 * @param publishMan
	 * @param remark
	 * @return
	 */
	public static String insertNotice(String title, String content, String publisherName,
			String remark) {

		String id = UUID.randomUUID().toString().replace("-", "");

		System.out.println("id=="+id);
		
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		
		
		String sql = "INSERT INTO notice (id, title ,content,publisherName ,date ,remark) values(?,?,?,?,?,?)";		
		
		Connection con =BaseDaoUtil.getConnection();
		PreparedStatement pstmt;
	    
		try {
	        pstmt = (PreparedStatement) con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, title);
	        pstmt.setString( 3,  content);
	        pstmt.setString( 4,  publisherName);
	        pstmt.setString( 5, date );
	        pstmt.setString(6 , remark );
	        
	        pstmt.execute();
	        
	        // 关闭 
	        pstmt.close();
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return id;
	}
	
	
	
	public static  void updateUserNoticeId(String userid , String noticeid){
		
		Connection con =BaseDaoUtil.getConnection();
		String sql="select noticeId from userInfo where id=?";
		try {
		
			PreparedStatement pst=(PreparedStatement) con.prepareStatement(sql);
			pst.setString(1, userid);
			ResultSet rs=pst.executeQuery();
			
			String notice_id=null;
			while(rs.next())
			  notice_id=rs.getString(1);
			
			 if(notice_id==null|| notice_id=="" || notice_id.equals("") ){
				 notice_id=noticeid;
			 }else{
				 notice_id+=","+noticeid;
			 }
			 
			 // 更新到 用户noticeid 
			
			 sql="update userinfo  set noticeid=? where id=? ";
			 pst=(PreparedStatement) con.prepareStatement(sql);
			 
			 pst.setString(1, notice_id);
			 pst.setString(2, userid);
			 pst.executeUpdate();
			 
			 pst.close();
			 con.close();
			
		} catch (SQLException e) {
		 
			e.printStackTrace();
		}
		
		
	}
	
	
//	public static void main(String[] args) {
//		
//		SendUploadMediaInfo send =new SendUploadMediaInfo();
//		String id =send.insertNotice("测试123", "就问你服不服", "系统发布者", "没有备注");
//		
//		System.out.println("测试id " +id);
//		 updateUserNoticeId("8a95c7035838115301583811d4350000",id);
//		
//		
//	}
	
}
