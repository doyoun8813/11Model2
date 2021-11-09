<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>���Ż���ȸ</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		$( "a.btn-primary:contains('�� ��')" ).on("click" , function() {
			self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
		});
		$( "a.btn-default:contains('��Ϻ���')" ).on("click" , function() {			
			self.location = "/purchase/listPurchase";
		});
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if test="${ user.role == 'admin' || user.role == 'manager' }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
	<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
		<jsp:include page="/layout/toolbarUser.jsp" />
	</c:if>
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu ���� Start /////////////////////////////////////-->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu ���� end /////////////////////////////////////-->
			
			<div class="page-header">
				<h3 class=" text-info">���Ż���ȸ</h3>
			</div>
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��ǰ��ȣ</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�����ھ��̵� </strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>���Ź��</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.paymentOption=='1  '  ? "���ݱ���" : "�ſ뱸��" }</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�������̸�</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�����ڿ���ó</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�������ּ�</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>���ſ�û����</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��������</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�ֹ���</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
			</div>
			
			<hr />

			<div class="row">
				<div class="col-md-12 text-center ">
					<a href="#" class="btn btn-primary">�� ��</a>
					<a href="#" class="btn btn-default">��Ϻ���</a>
				</div>
			</div>
			
			
			<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if test="${ param.paramRole != 'admin' }">
				</div>
			</c:if>	
			
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>
</html>
