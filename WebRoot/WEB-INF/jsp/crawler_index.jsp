<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/themes/icon.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/locale/easyui-lang-zh_CN.js"></script>
</head>
<style type="text/css">
    .tabs-wrap ul {
        height: 24px;
    }
</style>
<body class="easyui-layout">

<!-- 左侧 -->
<div data-options="region:'west', title:'分组', border:false, collapsible:false" style="width:180px;">
    <ul id="groupName" class="easyui-tree">
    </ul>
</div>

<!-- 右侧 -->
<div data-options="region:'center', border:false, collapsible:false">
    <div id="tabs" class="easyui-tabs" data-options="border:false, fit:true">
    </div>
</div>

<!-- 左侧菜单右键 -->
<div id="groupNameMenu" class="easyui-menu" style="width:120px;" data-options="onClick:menuHandler">
    <div data-options="iconCls:'icon-add',name:'add'">添加</div>
    <div data-options="iconCls:'icon-edit',name:'edit'">编辑</div>
    <div class="menu-sep"></div>
    <div data-options="iconCls:'icon-remove',name:'delete'">删除</div>
</div>

<script type="text/javascript">
    // 自定义树
    $(function () {
        $("#groupName").tree({
            url: 'group/list',
            animate: true,
            method: "POST",
            onContextMenu: function (e, node) {
                e.preventDefault();
                $(this).tree('select', node.target);
                $('#groupNameMenu').menu('show', {
                    left: e.pageX,
                    top: e.pageY
                });
            },
            // 编辑后事件
            onAfterEdit: function (node) {
                var _tree = $(this);
                if (node.id == 0) {
                    // 新增节点
                    $.post("group/create", {groupName: node.text}, function (data) {
                        if (data.status == 200) {
                            _tree.tree("update", {
                                target: node.target,
                                id: data.data.id
                            });
                        } else {
                            $.messager.alert('提示', '创建' + node.text + ' 分类失败!');
                            _tree.tree("remove", node.target);
                        }
                    });
                } else {
                    $.post("group/edit", {id: node.id, groupName: node.text}, function (data) {
                        if (data.status == 200) {
                            _tree.tree("update", {
                                target: node.target,
                                id: data.data.id
                            });
                        } else {
                            $.messager.alert('提示', data.msg);
                        }
                    });
                }
            },
            // 单击事件
            onClick: function (node) {
                var tabs = $("#tabs");
                var tab = tabs.tabs("getTab", node.text);
                if (tab) {
                    tabs.tabs("select", node.text);
                } else {
                    tabs.tabs('add', {
                        title: node.text,
                        href: "info/show/" + node.id,
                        method: "GET",
                        closable: true,
                        bodyCls: "content"
                    });
                }
            }
        });
    });

    // 右键事件
    function menuHandler(item) {
        var tree = $("#groupName");
        var node = tree.tree("getSelected");
        if (item.name === "add") {
            tree.tree('append', {
                data: [{
                    text: '新建分类',
                    id: 0
                }]
            });
            var _node = tree.tree('find', 0);
            tree.tree("select", _node.target).tree('beginEdit', _node.target);
        } else if (item.name === "edit") {
            tree.tree('beginEdit', node.target);
        } else if (item.name === "delete") {
            $.messager.confirm('<font color="red">警告</font>', '确定删除名为 ' + node.text +
                    ' 的分类吗？<br><font color="red">(其下所有规则也会同时被删除)</font>',
                    function (r) {
                        if (r) {
                            $.post("group/delete", {id: node.id}, function () {
                                tree.tree("remove", node.target);
                            });
                        }
                    });
        }
    }
</script>
</body>
</html>