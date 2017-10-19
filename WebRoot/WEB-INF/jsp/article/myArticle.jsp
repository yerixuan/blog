<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的帖子</title>
    <metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />
    
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
     
     <div class="jumbotron">
     
       <div class="page-header">
          <h2 ><p class="text-center"  >${article.title }
                <small>分类：${article.type }</small></p>
                <input type="hidden" id="type" value="${ article.type}">
                <input type="hidden" id="title"  value="${article.title}">
         </h2>
     </div>
     
     
 
     
     <div class="panel-body">
				 <div id="article_html_old">${ article.html}</div>
				  
				 	<input type="hidden" value="${userid } "  id="userid">		
					<input type="hidden" value="${article.id }"  id="articleid"> 
				 <div class="pull-right">
				   
				   <table class="table">
				   <tr><td>
				    <button type="button" data-toggle="modal"  class="btn btn-primary pull-right btn-sm" onclick="updateArticle()">编辑</button>	<br>			 
				    </td></tr>
				    <tr><td><label>修改时间： </label>${article.updateDate }  <br></td></tr>
                  <tr>
                  <td>
                    <label>访问量： </label> ${article.accessCount}  </td>
                   <tr>
                   <tr>
                   <td> <label>点赞数： </label> ${ article.likeNum} </td>
                   </tr>
                   </table>
                    </div>
			</div>
     
      
     
     <!--  <div class="panel-footer"> 
			 <p>评论区</p>
			   <table class="table  table-striped"      id="commentTable">
			   
			   
			   
			   </table>
			 
			 
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
										<span class="perpage_num">10</span>
									
										<select name="perpage_num" id="perpage_num">
											<option value="10" selected>10</option>
											
										暂时定死 每页 10 条
										 	<option value="20">20</option>
											<option value="50">50</option>
										</select> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										当前第 <span class="page_num" id="current_pageNum"></span> 页/共 <span id="total_pageNum"
											class="whole_page_num"></span> 页
									</p>
									 
								</div>
							</div>
						</div> -->
			 
     
     
     
     
     
     
     </div>
     
     
     <div class="modal fade" id="updateArticleModal" tabindex="-1"
		role="dialog" aria-labelledby="ArticleModal">
		<div class="modal-dialog" role="document" style="width:800px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ArticleModal">
						<p class="text-center">编辑帖子</p>
						
						<div class="alert alert-success alert-dismissable" > <span id="updateArticleSuccess"></span></div>
						
					</h4>
				</div>
				<div class="modal-body">
 
					<form class="form-horizontal" name="updateArticleForm" role="form">

						<table class="table">
 
							<tr>
								<td><label>标题：</label></td>
								<td><input type="text" id="title_modal" disabled /></td>
							</tr>
  
                           <tr>
                           
                           <td><label >菜单分类</label></td>
                           <td>
                            
                            <input type="text"  id="classificationId_modal" disabled >
                           <input type="hidden" id="classificationId" value="${article.classificationId }">
                           </td>
                           </tr> 
 
							<tr>
								<td><label>学科类别：</label></td>
								<td><input type="text" id="type_modal"  disabled/>
								    
								</td>
							</tr>

							<tr>
								<td><label> 内容： </label></td>
								<td>
								
										<textarea name="articleHtml_modal"  id="articleHtml"   rows="8" style="width:550px;height:200px;visibility:hidden;"> </textarea>
								
   
							 
                            </td>
							</tr>
						</table>

					</form>
					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>  
			        <button type="button" id="submitArticleButton" class="btn btn-primary"    onclick="excute_update()"  >确定</button>   
				</div>
				</div>
			</div>
		</div>
	</div>
     
     
     
     
     
     </div>
     
    <script src="./js/jquery-3.1.1.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
 	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
    <script   src="./js/kindeditor.js"></script>
	<script   src="./js/lang/zh_CN.js"></script>
	<script   src="./js/plugins/code/prettify.js"></script>
     <script>

     //打开更新模态框
     function updateArticle(){
    	
    	  
    	 $('#updateArticleModal').modal({backdrop: 'static'});
    	 $('#updateArticleModal').modal('show');
    	 
    	 // 将值 传到 模态框上
    	   
    	 console.log("看看文章内容");
    	 console.log($('#article_html_old').html());
    	  
    	   KindEditor.instances[0].html($('#article_html_old').html())
    	   
    	   
				  $('#articleHtml').val($('#article_html_old').html())
				  $('#classificationId_modal').val($('#classificationId').val())
				  $('#type_modal').val($('#type').val())
				  $('#title_modal').val($('#title').val())
			
				  
				  
				  
		}

		var serverAddress = '<%=basePath%>';
     
     
     var add_order_photo_dir_photoGuideEditor;
     KindEditor.ready(function(K) {
     	add_order_photo_dir_photoGuideEditor = K.create(  'textarea[name="articleHtml_modal"]', {
     		cssPath : './js/plugins/code/prettify.css',
     		uploadJson : 'common/ajax/editor_image_upload?serverAddress='+serverAddress+'&userid='+$('#userId').val(),
     		fileManagerJson : 'common/file_manager_json',
     		allowFileManager : true,
     		afterCreate : function() {
     			var self = this;
     			K.ctrl(document, 13, function() {
     				self.sync();
     				document.forms['updateArticleForm'].submit();
     			});
     			K.ctrl(self.edit.doc, 13, function() {
     				self.sync();
     				document.forms['updateArticleForm'].submit();
     			});
     		}
     	});
     	prettyPrint();
     });
     
     
     // 获取更新模态框内的内容，更新数据库数据
     function  excute_update(){
     	
     	
    	 
     	 var articleid=$('#articleid').val();	 
         var new_article_html=add_order_photo_dir_photoGuideEditor.html();
     	 
        
         console.log("查看参数");
         console.log("aid="+articleid+"  "+new_article_html);
         
     	$.ajax({
     		
     		url:serverAddress+'updateArticle',
     		method:'POST',
     		data:{"articleid" : articleid ,"article_html":new_article_html},
     		success: function (data,status){
     			
     			console.log(data.data);
     			if(data.data=='1')
     			$('#updateArticleSuccess').html("帖子更新成功");
     		}
     		
     	});
         
      	
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
    	 
    	 var serverAddress='<%=basePath%>';
    	 var articleid=$('#articleid').val();
    	  
    	 //获取下一页 评论前 将当前页面的 评论 清空
    	 $('#commentTable').html("");
    	 
    	 $.ajax({
    		
    		 url: serverAddress+"commentList",
    		 method:'POST',
    		 data: {"articleid": articleid ,"page_num" :page_num},       //  "articleid=" +articleid,
    		 success:function (data,status){
    			  
    			   var new_elem;
    			   var num=(data.currentPage-1)*10;
    			   for (var i = 0; i < data.data.length; i++){
    			   
    				    
    				    new_elem =  '<div class="panel-defau lt"> <tr> <td> <a href="#" >'+data.data[i].fromUserId +'</a> 评论： ' +
    				    data.data[i].commentContent +  '<br>  评论时间：  <a href="#"> '+data.data[i].commentDate   + ' </a>  <a class="pull-right"> #'+  ++num  +'</a> </td></tr> </div>'
    				   
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
    	 var articleid=$('#articleid').val();
    	 var serverAddress ='<%=basePath%>';
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
     
     
     </script>
     
     
     
     
  </body>
  
</html>
