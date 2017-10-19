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
    <form id="${groupId}addinfoMessage" method="post" style="margin-top: 35px;">
        <table>
            <tr>
                <td width="100" align="right"><span class="title">规则名称:</span></td>
                <td width="400">
                    <label>
                        <input type="text" id="${groupId}addtitle" name="title">
                    </label>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型:</span></td>
                <td>
                    <label>
                        <input id="${groupId}adddtype" name="dtype">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}addhostname" name="hostname">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">端&nbsp;&nbsp;口&nbsp;&nbsp;号:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}addport" name="port">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">用&nbsp;&nbsp;户&nbsp;&nbsp;名:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}addusername" name="username">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</span></td>
                <td>
                    <label>
                        <input id="${groupId}addpassword" name="password">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">数据库名:</span></td>
                <td>
                    <label>
                        <input id="${groupId}adddatabase" name="databasename">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</span></td>
                <td>
                    <label>
                        <input id="${groupId}addtable" name="tablename">
                    </label>
                    <span class="attention">*</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="title">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述:</span></td>
                <td>
                    <label>
                        <input type="text" id="${groupId}adddescription" name="description">
                    </label>
                </td>
            </tr>
            <tr>
                <td><input type="hidden" name="groupId" value="${groupId}"></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a id="${groupId}add_btn_save" href="#">保存</a>
                </td>
            </tr>
        </table>
    </form>

</div>
<script type="text/javascript">
    $("#" + ${groupId} +"addtitle").textbox({
        width: 380,
        prompt: "规则名称",
        iconCls: "icon-tip",
        iconAlign: "left"
    });

    $("#" + ${groupId} +"adddtype").combobox({
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
            $("#" + ${groupId} +"adddatabase").textbox("setValue", "");
        }
    });

    $("#" + ${groupId} +"addhostname").textbox({
        width: 380,
        prompt: "地址",
        iconCls: "icon-tip",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"adddatabase").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"addport").numberbox({
        width: 380,
        prompt: "端口号",
        min: 0,
        max: 65536,
        iconCls: "icon-tip",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"adddatabase").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"addusername").textbox({
        width: 380,
        prompt: "用户名",
        iconCls: "icon-man",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"adddatabase").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"addpassword").textbox({
        width: 380,
        type: "password",
        prompt: "密码",
        iconCls: "icon-lock",
        iconAlign: "left",
        required: true,
        onChange: function () {
            $("#" + ${groupId} +"adddatabase").combobox("setValues", "");
        }
    });

    $("#" + ${groupId} +"adddatabase").textbox({
        required: true,
        prompt: "数据库名"
    });

    $("#" + ${groupId} +"addtable").combobox({
        editable: false,
        cache: false,
        panelHeight: 100,
        required: true,
        valueField: 'tableName',
        textField: 'tableName',
        onShowPanel: function () {
            $("#" + ${groupId} +"addtable").combobox("setValues", "");
            getTables();
        }
    });

    $("#" + ${groupId} +"adddescription").textbox({
        width: 380,
        height: 100,
        prompt: "可省略",
        multiline: true
    });

    $("#" + ${groupId} +"add_btn_save").linkbutton({
        iconCls: 'icon-save',
        onClick: function () {
            // 显示进度条
            $.messager.progress();
            $("#" + ${groupId} +"addinfoMessage").form("submit", {
                url: "info/save",
                method: "POST",
                onSubmit: function () {
                    var isValid = $("#" + ${groupId} +"addinfoMessage").form('validate');
                    if (!isValid) {
                        $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;	// 返回false终止表单提交
                },
                success: function () {
                    $.messager.progress('close');	// 如果提交成功则隐藏进度条
                    $("#" + ${groupId} +"addwindow").window("close"); // 关闭窗口
                    $("#" + ${groupId} +"infolist").datagrid("reload", {groupId:${groupId}});
                }
            });

        }
    });

    function getTables() {
        var dtype = $("#" + ${groupId} +"adddtype").combobox("getValue");
        var hostname = $("#" + ${groupId} +"addhostname").val();
        var port = $("#" + ${groupId} +"addport").val();
        var username = $("#" + ${groupId} +"addusername").val();
        var password = $("#" + ${groupId} +"addpassword").val();
        var database = $("#" + ${groupId} +"adddatabase").val();
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
            $("#" + ${groupId} +"addtable").combobox("loadData", tables);
        }
    }

</script>
