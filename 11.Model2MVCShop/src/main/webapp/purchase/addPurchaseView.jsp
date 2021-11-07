<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>��ǰ ����</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncAddPurchase() {
		$("form").attr("method", "POST")
				.attr("action", "/purchase/addPurchase").submit();
	}

	$(function() {

		//==> Form Submit ó��
		$("button:contains('�� ��')").on("click", function() {
			fncAddPurchase();
		});
		$("button:contains('�� ��')").on("click", function() {
			history.go(-1);
		});

		//==> divyDate datepicker 
		$("#divyDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if
		test="${ param.paramRole == 'admin' || user.role == 'admin' || user.role == 'manager' }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
	<c:if
		test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		<jsp:include page="/layout/toolbarUser.jsp" />
	</c:if>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">

			<!--  Menu ���� Start /////////////////////////////////////-->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu ���� end /////////////////////////////////////-->

			<div class="page-header text-center">
				<h3 class=" text-info">�� ǰ �� ��</h3>
			</div>

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
				<input type="hidden" name="prodNo" value="${product.prodNo}" />
				<input type="hidden" name="menu" value="${param.menu}" />
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodNo}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodName}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodDetail}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">��������</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.manuDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">����</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.price}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">�������</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.regDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
					<div class="col-sm-4">
						<p class="form-control-static">${user.userId}</p>
						<input type="hidden" name="buyerId" value="${user.userId}" />
					</div>
				</div>

				<div class="form-group">
					<label for="paymentOption"
						class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
					<div class="col-sm-4">
						<select name="paymentOption" id="paymentOption"
							class="form-control">
							<option value="1">���ݱ���</option>
							<option value="2">�ſ뱸��</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="receiverName"
						class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName"
							name="receiverName" placeholder="�������̸�" value="${user.userName}">
					</div>
				</div>

				<div class="form-group">
					<label for="receiverPhone"
						class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone"
							name="receiverPhone" placeholder="�����ڿ���ó" value="${user.phone}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyAddr"
						class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr"
							name="divyAddr" placeholder="�������ּ�" value="${user.addr}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyRequest"
						class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest"
							name="divyRequest" placeholder="���ſ�û����">
					</div>
				</div>

				<div class="form-group">
					<label for="divyDate"
						class="col-sm-offset-1 col-sm-3 control-label">����������</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate"
							name="divyDate" placeholder="����������">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">�� ��</button>
						<button type="reset" class="btn btn-default">�� ��</button>
					</div>
				</div>

			</form>
			<!-- form End /////////////////////////////////////-->

			<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		</div>
		</c:if>

	</div>
	<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>