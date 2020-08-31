<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%--查询条件--%>
<form class="layui-form">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:auto">商品名称：</label>
        <div class="layui-input-inline">
            <input type="text" id="name" name="name" class="layui-input">
        </div>
        <label class="layui-form-label" style="width:auto">生产日期：</label>
        <div class="layui-input-inline">
            <input type="text" id="createtime" name="createtime"
                   class="layui-input" placeholder="xxxx-xx-xx">
            <%--<input type="text" id="createtime" name="createtime" lay-verify="date"--%>
            <%--placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">--%>
        </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button id="search-btn" type="button" class="layui-btn">搜索</button>
    </div>
</form>
<%--表格--%>
<table id="item-table" lay-filter="item-table"></table>

<%--自定义表格头工具栏--%>
<script type="text/html" id="toolbar-head">
    <button id="add-btn" type="button" class="layui-btn" lay-event="add">
        <i class="layui-icon">&#xe654;</i> 添加</button>
    <button id="del-btn" type="button" class="layui-btn layui-btn-danger" lay-event="del">
        <i class="layui-icon">&#xe640;</i> 批量删除</button>
</script>

<%--自定义表格行工具栏--%>
<script type="text/html" id="toolbar-row">
    <a class="layui-btn layui-btn-xs layui-btn-primary" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delById">
        <i class="layui-icon">&#xe640;</i>删除</a>
</script>

<script type="text/html" id="item-edit-layer">
    <form id="item-edit-form" style="width: 80%" class="layui-form" lay-filter="item-edit-form">
        <input type="hidden" name="id">
        <div class="layui-form-item">
            <label class="layui-form-label">商品名称：</label>
            <div class="layui-input-block">
                <input type="text" name="name" class="layui-input">
                <%--<input type="text" name="name" required lay-verify="required"--%>
                       <%--placeholder="商品名称" autocomplete="off" class="layui-input">--%>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品价格：</label>
            <div class="layui-input-block">
                <input type="text" name="price" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">生产日期：</label>
            <div class="layui-input-block">
                <input type="text" name="createtime" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态：</label>
            <div class="layui-input-block">
                <input type="radio" name="status" value="1" title="在售" checked>
                <input type="radio" name="status" value="0" title="未售">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品描述：</label>
            <div class="layui-input-block">
                <select name="detail" lay-verify="">
                    <option value="" selected>请选择</option>
                    <option value="好">好</option>
                    <option value="很好">很好</option>
                    <option value="非常好">非常好</option>
                    <%--<c:forEach items="${requestScope.games}" var="g">--%>
                        <%--<option value="${g.id}">${g.name}</option>--%>
                    <%--</c:forEach>--%>
                </select>
            </div>
        </div>
    </form>
</script>

