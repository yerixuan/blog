
<%@ page isELIgnored="false" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 

%>
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>${article.title }</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   
   <link rel="stylesheet" href="././css/bootstrap.min.css">
   <link rel="stylesheet" href="./css/main.css">  
    <link rel="stylesheet" href="./js/themes/default/default.css" />
	<link rel="stylesheet" href="./js/plugins/code/prettify.css" />
 
  </head>
 
  
  <body>
  
  
  
	<div class="container">
	
	<div class="col-sm-3">
	
	<table class="table table-condensed  " >
	<caption class="text-center">作者信息</caption>
	<tr>
	<td><label class="control-label col-sm-3">作者：</label></td>
	<td>
	<div class="col-sm-9" >
	<p > <input type="hidden" id="author" value="${user.userName}">
	${user.userName}</p>
	</div></td>
	</tr>
	
	<tr>
	<td><label class="control-label col-sm-3">头像：</label></td>
	
	<td>
	<div class="col-sm-9" >
	 <img alt="头像加载失败" src='${user.pictureurl }' id="author_picture">
	 </div>
	</td>
	
	</tr>
	
	<tr>
	<td><label class="control-label col-sm-3">学校：</label></td>
	<td>
	<div class="col-sm-9">
	 ${user.schoolName }
	 </div>
	 </td>
	</tr>
	
	<tr>
	<td><label class="control-label col-sm-3" >院系：</label></td>
	<td>
	<div class="col-sm-9">
	${user.department }
	</div>
	</td>
	</tr>
	
	<tr>
	<td><label class="control-label col-sm-3" >创建时间：</label></td>
	<td>
	<div class="col-sm-9">
	${user.createDate }
	</div>
	</td>
	</tr>
	
	
	</table>
	
	
	</div>
	
	<div class="col-sm-9">  
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<p class="text-center" id="title">${article.title }</p>
					<input type="hidden" value="${userid } "  id="userid">		
					<input type="hidden" value="${article.id }"  id="articleid"> 
				</h3>
			</div>



			<div class="panel-body">
				<p>${ article.html}</p>
				
				<br><br>
	 <p class="text-center">
                <button type="button" class="btn btn-primary btn-sm" onclick="like()">点赞  <span id="likeNum">${article.likeNum }</span></button>
		       <button type="button" class="btn btn-success btn-sm" onclick="feedback()">反馈</button>
		<p>         		
				
				 <div class="pull-right">
				    <label>修改时间： </label>${article.updateDate } <br>
                    <label>访问量： </label> ${article.accessCount} <br>
                    </div>
			</div>
			
			 
           
			 <div class="panel-footer"> 
			 <p>评论区</p>

					<div class="panel panel-default">
					<div class="panel-body">
					<div class="col-sm-9">

						<table class="table  table-striped" id="commentTable">



						</table>
                     </div>
					</div>
              




<div class="panel-footer"> 
					<div class="well well-sm">
								<div class="well-inner">
									<p>
										共 <span class="num" id="totalCount"></span> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp; <a   class="first_page" onclick= getComment("first_page")  >首页</a>
									&nbsp;&nbsp; <a   class="prev_page" onclick= getComment("prev_page")  >上一页</a> &nbsp;&nbsp;
									<a   class="next_page" onclick= getComment("next_page") >下一页</a> &nbsp;&nbsp; <a  
										class="last_page" onclick= getComment("last_page")  >尾页</a> &nbsp;&nbsp;&nbsp;&nbsp;
									
									<input type="hidden" id="current_page" value=1> 
									<input type="hidden" id="total_pageCount"   />
									<p>
										每页
										<!-- <span class="perpage_num">10</span>
									-->
										<select name="perpage_num" id="perpage_num">
											<option value="10" selected>10</option>
											
										<!-- 暂时定死 每页 10 条
										 	<option value="20">20</option>
											<option value="50">50</option> -->
										</select> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										当前第 <span class="page_num" id="current_pageNum"></span> 页/共 <span id="total_pageNum"
											class="whole_page_num"></span> 页
									</p>
									 
								</div>
							</div>
						  </div>
						</div>
						</div>
			 
			 
			  <h3 class="panel-title">
					 评论：
				</h3>
			     
			    <div class="panel-body">
			    
			    <textarea  id="commentArea"  name="commentArea"  rows="8"   >  </textarea>
			    
			    <button type="button" class="btn  btn-primary " onclick="submitComment()">提交评论</button>
           </div>
			    </div>
			    
			  </div>
			  
			    
			    
		</div>
		
		
		
		 
		
	</div>


