package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.NoticeService;
import util.AjaxObject;

@Controller
public class NoticeController {

	private NoticeService noticeService;
	
	
 
    @Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}





	@RequestMapping(value="/getNoticeList" ,method=RequestMethod.POST)
	@ResponseBody
	public AjaxObject getNoticeList(String ids,String userId){
		  
	 
	 
		return new AjaxObject("200","获取公告成功" ,noticeService.getNoticList(ids,userId));
	}
	
	
	/**
	 * 添加公告
	 * @param title
	 * @param comment
	 * @return
	 */
	@RequestMapping(value="/addnotice" ,method=RequestMethod.POST)
	@ResponseBody
	public AjaxObject addNotice(String title ,String comment,String userid ){
		
		
		String date =new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		
		//保存公告
		String noticeid =noticeService.addNotice(title, comment, date, userid);	
		
		
		//将公告id 添加到所有用户的公告列表上
	   boolean success=noticeService.addNoticeToAllUser(noticeid);
		
		
	   if(success){
		   
		   return new AjaxObject("200" ,"公告发布成功" ,"");
	   }else{
		   return new AjaxObject("500" ,"发布公告时出错，请联系管理员","");
		   
	   }
		
	   
		
		
		 
	}
	
	
}
