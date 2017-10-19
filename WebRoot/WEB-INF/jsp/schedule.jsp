<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    .title {
        font-size: 15px;
    }
</style>
<div align="center">
    <table style="margin-top: 35px;">
        <tr>
            <td width="100" align="right"><span class="title">采集类型:</span></td>
            <td width="400">
                <label>
                    <input id="${groupId}schedule_type" name="type">
                </label>
            </td>
        </tr>

        <tr>
            <td width="100" align="right"><span class="title">时间调度:</span></td>
            <td width="400">
                <label>
                    <input type="text" id="${groupId}schedule_day" name="day"><span class="title">天&nbsp;</span>
                    <input type="text" id="${groupId}schedule_hour" name="hour"><span class="title">时&nbsp;</span>
                    <input type="text" id="${groupId}schedule_minute" name="minute"><span class="title">分&nbsp;</span>
                </label>
            </td>
        </tr>

        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td colspan="2" align="center">
                <a id="${groupId}schedule_btn_save" href="#">执行</a>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
    $("#" + ${groupId} +"schedule_type").combobox({
        panelHeight: 50,
        valueField: "value",
        textField: "label",
        value: "0",
        editable: false,
        required: true,
        data: [{
            label: '定时采集',
            value: '0'
        }, {
            label: '间隔重复采集',
            value: '1'
        }],
        onChange: function () {
            var value = $("#" + ${groupId} +"schedule_type").combobox("getValue");
            var day = $("#" + ${groupId} +"schedule_day");
            var hour = $("#" + ${groupId} +"schedule_hour");
            var minute = $("#" + ${groupId} +"schedule_minute");
            if (value == '0') {
                day.numberbox("disable");
                hour.numberbox("enable");
                minute.numberbox("enable");
            } else {
                day.numberbox("enable");
                hour.numberbox("disable");
                minute.numberbox("disable");
            }
            day.numberbox("setValue", 1);
            hour.numberbox("setValue", 0);
            minute.numberbox("setValue", 0);
        }
    });

    $("#" + ${groupId} +"schedule_day").numberbox({
        width: 90,
        min: 1,
        max: 60
    });

    $("#" + ${groupId} +"schedule_hour").numberbox({
        width: 90,
        min: 0,
        max: 24
    });

    $("#" + ${groupId} +"schedule_minute").numberbox({
        width: 90,
        min: 0,
        max: 60
    });

    $("#" + ${groupId} +"schedule_btn_save").linkbutton({
        iconCls: 'icon-save',
        onClick: function () {
            // 显示进度条
            $.messager.progress();
            // 获取数据
            var type = $("#" + ${groupId} +"schedule_type").combobox("getValue");
            var day = $("#" + ${groupId} +"schedule_day").numberbox("getValue");
            var hour = $("#" + ${groupId} +"schedule_hour").numberbox("getValue");
            var minute = $("#" + ${groupId} +"schedule_minute").numberbox("getValue");
            var rows = $("#" + ${groupId} +"infolist").datagrid("getSelections");
            var ids = [];
            for (var i = 0; i < rows.length; i++) {
                ids[i] = rows[i].id;
            }
            $.ajax({
                url: "quartz/crawler",
                method: "POST",
                dataType: "jsonp",
                jsonpCallback: "crawler",
                data: {
                    type: type,
                    day: day,
                    hour: hour,
                    minute: minute,
                    ids: ids
                }
            });
        }
    });

    function crawler(data) {
        $.messager.progress('close');	// 隐藏进度条
        $("#" + ${groupId} +"schedule").window("close"); // 关闭窗口
        if (data.status != 200) {
            $.messager.alert("采集失败", data.msg);
        } else {
            $.messager.alert("采集成功", "采集任务已开始");
        }
    }

    $(function () {
        $("#" + ${groupId} +"schedule_day").numberbox("disable");
    });
</script>