<div class="modal fade" id="report" tabindex="-1" role="dialog"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="reportModalLabel"><p class="text-center">举报帖子</p></h4>
				</div>


		<form role="form" class="form-horizontal" id="reportForm">

<div class="alert alert-success alert-dismissable">
            <button type="button" class="close" data-dismiss="alert"
                    aria-hidden="true">
                &times;
            </button>
            <p id="info"></p>
        </div>
    <table class="table" >
    
    <tr>
      <td><label>标题：</label> </td>
      <td><input id="title_modal" disabled /> </td>   
    
    </tr>
    
     <tr>
      <td><label>作者：</label> </td>
      <td><input id="author_modal" disabled/> </td>   
    
    </tr>
    
    <tr>
     <td> <label>举报原因：</label> </td>
     <td><select id="type_modal">
									<option value="欺诈">欺诈</option>
									<option value="色情">色情</option>
									<option value="政治谣言">政治谣言</option>
									<option value="常识性谣言">常识性谣言</option>
									<option value="隐私收集">隐私收集</option>
									<option value="抄袭">抄袭</option>
									<option value="诽谤、冒名">诽谤、冒名</option>
									<option value="其他">其他</option>

							</select></td>
    </tr>
    <tr>
       
       <td><label>详细描述：</label></td>
      <td><textarea id="reason_modal"  rows="8" style="width:300px;height:200px;"> </textarea> </td>
    </tr>
    </table>
				 
    
	    </form>

	 
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" id="submitButton" class="btn btn-primary"  onclick="submit_report()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

 

</body>

    <script src="./js/jquery-3.1.1.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
 	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
 
	<script   src="./js/kindeditor.js"></script>
	<script   src="./js/lang/zh_CN.js"></script>
	<script   src="./js/plugins/code/prettify.js"></script>

 <script>
 
 //全局变量
 var serverAddress='<%=basePath%>';
 var articleid=$('#articleid').val();
 var userid= $('#userid').val();
 var isSuccess =true ;
 
 // 提交举报内容
 function submit_report(){
	 
	 
	 $.ajax({
		
		 url:serverAddress+'isReport',
		 method:'POST',
		 data:{"articleid":articleid,"userid" : userid},
		 success: function(data,status){
			 
			 
			 console.log(data);
			 // 已经举报过了
			 if(data.status=='201'){
				 
				 
				 $('#info').html(data.message);
				 //直接关闭模态框 alert 一下
				  $('#report').modal('hide');
				 alert("您已经举报过该帖子了！");
				 
				 
				 return ;
			 }else {
				 
			 
				
				var reason=$('#reason_modal').val();
		        var type=$('#type_modal').val();
		        
		        //添加举报数据
		        $.ajax({
		        	
		        	url:serverAddress+'addReport',
		        	method:'POST',
		        	data:{"articleid":articleid,"userid":userid ,"type":type,"reason":reason,"status":1},
		        	success:function(data,status){
		        		
		        		console.log("举报后");
		        		console.log(data);
		        		$('#report').modal('hide');
		        		alert("举报成功，等待管理员审核");
		        	}
		        })
				
				 
			 }
			 
			 
		 
		 }
		 
	 });  
	
	
	 
	    
	  
	 
	 
 }
 
 
 
 
 
 
 // 用户点赞
 function like(){
	 
    $.ajax({
    	
    	url:serverAddress+'addLike',
    	method:'POST',
    	data:{"articleid":articleid,"userid" :userid},
    	success:function (data,status){
    		
    		console.log(data);
    		$('#likeNum').html(data.data);
    		
    		
    	}
    	
    });
	 
 
	 
	 
 }
 
 
 //关闭模态框时 ，清理里面的内容
 $('#report').on('hide.bs.modal' ,function(){
	 
	  $('#title_modal').val("");
	   
	  $('#author_modal').val("");
	 
	  $('#reason_modal').val("");
	 
 });
 
 
 
 
 // 反馈 打开反馈模态框
 function feedback(){
	 
    // 打开模态框
    
    $('#report').modal('show');
    
    $('#title_modal').val($('#title').html());
   
    $('#author_modal').val($('#author').val());
    
    
    
    
	 
 
	 
 }
 

 // 翻页函数
 function getComment(option ){
	 
	 var current_page= $('#current_page').val();
	 var total_page=$('#total_pageCount').val();
	 
  
	 if(option=="first_page") 
		 {
		 addCommentList(1);
		 return ;
		 }
	 
	 // 上一页
	 if(option=="prev_page"){
		 
	 	 if(current_page==1){
			 alert("已经在第一页了！");
		     return ; 
		 }
		 
		 addCommentList(--current_page);
		 return ;
	  }
		 
	 // 下一页
		 if(option=="next_page"){
			 
			 if(current_page== total_page) {
				 
				 alert("已经是最后一页了！");
				 return ;
				 
			 } 
			 
			 addCommentList(++current_page);
			 return ;
			 
		 }
			 
	          //最后一页
			 if(option=="last_page"){
				 
				 
				 addCommentList(total_page) ;
				 return ;
				 
			 }
	 
 
 }
 
 
 
 
 
  
 //获取 评论内容  添加到页面上
