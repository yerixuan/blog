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
    
    <title>叶子的网站-管理</title>
    
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
				 	 <input type="hidden" id="managerid" value="${managerid}">  
								 <a href="logout_manager" >注销</a></li>	 
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
            <li class="active"><a   onclick= 'publishArticle()' >发布帖子</a></li> <td></tr>
            <tr><td>    <li><a   onclick='getAllArticle("wdtz",1)'  >已发帖子</a></li></td></tr>
             <tr><td><li> <a   onclick= 'getAllArticle("shtz",1)' >审核帖子</a> </li></td></tr>
            <tr><td><li><a onclick= 'getAllArticle("ystz",1)'>已审核帖子</a></li></td> </tr>
            
           <!--   <tr><td>   <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Java <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">jmeter</a></li>
                    <li><a href="#">EJB</a></li>
                    <li><a href="#">Jasper Report</a></li>
                    <li class="divider"></li>
                    <li><a href="#">分离的链接</a></li>
                    <li class="divider"></li>
                    <li><a href="#">另一个分离的链接</a></li>
                </ul>
            </li></td></tr> -->
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
								<tbody id="articlelist_body"></tbody>

							</table>
							<br> <br>
							<div class="well well-sm">
							
								<div class="well-inner">
									<p>
										共 <span class="num"></span> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp; <a  class="first_page">首页</a>
									&nbsp;&nbsp; <a   class="prev_page">上一页</a> &nbsp;&nbsp;
									<a   class="next_page">下一页</a> &nbsp;&nbsp; <a  
										class="last_page">尾页</a> &nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										每页
										<!-- <span class="perpage_num">10</span>
									-->
										<select name="perpage_num" id="perpage_num">
											<option value="10" selected>10</option>
											<option value="20">20</option>
											<option value="50">50</option>
										</select> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										当前第 <span class="page_num"></span> 页/共 <span
											class="whole_page_num"></span> 页
									</p>
									<!-- <p class="skip_page">
										跳转到第 <input type="text" id="skip_to"> 页 <a href="#"
											class="go_page">跳转</a>
									</p> -->
								</div>
							</div>
						</div>
						<div class="btn-group">
							<!-- <button type="button"
								class="btn btn-primary select-btn push-news">消息推送</button>
 -->
							<!-- <button type="button" style="display:none" data-toggle="modal"
								class="hide-push" data-target="#myModal">消息推送</button>
							<button type="button" class="btn btn-success select-btn hot-tags">热门标记</button> -->
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
     
     
  <div class="modal fade" id="AddArticleModal" tabindex="-1"
		role="dialog" aria-labelledby="ArticleModal">
		<div class="modal-dialog" role="document" style="width:800px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ArticleModal">
						<p class="text-center">新增帖子</p>
						
						<div class="alert alert-success" > <span id="AddArticleSuccess"></span></div>
						
					</h4>
				</div>
				<div class="modal-body">
 
					<form class="form-horizontal" name="articleForm" role="form">

						<table class="table" id="articleTable">

							<tr>
								<td><label>标题：</label></td>
								<td><input type="text" id="title" /></td>
							</tr>
  
                           <tr>
                           
                           <td><label >菜单分类</label></td>
                           <td>
                           <select id="classificationId" onclick="clearType()">
                           <option value="zyzn">志愿指南</option>
                           <option value="gxfj" >高校风景</option>
                           <option value="wtjl">问题交流</option> 
                           <option value="jysp">加油视频</option>                        
                           <option value="xgxw">相关新闻</option>      
                           </select>
                           
                           
                           </td>
                           </tr> 
      
       
							<tr id="clear_type">
								<td><label>学科类别：</label></td>
								<td><input type="text" id="type" />
								    
								</td>
							</tr>
  
							<tr>
								<td><label> 内容： </label></td>
								<td>
								
										<textarea name="articleHtml"  id="articleHtml"   rows="8" style="width:550px;height:200px;visibility:hidden;"> </textarea>
								
   
								</textarea>
                            </td>
							</tr>
						</table>

					</form>
					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>  
			        <button type="button" id="submitArticleButton" class="btn btn-primary"    onclick="addArticle()"  >确定</button>   
				</div>
				</div>
			</div>
		</div>
	</div>
     
     
      <div class="modal fade" id="reviewDatailModal" tabindex="-1"
		role="dialog" aria-labelledby="ArticleModal">
		<div class="modal-dialog" role="document" style="width:800px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ArticleModal">
						<p class="text-center">审核结果</p>
					 
					</h4>
				</div>
				<div class="modal-body">
 
					<form class="form-horizontal" name="articleForm" role="form">

						<table class="table" id="reviewDetailTable">
                             
                           <tr>
                            <td> <a>审核结果：</a></td> <td><p id="review_result"></p>  </td>
                           </tr>   
                           <tr>
                            <td><a>理由：</a></td> <td><p id="review_reason"> </p> </td>
                           
                           </tr>
						  <tr>
						   <td><a>时间：</a></td> <td> <p id="review_time"> </p></td>
						  </tr>
						</table>

					</form>
					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>  
			        
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
     
     var add_order_photo_dir_photoGuideEditor;
     KindEditor.ready(function(K) {
     	add_order_photo_dir_photoGuideEditor = K.create(  'textarea[name="articleHtml"]', {
     		cssPath : './js/plugins/code/prettify.css',
     		uploadJson : 'common/ajax/editor_image_upload?serverAddress='+serverAddress+'&userid='+$('#userId').val(),
     		fileManagerJson : 'common/file_manager_json',
     		allowFileManager : true,
     		afterCreate : function() {
     			var self = this;
     			K.ctrl(document, 13, function() {
     				self.sync();
     				document.forms['articleForm'].submit();
     			});
     			K.ctrl(self.edit.doc, 13, function() {
     				self.sync();
     				document.forms['articleForm'].submit();
     			});
     		}
     	});
     	prettyPrint();
     });
     
     
     </script>
     
     
     <script>
     
     var serverAddress = '<%=basePath%>';
     var userid= $('#managerid').val();
     
     var type_data; 
     
     //添加帖子
     function addArticle(){
    	 
    	 $.ajax({
    			
    		 url: serverAddress+"addArticle"  ,
    		 method: 'POST' ,
    		 data:{"userid" : userid ,"title" : $('#title').val() ,"type" :$('#type').val() ,"articleHtml" : add_order_photo_dir_photoGuideEditor.html() ,"classificationId":$('#classificationId').val()},
    		 success: function (data, status ){
    			 
    			 console.log(data.data);
    			 
    			 alert("帖子发布成功");
    		 }
    		 
    	 });
    	 
    	// 保存成功关闭 关闭默认模态框
    	 $('#AddArticleModal').modal("hide");
    	 
     }
     
     //关闭模态框的时候 要把里面的内容清空
     $('#AddArticleModal').on('hide.bs.modal' ,function(){
    	 
    	 $('#title').val("");  
    	 KindEditor.instances[0].html("")
    	 $('#type').val(""); 
     })
     
     
     
     
     
     //根据选择发帖分类  动态隐藏 学科类别
     function clearType(){
    	 $("#classificationId").bind("change", function(){ 
    		 
    		 if($('#classificationId').val()=='gxfj' || $('#classificationId').val()=='jysp')
    	      {
    			 $('#clear_type').hide();
    			 
    	      }else {
    	    	  
    	    	  $('#clear_type').show();
    	      }
    		 
    		 
    	 });
    	
    	 
     }
     
     
   //发布帖子 管理员可以发布所有类型的帖子 
   function  publishArticle(){
	 
	   $('#AddArticleModal').modal({backdrop: 'static'});
	   $('#AddArticleModal').modal('show');
	   
	   
   }
     
 
     
     function first_page(){
    	 
    	 
    	 console.log("看看")
    	 console.log($('.page_num'));
     
    	  
    	 var curpage= $('.page_num').html();
    	 
    	 if(curpage!=1) 
    		  --curpage;
    	 
 
    	 
    	 getAllArticle(type_data,curpage);
    	 
    	 
     }
     
     
     
     
     //获取已审核帖子的审核结果详情
     function getDetail(articleid_detail){
    	  
    	 $.ajax({
    		
    		 url:serverAddress+'reviewDetail',
    		 method:'POST',
    		 data:{"articleid":articleid_detail},
    		 success:function (data ,status ){
    			 
    			 console.log("审核结果详情");
    			 console.log(data);
    			
    			 //打开详情模态框 并将值设置进去
    			  $('#reviewDatailModal').modal('show');
    			 
    			   
    			  if(data.data.feedback=='0')
    			  $('#review_result').html("未通过审核");
    			  else 
    				  $('#review_result').html("通过审核");
    			  
    			  $('#review_reason').html(data.data.feedbackReason);
    			 
    			  $('#review_time').html(data.data.date);
    			 
    		 }
    		 
    	 });
    	 
    	 
     }
     
     
     
     function getAllArticle( type ,curpage){
    	 
   
    	  console.log("调用了")
    	   
    	  var managerid=$('#managerid').val();
    	  var perpage_num=$('#perpage_num').val();//每页多少条数据
    	  var id=type_data;
    	   if(type=='wdtz'){
    		 
    		 type_data='wdtz';
    		 
    	 } else if(type=='shtz'){
    		 
    		 type_data='shtz';
    	 }else if(type=='ystz'){
    		 
    		 type_data='ystz';
    		 
    	 }
    	   
    	 
    	  $('#articlelist_body').text('');
    	   var data = {
   	            channelId: type_data,
   	            currentPage: curpage,
   	            pageSize: perpage_num ,
   	            userid :managerid
   	            
   	        };
   	        $.ajax({
   	            url: serverAddress+'getArticleListByPager',
   	            method: 'POST',
   	            data: data,
   	            success: function(data, status) {
   	            	console.log("diaoyong1")
   	                console.log(data);
   	                $('.num').text(data.totalCount);
   	                $('.page_num').text(data.currentPage);
   	                $('.whole_page_num').text(data.pageCount);
   	                $('.first_page,.next_page,.prev_page,.last_page,.go_page').off('click');
   	                $('#perpage_num').off('change');
   	                $('.first_page').on('click', function() {
   	                    var perpage_num = $('#perpage_num').val();
   	                    getAllArticle(id, 1, perpage_num);
   	                });
   	                $('.last_page').on('click', function() {
   	                    var perpage_num = $('#perpage_num').val();
   	                    getAllArticle(id, data.pageCount, perpage_num);
   	                });
   	                $('.go_page').on('click', function() {
   	                    var skipto = $('#skip_to').val();
   	                    if (skipto <= data.pageCount && skipto >= 1) {
   	                        var perpage_num = $('#perpage_num').val();
   	                        getAllArticle(id, skipto, perpage_num);
   	                    } else {
   	                        alert('请输入合理的页数');
   	                    }
   	                });
   	                if (curpage < data.pageCount) {
   	                    $('.next_page').on('click', function() {
   	                        var perpage_num = $('#perpage_num').val();
   	                        getAllArticle(id, ++curpage, perpage_num);
   	                    });
   	                } else {
   	                    $('.next_page').on('click', function() {
   	                        return false;
   	                    });
   	                }
   	                if (curpage > 1) {
   	                    $('.prev_page').on('click', function() {
   	                        var perpage_num = $('#perpage_num').val();
   	                        getAllArticle(id, --curpage, perpage_num);
   	                    });
   	                } else {
   	                    $('.prev_page').on('click', function() {
   	                        return false;
   	                    });
   	                }
   	                $('#perpage_num').change(function() {
   	                    var perpage_num = $('#perpage_num').val();
   	                     
   	                    console.log(perpage_num);
   	                    getAllArticle(id, 1, perpage_num);
   	                    $('#perpage_num').blur();
   	                });

   	                if (status === 'success') {
   	                	
   	                if(data.status!='400'){
   	                	
    	                	
   	                    for (var i = 0; i < data.data.length; i++) {
   	                       
   	                    	if(type_data=='shtz'){
   	                    		var new_elem = '<tr>' +
   	                            '<td>' +
   	                            '<input type="checkbox" name="checkbox" value="' + 1 + '">' +
   	                            '</td>' +
   	                            '<td>' +
   	                            '<a  title="点击查看详情" href="reviewArticle?articleId=' + data.data[i].id + '&userid='+$('#managerid').val() +'">' +data.data[i].type +": "+ data.data[i].title +" -(" +data.data[i].userId +")" + '</a>' +
   	                            '</td>' +
   	                            '<td>' +
   	                           
   	                            '</td>' +
   	                            '</tr>';
   	                    	}else if(type_data=='ystz'){
   	                    		//已审帖子
   	                    		
   	                    		
   	                    		var button='<td> <button type="button" class="btn btn-primary btn-sm" onclick=getDetail("'+ data.data[i].id  +'") >详情</button></td></tr> '
   	                    	  
   	                    		 var new_elem ='<tr><td> <input type="checkbox" name="checkbox" value="1" > </td><td><a>'+data.data[i].type+': '+data.data[i].title+'</td>';
   	                    		new_elem=new_elem+button;
   	                    		
   	                    	}else{
   	                    	var new_elem = '<tr>' +
   	                            '<td>' +
   	                            '<input type="checkbox" name="checkbox" value="' + 1 + '">' +
   	                            '</td>' +
   	                            '<td>' +
   	                            '<a  title="点击查看详情" href="myArticleDetail?articleId=' + data.data[i].id + '&userid='+$('#managerid').val() +'">' +data.data[i].type +": "+ data.data[i].title +" -(" +data.data[i].userId +")" + '</a>' +
   	                            '</td>' +
   	                            '<td>' +
   	                           
   	                            '</td>' +
   	                            '</tr>';
   	                    	}
   	                        $('#articlelist_body').append(new_elem);
   	                    }
   	                }
    	   
    	   
    	 
     }
     
   	            }
   	        })
     }
     </script>
     
     <script>
     
     
     </script>
     
  </body>
  
  
  
  
</html>
