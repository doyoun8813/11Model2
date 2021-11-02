<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>��ǰ���</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncAddProduct(){
		
		//==> ��ȿ�� üũ
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='prodName']").focus();
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='prodDetail']").focus();
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			$("input[name='manuDate']").focus();
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			$("input[name='price']").focus();
			return;
		}
		
		//==> submit ���
		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	}
	
	$(function() {
		
		//==> Form Submit ó��
		$("button.btn-primary").on("click", function(){
			fncAddProduct();
		});
		
		//==> manuDate datepicker 
		$("#manuDate").datepicker({
		});
		
		//==> manuDate '/' CSV change '-'
		$("#manuDate").on("change", function(){
			var manuVal = $(this).val();
			//alert(manuVal);
			var manuValChg = manuVal.replaceAll("/", "-");
			//alert(manuValChg);
			$(this).val(manuValChg);
		});
		
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="row">
		
			<div class="page-header text-center">
				<h3 class=" text-info">�� ǰ �� ��</h3>
				<h5 class="text-muted">
					���ο� <strong class="text-danger">��ǰ�� ���</strong>�� �ּ���.
				</h5>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">

				<div class="form-group">
					<label for="prodName"
						class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodName"
							name="prodName" placeholder="��ǰ��">
					</div>
				</div>
				
				<div class="form-group">
					<label for="prodDetail"
						class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodDetail"
							name="prodDetail" placeholder="��ǰ������">
					</div>
				</div>
				
				<div class="form-group">
					<label for="manuDate"
						class="col-sm-offset-1 col-sm-3 control-label">��������</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="manuDate"
							name="manuDate" readonly="readonly" placeholder="��ǰ��������">
					</div>
				</div>
				
				<div class="form-group">
					<label for="price"
						class="col-sm-offset-1 col-sm-3 control-label">����</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="price"
							name="price" placeholder="��ǰ����">
					</div>
				</div>
				
				<div class="form-group">
					<label for="fileName"
						class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
					<div class="col-sm-4">
						<input type="file" id="fileName"
							name="fileName" placeholder="��ǰ�̹���">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">�� ��</button>
						<button type="reset" class="btn btn-default">�� ��</button>
					</div>
				</div>
			
			</form>
		
		</div>
		
	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</form>
</body>
</html>
