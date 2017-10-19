<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    .attention {
        color: red;
    }

    .title {
        font-size: 15px;
    }
</style>
<div align="center">
    <form id="${groupId}infoMessage" method="post" style="margin-top: 35px;">
        <table>
            <tr>
                <td width="100" align="right"><span class="title">规则名称:</span></td>
                <td width="400">
                    <label>
                        <input type="text" id="${groupId}title" name="title">
                    </label>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型:</span></td>
                <td>
                    <label>
                        <input id="${groupId}dtype" name="dtype">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}hostname" name="hostname">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">端&nbsp;&nbsp;口&nbsp;&nbsp;号:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}port" name="port">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">用&nbsp;&nbsp;户&nbsp;&nbsp;名:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}username" name="username">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</span></td>
                <td>
                    <label>
                        <input id="${groupId}password" name="password">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">数据库名:</span></td>
                <td>
                    <label>
                        <input id="${groupId}database" name="databasename">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</span></td>
                <td>
                    <label>
                        <input id="${groupId}table" name="tablename">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}description" name="description">
                    </label>
                </td>
            </tr>
            <tr>
                <td><input type="hidden" id="${groupId}groupId" class="easyui-textbox" name="groupId"
                           value="${groupId}"></td>
                <td><input type="hidden" id="${groupId}id" class="easyui-textbox" name="id" value="${groupId}"></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a id="${groupId}btn_save" href="#">保存</a>
                </td>
            </tr>
        </table>
    </form>

</div>
<script type="text/javascript">
    $("#" + ${groupId} +"title").textbox({
        width: 380,
        prompt: "规则名称",
        iconCls: "icon-tip",
        iconAlign: "left"
    });

    $("#" + ${groupId} +"dtype").combobox({
        panelHeight: 50,
        valueField: "value",
        textField: "label",
        value: "mysql",
        editable: false,
        required: true,
        data: [{
            label: 'MySQL',
            value: 'mysql'
        }, {
            label: 'Oracle',
            value: 'oracle'
        }],
        onChange: function () {
            $("#" + ${groupId} +"database").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"hostname").textbox({
        width: 380,
        prompt: "地址",
        iconCls: "icon-tip",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"database").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"port").numberbox({
        width: 380,
        prompt: "端口号",
        min: 0,
        max: 65536,
        iconCls: "icon-tip",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"database").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"username").textbox({
        width: 380,
        prompt: "用户名",
        iconCls: "icon-man",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"database").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"password").textbox({
        width: 380,
        type: "password",
        prompt: "密码",
        iconCls: "icon-lock",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"database").textbox("setValue", "");
        }
    });

    $("#" + ${groupId} +"database").combobox({
        required: true,
        prompt: "数据库名"
    });

    $("#" + ${groupId} +"table").combobox({
        editable: false,
        cache: false,
        panelHeight: 100,
        required: true,
        valueField: 'tableName',
        textField: 'tableName',
        onShowPanel: function () {
            $("#" + ${groupId} +"table").combobox("setValues", "");
            getTables();
        }
    });

    $("#" + ${groupId} +"description").textbox({
        width: 380,
        height: 100,
        prompt: "可省略",
        multiline: true
    });

    $("#" + ${groupId} +"btn_save").linkbutton({
        iconCls: 'icon-save',
        onClick: function () {
            // 显示进度条
            $.messager.progress();
            $("#" + ${groupId} +"infoMessage").form("submit", {
                url: "info/update",
                method: "POST",
                onSubmit: function () {
                    var isValid = $("#" + ${groupId} +"infoMessage").form('validate');
                    if (!isValid) {
                        $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;	// 返回false终止表单提交
                },
                success: function () {
                    $.messager.progress('close');	// 如果提交成功则隐藏进度条
                    $("#" + ${groupId} +"editwindow").window("close"); // 关闭窗口
                    $("#" + ${groupId} +"infolist").datagrid("reload", {groupId:${groupId}});
                }
            });

        }
    });

    function getTables() {
        var dtype = $("#" + ${groupId} +"dtype").combobox("getValue");
        var hostname = $("#" + ${groupId} +"hostname").val();
        var port = $("#" + ${groupId} +"port").val();
        var username = $("#" + ${groupId} +"username").val();
        var password = $("#" + ${groupId} +"password").val();
        var database = $("#" + ${groupId} +"database").val();
        $.ajax({
            url: "db/getTables",
            method: "POST",
            dataType: "jsonp",
            jsonpCallback: "tablesGet",
            data: {
                dtype: dtype,
                hostname: hostname,
                port: port,
                username: username,
                password: password,
                databasename: database
            }
        });
    }

    function tablesGet(data) {
        if (data.status != 200) {
            $.messager.alert('获取表失败', '<span class="attention">请检查网络或参数</span>');
        } else {
            var tables = [];
            for (var i = 0; i < data.data.length; i++) {
                tables[i] = {
                    tableName: data.data[i]
                }
            }
            $("#" + ${groupId} +"table").combobox("loadData", tables);
        }
    }

    $(function () {
        $.messager.progress();
        var id = $("#" + ${groupId} +"infolist").datagrid("getSelected").id;
        $.ajax({
            url: "info/detail",
            method: "POST",
            dataType: "jsonp",
            jsonpCallback: "detailGet",
            data: {
                id: id
            }
        });
    });

    function detailGet(data) {
        if (data.status != 200) {
            $.messager.alert("错误", '获取信息失败，请重试');
            $.messager.progress('close');	// 隐藏进度条
            $("#" + ${groupId} +"editwindow").window("close"); // 关闭窗口
        } else {
            var id = data.data.id;
            var title = data.data.title;
            var hostname = data.data.hostname;
            var port = data.data.port;
            var databasename = data.data.databasename;
            var tablename = data.data.tablename;
            var description = data.data.description;
            var dtype = data.data.dtype;
            var groupId = data.data.groupId;
            var username = data.data.username;
            var password = data.data.password;
            $("#" + ${groupId} +"dtype").combobox("setValue", dtype);
            $("#" + ${groupId} +"hostname").textbox("setValue", hostname);
            $("#" + ${groupId} +"port").textbox("setValue", port);
            $("#" + ${groupId} +"database").combobox("setValue", databasename);
            $("#" + ${groupId} +"username").textbox("setValue", username);
            $("#" + ${groupId} +"password").textbox("setValue", password);
            $("#" + ${groupId} +"groupId").textbox("setValue", groupId);
            $("#" + ${groupId} +"id").textbox("setValue", id);
            $("#" + ${groupId} +"title").textbox("setValue", title);
            $("#" + ${groupId} +"table").combobox("setValue", tablename);
            $("#" + ${groupId} +"description").textbox("setValue", description);
            $.messager.progress('close');	// 隐藏进度条
        }
    }

</script>