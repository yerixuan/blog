<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    .attention {
        color: red;
    }
</style>

<table id="${groupId}infolist"></table>

<div id="${groupId}addwindow"></div>

<div id="${groupId}editwindow"></div>

<div id="${groupId}schedule"></div>

<script type="text/javascript">

    Date.prototype.format = function (format) {
        var o = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S": this.getMilliseconds()
        };
        if (/(y+)/.test(format)) {
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            }
        }
        return format;
    };

    function formatDateTime(val) {
        var now = new Date(val);
        return now.format("yyyy-MM-dd hh:mm:ss");
    }

    $("#" + ${groupId} +"infolist").datagrid({
        title: "信息列表",
        singleSelect: false,
        pagination: true,
        collapsible: false,
        url: "info/list",
        method: 'POST',
        queryParams: {
            groupId:${groupId}
        },
        pageSize: 20,
        columns: [[{
            field: 'ck',
            checkbox: true
        }, {
            field: 'id',
            title: "信息ID",
            width: 100,
            align: 'center'
        }, {
            field: 'title',
            title: "规则名称",
            width: 200,
            align: 'center'
        }, {
            field: 'hostname',
            title: "ip地址",
            width: 200,
            align: 'center'
        }, {
            field: 'port',
            title: "端口号",
            width: 100,
            align: 'center'
        }, {
            field: 'dtype',
            title: "数据库类型",
            width: 150,
            align: 'center'

        }, {
            field: 'databasename',
            title: "数据库名",
            width: 200,
            align: 'center'
        }, {
            field: 'tablename',
            title: "表名",
            width: 150,
            align: 'center'
        }, {
            field: 'description',
            title: "描述",
            width: 290,
            align: 'center'
        }, {
            field: 'created',
            title: "创建日期",
            width: 150,
            align: 'center',
            formatter: formatDateTime
        }, {
            field: 'updated',
            title: "更新日期",
            width: 150,
            align: 'center',
            formatter: formatDateTime
        }]],
        toolbar: [{
            text: '新增规则',
            iconCls: 'icon-add',
            handler: function () {
                $("#" + ${groupId} +"addwindow").window("open").window("refresh");
            }
        }, {
            text: '编辑规则',
            iconCls: 'icon-edit',
            handler: function () {
                var row = $("#" + ${groupId} +"infolist").datagrid("getSelected");
                if (row != null) {
                    $("#" + ${groupId} +"editwindow").window("open").window("refresh");
                } else {
                    $.messager.alert("提示", '请先选中一行');
                }
            }
        }, {
            text: '删除规则',
            iconCls: 'icon-remove',
            handler: function () {
                var row = $("#" + ${groupId} +"infolist").datagrid("getSelected");
                if (row != null) {
                    $.messager.confirm('<span class="attention">警告</span>', '确定删除id为<span class="attention">' + row.id +
                            '</span>的规则吗？',
                            function (r) {
                                if (r) {
                                    $.ajax({
                                        url: "info/delete",
                                        method: "POST",
                                        data: {
                                            id: row.id
                                        },
                                        success: function (data) {
                                            if (data.status != 200)
                                                $.messager.alert("操作失败", data.msg);
                                            else
                                                $.messager.alert("操作成功", '删除成功');
                                            $("#" + ${groupId} +"infolist").datagrid("reload");
                                        }
                                    });
                                }
                            });
                } else {
                    $.messager.alert("提示", '请先选中一行');
                }
            }
        }, {
            text: '采集',
            iconCls: 'icon-ok',
            handler: function () {
                var rows = $("#" + ${groupId} +"infolist").datagrid("getSelections");
                if (rows.length > 0) {
                    $("#" + ${groupId} +"schedule").window("open").window("refresh");
                } else {
                    $.messager.alert("提示", '请先至少选中一行');
                }
            }
        }]
    }).datagrid("getPager").pagination({
        pageList: [20, 30, 40]
    });

    $("#" + ${groupId} +"addwindow").window({
        title: "添加规则",
        collapsible: false,
        minimizable: false,
        maximizable: false,
        iconCls: 'icon-add',
        width: 600,
        height: 500,
        closed: true,
        modal: true,
        href: 'info/add',
        method: 'POST',
        queryParams: {
            groupId: ${groupId}
        }
    });

    $("#" + ${groupId} +"editwindow").window({
        title: "修改规则",
        collapsible: false,
        minimizable: false,
        maximizable: false,
        iconCls: 'icon-edit',
        width: 600,
        height: 500,
        closed: true,
        modal: true,
        href: 'info/detail',
        method: 'GET',
        queryParams: {
            groupId: ${groupId}
        }
    });

    $("#" + ${groupId} + "schedule").window({
        title: "采集时间调度设置",
        collapsible: false,
        minimizable: false,
        maximizable: false,
        iconCls: 'icon-edit',
        width: 600,
        height: 500,
        closed: true,
        modal: true,
        href: 'quartz/show',
        method: 'GET',
        queryParams: {
            groupId: ${groupId}
        }
    });

</script>