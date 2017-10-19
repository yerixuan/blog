<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>叶子的网站-系统管理员</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 <link rel="stylesheet" href="././css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/main.css">

    <link rel="stylesheet" href="./js/themes/default/default.css" />
	<link rel="stylesheet" href="./js/plugins/code/prettify.css" />

 

  </head>
  
  <body>
     
     
     <nav class="navbar navbar-default">
		<!-- inverse -->
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">叶子的网站 ${menu}  </a>
 
			</div>
			<form class="navbar-form navbar-right" role="search">
		 
            <br>
			 <tr>  
				<table class="table">
					<tr>
				 	<td>
				 	 <input type="hidden" id="userid" value="${userid}">  
								 <a href="logout_admin" >注销</a></li>	 
						</td>
					</tr>
				</table>
			</form>


		</div>
	</nav>
 

    <div class="container-fluid">
		<div class="row">  
			<div class="col-sm-2">
			 
			 
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <div class="navbar-header">
   
        <a class="navbar-brand" >菜单</a>
    </div>
    <div class="collapse navbar-collapse" id="example-navbar-collapse">
    <table class="table" >
        <ul class="nav navbar-nav ">
        <tr><td>
            <li class="active"><a   onclick= 'publishNotice()' >发布系统公告</a></li> <td></tr>
           
          
           <!--  <tr><td>    <li><a   onclick='getAllArticle("wdtz",1)'  >已发帖子</a></li></td></tr>
             <tr><td><li> <a   onclick= 'getAllArticle("shtz",1)' >审核帖子</a> </li></td></tr>
            <tr><td><li><a onclick= 'getAllArticle("ystz",1)'>已审核帖子</a></li></td> </tr> -->
            
              <tr><td>   <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    管理员操作 <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a    onclick="addManager(1,10)">任命管理员</a></li>
                    
                   
                    <li class="divider"></li>
                  <li><a  onclick="removeManager(1,10)" >删除管理员</a></li>
                  
                </ul>
            </li></td></tr>  
        </ul>
        </table>
    </div>
    </div>