function addCommentList(page_num){
	 
	
	  
	 //获取下一页 评论前 将当前页面的 评论 清空
	 $('#commentTable').html("");
	 
	 $.ajax({
		
		 url: serverAddress+"commentList",
		 method:'POST',
		 data: {"articleid": articleid ,"page_num" :page_num},       //  "articleid=" +articleid,
		 success:function (data,status){
			  
			   var new_elem;
			   var num=(data.currentPage-1)*10;
			   var userinfo;
			   
			   
			   for (var i = 0; i < data.data.length; i++){
			   
				    
				  
				    
				    new_elem =  '<div class=""> <br><tr> <td> <img alt="" style="width:80px;height:80px;" src="'+data.data[i].userpictureUrl+'"> <br>'+' <a  >'+data.data[i].fromUserId +'</a> <br> 积分：<a> ' + data.data[i].userIntegral+'</a></td><td>&nbsp&nbsp&nbsp&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <a> 评论：</a> ' +
				    data.data[i].commentContent +  '<br>  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  <a  >评论时间：</a>  '+data.data[i].commentDate   + '   <a class="pull-right"> #'+  ++num  +'</a> </td></tr><br><br> </div>'
				   
			 	  $('#commentTable').append(new_elem);
				
				 
		  }  
			  
			 // 将 获取的 当前页面数 页面总数  总记录数 赋值
			   $('#current_page').val(data.currentPage);
			   $('#totalCount').html(data.totalCount);
			   $('#current_pageNum').html(data.currentPage);
			   $('#total_pageNum').html(data.pageCount);
			   
			   $('#total_pageCount').val(data.pageCount);
			   
			   
			   
			 console.log(data.data);
			 
		 }
	 
	 });
	 
	 
 }
 
 
 //参照 script01 
   window.onload =addCommentList(1);

  
 
 
 
 
 //提交评论 成功后 将 评论内容写到评论区中 
 function submitComment(){
	 
	 var userid =$('#userid').val();
	 var commentConnent=editor1.html();
 
	 var page_num=$('#page_num').val();
	 
	 
	  
	 
	 $.ajax({
			
		 url: serverAddress+"addComment"  ,
		 method: 'POST' ,
		 data:{ "userid" :userid ,"commentConnent" :commentConnent,"articleid":articleid},
		 success: function (data, status ){
			  
			 console.log(data.data);
			 
			 $('#commentTable').html("");
			 
			 var total_page=$('#total_pageCount').val();
			 var total_count =$('#totalCount').html();
			 
			 
			 
			 //遇到页面最后一条 再提交一条评论 就要 跳到下一页
			 if(total_count%10==0)
				 total_page++;
			 
			 // 获取当前页数 当参数传入  直接跳到 评论页末尾  不要直接跳到第一页
			 addCommentList(total_page); 
		/* 		 var new_elem ='<tr> <td> <a href="#"> ' +data.data.fromUserId+'</a> 评论 ：     '+data.data.commentContent +
			'<p  class="text-right"> <a >'	+    '# '+ num++  + '</a></p>  </td> </tr>';
				 
				 $('#commentTable').append(new_elem); */
			 
				 //清空评论框的内容
				 editor1.html("");
			 
			  
			 
		 }
		 
	 });
	 
	 
	 
	 
	 
 }
 
 
 
 
 
 var editor1;
 KindEditor.ready(function(K) {
		  editor1 = K.create('textarea[name="commentArea"]', {
			 cssPath : './js/plugins/code/prettify.css',
			uploadJson : 'upload_json.jsp',
			fileManagerJson : 'file_manager_json.jsp',
			allowFileManager : false,
			items: [
			       '|', 'forecolor', 'hilitecolor', 'bold',
			        'italic', 'underline', 'strikethrough',  'removeformat', '|', 'emoticons',  
			         
			]   ,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
			}
		});
		 prettyPrint();
	});
 
 
 
 </script>

</html>
