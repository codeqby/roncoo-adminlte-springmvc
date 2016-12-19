<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">角色管理</h3>
				<div class="box-tools pull-right">
					<a id="roleAdd" class="btn btn-sm btn-primary" target="modal" modal="lg" href="${ctx}/admin/role/add">添加</a>
				</div>
			</div>
			<div class="box-body">
				<div class="clearfix">
					<div class="col-md-4">
						<div class="input-group date ">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" id="roleTime" placeholder="选择时间...">
						</div>
					</div>
					<div class="col-md-4">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-search"></i></span>
							<input type="text" class="form-control" id="rolePremise" placeholder="根据账号搜索...">
						</div>
					</div>
					<div class="col-md-4">
						<button type="submit" id="roleSeek" class="btn btn-primary">搜索</button>
					</div>
				</div>
				<table id="role_tab" class="table table-bordered table-striped">
					<thead>
						<tr>
							<tr>
								<th>序号</th>
								<th>角色</th>
								<th>角色值</th>
								<th>状态</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteUser">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
				<h4 class="modal-title">提示</h4>
			</div>
			<div class="modal-body">
				<p>确认删除？</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">确认</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	//初始化时间选择器
	$('#roleTime').datepicker({
		language: 'zh-CN',
		format: 'yyyy-mm-dd',
		autoclose: true,
		todayHighlight: true
	});
	//初始化表格
	
	var No=0;
	var role_tab = $('#role_tab').DataTable({
		"dom" : 'itflp',
		"processing" : true,
		"searching" : false,
		"serverSide" : true, //启用服务器端分页
		"bInfo" : false,
		"language" : {
			"url" : "plugins/datatables/language.json"
		},
		"ajax" : {
			"url" : "${ctx}/admin/role/page",
			"type" : "post"
		},
		"columns" : [ 
		    {"data" : null}, 
			{"data" : "roleName"},
			{"data" : "roleValue"},
			{"data" : null},
			{"data" : "createTime"},
			{"data" : null} 
			],
		"columnDefs" : [
						{
						    targets: 0,
						    data: null,
						    render: function (data) {
						    	No=No+1;
						        return No;
						    }
						},
						{
						    targets: 3,
						    data: null,
						    render: function (data) {
						    	if(data.statusId == "0"){
						    		return "不可用";
						    	}
						    	if(data.statusId == "1"){
						    		return "可用";
						    	}
						    	return "未知状态";
						    }
						},
		                {
			"targets" : -1,
			"data" : null,
			"render" : function(data) {
				return '<a class="btn btn-xs btn-primary" target="modal" modal="lg" href="${ctx}/admin/role/view?id='
						+ data.id
						+ '">查看</a> &nbsp;<a class="btn btn-xs btn-info roleEdit" target="modal" modal="lg" href="${ctx}/admin/role/edit?id='
						+ data.id
						+ '">修改</a> &nbsp;<a class="btn btn-xs btn-default btn-del" data-body="确认要删除吗？" target="ajaxTodo" href="${ctx}/admin/role/delete?id='
						+ data.id + '">删除</a>'
			}
		} ]
	}).on('preXhr.dt', function ( e, settings, data ) {
		No=0;
    } );
	
	//点击删除确认时，删除后刷新
    $(".btn-del").on('click',function(){
		reloadTable(role_tab,"#roleTime","#rolePremise");
	});
	
	//动态生成的元素需要这样做点击事件
    $(document).on("click", ".roleEdit", function() {  
    	list_ajax = role_tab;
    }); 
	
	$("#roleAdd").on('click',function(){
		list_ajax = role_tab;
	});
	$("#roleSeek").on("click",function(){
 		reloadTable(role_tab,"#roleTime","#rolePremise");
	});
});
</script>