<script>
    layui.use(['table','form','laydate','layer'],function(){
        var table = layui.table,form=layui.form,date=layui.laydate,layer=layui.layer;
        // var $=layui.jquery;
        form.render();
        date.render({elem:'#createtime'});
        table.render({
            id: 'item-table',
            elem: '#item-table',
            url: '/item/select',
            method: 'post',
            page: { layout: ['prev', 'page', 'next', 'count', 'limit', 'skip']},
            limit:3,limits:[3, 6, 9],
            //first:'首页',last:'尾页',theme:'#1E9FFF',
            // request: {pageName:'pi',limitName:'ps'},
            toolbar: '#toolbar-head',
            cols: [[
                {field:'checkbox',type:'checkbox',align:'center',fixed:'left'},
                {field:'id',title:'ID',align:'center',width:80,sort:true,fixed:'left'},
                {field:'status',title: '状态', align: 'center', width:100,templet:function(d){
                    return d.status==1?'<span class="layui-badge layui-bg-blue">在售</span>':
                    '<span class="layui-badge layui-bg-orange">未售</span>'}},
                {field:'name', title: '商品名称', align: 'center', width:100},
                {field:'price', title: '商品价格', align: 'center', width:100},
                {field:'createtime', title: '创建时间', align: 'center', width:170},
                {field:'detail', title: '商品描述', align: 'center', width:100},
                {title:'操作',align:'center',width:200,toolbar:'#toolbar-row',fixed:'right'}
            ]],
            even: true
        });

        //条件查询
        $('#search-btn').click(function(){
            table.reload('item-table',{
                where:{
                    name:$('#name').val(),
                    createtime:$('#createtime').val()
                },
                page:{curr:1}
            });
        });

        //监听头工具栏
        table.on('toolbar(item-table)',function(obj){
            var cs = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        area: ['400px','400px'],
                        content: $("#item-edit-layer").html(),
                        btn: ['提交', '取消'],
                        success:function(layero, index){
                            form.render();
                            // form.render(null,'item-edit-form');
                        },
                        yes: function(index, layero){
                            $.ajax({
                                url:"/item/add",
                                method:"post",
                                data:$("#item-edit-form").serialize(),
                                success:function (rs) {
                                    if(rs.status){
                                        table.reload('item-table',{
                                            where:{
                                                name:$('#name').val(),
                                                createtime:$('#createtime').val()
                                            },
                                            page:{curr:1}
                                        });
                                        layer.close(index);
                                    }else{
                                        layer.msg(rs.message);
                                    }
                                }
                            })
                        },
                        btn2: function(index, layero){
                            layer.close(index);
                        }
                    });
                    break;
                case 'del':
                    if(cs.data.length>0){
                        layer.confirm('确定删除选中行么?', {icon: 3, title:'提示'}, function(index){
                            var ids=new Array();
                            $.each(cs.data,function(i,obj){
                                ids.push(obj.id);
                            })
                            $.ajax({
                                url:"/item/del",
                                method:'post',
                                data:'ids='+ids,
                                success:function(rs){
                                    if(rs.status){
                                        table.reload('item-table',{
                                            where:{
                                                name:$('#name').val(),
                                                createtime:$('#createtime').val()
                                            },
                                            page:{curr:1}
                                        });
                                        layer.close(index);
                                    }
                                }
                            })
                        });
                    }
                    break;
            };
        });

        //监听行工具栏
        table.on('tool(item-table)', function(obj){
            var d = obj.data;
            var event = obj.event;
            var tr = obj.tr;

            if(event === 'detail'){
                layer.open({
                    type: 1,
                    area: ['400px', '400px'],
                    content: $("#item-edit-layer").html(),
                    btn: ['确定'],
                    success: function(layero, index){
                        form.val("item-edit-form", {
                            "name":d.name,
                            "price":d.price,
                            "createtime":d.createtime,
                            "status":d.status+"",
                            "detail":d.detail
                        });
                    },
                    yes: function(index, layero){
                        layer.close(index);
                    }
                });
            }else if(event === 'delById'){
                layer.confirm('确定删除这一行么',function(index){
                    $.ajax({
                        url:"/item/delById",
                        method:'post',
                        data:'id='+d.id,
                        success:function(rs){
                            if(rs.status){
                                table.reload('item-table',{
                                    where:{
                                        name:$('#name').val(),
                                        createtime:$('#createtime').val()
                                    },
                                    page:{curr:1}
                                });
                                layer.close(index);
                            }
                        }
                    })
                });
            } else if(event === 'edit'){
                layer.open({
                    type: 1,
                    area: ['400px', '400px'],
                    content: $("#item-edit-layer").html(),
                    btn: ['提交', '取消'],
                    success: function(layero, index){
//                        $("#aaa").append('<option value="">请选择一个城市</option>\\n\' +\n' +
//                            '                            \'                    <option value="1">空闲</option>\\n\' +\n' +
//                            '                            \'                    <option value="0">预定</option>\\n\' +')
//                        form.render()
                        form.val("item-edit-form", {
                            "id":d.id,
                            "name":d.name,
                            "price":d.price,
                            "createtime":d.createtime,
                            "status":d.status+"",
                            "detail":d.detail
                        });
                    },
                    yes: function(index, layero){
                        $.ajax({
                            url:"/item/update",
                            method:"post",
                            data:$("#item-edit-form").serialize(),
                            success:function (rs) {
                                if(rs.status){
                                    table.reload('item-table',{
                                        where:{
                                            name:$('#name').val(),
                                            createtime:$('#createtime').val()
                                        }
                                    });
                                    layer.close(index);
                                }else{
                                    layer.msg(rs.message);
                                }
                            }
                        })
                    },
                    btn2: function(index, layero){
                        layer.close(index);
                    }
                });
            }
        });
    });
</script>