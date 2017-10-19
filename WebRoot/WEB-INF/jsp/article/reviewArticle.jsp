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
    
    <title>审核帖子</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 
	 <link rel="stylesheet" href="././css/bootstrap.min.css">
   <link rel="stylesheet" href="./css/main.css">  
	 

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
				 <p id="article_html_old">${ article.html}</p>
				  
				 	<input type="hidden" value="${managerid } "  id="managerid">		
					<input type="hidden" value="${article.id }"  id="articleid"> 
				 <div class="pull-right">
				   
				   <table class="table">
				  
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
			
			 <p class="text-center">
			 
			<button type="button" class="btn btn-success" onclick="review()">审核</button>
			</p>
			<br><br>
		 
    <div class="well well-sm">    
			 <p  >举报内容区</p>
			   <table class="table table-striped"      id="reportTable">
			 
			   
			   </table>
			 
			  
			 
								<div class="well-inner  ">
									<p>
										共 <span class="num" id="totalCount"></span> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp; <a   class="first_page" onclick= flip("first_page")  >首页</a>
									&nbsp;&nbsp; <a   class="prev_page" onclick= flip("prev_page")  >上一页</a> &nbsp;&nbsp;
									<a   class="next_page" onclick= flip("next_page") >下一页</a> &nbsp;&nbsp; <a  
										class="last_page" onclick= flip("last_page")  >尾页</a> &nbsp;&nbsp;&nbsp;&nbsp;
									
									<input type="hidden" id="current_page" value=1> 
									<input type="hidden" id="total_pageCount"   />
									<p>
										每页
									 
										<select name="perpage_num" id="perpage_num">
											<option value="10" selected>10</option>
 	 
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
    
    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="reportModalLabel"><p class="text-center">举报帖子</p></h4>
				</div>


		<form role="form" class="form-horizontal" id="reviewForm">

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
    <td><label>帖子是否合法：</label></td>
    <td> 
     <select id="isLegal">
      <option value="1">合法</option>
      <option value="0">违规</option>
     </select>
    
     </td>
   </tr>
  
    <tr>
       
       <td><label>理由：</label></td>
      <td><textarea id="reason_modal"  rows="8" style="width:300px;height:200px;"> </textarea> </td>
    </tr>
    </table>
	 
	    </form>
 
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" id="submitButton" class="btn btn-primary"  onclick="submit_review()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
    
    
     <script src="./js/jquery-3.1.1.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
 	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
    
    
    <script>
    
    var serverAddress='<%=basePath%>';
    var articleid=$('#articleid').val();
    var managerid=$('#managerid').val();
    var title=$('#title').val();
    
   
    
    //在页面加载的时候 加载举报内容进来
    window.onload=function (){
    	
    	getReportList(articleid ,1);
    	
    }
    
    
    //执行翻页动作
    function flip(option ){
    	
    	var curpage=$('#current_pageNum').html();
		
		var totalPage=$('#total_pageNum').html();
    	
	
    	//首页
    	if(option=='first_page'){
    		
    		curpage=1;
    		 
    	}else if(option=='next_page'){
    		//下一页
    	 
    		if(totalPage==curpage)
    			 ; //什么都不做
    		else ++curpage;
    		
    		
    	}else if(option=='prev_page'){
    		//上一页
       
    		if(totalPage==1||curpage==1)
    			curpage=1;
    		else{
    			--curpage;
    		}
    		
    	}else if(option=='last_page'){
    		//尾页
    		curpage=totalPage;
    		
    	}
    	
    	alert("当前页等于=="+curpage+"  total=="+totalPage)
    	getReportList(articleid,curpage);
    	
    	
    }



    
    // 获取 帖子的举报列表
    function getReportList(articleid ,curpage){
    	
    	//每一页条数 暂定为 每页10条
        var pageSize= $('#perpage_num').val();
    	
        $('#reportTable').text("");
        
    	$.ajax({
    		url:serverAddress+'getReportList',
    		method:'POST',
    		data:{"articleid":articleid,"currentpage":curpage,"pageSize":pageSize},
    		success:function (data,status){
    			
    			console.log("举报内容");
    			console.log(data);
    			
    			//获取到数据后 将 分页数据 设置好
    			$('#current_pageNum').html(data.currentPage);
    			$('#total_pageNum').html(data.pageCount);
    			$('#totalCount').html(data.totalCount)
    			
    			var num=(data.currentPage-1)*10;
    			
    			for(var i=0 ;i<data.data.length ;i++ ){
    				
    				var new_elem =  '<div class="panel-defau lt"> <tr> <td> <a >'+data.data[i].reportUserId +'</a> 举报： ' +
 				    data.data[i].type +'<br><a> 详细原因：</a> '+data.data[i].reason+  '<br> <a> 时间：</a>    '+data.data[i].date   + '   <a class="pull-right"> #'+  ++num  +'</a> </td></tr> </div><br>'
    				
    				$('#reportTable').append(new_elem);
    				
    			}
    			
    			
    		}
    		
    	});
    	
    	
    }
    
    
    //点击 后打开模态框 填写审核理由
    function review( ){
    	 
     
    	  $('#title_modal').val(title);
    	  $('#reviewModal').modal({backdrop: 'static'});
    	  $('#reviewModal').modal('show');
    	
    }   
    
    
    //关闭模态框的时候 要把里面的内容清空
    $('#reviewModal').on('hide.bs.modal' ,function(){
    
    	$('#reason_modal').val("");
    	
    	
    })
    
    
    // 提交 审核结果
    function submit_review(){
    	
    	//帖子是否合法
      var islegal=$('#isLegal').val();
      var reason=$('#reason_modal').val();
    	
    	$.ajax({
    		url:serverAddress+'submit_review_result',
    		method:'POST',
    		data:{"articleid":articleid,"islegal":islegal,"reason":reason,"managerid":managerid,"title":title},
    		success:function (data,status){
    			
    			console.log("审核结果");
    			console.log(data);
    			
    			$('#reviewModal').modal('hide');
    			alert("审核完成");
    			
    		}
    		
    	});
    	
    	
    	
    }
    
    
    </script>
    
    
  </body>
</html>
