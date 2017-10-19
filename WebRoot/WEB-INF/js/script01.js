//window.onload = function() {
//	
//	
//	  //获取菜单
//    $.ajax({
//        url: 'http://localhost:8080/cs/Menus',
//        data:  "userId="+ $('#userId').val()  ,
//        method: 'POST',
//        success: function(data, status) {
//        	
//        	console.log(data.data);
//        	
//            if (data.status === '200') {
//                console.log(data.data);
//                for (var i in data.data) {
//                    console.log(i);
//                  
//                    if(i=='wdtz'){
//                    	var new_elem='<div class="accordion-group">' +
//                        '<div class="accordion-heading">' +
//                       
//                        //dropdown
//                        '<li class="" ><a  '
//                        
//                        +    
//                        ' data-parent="#accordion-897486"  href="#accordion-element-708546"  class="btn btn-default accordion-toggle collapsed  " data-toggle="collapse"  >' + data.data[i] + ' <span class="caret"></span> </a>  ' +
//                       
//                        '<div id="accordion-element-708546" class="accordion-body collapse">'+
//                        ' <div class="accordion-inner">'+
//                       
//                        '<ul class="" >  <li><a  href="#" id="wdtz"> 已发贴</a> </li> <li><a data-toggle="collapse" href="#" id="addArticle" onclick="openAddArticle()" > 新增帖子</a> </li>  '+   // <li><a> aa</a>
//                 
//                        
//                        '</div>' +
//                        '<div   '   + '  class="accordion-body collapse" style="display:inline">' +
//                        '<div class="accordion-inner">' +
//                        '<ul>' +
//                        '<li>' +
//                        '<a href="#" id="' + i + '-hot">热门</a>' +
//                        '</li>' +
//                        '</ul>' +
//                        '</div>' +
//                        '</div>'
//                    '</div>';
//                    	
//                    }
//                    else{
//                    var new_elem = '<div class="accordion-group">' +
//                        '<div class="accordion-heading">' +
//                        
//                        '<li><a class="btn btn-default " data-toggle="collapse"' +
//                        ' data-parent="#accordion-897486" id="' + i + '">' + data.data[i] + '</a> </li> ' +
//                        '</div>' +
//                        '<div id="' + i + '" class="accordion-body collapse" style="display:inline">' +
//                        '<div class="accordion-inner">' +
//                        '<ul>' +
//                        '<li>' +
//                        '<a href="#" id="' + i + '-hot">热门</a>' +
//                        '</li>' +
//                        '</ul>' +
//                        '</div>' +
//                        '</div>'
//                    '</div>';
//                    }
//                    
//                    $('.accordion').append(new_elem);
//
//                    (function(index) {
//                    	 
//                    		 
//                        $('#' + index).on('click', function() {
//                        	
//                            
//                            var perpage_num = $('#perpage_num').val();
//                            console.log(perpage_num);
//                            
// 
//                            getAllArticle(index, 1, perpage_num);
//                            
//                        });
//                        $('#' + index + '-hot').on('click', function() {
//                            var perpage_num = $('#perpage_num').val();
//                            getAllHotNews(index, 1, perpage_num);
//                        });
//                    }(i));
//                }
//            } else {
//                alert('获取新闻失败,请重新刷新');
//            }
//        }
//    });
//	
//	
//	 
//	   
//	   var getAllArticle = function(id, curpage, pagesize) {
//	        $('#newslist').text('');
//	        var data = {
//	            channelId: id,
//	            currentPage: curpage,
//	            pageSize: pagesize ,
//	            userid :$('#userId').val()
//	            
//	        };
//	        $.ajax({
//	            url: 'http://localhost:8080/cs/getArticleListByPager',
//	            method: 'POST',
//	            data: data,
//	            success: function(data, status) {
//	                console.log(data);
//	                $('.num').text(data.totalCount);
//	                $('.page_num').text(data.currentPage);
//	                $('.whole_page_num').text(data.pageCount);
//	                $('.first_page,.next_page,.prev_page,.last_page,.go_page').off('click');
//	                $('#perpage_num').off('change');
//	                $('.first_page').on('click', function() {
//	                    var perpage_num = $('#perpage_num').val();
//	                    getAllArticle(id, 1, perpage_num);
//	                });
//	                $('.last_page').on('click', function() {
//	                    var perpage_num = $('#perpage_num').val();
//	                    getAllArticle(id, data.pageCount, perpage_num);
//	                });
//	                $('.go_page').on('click', function() {
//	                    var skipto = $('#skip_to').val();
//	                    if (skipto <= data.pageCount && skipto >= 1) {
//	                        var perpage_num = $('#perpage_num').val();
//	                        getAllArticle(id, skipto, perpage_num);
//	                    } else {
//	                        alert('请输入合理的页数');
//	                    }
//	                });
//	                if (curpage < data.pageCount) {
//	                    $('.next_page').on('click', function() {
//	                        var perpage_num = $('#perpage_num').val();
//	                        getAllArticle(id, ++curpage, perpage_num);
//	                    });
//	                } else {
//	                    $('.next_page').on('click', function() {
//	                        return false;
//	                    });
//	                }
//	                if (curpage > 1) {
//	                    $('.prev_page').on('click', function() {
//	                        var perpage_num = $('#perpage_num').val();
//	                        getAllArticle(id, --curpage, perpage_num);
//	                    });
//	                } else {
//	                    $('.prev_page').on('click', function() {
//	                        return false;
//	                    });
//	                }
//	                $('#perpage_num').change(function() {
//	                    var perpage_num = $('#perpage_num').val();
//	                    console.log(perpage_num);
//	                    getAllArticle(id, 1, perpage_num);
//	                    $('#perpage_num').blur();
//	                });
//
//	                if (status === 'success') {
//	                    for (var i = 0; i < data.data.length; i++) {
//	                        var new_elem = '<tr>' +
//	                            '<td>' +
//	                            '<input type="checkbox" name="checkbox" value="' + data.data[i].newsId + '">' +
//	                            '</td>' +
//	                            '<td>' +
//	                            '<a  title="点击查看详情" href="articleDetail?articleId=' + data.data[i].id + '&userid='+$('#userId').val() +'">' +data.data[i].type +": "+ data.data[i].title +" -(" +data.data[i].userId +")" + '</a>' +
//	                            '</td>' +
//	                            '<td>' +
//	                           // '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
//	                            '</td>' +
//	                            '</tr>';
//	                        $('#newslist').append(new_elem);
//	                    }
//	                }
//	            }
//	        });
//	    };
//	   
//	   
//	   
//	   
//	   
//	   
//	   
//	   
//}