window.onload = function() {
    //获取菜单
    $.ajax({
        url: 'http://localhost:8080/cs/Menus',
        method: 'POST',
        success: function(data, status) {
            if (data.status === '200') {
                console.log(data.data);
                for (var i in data.data) {
                    console.log(i);
                    var new_elem = '<div class="accordion-group">' +
                        '<div class="accordion-heading">' +
                        '<a class="accordion-toggle collapsed" data-toggle="collapse"' +
                        ' data-parent="#accordion-897486" id="' + i + '">' + data.data[i] + '</a>' +
                        '</div>' +
//                        '<div id="' + i + '" class="accordion-body collapse" style="display:inline">' +
//                        '<div class="accordion-inner">' +
//                        '<ul>' +
//                        '<li>' +
//                        //'<a href="#" id="' + i + '-hot">热门</a>' +
//                        '</li>' +
//                        '</ul>' +
//                        '</div>' +
//                        '</div>'
                    '</div>';
                    $('.accordion').append(new_elem);

                    (function(index) {
                    	alert(index)
                        $('#' + index).on('click', function() {
                            var perpage_num = $('#perpage_num').val();
                            console.log(perpage_num);
                            getAllNews(index, 1, perpage_num);
                        });
                        $('#' + index + '-hot').on('click', function() {
                            var perpage_num = $('#perpage_num').val();
                            getAllHotNews(index, 1, perpage_num);
                        });
                    }(i));
                }
            } else {
                alert('获取新闻失败,请重新刷新');
            }
        }
    });

    //获取栏目下所有新闻
    var getAllNews = function(id, curpage, pagesize) {
        $('#newslist').text('');
        var data = {
            channelId: id,
            currentPage: curpage,
            pageSize: pagesize
        };
        $.ajax({
            url: 'http://localhost:8080/AppI/getNewsListByPager',
            method: 'POST',
            data: data,
            success: function(data, status) {
                console.log(data);
                $('.num').text(data.pageCount * 10);
                $('.page_num').text(data.currentPage);
                $('.whole_page_num').text(data.pageCount);
                $('.first_page,.next_page,.prev_page,.last_page,.go_page').off('click');
                $('#perpage_num').off('change');
                $('.first_page').on('click', function() {
                    var perpage_num = $('#perpage_num').val();
                    getAllNews(id, 1, perpage_num);
                });
                $('.last_page').on('click', function() {
                    var perpage_num = $('#perpage_num').val();
                    getAllNews(id, data.pageCount, perpage_num);
                });
                $('.go_page').on('click', function() {
                    var skipto = $('#skip_to').val();
                    if (skipto <= data.pageCount && skipto >= 1) {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, skipto, perpage_num);
                    } else {
                        alert('请输入合理的页数');
                    }
                });
                if (curpage < data.pageCount) {
                    $('.next_page').on('click', function() {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, ++curpage, perpage_num);
                    });
                } else {
                    $('.next_page').on('click', function() {
                        return false;
                    });
                }
                if (curpage > 1) {
                    $('.prev_page').on('click', function() {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, --curpage, perpage_num);
                    });
                } else {
                    $('.prev_page').on('click', function() {
                        return false;
                    });
                }
                $('#perpage_num').change(function() {
                    var perpage_num = $('#perpage_num').val();
                    console.log(perpage_num);
                    getAllNews(id, 1, perpage_num);
                    $('#perpage_num').blur();
                });

                if (status === 'success') {
                    for (var i = 0; i < data.data.length; i++) {
                        var new_elem = '<tr>' +
                            '<td>' +
                            '<input type="checkbox" name="checkbox" value="' + data.data[i].newsId + '">' +
                            '</td>' +
                            '<td>' +
                            '<a href="' + data.data[i].htmlpath + '">' + data.data[i].title + '</a>' +
                            '</td>' +
                            '<td>' +
                            '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
                            '</td>' +
                            '</tr>';
                        $('#newslist').append(new_elem);
                    }
                }
            }
        });
    };

    //获取栏目下所有热门新闻
    var getAllHotNews = function(id, curpage, pagesize) {
        $('#newslist').text('');
        var data = {
            channelId: id,
            currentPage: curpage,
            pageSize: pagesize
        };
        $.ajax({
            url: 'http://localhost:8080/AppI/getHotNewsListByPager',
            method: 'POST',
            data: data,
            success: function(data, status) {
                console.log(data);
                $('.num').text(data.pageCount * 10);
                $('.page_num').text(data.currentPage);
                $('.whole_page_num').text(data.pageCount);
                $('.first_page,.next_page,.prev_page,.last_page,.go_page').off('click');
                $('#perpage_num').off('change');
                $('.first_page').on('click', function() {
                    var perpage_num = $('#perpage_num').val();
                    getAllNews(id, 1, perpage_num);
                });
                $('.last_page').on('click', function() {
                    var perpage_num = $('#perpage_num').val();
                    getAllNews(id, data.pageCount, perpage_num);
                });
                $('.go_page').on('click', function() {
                    var skipto = $('#skip_to').val();
                    if (skipto <= data.pageCount && skipto >= 1) {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, skipto, perpage_num);
                    } else {
                        alert('请输入合理的页数');
                    }
                });
                if (curpage < data.pageCount) {
                    $('.next_page').on('click', function() {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, ++curpage, perpage_num);
                    });
                } else {
                    $('.next_page').on('click', function() {
                        return false;
                    });
                }
                if (curpage > 1) {
                    $('.prev_page').on('click', function() {
                        var perpage_num = $('#perpage_num').val();
                        getAllNews(id, --curpage, perpage_num);
                    });
                } else {
                    $('.prev_page').on('click', function() {
                        return false;
                    });
                }
                $('#perpage_num').change(function() {
                    var perpage_num = $('#perpage_num').val();
                    console.log(perpage_num);
                    getAllNews(id, 1, perpage_num);
                    $('#perpage_num').blur();
                });

                if (status === 'success') {
                    for (var i = 0; i < data.data.length; i++) {
                        var new_elem = '<tr>' +
                            '<td>' +
                            '<input type="checkbox" name="checkbox" value="' + data.data[i].newsId + '">' +
                            '</td>' +
                            '<td>' +
                            '<a href="' + data.data[i].htmlpath + '">' + data.data[i].title + '</a>' +
                            '</td>' +
                            '<td>' +
                            '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
                            '</td>' +
                            '</tr>';
                        $('#newslist').append(new_elem);
                    }
                }
            }
        });
    };

    $('.hot-tags').on('click', function() {
        var hotIds = [];
        $('input[name="checkbox"]:checked').each(function() {
            hotIds.push(this.value);
        });
        if (hotIds.length !== 0) {
            addHotTags(hotIds.toString())
        } else {
            alert('请先选中新闻');
        }
        console.log(hotIds.toString());
    });

    //热门标记
    var addHotTags = function(ids) {
        var data = {
            id: ids
        };
        $.ajax({
            url: 'http://localhost:8080/AppI/hotTags',
            method: 'POST',
            data: data,
            success: function(data, status) {
                console.log(data);
            }
        });
    };

    //消息推送
    $('.push-news').on('click', function() {
        var selectedIds = [];
        $('input[name="checkbox"]:checked').each(function() {
            var thisdata = {
                id: this.value,
                title: $(this).parent().next().find('a').text()
            }
            selectedIds.push(thisdata);

        });
        if (selectedIds.length === 1) {
            console.log(selectedIds);
            $('.hide-push').click();
            $('.push-content').val(selectedIds[0].title);
            $('.hidden-id').text(selectedIds[0].id);
        } else {
            alert('请选中新闻，每次只能推送一条');
        }
    });

    $('.checkbox-inline').change(function() {});

    $('.dopush').on('click', function() {
        var date = new Date();
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
        var D = date.getDate() + ' ';
        var h = $('.time-selector').val().split(':')[0] + ':';
        var m = $('.time-selector').val().split(':')[1] + ':';
        var s = date.getSeconds();
        var strtime = Y + M + D + h + m + s;
        var timestamp = new Date(strtime).getTime();
        console.log(); //呀麻碟
        var data = {
        	id: $('.hidden-id').text(),
        	MsgExpires: Number($('.expire-time').val()),
        	Target: Number($('input[name="optionsRadiosinline"]:checked').val()),
        	'Target-content': $('input[name="optionsRadiosinline"]:checked').val() == 1 ? null : $('.spobj').val(),
        	sendTime: timestamp 
        };
        $.ajax({
        	url:'http://localhost:8080/AppI/pushNews',
        	method: 'POST',
        	data: data,
        	success: function(data, status) {
        		console.log(data);
        		console.log(status);
        		if(status === 'success') {
        			$('.btn-cancel').click();
        		}
        	}
        });
        console.log(data);
    });
};