</nav>
			 
			 
		 
		 </div>
				 
					 
			 

			<div class="col-sm-10">
			  
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="center-block"> 
							<p class="panel-title text-center">内容详情</p>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered content-table">
								<thead class="well well-sm">
									<tr>
										 
									</tr>
								</thead>
								<tbody id="userlist_body"></tbody>

							</table>
							<br> <br>
							<div class="well well-sm">
							
								<div class="well-inner">
									<p>
										共 <span class="num"></span> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp; <a  onclick="first_page()">首页</a>
									&nbsp;&nbsp; <a   onclick="prev_page()">上一页</a> &nbsp;&nbsp;
									<a   onclick="next_page()">下一页</a> &nbsp;&nbsp; <a  
										onclick="last_page()">尾页</a> &nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										每页
										<!-- <span class="perpage_num">10</span>
									-->
										<select name="perpage_num" id="perpage_num"  onchange="changePageNum()">
											<option value="10" selected>10</option>
											<option value="20">20</option>
											<option value="50">50</option>
										</select> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										当前第 <span id="page_num"></span> 页/共 <span
											class="whole_page_num"></span> 页
									</p>
									
								</div>
							</div>
						</div>
						<div class="btn-group">
						
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
     
     
  
     
      <div class="modal fade" id="NoticeModal" tabindex="-1"
		role="dialog" aria-labelledby="ArticleModal">
		<div class="modal-dialog" role="document" style="width:800px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ArticleModal">
						<p class="text-center">发布公告</p>
					 
					</h4>
				</div>
				<div class="modal-body">
 
					<form class="form-horizontal" name="articleForm" role="form">

						<table class="table" id="reviewDetailTable">
                             
                           <tr>
                            <td> <a>标题：</a></td> <td> <input type="text" id="notice_title">  </td>
                           </tr>   
                           <tr>
                            <td><a>内容：</a></td> <td><textarea   id="notice_comment" >  </textarea></td>
                           
                           </tr>
						  <!-- <tr>
						   <td><a>时间：</a></td> <td> <p id="review_time"> </p></td>
						  </tr> -->
						</table>

					</form>
					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>  
			        <button type="button" class="btn btn-default"  onclick="excute_publish()">发布</button>  
				</div>
				</div>
			</div>
		</div>
	</div>
     
     
     <script src="./js/jquery-3.1.1.min.js"></script>
	<script src="./js/script01.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
	<script   src="./js/kindeditor.js"></script>
	<script   src="./js/lang/zh_CN.js"></script>
	<script   src="./js/plugins/code/prettify.js"></script>
     
     
     
     
    <script>
    
    var userid =$('#userid').val();
    var serverAddress = '<%=basePath%>';
    
    //记录当前菜单类型
    var type_data; 
    
    
    
    // 发布系统公告 //打开模态框
   function  publishNotice(){

    	 
    	$('#NoticeModal').modal('show');
	   
   }
    
    //关闭发布公告模态框 ，并清楚里面的内容
    function closeModal(){
    	
    	//每次打开模态框 将上次填写的内容清除
    	$('#notice_title').val("");
    	$('#notice_comment').val("");
    	$('#NoticeModal').modal('hide');
    	
    }
    
    
    // 发布公告内容，将公告内容存入数据库
    function excute_publish(){
    	
    	var title=$('#notice_title').val();
    	var comment=$('#notice_comment').val();
    	
    	$.ajax({
    		
    		url:serverAddress+'addnotice',
    		method:'POST',
    		data:{"title":title , "comment" : comment,"userid":userid},
    		success: function (data,status){
    			
    			
    			console.log("发布公告成功");
    			console.log(data);
    			
    			
    			closeModal();
                alert(data.message)
    			 
    			
    			
    		}
    		
    	});
    	
    	
    }
    
    
    //添加管理员
    function addManager(pageNum ,pageSize){
        
    	//当前菜单为 添加管理员
    	type_data="addManager";
     
    	$('#userlist_body').html("");
    	
    	$.ajax({
    		
    		url:serverAddress+'addManager',
    		method:'POST',
    		data:{"currentPage":pageNum , "pageSize" : pageSize,"role":0},
    		success:function (data,status){
    			
    			console.log("添加管理员");
    			console.log(data.data);
    			
    			
    			$('#page_num').html(data.currentPage);
    			$('.num').html(data.totalCount);
    			$('.whole_page_num').html(data.pageCount)
    			
    			var body_head='<tr><th>用户名</th><th>学校</th><th>院系</th><th>用户积分</th><th>创建时间</th> <th>个人描述</th><th>操作</th></tr>'
    			
    			$('#userlist_body').append(body_head);
    			
    			for(var i=0 ;i<data.data.length; i++){
    			  
    			   var new_elem='<tr><td>'+data.data[i].userName+'</td> <td>'+data.data[i].schoolName+'</td> <td>'+data.data[i].department+'</td> <td>'+data.data[i].integral+'</td><td>'+data.data[i].createDate+'</td><td>'+data.data[i].description+'</td> <td>  <button  type="button" class="btn btn-success" onclick=updateUser("'+data.data[i].id+ '",1)>升级</button></td></tr>'
    			
    			   $('#userlist_body').append(new_elem);
    			}
    			
    		}
    		
    	});
    	
    	
    }
    
    
    
    //升级/降级 普通用户（管理员）为管理员（普通用户）
    function updateUser(userid,flag){
    	
    	$.ajax({
    		url:serverAddress+'updateUser',
    		method:'POST',
    		data:{"userid":userid,"flag" :flag},
    		success: function (data,status){
    			
    			console.log("升级管理员");
    			console.log(data.data);
    			
    			
    		 	var pageNum=$('#page_num').html();
    			var pageSize= $('#perpage_num').val(); 
    			
    			
    			$('#userlist_body').html("");
    			//刷新界面
    			if(flag == 1)
    			addManager(pageNum,pageSize);
    			else 
    				removeManager(pageNum,pageSize);
    			
    		}
    		
    		
    	});
    	
    	
    }
    
    
    
    //删除管理员
    function removeManager(pageNum ,pageSize){
    	
    	
    	type_data="removeManager";
    	
    	$('#userlist_body').html("");
    	
    	$.ajax({
    		
    		url:serverAddress+'removeManager',
    		method:'POST',
            data:{"currentPage":pageNum , "pageSize" :pageSize ,"role" : 1},
    		success:function (data,status){
    			
    			console.log("降级管理员");
    			console.log(data);
    			
    			$('#page_num').html(data.currentPage);
    			$('.num').html(data.totalCount);
    			$('.whole_page_num').html(data.pageCount);
    			
    			
    			var body_head='<tr><th>用户名</th><th>学校</th><th>院系</th><th>用户积分</th><th>创建时间</th> <th>个人描述</th><th>操作</th></tr>'
        			
        		$('#userlist_body').append(body_head);
        			
    			
        			for(var i=0 ;i<data.data.length; i++){
        			  
        			   var new_elem='<tr><td>'+data.data[i].userName+'</td> <td>'+data.data[i].schoolName+'</td> <td>'+data.data[i].department+'</td> <td>'+data.data[i].integral+'</td><td>'+data.data[i].createDate+'</td><td>'+data.data[i].description+'</td> <td>  <button  type="button" class="btn btn-danger" onclick=updateUser("'+data.data[i].id+ '",0)>降级</button></td></tr>'
        			
        			   $('#userlist_body').append(new_elem);
        			}
    			
    		}
    		
    	}) ;
    	
    	
    	
    }
    
    
    //修改每页的显示记录条数
    function changePageNum(){
    	
    	
    	var pageNum=$('#page_num').html();
		var pageSize= $('#perpage_num').val(); 
    	
    	if(type_data== 'removeManager'){
 
    		removeManager(pageNum,pageSize);
    		
    		
    	}else{
    		
    		addManager(pageNum,pageSize);
    		
    	}
    	
    }
    
    
    //首页
    function first_page(){
    	
    	var pageSize= $('#perpage_num').val(); 
    	
    	if(type_data== 'addManager'){	
    		addManager(1,pageSize);
    	}else{ 
    		removeManager(1,pageSize);
    	}
    	
    	
    	
    	
    
    }
    
    //上一页
    function prev_page(){
    	
    		var pageNum=$('#page_num').html();
    		var pageSize= $('#perpage_num').val(); 
    		
    		if(pageNum==1) 
    			pageNum=1;
    		else 
    			pageNum--;
    		
    		if(type_data== 'addManager'){	
        		addManager(pageNum,pageSize);
        	}else{ 
        		removeManager(pageNum,pageSize);
        	}
        	
    		
    		
    		
    }
    
    
    // 下一页
    function next_page(){
    	
    	var pageNum=$('#page_num').html();
		var pageSize= $('#perpage_num').val(); 
		var totalpage=$('.whole_page_num').html();
		
		if(pageNum==totalpage) ;
		else pageNum++;
		

		if(type_data== 'addManager'){	
    		addManager(pageNum,pageSize);
    	}else{ 
    		removeManager(pageNum,pageSize);
    	}
    	
    }
    
    
    //尾页
    function last_page(){
    	
    	var pageSize= $('#perpage_num').val(); 
		var totalpage=$('.whole_page_num').html();
		
		if(type_data== 'addManager'){	
    		addManager(totalpage,pageSize);
    	}else{ 
    		removeManager(totalpagebn,pageSize);
    	}
    }
    
    
    
    </script>
    
 
    
  </body>
  
  
  
  
</html>

